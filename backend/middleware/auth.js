/**
 * middleware/auth.js - protects admin-only routes.
 * Expects "Authorization: Bearer <token>" set by the frontend after login
 * (see routes/auth.js for how the token is issued).
 */
const { verify } = require("../lib/auth");

function requireAuth(req, res, next) {
  const header = req.headers.authorization || "";
  const token = header.startsWith("Bearer ") ? header.slice(7) : null;
  if (!token) {
    return res.status(401).json({ error: "Missing or invalid authorization header." });
  }
  const payload = verify(token, process.env.SESSION_SECRET);
  if (!payload) {
    return res.status(401).json({ error: "Invalid or expired session. Please log in again." });
  }
  req.admin = payload;
  next();
}

module.exports = { requireAuth };
