/**
 * routes/reservations.js
 *
 * Public: POST /api/reservations (guest creates a reservation - this is
 * what checkout.js's completeReservation() calls instead of writing to
 * localStorage, once the frontend is pointed at this API - see
 * assets/js/api-client.js in the site/ folder).
 *
 * Admin-only (requireAuth): list/filter, get one, update status/notes.
 */
const { Router } = require("../lib/router");
const { rateLimit } = require("../lib/ratelimit");
const { requireAuth } = require("../middleware/auth");
const { transaction, readAll, logActivity } = require("../lib/store");
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
  const allData = readAll();
  const tourRecord = allData.tours.find((t) => t.slug === b.slug);
  if (tourRecord && Array.isArray(tourRecord.availableDays) && tourRecord.availableDays.length) {
    const requestedDate = new Date(b.date + "T00:00:00");
    const dayKey = DAY_KEYS[requestedDate.getDay()];
    if (!tourRecord.availableDays.includes(dayKey)) {
      return res.status(400).json({ error: "This tour is not available on the selected day. Please choose a different date." });
    }
  }
  if (tourRecord && tourRecord.isIsland) {
    // Same rule as the calendar widget's minimum date, enforced here as
    // the authoritative check - a request can never bypass this by
    // going around the calendar UI, and it doesn't depend on the
    // frontend's live-data fetch having completed in time. The number of
    // days comes from Admin -> Settings -> Booking Rules (islandMinAdvanceDays)
    // instead of being hardcoded, so changing that setting actually takes
    // effect here too.
    const rawAdvance = Number(allData.settings && allData.settings.islandMinAdvanceDays);
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
  const dupWindowMs = 60 * 1000;
  const recentDuplicate = allData.reservations.find((r) =>
    r.email === b.email && r.slug === b.slug && r.date === b.date &&
    Date.now() - new Date(r.createdAt).getTime() < dupWindowMs
  );
  if (recentDuplicate) {
    return res.status(201).json(recentDuplicate);
  }

  const reservation = {
    id: generateReservationId(),
    slug: b.slug,
    tourName: { en: b.tourNameEn, tr: b.tourNameTr || b.tourNameEn },
    date: b.date,
    lang: ["en", "tr", "de", "ru", "pl"].includes(b.lang) ? b.lang : "tr",
    pricingMode: b.pricingMode === "single_double" ? "single_double" : "standard",
    adults: b.adults || 0,
    children: b.children || 0,
    infants: b.infants || 0,
    single: b.single || 0,
    double: b.double || 0,
    customer: `${b.firstName} ${b.lastName}`,
    firstName: b.firstName,
    lastName: b.lastName,
    email: b.email,
    phone: b.phone || "",
    country: b.country || "",
    hotelName: b.hotelName || "",
    notes: b.notes || "",
    paymentMethod: b.paymentMethod || "reserve_pay_later",
    total: b.total,
    status: "Pending",
    createdAt: new Date().toISOString(),
  };

  await transaction((data) => {
    data.reservations.unshift(reservation);
    logActivity(data, "Reservation Created", reservation);
    data.notifications.unshift({
      id: "notif-" + Math.random().toString(36).slice(2, 10),
      type: "new_reservation",
      reservationId: reservation.id,
      customer: reservation.customer,
      tour: reservation.tourName.en,
      slug: reservation.slug,
      createdAt: new Date().toISOString(),
      read: false,
    });
    data.notifications = data.notifications.slice(0, 100);
  });

  // Respond as soon as the booking itself is safely saved - that's the
  // part the guest is actually waiting on. PDF generation and sending two
  // emails each involve a real network round-trip (a full SMTP handshake
  // per email) and used to happen here, before responding; on a slow SMTP
  // provider that easily added several extra seconds, long enough to trip
  // the frontend's own request timeout even though the reservation had
  // already been saved - the browser would show an error and let the
  // guest submit again, creating a second, duplicate reservation for a
  // booking that had actually already succeeded. Returning now and doing
  // the email/PDF work after removes that window entirely; the duplicate
  // guard above still covers any request that somehow gets resent anyway.
  res.status(201).json(reservation);

  const site = readAll().settings;
  const company = {
    whatsapp: site.whatsapp || "",
    phone: site.phone || "",
  };
  const ownerEmail = site.email || process.env.OWNER_NOTIFICATION_EMAIL || process.env.ADMIN_EMAIL;

  // Read fresh at send-time (not from anything captured when the booking
  // was made) so the voucher always reflects whatever the admin currently
  // has set for this tour, same "one source of truth" as the website.
  const tourNow = readAll().tours.find((x) => x.slug === reservation.slug);
  const tourTimes = { departureTime: tourNow && tourNow.departureTime, returnTime: tourNow && tourNow.returnTime };

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

  await transaction((data) => {
    const [customerResult, ownerResult] = emailResults;
    const customerOk = customerResult.status === "fulfilled" && customerResult.value.sent;
    const ownerOk = ownerResult.status === "fulfilled" && ownerResult.value.sent;
    if (!customerOk) {
      const reason = customerResult.status === "rejected" ? customerResult.reason.message : customerResult.value.reason;
      logActivity(data, `Customer email NOT sent (${reason})`, reservation);
    } else {
      logActivity(data, "Customer confirmation email sent", reservation);
    }
    if (!ownerOk) {
      const reason = ownerResult.status === "rejected" ? ownerResult.reason.message : ownerResult.value.reason;
      logActivity(data, `Owner notification email NOT sent (${reason})`, reservation);
    } else {
      logActivity(data, "Owner notification email sent", reservation);
    }
  });
});

