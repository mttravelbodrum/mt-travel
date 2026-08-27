/**
 * routes/hotels.js
 * Public: GET list (powers the searchable hotel-name field on the
 * booking page).
 * Admin-only: create, update, delete (Admin -> Hotels).
 *
 * Data layer: Supabase (see lib/supabase.js).
 */
const { Router } = require("../lib/router");
const { requireAuth } = require("../middleware/auth");
const { supabase } = require("../lib/supabase");

const router = new Router();

function generateHotelId() {
  return "htl-" + Date.now().toString(36) + Math.random().toString(36).slice(2, 7);
}

// ---- GET /api/hotels (public) ----
router.get("/", async (req, res) => {
  // Postgres's default collation does not sort Turkish I/i/İ/ı the way a
  // Turkish-alphabetized list needs (same reason the old JSON-store
  // version called localeCompare(name, "tr")) - ORDER BY name alone would
  // put e.g. "Işıl..." and "İçmeler..." in the wrong relative order, so
  // sorting is done here in JS with the same 'tr' locale instead of in
  // the query.
  const { data, error } = await supabase.from("hotels").select("*");
  if (error) return res.status(500).json({ error: "Could not load hotels." });
  const hotels = (data || []).slice().sort((a, b) => a.name.localeCompare(b.name, "tr"));
  res.json(hotels);
});

// ---- POST /api/hotels (admin) ----
router.post("/", requireAuth, async (req, res) => {
  const name = (req.body && req.body.name || "").trim();
  if (!name) return res.status(400).json({ error: "Hotel name is required." });

  // Case-insensitive duplicate check, same rule as before (a unique
  // index on lower(name) in the schema also backstops this at the DB
  // level against a race between two simultaneous requests).
  const { data: dupes } = await supabase.from("hotels").select("id").ilike("name", name);
  if (dupes && dupes.length) {
    // Same "silently accept, don't error" behavior as the old store:
    // the caller gets back a hotel object either way.
    const { data: existingRow } = await supabase.from("hotels").select("*").ilike("name", name).limit(1).single();
    return res.status(201).json(existingRow);
  }

  const hotel = { id: generateHotelId(), name };
  const { data: created, error } = await supabase.from("hotels").insert(hotel).select().single();
  if (error) return res.status(500).json({ error: "Could not add the hotel." });
  res.status(201).json(created);
});

// ---- PUT /api/hotels/:id (admin) ----
router.put("/:id", requireAuth, async (req, res) => {
  const name = (req.body && req.body.name || "").trim();
  if (!name) return res.status(400).json({ error: "Hotel name is required." });

  const { data: updated, error } = await supabase
    .from("hotels").update({ name }).eq("id", req.params.id).select().maybeSingle();
  if (error) return res.status(500).json({ error: "Could not update the hotel." });
  if (!updated) return res.status(404).json({ error: "Hotel not found." });
  res.json(updated);
});

// ---- DELETE /api/hotels/:id (admin) ----
router.delete("/:id", requireAuth, async (req, res) => {
  const { data: existing } = await supabase.from("hotels").select("id").eq("id", req.params.id).maybeSingle();
  if (!existing) return res.status(404).json({ error: "Hotel not found." });

  const { error } = await supabase.from("hotels").delete().eq("id", req.params.id);
  if (error) return res.status(500).json({ error: "Could not delete the hotel." });
  res.json({ deleted: true });
});

module.exports = router;
