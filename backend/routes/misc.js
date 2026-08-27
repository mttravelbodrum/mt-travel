/**
 * routes/misc.js - settings, customers (derived from reservations),
 * activity log, notifications, dashboard stats, contact form.
 * All admin-only except /company-info and /contact.
 *
 * Data layer: Supabase (see lib/supabase.js).
 */
const { Router } = require("../lib/router");
const { requireAuth } = require("../middleware/auth");
const { supabase } = require("../lib/supabase");
const { sendMail } = require("../lib/mailer");
const { contactFormEmail, contactConfirmationEmail } = require("../lib/email-templates");
const { rateLimit } = require("../lib/ratelimit");

const router = new Router();

function settingsToApiShape(row) {
  if (!row) return {};
  return {
    companyName: row.company_name,
    phone: row.phone,
    whatsapp: row.whatsapp,
    email: row.email,
    address: row.address,
    currency: row.currency,
    islandMinAdvanceDays: row.island_min_advance_days,
    defaultLanguage: row.default_language,
  };
}

const SETTINGS_FIELD_MAP = {
  companyName: "company_name", phone: "phone", whatsapp: "whatsapp", email: "email",
  address: "address", currency: "currency", islandMinAdvanceDays: "island_min_advance_days",
  defaultLanguage: "default_language",
};

// ---- Settings: single row, camelCase <-> snake_case at the edges ----
router.get("/settings", requireAuth, async (req, res) => {
  const { data, error } = await supabase.from("settings").select("*").eq("id", 1).maybeSingle();
  if (error) return res.status(500).json({ error: "Could not load settings." });
  res.json(settingsToApiShape(data));
});

// Public, no-auth subset of settings for the live site to sync against -
// only the fields already shown publicly on the contact page anyway
// (phone, email, WhatsApp, address), plus islandMinAdvanceDays so the
// booking calendar can enforce whatever advance-notice window the admin
// has configured (Admin -> Settings -> Booking Rules) instead of a
// hardcoded number. Everything else in settings (currency, etc.) stays
// admin-only via the route above.
router.get("/company-info", async (req, res) => {
  const { data, error } = await supabase.from("settings").select("company_name, phone, whatsapp, email, address, island_min_advance_days").eq("id", 1).maybeSingle();
  if (error) return res.status(500).json({ error: "Could not load settings." });
  const s = data || {};
  res.json({
    companyName: s.company_name,
    phone: s.phone,
    whatsapp: s.whatsapp,
    email: s.email,
    address: s.address,
    islandMinAdvanceDays: s.island_min_advance_days,
  });
});

router.put("/settings", requireAuth, async (req, res) => {
  const updates = req.body || {};
  const patch = {};
  for (const [camelKey, value] of Object.entries(updates)) {
    const snakeKey = SETTINGS_FIELD_MAP[camelKey];
    if (snakeKey) patch[snakeKey] = value;
  }
  const { data: updated, error } = await supabase.from("settings").update(patch).eq("id", 1).select().single();
  if (error) return res.status(500).json({ error: "Could not update settings." });
  res.json(settingsToApiShape(updated));
});

// ---- Customers: derived from reservations (grouped by email) ----
router.get("/customers", requireAuth, async (req, res) => {
  const { data: reservations, error } = await supabase
    .from("reservations").select("customer, email, phone, country, total, date, created_at")
    .order("created_at", { ascending: true });
  if (error) return res.status(500).json({ error: "Could not load customers." });

  const byEmail = {};
  for (const r of reservations || []) {
    if (!byEmail[r.email]) {
      byEmail[r.email] = {
        name: r.customer, email: r.email, phone: r.phone, country: r.country,
        bookings: 0, totalSpent: 0, lastBooking: r.date,
      };
    }
    byEmail[r.email].bookings += 1;
    byEmail[r.email].totalSpent += Number(r.total);
    if (r.date > byEmail[r.email].lastBooking) byEmail[r.email].lastBooking = r.date;
  }
  res.json(Object.values(byEmail));
});

// Customers have no record of their own - they're computed from reservations
// by email (see above). Deleting a customer therefore means deleting every
// reservation under that email; there's nothing else to remove.
router.delete("/customers/:email", requireAuth, async (req, res) => {
  const email = decodeURIComponent(req.params.email);
  const { data: toRemove, error: fetchErr } = await supabase.from("reservations").select("id, customer").eq("email", email);
  if (fetchErr) return res.status(500).json({ error: "Could not load the customer's reservations." });
  if (!toRemove || !toRemove.length) return res.status(404).json({ error: "No reservations found for this customer." });

  const { error: deleteErr } = await supabase.from("reservations").delete().eq("email", email);
  if (deleteErr) return res.status(500).json({ error: "Could not delete the customer's reservations." });

  await supabase.from("activity_log").insert({
    action: `Customer Deleted (${toRemove.length} reservation${toRemove.length === 1 ? "" : "s"} removed)`,
    reservation_id: null, customer: toRemove[0].customer || email, tour_name: null, slug: null,
  });
  res.json({ deleted: true, email, reservationsRemoved: toRemove.length });
});

// ---- Activity log ----
router.get("/activity-log", requireAuth, async (req, res) => {
  const limit = Math.min(parseInt(req.query.limit, 10) || 50, 200);
  const { data, error } = await supabase.from("activity_log").select("*").order("at", { ascending: false }).limit(limit);
  if (error) return res.status(500).json({ error: "Could not load the activity log." });
  res.json((data || []).map((r) => ({
    id: r.id, action: r.action, reservationId: r.reservation_id, customer: r.customer,
    tour: r.tour_name, slug: r.slug, by: r.by, at: r.at,
  })));
});

