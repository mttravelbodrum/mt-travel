/**
 * lib/store.js — a tiny JSON-file database. No SQL, no native modules,
 * no npm install. Works on any Node.js version.
 *
 * ⚠ NO LONGER USED as of the Supabase migration - every route now reads
 * and writes through lib/supabase.js instead. Left in place, unused, as
 * a rollback reference and because backend/data/db.json is still a handy
 * offline copy of what was migrated. Safe to delete once you've verified
 * the Supabase-backed site in production; nothing requires this file.
 *
 * Deliberately chosen over a real SQL database for this project: the
 * whole "database" is one human-readable file you can open in a text
 * editor, back up by copying, or restore by pasting an old copy back.
 * That fits a small tourism operator far better than requiring a
 * database server. If you outgrow this later (very high traffic, many
 * concurrent staff), migrating to Postgres/MySQL is a contained change
 * limited to this one file — every route file calls only the methods
 * below, never touches the file format directly.
 */
const fs = require("node:fs");
const path = require("node:path");

const DB_PATH = process.env.DB_PATH || path.join(__dirname, "..", "data", "db.json");

const EMPTY = { reservations: [], tours: [], settings: {}, activityLog: [], notifications: [], hotels: [] };

function ensureFile() {
  fs.mkdirSync(path.dirname(DB_PATH), { recursive: true });
  if (!fs.existsSync(DB_PATH)) {
    fs.writeFileSync(DB_PATH, JSON.stringify(EMPTY, null, 2));
  }
}

function readAll() {
  ensureFile();
  try {
    const raw = fs.readFileSync(DB_PATH, "utf8");
    const data = JSON.parse(raw);
    return { ...EMPTY, ...data };
  } catch (err) {
    // A corrupted file should never crash the whole API - fail safe to empty.
    console.error("store.js: could not parse", DB_PATH, "- starting from an empty database.", err.message);
    return { ...EMPTY };
  }
}

// Synchronous, whole-file write. Simple and safe for this scale (a single
// small business's traffic) - every write is atomic from the OS's point
// of view because we write to a temp file then rename over the original.
function writeAll(data) {
  ensureFile();
  const tmp = DB_PATH + ".tmp";
  fs.writeFileSync(tmp, JSON.stringify(data, null, 2));
  fs.renameSync(tmp, DB_PATH);
}

// A very small mutex so two requests arriving in the same tick can't both
// read-modify-write and silently drop one one another's change.
let queue = Promise.resolve();
function transaction(fn) {
  queue = queue.then(() => {
    const data = readAll();
    const result = fn(data);
    writeAll(data);
    return result;
  });
  return queue;
}

// Shared activity-log helper - used by both routes/reservations.js and
// routes/misc.js (customer deletion), so it lives here rather than being
// duplicated or left inaccessible to one of them.
function logActivity(data, action, context) {
  data.activityLog.unshift({
    id: "log-" + Math.random().toString(36).slice(2, 10),
    action,
    reservationId: context?.id || null,
    customer: context?.customer || null,
    tour: context?.tourName?.en || null,
    slug: context?.slug || null,
    by: "System",
    at: new Date().toISOString(),
  });
  data.activityLog = data.activityLog.slice(0, 200);
}

module.exports = { readAll, writeAll, transaction, logActivity, DB_PATH };