// ---- GET /api/reservations (admin - list with filters) ----
router.get("/", requireAuth, (req, res) => {
  const { status, search, page = "1", perPage = "20", sort = "created_desc" } = req.query;
  let all = readAll().reservations;

  if (status && status !== "all") {
    all = all.filter((r) => r.status === status);
  }
  if (search) {
    const s = search.toLowerCase();
    all = all.filter((r) =>
      r.id.toLowerCase().includes(s) ||
      r.firstName.toLowerCase().includes(s) ||
      r.lastName.toLowerCase().includes(s) ||
      r.email.toLowerCase().includes(s) ||
      (r.tourName.en || "").toLowerCase().includes(s)
    );
  }

  const sorters = {
    created_desc: (a, b) => new Date(b.createdAt) - new Date(a.createdAt),
    created_asc: (a, b) => new Date(a.createdAt) - new Date(b.createdAt),
    date_asc: (a, b) => a.date.localeCompare(b.date),
    date_desc: (a, b) => b.date.localeCompare(a.date),
    total_desc: (a, b) => b.total - a.total,
    total_asc: (a, b) => a.total - b.total,
  };
  all = [...all].sort(sorters[sort] || sorters.created_desc);

  const total = all.length;
  const p = Math.max(1, parseInt(page, 10) || 1);
  const pp = Math.max(1, parseInt(perPage, 10) || 20);
  const paged = all.slice((p - 1) * pp, p * pp);

  res.json({ results: paged, total, page: p, perPage: pp });
});

// ---- GET /api/reservations/:id (admin) ----
router.get("/:id", requireAuth, (req, res) => {
  const found = readAll().reservations.find((r) => r.id === req.params.id);
  if (!found) return res.status(404).json({ error: "Reservation not found." });
  res.json(found);
});

