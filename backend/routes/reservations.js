/**
 * routes/reservations.js
 *
 * Public: POST /api/reservations (guest creates a reservation - this is
 * what checkout.js's completeReservation() calls, via
 * site/assets/js/api-client.js).
 *
 * Admin-only (requireAuth): list/filter, get one, update status/notes,
 * send a custom email, delete.
 *
 * Data layer: Supabase (see lib/supabase.js). Every validation rule and
 * every response shape below is identical to the JSON-file-store version
 * this replaced - only where the data itself now lives has changed.
 */
const { Router } = require("../lib/router");
const { rateLimit } = require("../lib/ratelimit");
const { requireAuth } = require("../middleware/auth");
const { supabase } = require("../lib/supabase");
const { sendMail } = require("../lib/mailer");
const { customerConfirmationEmail, ownerNotificationEmail, statusUpdateEmail, adminCustomEmail } = require("../lib/email-templates");
const { generateTicketPdf } = require("../lib/pdf-ticket");

const router = new Router();

function generateReservationId() {
  const ts = Date.now().toString().slice(-6);
  const rnd = Math.floor(1000 + Math.random() * 9000);
  return `MTG-${ts}${rnd}`;
}

function isValidEmail(v) {
  return typeof v === "string" && /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v);
}

// Maps a reservations row (snake_case, as Postgres returns it) to the
// exact camelCase shape the frontend and admin panel have always
// received from this API - see the old in-memory `reservation` object
// this replaces for the authoritative field list.
function toApiShape(row) {
  if (!row) return row;
  return {
    id: row.id,
    slug: row.slug,
    tourName: { en: row.tour_name_en, tr: row.tour_name_tr },
    date: row.date,
    lang: row.lang,
    pricingMode: row.pricing_mode,
    adults: row.adults,
    children: row.children,
    infants: row.infants,
    single: row.single_count,
    double: row.double_count,
    customer: row.customer,
    firstName: row.first_name,
    lastName: row.last_name,
    email: row.email,
    phone: row.phone,
    country: row.country,
    hotelName: row.hotel_name,
    notes: row.notes,
    paymentMethod: row.payment_method,
    total: Number(row.total),
    status: row.status,
    createdAt: row.created_at,
  };
}

async function logActivity(fields) {
  const { error } = await supabase.from("activity_log").insert({
    action: fields.action,
    reservation_id: fields.reservationId ?? null,
    customer: fields.customer ?? null,
    tour_name: fields.tourName ?? null,
    slug: fields.slug ?? null,
    by: fields.by || "System",
  });
  if (error) console.error("[activity_log] insert failed:", error.message);
}

// Guests can submit up to 5 reservations per hour per IP - generous for
// real use, tight enough to block scripted abuse.
const createLimiter = rateLimit({
  windowMs: 60 * 60 * 1000,
  max: 5,
  message: { error: "Too many reservations submitted. Please contact us directly if you need to book more." },
});

