/**
 * lib/supabase.js
 *
 * The backend's one and only connection to the database. Uses the
 * SECRET (service_role) key, never the publishable one - this file only
 * ever runs server-side, so RLS is intentionally bypassed here exactly
 * like it always effectively was with the old JSON-file store (which
 * had no row-level access control of its own either). Every route
 * still enforces who's allowed to do what via requireAuth
 * (middleware/auth.js) - RLS in Supabase is the second, independent
 * layer described in supabase/migrations/002_rls_policies.sql, not a
 * replacement for it.
 *
 * Fails fast and clearly if the required env vars are missing, instead
 * of limping along and throwing confusing errors from deep inside a
 * query later.
 */
const { createClient } = require("@supabase/supabase-js");

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SECRET_KEY = process.env.SUPABASE_SECRET_KEY;

if (!SUPABASE_URL || !SUPABASE_SECRET_KEY) {
  throw new Error(
    "Missing Supabase configuration. Set SUPABASE_URL and SUPABASE_SECRET_KEY " +
    "in backend/.env (copy backend/.env.example if you haven't yet, then fill " +
    "in the real values from your Supabase project's Settings -> API page)."
  );
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SECRET_KEY, {
  auth: { persistSession: false }, // server-side only, no browser session to keep
});

module.exports = { supabase };
