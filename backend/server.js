/**
 * server.js - MT Travel backend entry point.
 *
 * Run with:  node server.js   (that's it - no npm install, no build step)
 * Requires plain Node.js 18+. See README.md in this folder for full
 * setup, deployment options, and how to point the frontend at this API.
 *
 * Zero third-party dependencies on purpose: everything here runs on
 * Node's own built-in modules (http, crypto, fs), so there is nothing
 * to `npm install`, nothing that can fail to compile, and nothing to
 * keep patched for security beyond Node itself.
 */
const http = require("node:http");
const { loadEnv } = require("./lib/env");
loadEnv();

const { Router } = require("./lib/router");
const { rateLimit } = require("./lib/ratelimit");

const authRoutes = require("./routes/auth");
const reservationRoutes = require("./routes/reservations");
const tourRoutes = require("./routes/tours");
const hotelRoutes = require("./routes/hotels");
const miscRoutes = require("./routes/misc");

// ---- Required configuration check (fail loudly at startup, not silently at request time) ----
const REQUIRED_ENV = ["ADMIN_EMAIL", "ADMIN_PASSWORD_HASH", "SESSION_SECRET"];
const missingEnv = REQUIRED_ENV.filter((k) => !process.env[k]);
if (missingEnv.length) {
  console.error(`\nMissing required .env values: ${missingEnv.join(", ")}`);
  console.error(`Copy .env.example to .env and fill these in (see README.md "Setup").`);
  console.error(`Tip: generate ADMIN_PASSWORD_HASH by running:  node hash-password.js yourpassword\n`);
  process.exit(1);
}

const app = new Router();
app.use("/api/auth", authRoutes);
app.use("/api/reservations", reservationRoutes);
app.use("/api/tours", tourRoutes);
app.use("/api/hotels", hotelRoutes);
app.use("/api", miscRoutes); // /api/settings, /api/customers, /api/activity-log, /api/stats, /api/contact

const generalLimiter = rateLimit({ windowMs: 15 * 60 * 1000, max: 300 });

const allowedOrigins = (process.env.FRONTEND_ORIGIN || "").split(",").map((s) => s.trim()).filter(Boolean);
// Matches http(s)://localhost:ANY_PORT or http(s)://127.0.0.1:ANY_PORT - so serving
// the frontend on a different local port than whatever FRONTEND_ORIGIN happens to
// list (a very common source of "cannot reach the backend" during local testing)
// doesn't silently break every request. Production domains are NOT covered by this
// and still require being listed explicitly in FRONTEND_ORIGIN.
const LOCAL_ORIGIN_RE = /^https?:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/;
function isAllowedOrigin(origin) {
  if (!origin) return false;
  if (allowedOrigins.includes(origin)) return true;
  return LOCAL_ORIGIN_RE.test(origin);
}

const server = http.createServer(async (req, res) => {
  // ---- CORS ----
  const origin = req.headers.origin;
  if (isAllowedOrigin(origin)) {
    res.setHeader("Access-Control-Allow-Origin", origin);
    res.setHeader("Access-Control-Allow-Credentials", "true");
    res.setHeader("Access-Control-Allow-Methods", "GET,POST,PUT,PATCH,DELETE,OPTIONS");
    res.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization");
  }
  if (req.method === "OPTIONS") {
    res.statusCode = 204;
    return res.end();
  }

  res.setHeader("X-Content-Type-Options", "nosniff");
  res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
  res.status = (code) => { res.statusCode = code; return res; };
  res.json = (obj) => {
    res.setHeader("Content-Type", "application/json; charset=utf-8");
    res.end(JSON.stringify(obj));
  };

  const url = req.url.split("?")[0];

  if (url === "/api/health" && req.method === "GET") {
    return res.json({ status: "ok", time: new Date().toISOString() });
  }

  if (!url.startsWith("/api/")) {
    return res.status(404).json({ error: "Not found." });
  }

  generalLimiter(req, res, async () => {
    try {
      const matched = await app.handle(req, res);
      if (!matched && !res.writableEnded) {
        res.status(404).json({ error: "Not found." });
      }
    } catch (err) {
      console.error(err);
      if (!res.writableEnded) res.status(500).json({ error: "Something went wrong. Please try again." });
    }
  });
});

const PORT = process.env.PORT || 4000;
server.on("error", (err) => {
  if (err.code === "EADDRINUSE") {
    console.error(`\nPort ${PORT} is already in use - the backend might already be running elsewhere.`);
    console.error("If you're sure nothing else needs it, stop whatever is using that port and try again.\n");
    process.exit(1);
  }
  throw err;
});
server.listen(PORT, () => {
  console.log(`MT Travel API listening on http://localhost:${PORT}`);
  console.log(`Health check: http://localhost:${PORT}/api/health`);
  console.log(`Database file: ${require("./lib/store").DB_PATH}`);
});

module.exports = server;