// ---- POST /api/reservations (public - guest checkout) ----
router.post("/", createLimiter, async (req, res) => {
  const b = req.body || {};
  const required = ["slug", "tourNameEn", "date", "firstName", "lastName", "email", "total"];
  const missing = required.filter((k) => !b[k] && b[k] !== 0);
  if (missing.length) {
    return res.status(400).json({ error: `Missing required fields: ${missing.join(", ")}` });
  }
  if (!isValidEmail(b.email)) {
    return res.status(400).json({ error: "Invalid email address." });
  }

  const DAY_KEYS = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];

  const { data: tourRecord, error: tourErr } = await supabase
    .from("tours").select("id, is_island, available_days").eq("slug", b.slug).maybeSingle();
  if (tourErr) return res.status(500).json({ error: "Could not look up the tour. Please try again." });

  if (tourRecord && Array.isArray(tourRecord.available_days) && tourRecord.available_days.length) {
    const requestedDate = new Date(b.date + "T00:00:00");
    const dayKey = DAY_KEYS[requestedDate.getDay()];
    if (!tourRecord.available_days.includes(dayKey)) {
      return res.status(400).json({ error: "This tour is not available on the selected day. Please choose a different date." });
    }
  }
  if (tourRecord && tourRecord.is_island) {
    // Same rule as the calendar widget's minimum date, enforced here as
    // the authoritative check - a request can never bypass this by
    // going around the calendar UI, and it doesn't depend on the
    // frontend's live-data fetch having completed in time. The number of
    // days comes from Admin -> Settings -> Booking Rules
    // (island_min_advance_days) instead of being hardcoded, so changing
    // that setting actually takes effect here too.
    const { data: settingsRow } = await supabase.from("settings").select("island_min_advance_days").eq("id", 1).maybeSingle();
    const rawAdvance = Number(settingsRow && settingsRow.island_min_advance_days);
    const advanceDays = Number.isFinite(rawAdvance) && rawAdvance >= 0 ? rawAdvance : 1;
    const todayStr = new Date().toLocaleDateString("en-CA", { timeZone: "Europe/Istanbul" }); // YYYY-MM-DD
    const minDate = new Date(todayStr + "T00:00:00");
    minDate.setDate(minDate.getDate() + advanceDays);
    const minDateStr = minDate.toISOString().slice(0, 10);
    if (b.date < minDateStr) {
      const unit = advanceDays === 1 ? "day's" : "days'";
      return res.status(400).json({ error: `This tour requires at least ${advanceDays} ${unit} advance booking. Please choose a later date.` });
    }
  }

  // Idempotency / double-submit guard: if this exact guest already booked
  // this exact tour for this exact date in roughly the last minute, this
  // is almost certainly the same submission arriving twice (a slow
  // response that made the browser's request time out and retry, a
  // double-click that got past the frontend's own guard, or a flaky
  // connection resending the same POST) rather than a genuine second
  // booking - nobody books the same tour on the same day twice within
  // seconds of the first attempt. Return the reservation that already
  // exists instead of creating a duplicate.
  const dupWindowStart = new Date(Date.now() - 60 * 1000).toISOString();
  const { data: recentDuplicate } = await supabase
    .from("reservations").select("*")
    .eq("email", b.email).eq("slug", b.slug).eq("date", b.date)
    .gte("created_at", dupWindowStart)
    .order("created_at", { ascending: false }).limit(1).maybeSingle();
  if (recentDuplicate) {
    return res.status(201).json(toApiShape(recentDuplicate));
  }

  const reservationId = generateReservationId();
  const insertRow = {
    id: reservationId,
    tour_id: tourRecord ? tourRecord.id : null,
    slug: b.slug,
    tour_name_en: b.tourNameEn,
    tour_name_tr: b.tourNameTr || b.tourNameEn,
    date: b.date,
    lang: ["en", "tr", "de", "ru", "pl"].includes(b.lang) ? b.lang : "tr",
    pricing_mode: b.pricingMode === "single_double" ? "single_double" : "standard",
    adults: b.adults || 0,
    children: b.children || 0,
    infants: b.infants || 0,
    single_count: b.single || 0,
    double_count: b.double || 0,
    customer: `${b.firstName} ${b.lastName}`,
    first_name: b.firstName,
    last_name: b.lastName,
    email: b.email,
    phone: b.phone || "",
    country: b.country || "",
    hotel_name: b.hotelName || "",
    notes: b.notes || "",
    payment_method: b.paymentMethod || "reserve_pay_later",
    total: b.total,
    status: "Pending",
  };

  const { data: inserted, error: insertErr } = await supabase.from("reservations").insert(insertRow).select().single();
  if (insertErr) {
    console.error("[reservations] insert failed:", insertErr.message);
    return res.status(500).json({ error: "Could not save the reservation. Please try again." });
  }
  const reservation = toApiShape(inserted);

  await logActivity({ action: "Reservation Created", reservationId: reservation.id, customer: reservation.customer, tourName: reservation.tourName.en, slug: reservation.slug });
  const { error: notifErr } = await supabase.from("notifications").insert({
    id: "notif-" + Math.random().toString(36).slice(2, 10),
    type: "new_reservation",
    reservation_id: reservation.id,
    customer: reservation.customer,
    tour: reservation.tourName.en,
    slug: reservation.slug,
    read: false,
  });
  if (notifErr) console.error("[notifications] insert failed:", notifErr.message);

  // Respond as soon as the booking itself is safely saved - that's the
  // part the guest is actually waiting on. PDF generation and sending two
  // emails each involve a real network round-trip (a full SMTP handshake
  // per email); returning now and doing that work after removes any
  // chance of the frontend's own request timeout firing on a slow SMTP
  // provider and causing a duplicate submit. The idempotency guard above
  // still covers any request that somehow gets resent anyway.
  res.status(201).json(reservation);

  const { data: settingsRow2 } = await supabase.from("settings").select("*").eq("id", 1).maybeSingle();
  const site = settingsRow2 || {};
  const company = {
    whatsapp: site.whatsapp || "",
    phone: site.phone || "",
  };
  const ownerEmail = site.email || process.env.OWNER_NOTIFICATION_EMAIL || process.env.ADMIN_EMAIL;

  // Read fresh at send-time (not from anything captured when the booking
  // was made) so the voucher always reflects whatever the admin currently
  // has set for this tour, same "one source of truth" as the website.
  const { data: tourNow } = await supabase.from("tours").select("departure_time, return_time").eq("slug", reservation.slug).maybeSingle();
  const tourTimes = { departureTime: tourNow && tourNow.departure_time, returnTime: tourNow && tourNow.return_time };

  let ticketPdf = null;
  try {
    ticketPdf = await generateTicketPdf(reservation, company, tourTimes);
  } catch (err) {
    console.error("[pdf-ticket] generation failed:", err.message);
  }
  const attachment = ticketPdf
    ? { filename: `MT-Group-Travel-${reservation.id}.pdf`, contentType: "application/pdf", content: ticketPdf }
    : undefined;

  const emailResults = await Promise.allSettled([
    sendMail({ to: reservation.email, ...customerConfirmationEmail(reservation, company), attachment }),
    ownerEmail ? sendMail({ to: ownerEmail, ...ownerNotificationEmail(reservation) }) : Promise.resolve({ sent: false, reason: "OWNER_NOTIFICATION_EMAIL not set" }),
  ]);

  const [customerResult, ownerResult] = emailResults;
  const customerOk = customerResult.status === "fulfilled" && customerResult.value.sent;
  const ownerOk = ownerResult.status === "fulfilled" && ownerResult.value.sent;
  if (!customerOk) {
    const reason = customerResult.status === "rejected" ? customerResult.reason.message : customerResult.value.reason;
    await logActivity({ action: `Customer email NOT sent (${reason})`, reservationId: reservation.id, customer: reservation.customer, tourName: reservation.tourName.en, slug: reservation.slug });
  } else {
    await logActivity({ action: "Customer confirmation email sent", reservationId: reservation.id, customer: reservation.customer, tourName: reservation.tourName.en, slug: reservation.slug });
  }
  if (!ownerOk) {
    const reason = ownerResult.status === "rejected" ? ownerResult.reason.message : ownerResult.value.reason;
    await logActivity({ action: `Owner notification email NOT sent (${reason})`, reservationId: reservation.id, customer: reservation.customer, tourName: reservation.tourName.en, slug: reservation.slug });
  } else {
    await logActivity({ action: "Owner notification email sent", reservationId: reservation.id, customer: reservation.customer, tourName: reservation.tourName.en, slug: reservation.slug });
  }
});

