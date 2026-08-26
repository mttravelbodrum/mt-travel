/**
 * lib/router.js — a minimal Express-style router built directly on
 * Node's built-in http module. No framework dependency.
 *
 * Supports app.get/post/put/patch/delete(path, ...middleware, handler),
 * :param path segments, req.query, req.body (JSON), req.params, and
 * res.json()/res.status(). Small enough to read top to bottom in a
 * couple of minutes, which matters more here than feature completeness.
 */
const { URL } = require("node:url");

function pathToMatcher(routePath) {
  const paramNames = [];
  const pattern = routePath
    .replace(/\/:[a-zA-Z_]+/g, (m) => {
      paramNames.push(m.slice(2));
      return "/([^/]+)";
    });
  return { regex: new RegExp(`^${pattern}$`), paramNames };
}

class Router {
  constructor() {
    this.routes = []; // { method, matcher, handlers }
  }

  _add(method, routePath, handlers) {
    this.routes.push({ method, path: routePath, matcher: pathToMatcher(routePath), handlers });
  }
  get(p, ...h) { this._add("GET", p, h); }
  post(p, ...h) { this._add("POST", p, h); }
  put(p, ...h) { this._add("PUT", p, h); }
  patch(p, ...h) { this._add("PATCH", p, h); }
  delete(p, ...h) { this._add("DELETE", p, h); }

  // Mount another Router (or this same class) under a prefix, Express-style `app.use(prefix, subRouter)`.
  use(prefix, subRouter) {
    for (const r of subRouter.routes) {
      // "/api/tours" + "/" must become "/api/tours", not "/api/tours/" - a bare
      // sub-route of "/" means "the mount point itself", not "mount point + slash".
      let fullPath = r.path === "/" ? prefix : prefix + r.path;
      if (fullPath.length > 1 && fullPath.endsWith("/")) fullPath = fullPath.slice(0, -1);
      this.routes.push({ ...r, path: fullPath, matcher: pathToMatcher(fullPath) });
    }
  }

  async handle(req, res) {
    const url = new URL(req.url, "http://localhost");
    let pathname = decodeURIComponent(url.pathname);
    if (pathname.length > 1 && pathname.endsWith("/")) pathname = pathname.slice(0, -1);
    res.status = (code) => { res.statusCode = code; return res; };
    res.json = (obj) => {
      const body = JSON.stringify(obj);
      res.setHeader("Content-Type", "application/json; charset=utf-8");
      res.end(body);
    };

    req.query = Object.fromEntries(url.searchParams.entries());

    for (const route of this.routes) {
      if (route.method !== req.method) continue;
      const match = pathname.match(route.matcher.regex);
      if (!match) continue;

      req.params = {};
      route.matcher.paramNames.forEach((name, i) => { req.params[name] = match[i + 1]; });

      req.body = await readJsonBody(req).catch(() => null);

      let i = 0;
      const next = (err) => {
        if (err) return sendError(res, err);
        const handler = route.handlers[i++];
        if (!handler) return; // handled
        try {
          const maybePromise = handler(req, res, next);
          if (maybePromise && typeof maybePromise.catch === "function") {
            maybePromise.catch((e) => sendError(res, e));
          }
        } catch (e) {
          sendError(res, e);
        }
      };
      next();
      return true;
    }
    return false; // no route matched
  }
}

function readJsonBody(req) {
  return new Promise((resolve, reject) => {
    if (req.method === "GET" || req.method === "DELETE") return resolve(null);
    let chunks = [];
    let size = 0;
    req.on("data", (c) => {
      size += c.length;
      if (size > 100 * 1024) { req.destroy(); return reject(new Error("Body too large")); }
      chunks.push(c);
    });
    req.on("end", () => {
      if (!chunks.length) return resolve(null);
      try { resolve(JSON.parse(Buffer.concat(chunks).toString("utf8"))); }
      catch { resolve(null); }
    });
    req.on("error", reject);
  });
}

function sendError(res, err) {
  console.error(err);
  if (res.writableEnded) return;
  res.status(err.status || 500).json({ error: err.publicMessage || "Something went wrong. Please try again." });
}

module.exports = { Router };
