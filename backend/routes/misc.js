/**
 * routes/misc.js - settings (key/value store), customers (derived from
 * reservations), and the activity log. All admin-only.
 */
const { Router } = require("../lib/router");
const { requireAuth } = require("../middleware/auth");
const { transaction, readAll, logActivity } = require("../lib/store");
const { sendMail } = require("../lib/mailer");
const { contactFormEmail, contactConfirmationEmail } = require("../lib/email-templates");
const { rateLimit } = require("../lib/ratelimit");

const router = new Router();

// ---- Settings: simple key/value store ----
router.get("/settings", requireAuth, (req, res) => {
  res.json(readAll().settings);
});

// Public, no-auth subset of settings for the live site to sync against -
// only the fields already shown publicly on the contact page anyway
// (phone, email, WhatsApp, address), plus islandMinAdvanceDays so the
// booking calendar can enforce whatever advance-notice window the admin
// has configured (Admin -> Settings -> Booking Rules) instead of a
// hardcoded number. Everything else in settings (currency defaults, SEO
// fields, etc.) stays admin-only via the route above.
router.get("/company-info", (req, res) => {
  const s = readAll().settings || {};
  res.json({
    companyName: s.companyName,
    phone: s.phone,
    whatsapp: s.whatsapp,
    email: s.email,
    address: s.address,
    islandMinAdvanceDays: s.islandMinAdvanceDays,
  });
});

router.put("/settings", requireAuth, async (req, res) => {
  const updates = req.body || {};
  let result = null;
  await transaction((data) => {
    data.settings = { ...data.settings, ...updates };
    result = data.settings;
  });
  res.json(result);
});

// ---- Customers: derived from reservations (grouped by email) ----
router.get("/customers", requireAuth, (req, res) => {
  const reservations = [...readAll().reservations].sort((a, b) => new Date(a.createdAt) - new Date(b.createdAt));
  const byEmail = {};
  for (const r of reservations) {
    if (!byEmail[r.email]) {
      byEmail[r.email] = {
        name: r.customer, email: r.email, phone: r.phone, country: r.country,
        bookings: 0, totalSpent: 0, lastBooking: r.date,
      };
    }
    byEmail[r.email].bookings += 1;
    byEmail[r.email].totalSpent += r.total;
    if (r.date > byEmail[r.email].lastBooking) byEmail[r.email].lastBooking = r.date;
  }
  res.json(Object.values(byEmail));
});

// Customers have no record of their own - they're computed from reservations
// by email (see above). Deleting a customer therefore means deleting every
// reservation under that email; there's nothing else to remove.
router.delete("/customers/:email", requireAuth, async (req, res) => {
  const email = decodeURIComponent(req.params.email);
  let removedCount = 0;
  await transaction((data) => {
    const before = data.reservations.length;
    const removed = data.reservations.filter((r) => r.email === email);
    data.reservations = data.reservations.filter((r) => r.email !== email);
    removedCount = before - data.reservations.length;
    if (removedCount > 0) {
      logActivity(data, `Customer Deleted (${removedCount} reservation${removedCount === 1 ? "" : "s"} removed)`, { email, customer: removed[0] ? removed[0].customer : email });
    }
  });
  if (removedCount === 0) return res.status(404).json({ error: "No reservations found for this customer." });
  res.json({ deleted: true, email, reservationsRemoved: removedCount });
});

// ---- Activity log ----
router.get("/activity-log", requireAuth, (req, res) => {
  const limit = Math.min(parseInt(req.query.limit, 10) || 50, 200);
  res.json(readAll().activityLog.slice(0, limit));
});

// ---- Notifications (for the admin bell) ----
router.get("/notifications", requireAuth, (req, res) => {
  const all = readAll().notifications;
  res.json({ notifications: all.slice(0, 30), unreadCount: all.filter((n) => !n.read).length });
});

router.patch("/notifications/read-all", requireAuth, async (req, res) => {
  await transaction((data) => {
    data.notifications.forEach((n) => { n.read = true; });
  });
  res.json({ ok: true });
});

// ---- Dashboard stats (computed on the fly - fine at this scale) ----
router.get("/stats", requireAuth, (req, res) => {
  const { reservations } = readAll();
  const totalReservations = reservations.length;
  const totalRevenue = reservations.filter((r) => r.status !== "Cancelled").reduce((s, r) => s + r.total, 0);
  const today = new Date().toISOString().slice(0, 10);
  const todayReservations = reservations.filter((r) => (r.createdAt || "").slice(0, 10) === today).length;
  const totalCustomers = new Set(reservations.map((r) => r.email)).size;
  const byStatus = {};
  reservations.forEach((r) => { byStatus[r.status] = (byStatus[r.status] || 0) + 1; });
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
  const site = readAll().settings || {};
  const ownerEmail = site.email || process.env.OWNER_NOTIFICATION_EMAIL || process.env.ADMIN_EMAIL;

  const emailResults = await Promise.allSettled([
    ownerEmail ? sendMail({ to: ownerEmail, replyTo: email, ...contactFormEmail(data) }) : Promise.resolve({ sent: false, reason: "OWNER_NOTIFICATION_EMAIL not set" }),
    sendMail({ to: email, ...contactConfirmationEmail(data) }),
  ]);

  await transaction((d) => {
    const [ownerResult, customerResult] = emailResults;
    const ownerOk = ownerResult.status === "fulfilled" && ownerResult.value.sent;
    const customerOk = customerResult.status === "fulfilled" && customerResult.value.sent;
    const context = { id: null, customer: `${firstName} ${lastName}`, tourName: { en: subject, tr: subject } };
    logActivity(d, "Contact Form Submitted", context);
    if (!ownerOk) {
      const reason = ownerResult.status === "rejected" ? ownerResult.reason.message : ownerResult.value.reason;
      logActivity(d, `Contact form owner email NOT sent (${reason})`, context);
    }
    if (!customerOk) {
      const reason = customerResult.status === "rejected" ? customerResult.reason.message : customerResult.value.reason;
      logActivity(d, `Contact form confirmation email NOT sent (${reason})`, context);
    }
  });

  // The message itself is safely logged either way (see activityLog
  // above) - a slow/misconfigured mailbox should never make a genuine
  // enquiry look like it failed to the person who sent it.
  res.status(201).json({ received: true });
});

module.exports = router;