// ---- GET /api/reservations (admin - list with filters) ----
router.get("/", requireAuth, async (req, res) => {
  const { status, search, page = "1", perPage = "20", sort = "created_desc" } = req.query;

  let query = supabase.from("reservations").select("*", { count: "exact" });
  if (status && status !== "all") query = query.eq("status", status);
  if (search) {
    const s = search.replace(/[%_]/g, "\\$&");
    // id/first_name/last_name/email/tour_name_en, case-insensitive
    query = query.or(
      `id.ilike.%${s}%,first_name.ilike.%${s}%,last_name.ilike.%${s}%,email.ilike.%${s}%,tour_name_en.ilike.%${s}%`
    );
  }

  const sorters = {
    created_desc: { column: "created_at", ascending: false },
    created_asc: { column: "created_at", ascending: true },
    date_asc: { column: "date", ascending: true },
    date_desc: { column: "date", ascending: false },
    total_desc: { column: "total", ascending: false },
    total_asc: { column: "total", ascending: true },
  };
  const s = sorters[sort] || sorters.created_desc;
  query = query.order(s.column, { ascending: s.ascending });

  const p = Math.max(1, parseInt(page, 10) || 1);
  const pp = Math.max(1, parseInt(perPage, 10) || 20);
  query = query.range((p - 1) * pp, p * pp - 1);

  const { data, error, count } = await query;
  if (error) return res.status(500).json({ error: "Could not load reservations." });

  res.json({ results: (data || []).map(toApiShape), total: count || 0, page: p, perPage: pp });
});

// ---- GET /api/reservations/:id (admin) ----
router.get("/:id", requireAuth, async (req, res) => {
  const { data, error } = await supabase.from("reservations").select("*").eq("id", req.params.id).maybeSingle();
  if (error) return res.status(500).json({ error: "Could not load the reservation." });
  if (!data) return res.status(404).json({ error: "Reservation not found." });
  res.json(toApiShape(data));
});

