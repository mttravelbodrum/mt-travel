/**
 * routes/tours.js
 * Public: GET list/one (operational fields only - price, hours,
 * visibility, availability. Full translated content/images/program/faq
 * live in tour_translations/tour_images and are read by the static site
 * generator, not this API - see supabase/migrations/001_initial_schema.sql
 * for why that split exists).
 * Admin-only: create, update, delete.
 *
 * Data layer: Supabase (see lib/supabase.js).
 */
const { Router } = require("../lib/router");
const { requireAuth } = require("../middleware/auth");
const { supabase } = require("../lib/supabase");

const router = new Router();

function slugify(name) {
  return name.toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/(^-|-$)/g, "");
}

// Maps a tours row (snake_case) to the exact camelCase shape this API
// has always returned.
function toApiShape(row) {
  if (!row) return row;
  return {
    slug: row.slug,
    category: row.category,
    isIsland: row.is_island,
    badge: row.badge,
    name: row.name,
    price: Number(row.price),
    durationHours: row.duration_hours != null ? Number(row.duration_hours) : null,
    rating: Number(row.rating),
    reviewCount: row.review_count,
    featured: row.featured,
    visible: row.visible,
    availableDays: row.available_days,
    priceAdult: row.price_adult != null ? Number(row.price_adult) : null,
    priceChild: row.price_child != null ? Number(row.price_child) : null,
    priceInfant: row.price_infant != null ? Number(row.price_infant) : 0,
    pricingMode: row.pricing_mode,
    priceSingle: row.price_single != null ? Number(row.price_single) : null,
    priceDouble: row.price_double != null ? Number(row.price_double) : null,
    departureTime: row.departure_time,
    returnTime: row.return_time,
    createdAt: row.created_at,
  };
}

// This backend table has no `name` field of its own in the admin's Tour
// form beyond the single English-ish display name it was seeded with -
// full i18n names live in tour_translations. Kept here unchanged from
// the JSON-store version so the admin panel's existing form keeps working.

// ---- GET /api/tours (public) ----
router.get("/", async (req, res) => {
  const { category, visibleOnly } = req.query;
  let query = supabase.from("tours").select("*");
  if (category && category !== "all") query = query.eq("category", category);
  if (visibleOnly === "true") query = query.eq("visible", true);
  query = query.order("created_at", { ascending: false });

  const { data, error } = await query;
  if (error) return res.status(500).json({ error: "Could not load tours." });
  res.json((data || []).map(toApiShape));
});

// ---- GET /api/tours/:slug (public) ----
router.get("/:slug", async (req, res) => {
  const { data, error } = await supabase.from("tours").select("*").eq("slug", req.params.slug).maybeSingle();
  if (error) return res.status(500).json({ error: "Could not load the tour." });
  if (!data) return res.status(404).json({ error: "Tour not found." });
  res.json(toApiShape(data));
});

const ALL_DAYS = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"];

// ---- POST /api/tours (admin) ----
router.post("/", requireAuth, async (req, res) => {
  const b = req.body || {};
  if (!b.name || !b.category || b.price == null) {
    return res.status(400).json({ error: "name, category and price are required." });
  }
  const slug = b.slug || slugify(b.name);

  const { data: existing } = await supabase.from("tours").select("slug").eq("slug", slug).maybeSingle();
  if (existing) return res.status(409).json({ error: `A tour with slug "${slug}" already exists.` });

  const insertRow = {
    slug, category: b.category, is_island: !!b.isIsland, badge: b.badge || "none",
    name: b.name, price: b.price, duration_hours: b.durationHours || null,
    price_adult: b.priceAdult != null ? b.priceAdult : b.price,
    price_child: b.priceChild != null ? b.priceChild : Math.round(b.price * 0.5 * 100) / 100,
    price_infant: b.priceInfant != null ? b.priceInfant : 0,
    rating: b.rating ?? 5.0, review_count: b.reviewCount ?? 0,
    featured: !!b.featured, visible: true,
    available_days: Array.isArray(b.availableDays) ? b.availableDays : [...ALL_DAYS],
  };

  const { data: created, error: insertErr } = await supabase.from("tours").insert(insertRow).select().single();
  if (insertErr) return res.status(500).json({ error: "Could not create the tour." });
  res.status(201).json(toApiShape(created));
});

// ---- PUT /api/tours/:slug (admin) ----
router.put("/:slug", requireAuth, async (req, res) => {
  const b = req.body || {};
  const { data: existing, error: fetchErr } = await supabase.from("tours").select("*").eq("slug", req.params.slug).maybeSingle();
  if (fetchErr) return res.status(500).json({ error: "Could not load the tour." });
  if (!existing) return res.status(404).json({ error: "Tour not found." });

  const patch = {};
  if (b.category !== undefined) patch.category = b.category;
  if (b.isIsland !== undefined) patch.is_island = !!b.isIsland;
  if (b.badge !== undefined) patch.badge = b.badge;
  if (b.name !== undefined) patch.name = b.name;
  if (b.price !== undefined) patch.price = b.price;
  if (b.priceAdult !== undefined) patch.price_adult = b.priceAdult;
  if (b.priceChild !== undefined) patch.price_child = b.priceChild;
  if (b.priceInfant !== undefined) patch.price_infant = b.priceInfant;
  if (b.pricingMode !== undefined) patch.pricing_mode = b.pricingMode;
  if (b.priceSingle !== undefined) patch.price_single = b.priceSingle;
  if (b.priceDouble !== undefined) patch.price_double = b.priceDouble;
  if (b.departureTime !== undefined) patch.departure_time = b.departureTime;
  if (b.returnTime !== undefined) patch.return_time = b.returnTime;
  if (b.durationHours !== undefined) patch.duration_hours = b.durationHours;
  if (b.featured !== undefined) patch.featured = !!b.featured;
  if (b.visible !== undefined) patch.visible = !!b.visible;
  if (b.availableDays !== undefined) {
    if (!Array.isArray(b.availableDays) || !b.availableDays.every((d) => ALL_DAYS.includes(d))) {
      return res.status(400).json({ error: "availableDays must be an array of valid day names." });
    }
    patch.available_days = b.availableDays;
  }
  if (!existing.available_days) patch.available_days = patch.available_days || [...ALL_DAYS]; // backfill older records on first touch

  const { data: updated, error: updateErr } = await supabase
    .from("tours").update(patch).eq("slug", req.params.slug).select().single();
  if (updateErr) return res.status(500).json({ error: "Could not update the tour." });
  res.json(toApiShape(updated));
});

// ---- DELETE /api/tours/:slug (admin) ----
router.delete("/:slug", requireAuth, async (req, res) => {
  const { data: existing } = await supabase.from("tours").select("slug").eq("slug", req.params.slug).maybeSingle();
  if (!existing) return res.status(404).json({ error: "Tour not found." });

  const { error } = await supabase.from("tours").delete().eq("slug", req.params.slug);
  if (error) return res.status(500).json({ error: "Could not delete the tour." });
  res.status(204).end();
});

module.exports = router;
