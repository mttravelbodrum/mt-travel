/**
 * routes/hotels.js
 * Public: GET list (powers the searchable hotel-name field on the
 * booking page).
 * Admin-only: create, update, delete (Admin -> Hotels).
 */
const { Router } = require("../lib/router");
const { requireAuth } = require("../middleware/auth");
const { transaction, readAll } = require("../lib/store");

const router = new Router();

function generateHotelId() {
  return "htl-" + Date.now().toString(36) + Math.random().toString(36).slice(2, 7);
}

// ---- GET /api/hotels (public) ----
router.get("/", (req, res) => {
  // 'tr' locale matters here specifically for I/i/İ/ı - without it,
  // sorting silently falls back to treating "İ" and "I" as equivalent to
  // plain "i", which puts e.g. "Işıl..." and "İçmeler..." in the wrong
  // relative order for a Turkish-alphabetized list.
  const hotels = (readAll().hotels || []).slice().sort((a, b) => a.name.localeCompare(b.name, "tr"));
  res.json(hotels);
});

// ---- POST /api/hotels (admin) ----
router.post("/", requireAuth, async (req, res) => {
  const name = (req.body && req.body.name || "").trim();
  if (!name) return res.status(400).json({ error: "Hotel name is required." });

  const hotel = { id: generateHotelId(), name, createdAt: new Date().toISOString() };
  await transaction((data) => {
    if (!data.hotels) data.hotels = [];
    const exists = data.hotels.some((h) => h.name.toLowerCase() === name.toLowerCase());
    if (exists) return;
    data.hotels.push(hotel);
  });
  res.status(201).json(hotel);
});

// ---- PUT /api/hotels/:id (admin) ----
router.put("/:id", requireAuth, async (req, res) => {
  const name = (req.body && req.body.name || "").trim();
  if (!name) return res.status(400).json({ error: "Hotel name is required." });

  let updated = null;
  await transaction((data) => {
    const hotel = (data.hotels || []).find((h) => h.id === req.params.id);
    if (!hotel) return;
    hotel.name = name;
    updated = hotel;
  });
  if (!updated) return res.status(404).json({ error: "Hotel not found." });
  res.json(updated);
});

// ---- DELETE /api/hotels/:id (admin) ----
router.delete("/:id", requireAuth, async (req, res) => {
  let deleted = false;
  await transaction((data) => {
    const before = (data.hotels || []).length;
    data.hotels = (data.hotels || []).filter((h) => h.id !== req.params.id);
    deleted = data.hotels.length < before;
  });
  if (!deleted) return res.status(404).json({ error: "Hotel not found." });
  res.json({ deleted: true });
});

module.exports = router;
