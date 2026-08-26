/**
 * routes/tours.js
 * Public: GET list/one (powers the live site instead of the static
 * tours.json export, once you're ready to switch).
 * Admin-only: create, update, delete.
 */
const { Router } = require("../lib/router");
const { requireAuth } = require("../middleware/auth");
const { transaction, readAll } = require("../lib/store");

const router = new Router();

function slugify(name) {
  return name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/(^-|-$)/g, "");
}

// ---- GET /api/tours (public) ----
router.get("/", (req, res) => {
  const { category, visibleOnly } = req.query;
  let tours = readAll().tours;
  if (category && category !== "all") tours = tours.filter((t) => t.category === category);
  if (visibleOnly === "true") tours = tours.filter((t) => t.visible);
  tours = [...tours].sort((a, b) => new Date(b.createdAt) - new Date(a.createdAt));
  res.json(tours);
});

// ---- GET /api/tours/:slug (public) ----
router.get("/:slug", (req, res) => {
  const tour = readAll().tours.find((t) => t.slug === req.params.slug);
  if (!tour) return res.status(404).json({ error: "Tour not found." });
  res.json(tour);
});

const ALL_DAYS = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"];

// ---- POST /api/tours (admin) ----
router.post("/", requireAuth, async (req, res) => {
  const b = req.body || {};
  if (!b.name || !b.category || b.price == null) {
    return res.status(400).json({ error: "name, category and price are required." });
  }
  const slug = b.slug || slugify(b.name);

  let conflict = false;
  let created = null;
  await transaction((data) => {
    if (data.tours.some((t) => t.slug === slug)) { conflict = true; return; }
    created = {
      slug, category: b.category, isIsland: !!b.isIsland, badge: b.badge || "none",
      name: b.name, price: b.price, durationHours: b.durationHours || null,
      priceAdult: b.priceAdult != null ? b.priceAdult : b.price,
      priceChild: b.priceChild != null ? b.priceChild : Math.round(b.price * 0.5 * 100) / 100,
      priceInfant: b.priceInfant != null ? b.priceInfant : 0,
      rating: b.rating ?? 5.0, reviewCount: b.reviewCount ?? 0,
      featured: !!b.featured, visible: true,
      availableDays: Array.isArray(b.availableDays) ? b.availableDays : [...ALL_DAYS],
      createdAt: new Date().toISOString(),
    };
    data.tours.unshift(created);
  });

  if (conflict) return res.status(409).json({ error: `A tour with slug "${slug}" already exists.` });
  res.status(201).json(created);
});

// ---- PUT /api/tours/:slug (admin) ----
router.put("/:slug", requireAuth, async (req, res) => {
  const b = req.body || {};
  let updated = null;
  let notFound = false;
  await transaction((data) => {
    const t = data.tours.find((x) => x.slug === req.params.slug);
    if (!t) { notFound = true; return; }
    if (b.category !== undefined) t.category = b.category;
    if (b.isIsland !== undefined) t.isIsland = !!b.isIsland;
    if (b.badge !== undefined) t.badge = b.badge;
    if (b.name !== undefined) t.name = b.name;
    if (b.price !== undefined) t.price = b.price;
    if (b.priceAdult !== undefined) t.priceAdult = b.priceAdult;
    if (b.priceChild !== undefined) t.priceChild = b.priceChild;
    if (b.priceInfant !== undefined) t.priceInfant = b.priceInfant;
    if (b.pricingMode !== undefined) t.pricingMode = b.pricingMode;
    if (b.priceSingle !== undefined) t.priceSingle = b.priceSingle;
    if (b.priceDouble !== undefined) t.priceDouble = b.priceDouble;
    if (b.departureTime !== undefined) t.departureTime = b.departureTime;
    if (b.returnTime !== undefined) t.returnTime = b.returnTime;
    if (b.durationHours !== undefined) t.durationHours = b.durationHours;
    if (b.featured !== undefined) t.featured = !!b.featured;
    if (b.visible !== undefined) t.visible = !!b.visible;
    if (b.availableDays !== undefined) {
      if (!Array.isArray(b.availableDays) || !b.availableDays.every((d) => ALL_DAYS.includes(d))) {
        return; // leave updated as null -> falls through to a 400 below
      }
      t.availableDays = b.availableDays;
    }
    if (!t.availableDays) t.availableDays = [...ALL_DAYS]; // backfill older records on first touch
    updated = t;
  });
  if (notFound) return res.status(404).json({ error: "Tour not found." });
  if (!updated) return res.status(400).json({ error: "availableDays must be an array of valid day names." });
  res.json(updated);
});

// ---- DELETE /api/tours/:slug (admin) ----
router.delete("/:slug", requireAuth, async (req, res) => {
  let removed = false;
  await transaction((data) => {
    const before = data.tours.length;
    data.tours = data.tours.filter((t) => t.slug !== req.params.slug);
    removed = data.tours.length < before;
  });
  if (!removed) return res.status(404).json({ error: "Tour not found." });
  res.status(204).end();
});

module.exports = router;