// ---- PATCH /api/reservations/:id (admin - status and/or notes) ----
router.patch("/:id", requireAuth, async (req, res) => {
  const { status, notes } = req.body || {};
  const validStatuses = ["Pending", "Confirmed", "Completed", "Cancelled"];
  if (status && !validStatuses.includes(status)) {
    return res.status(400).json({ error: `Status must be one of: ${validStatuses.join(", ")}` });
  }

  const { data: existing, error: fetchErr } = await supabase.from("reservations").select("status").eq("id", req.params.id).maybeSingle();
  if (fetchErr) return res.status(500).json({ error: "Could not load the reservation." });
  if (!existing) return res.status(404).json({ error: "Reservation not found." });

  const patch = {};
  if (status) patch.status = status;
  if (notes !== undefined) patch.notes = notes;

  const { data: updatedRow, error: updateErr } = await supabase
    .from("reservations").update(patch).eq("id", req.params.id).select().single();
  if (updateErr) return res.status(500).json({ error: "Could not update the reservation." });
  const updated = toApiShape(updatedRow);

  const statusChanged = status && status !== existing.status;
  if (statusChanged) {
    await logActivity({ action: `Reservation ${status}`, reservationId: updated.id, customer: updated.customer, tourName: updated.tourName.en, slug: updated.slug });
  }
  if (notes !== undefined) {
    await logActivity({ action: "Notes Updated", reservationId: updated.id, customer: updated.customer, tourName: updated.tourName.en, slug: updated.slug });
  }

  if (statusChanged) {
    try {
      const result = await sendMail({ to: updated.email, ...statusUpdateEmail(updated) });
      await logActivity({ action: result.sent ? "Status update email sent" : `Status update email NOT sent (${result.reason})`, reservationId: updated.id, customer: updated.customer, tourName: updated.tourName.en, slug: updated.slug });
    } catch (err) {
      await logActivity({ action: `Status update email NOT sent (${err.message})`, reservationId: updated.id, customer: updated.customer, tourName: updated.tourName.en, slug: updated.slug });
    }
  }

  res.json(updated);
});

// ---- POST /api/reservations/:id/email (admin - send a custom message to the guest) ----
router.post("/:id/email", requireAuth, async (req, res) => {
  const { subject, message } = req.body || {};
  if (!subject || !subject.trim() || !message || !message.trim()) {
    return res.status(400).json({ error: "Subject and message are required." });
  }
  const { data: row, error: fetchErr } = await supabase.from("reservations").select("*").eq("id", req.params.id).maybeSingle();
  if (fetchErr) return res.status(500).json({ error: "Could not load the reservation." });
  if (!row) return res.status(404).json({ error: "Reservation not found." });
  const reservation = toApiShape(row);

  try {
    const result = await sendMail({ to: reservation.email, ...adminCustomEmail(reservation, subject.trim(), message.trim()) });
    await logActivity({ action: result.sent ? "Custom email sent to guest" : `Custom email NOT sent (${result.reason})`, reservationId: reservation.id, customer: reservation.customer, tourName: reservation.tourName.en, slug: reservation.slug });
    if (!result.sent) {
      return res.status(502).json({ error: result.reason || "Could not send the email. Please check the SMTP configuration." });
    }
    res.json({ sent: true });
  } catch (err) {
    await logActivity({ action: `Custom email NOT sent (${err.message})`, reservationId: reservation.id, customer: reservation.customer, tourName: reservation.tourName.en, slug: reservation.slug });
    res.status(502).json({ error: "Could not send the email. Please check the SMTP configuration." });
  }
});

// ---- DELETE /api/reservations/:id ----
router.delete("/:id", requireAuth, async (req, res) => {
  const { data: found, error: fetchErr } = await supabase.from("reservations").select("*").eq("id", req.params.id).maybeSingle();
  if (fetchErr) return res.status(500).json({ error: "Could not load the reservation." });
  if (!found) return res.status(404).json({ error: "Reservation not found." });

  const { error: deleteErr } = await supabase.from("reservations").delete().eq("id", req.params.id);
  if (deleteErr) return res.status(500).json({ error: "Could not delete the reservation." });

  // Remove every existing activity log entry that references this
  // reservation (its creation, status changes, email results, etc.) -
  // Recent Activity is meant to reflect current state, not keep a trail
  // pointing at reservations that no longer exist.
  await supabase.from("activity_log").delete().eq("reservation_id", req.params.id);
  // Then record the deletion itself as its own event. This one won't
  // have a reservation_id (there's nothing left to point at), so a
  // future deletion of a different reservation won't filter it out.
  await logActivity({ action: "Reservation Deleted", reservationId: null, customer: found.customer || null, tourName: found.tour_name_en || null, slug: found.slug || null });

  res.json({ deleted: true, id: req.params.id });
});

module.exports = router;
