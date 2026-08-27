/**
 * lib/ratelimit.js — simple in-memory sliding-window rate limiter.
 * Fine for a single-process deployment (the normal case for a site this
 * size). If you later run multiple server instances behind a load
 * balancer, swap this for a shared store (e.g. Redis) - everything that
 * calls rateLimit() below would stay the same.
 */
function rateLimit({ windowMs, max, message }) {
  const hits = new Map(); // ip -> [timestamps]

  // Periodic cleanup so this Map never grows forever on a long-running server.
  setInterval(() => {
    const cutoff = Date.now() - windowMs;
    for (const [ip, times] of hits) {
      const kept = times.filter((t) => t > cutoff);
      if (kept.length) hits.set(ip, kept);
      else hits.delete(ip);
    }
  }, Math.max(windowMs, 60000)).unref();

  return (req, res, next) => {
    const ip = req.socket.remoteAddress || "unknown";
    const now = Date.now();
    const cutoff = now - windowMs;
    const times = (hits.get(ip) || []).filter((t) => t > cutoff);
    times.push(now);
    hits.set(ip, times);
    if (times.length > max) {
      res.status(429).json(message || { error: "Too many requests. Please try again shortly." });
      return;
    }
    next();
  };
}

module.exports = { rateLimit };