// ---- Notifications (for the admin bell) ----
router.get("/notifications", requireAuth, async (req, res) => {
  const { data, error } = await supabase.from("notifications").select("*").order("created_at", { ascending: false }).limit(30);
  if (error) return res.status(500).json({ error: "Could not load notifications." });
  const { count: unreadCount } = await supabase.from("notifications").select("id", { count: "exact", head: true }).eq("read", false);
  res.json({
    notifications: (data || []).map((n) => ({
      id: n.id, type: n.type, reservationId: n.reservation_id, customer: n.customer,
      tour: n.tour, slug: n.slug, createdAt: n.created_at, read: n.read,
    })),
    unreadCount: unreadCount || 0,
  });
});

router.patch("/notifications/read-all", requireAuth, async (req, res) => {
  const { error } = await supabase.from("notifications").update({ read: true }).eq("read", false);
  if (error) return res.status(500).json({ error: "Could not update notifications." });
  res.json({ ok: true });
});

// ---- Dashboard stats (computed on the fly - fine at this scale) ----
router.get("/stats", requireAuth, async (req, res) => {
  const { data: reservations, error } = await supabase.from("reservations").select("status, total, email, created_at");
  if (error) return res.status(500).json({ error: "Could not load stats." });
  const rows = reservations || [];
  const totalReservations = rows.length;
  const totalRevenue = rows.filter((r) => r.status !== "Cancelled").reduce((s, r) => s + Number(r.total), 0);
  const today = new Date().toISOString().slice(0, 10);
  const todayReservations = rows.filter((r) => (r.created_at || "").slice(0, 10) === today).length;
  const totalCustomers = new Set(rows.map((r) => r.email)).size;
  const byStatus = {};
  rows.forEach((r) => { byStatus[r.status] = (byStatus[r.status] || 0) + 1; });
  res.json({ totalReservations, totalRevenue, todayReservations, totalCustomers, byStatus });
});

function isValidEmail(v) {
  return typeof v === "string" && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);
}

const VALID_SUBJECTS = ["general", "booking", "private", "feedback"];
const SUPPORTED_LANGS = ["en", "tr", "de", "ru", "pl"];

// Same shape as the reservations limiter: generous for real visitors,
// tight enough to block a scripted flood of the contact form.
const contactLimiter = rateLimit({
  windowMs: 60 * 60 * 1000,
  max: 8,
  message: { error: "Too many messages submitted. Please contact us directly if this persists." },
});

// ---- Contact form ----
router.post("/contact", contactLimiter, async (req, res) => {
  const b = req.body || {};
  const firstName = (b.firstName || "").trim();
  const lastName = (b.lastName || "").trim();
  const email = (b.email || "").trim();
  const phone = (b.phone || "").trim();
  const message = (b.message || "").trim();
  const subject = VALID_SUBJECTS.includes(b.subject) ? b.subject : "general";
  const lang = SUPPORTED_LANGS.includes(b.lang) ? b.lang : "tr";

  if (!firstName || !lastName || !email || !message) {
    return res.status(400).json({ error: "Please fill in all required fields." });
  }
  if (!isValidEmail(email)) {
    return res.status(400).json({ error: "Invalid email address." });
  }

  const data = { firstName, lastName, email, phone, subject, message, lang };
  const { data: settingsRow } = await supabase.from("settings").select("email").eq("id", 1).maybeSingle();
  const ownerEmail = (settingsRow && settingsRow.email) || process.env.OWNER_NOTIFICATION_EMAIL || process.env.ADMIN_EMAIL;

  const emailResults = await Promise.allSettled([
    ownerEmail ? sendMail({ to: ownerEmail, replyTo: email, ...contactFormEmail(data) }) : Promise.resolve({ sent: false, reason: "OWNER_NOTIFICATION_EMAIL not set" }),
    sendMail({ to: email, ...contactConfirmationEmail(data) }),
  ]);

  const [ownerResult, customerResult] = emailResults;
  const ownerOk = ownerResult.status === "fulfilled" && ownerResult.value.sent;
  const customerOk = customerResult.status === "fulfilled" && customerResult.value.sent;

  await supabase.from("activity_log").insert({ action: "Contact Form Submitted", reservation_id: null, customer: `${firstName} ${lastName}`, tour_name: subject, slug: null });
  if (!ownerOk) {
    const reason = ownerResult.status === "rejected" ? ownerResult.reason.message : ownerResult.value.reason;
    await supabase.from("activity_log").insert({ action: `Contact form owner email NOT sent (${reason})`, reservation_id: null, customer: `${firstName} ${lastName}`, tour_name: subject, slug: null });
  }
  if (!customerOk) {
    const reason = customerResult.status === "rejected" ? customerResult.reason.message : customerResult.value.reason;
    await supabase.from("activity_log").insert({ action: `Contact form confirmation email NOT sent (${reason})`, reservation_id: null, customer: `${firstName} ${lastName}`, tour_name: subject, slug: null });
  }

  // The message itself is safely logged either way (see activity_log
  // above) - a slow/misconfigured mailbox should never make a genuine
  // enquiry look like it failed to the person who sent it.
  res.status(201).json({ received: true });
});

module.exports = router;