// ---- PATCH /api/reservations/:id (admin - status and/or notes) ----
router.patch("/:id", requireAuth, async (req, res) => {
  const { status, notes } = req.body || {};
  const validStatuses = ["Pending", "Confirmed", "Completed", "Cancelled"];
  if (status && !validStatuses.includes(status)) {
    return res.status(400).json({ error: `Status must be one of: ${validStatuses.join(", ")}` });
  }

  let updated = null;
  let notFound = false;
  let statusChanged = false;
  await transaction((data) => {
    const r = data.reservations.find((x) => x.id === req.params.id);
    if (!r) { notFound = true; return; }
    const oldStatus = r.status;
    if (status) r.status = status;
    if (notes !== undefined) r.notes = notes;
    updated = r;
    if (status && status !== oldStatus) {
      logActivity(data, `Reservation ${status}`, r);
      statusChanged = true;
    }
    if (notes !== undefined) {
      logActivity(data, "Notes Updated", r);
    }
  });

  if (!notFound && statusChanged) {
    try {
      const result = await sendMail({ to: updated.email, ...statusUpdateEmail(updated) });
      await transaction((data) => {
        const r = data.reservations.find((x) => x.id === req.params.id);
        logActivity(data, result.sent ? "Status update email sent" : `Status update email NOT sent (${result.reason})`, r);
      });
    } catch (err) {
      await transaction((data) => {
        const r = data.reservations.find((x) => x.id === req.params.id);
        logActivity(data, `Status update email NOT sent (${err.message})`, r);
      });
    }
  }

  if (notFound) return res.status(404).json({ error: "Reservation not found." });
  res.json(updated);
});

// ---- POST /api/reservations/:id/email (admin - send a custom message to the guest) ----
router.post("/:id/email", requireAuth, async (req, res) => {
  const { subject, message } = req.body || {};
  if (!subject || !subject.trim() || !message || !message.trim()) {
    return res.status(400).json({ error: "Subject and message are required." });
  }
  const reservation = readAll().reservations.find((r) => r.id === req.params.id);
  if (!reservation) return res.status(404).json({ error: "Reservation not found." });

  try {
    const result = await sendMail({ to: reservation.email, ...adminCustomEmail(reservation, subject.trim(), message.trim()) });
    await transaction((data) => {
      const r = data.reservations.find((x) => x.id === req.params.id);
      logActivity(data, result.sent ? "Custom email sent to guest" : `Custom email NOT sent (${result.reason})`, r);
    });
    if (!result.sent) {
      return res.status(502).json({ error: result.reason || "Could not send the email. Please check the SMTP configuration." });
    }
    res.json({ sent: true });
  } catch (err) {
    await transaction((data) => {
      const r = data.reservations.find((x) => x.id === req.params.id);
      logActivity(data, `Custom email NOT sent (${err.message})`, r);
    });
    res.status(502).json({ error: "Could not send the email. Please check the SMTP configuration." });
  }
});

// ---- DELETE /api/reservations/:id ----
router.delete("/:id", requireAuth, async (req, res) => {
  let found = null;
  let notFound = false;
  await transaction((data) => {
    const idx = data.reservations.findIndex((x) => x.id === req.params.id);
    if (idx === -1) { notFound = true; return; }
    found = data.reservations[idx];
    data.reservations.splice(idx, 1);
    // Remove every existing activity log entry that references this
    // reservation (its creation, status changes, email results, etc.) -
    // Recent Activity is meant to reflect current state, not keep a
    // trail pointing at reservations that no longer exist.
    data.activityLog = data.activityLog.filter((entry) => entry.reservationId !== req.params.id);
    // Then record the deletion itself as its own event. This one won't
    // have a reservationId (there's nothing left to point at), so a
    // future deletion of a different reservation won't filter it out.
    data.activityLog.unshift({
      id: "log-" + Math.random().toString(36).slice(2, 10),
      action: "Reservation Deleted",
      reservationId: null,
      customer: found.customer || null,
      tour: found.tourName ? found.tourName.en : null,
      slug: found.slug || null,
      by: "System",
      at: new Date().toISOString(),
    });
  });
  if (notFound) return res.status(404).json({ error: "Reservation not found." });
  res.json({ deleted: true, id: req.params.id });
});

module.exports = router;
