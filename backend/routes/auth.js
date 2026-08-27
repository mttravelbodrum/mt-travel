/**
 * routes/auth.js - real admin authentication.
 * Verifies the submitted password against a scrypt-hashed password and
 * issues a signed session token. admin-login.js (frontend) has no
 * fallback of its own - it always calls this endpoint.
 */
const { Router } = require("../lib/router");
const { verifyPassword, sign } = require("../lib/auth");
const { rateLimit } = require("../lib/ratelimit");

const router = new Router();

// Prevent brute-force login attempts: 10 tries per 15 minutes per IP.
const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 10,
  message: { error: "Too many login attempts. Please try again later." },
});

router.post("/login", loginLimiter, (req, res) => {
  const { email, password } = req.body || {};
  if (!email || !password) {
    return res.status(400).json({ error: "Email and password are required." });
  }

  const validEmail = email.trim().toLowerCase() === (process.env.ADMIN_EMAIL || "").toLowerCase();
  const validPassword = validEmail && verifyPassword(password, process.env.ADMIN_PASSWORD_HASH || "");

  if (!validEmail || !validPassword) {
    // Same generic message either way, so we never reveal which part was wrong.
    return res.status(401).json({ error: "Invalid email or password." });
  }

  const token = sign({ email: process.env.ADMIN_EMAIL, role: "admin" }, process.env.SESSION_SECRET, 12 * 60 * 60);
  res.json({ token, expiresIn: "12h" });
});

module.exports = router;
