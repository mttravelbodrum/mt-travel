/**
 * lib/auth.js — password hashing and signed session tokens using only
 * Node's built-in crypto module (no bcrypt, no jsonwebtoken package).
 *
 * Password hashing: scrypt, a modern, memory-hard KDF built into Node
 * since v10 (the same category of algorithm bcrypt/argon2 are in - NOT
 * a plain hash). Real salt per password, constant-time comparison.
 *
 * Session tokens: a small HMAC-signed token (header.payload.signature,
 * base64url) — functionally the same idea as a JWT (signed, tamper-proof,
 * carries an expiry) without needing the jsonwebtoken package.
 */
const crypto = require("node:crypto");

function hashPassword(password) {
  const salt = crypto.randomBytes(16).toString("hex");
  const hash = crypto.scryptSync(String(password), salt, 64).toString("hex");
  return `${salt}:${hash}`;
}

function verifyPassword(password, stored) {
  if (!stored || !stored.includes(":")) return false;
  const [salt, hash] = stored.split(":");
  const candidate = crypto.scryptSync(String(password), salt, 64).toString("hex");
  const a = Buffer.from(hash, "hex");
  const b = Buffer.from(candidate, "hex");
  if (a.length !== b.length) return false;
  return crypto.timingSafeEqual(a, b);
}

function base64url(input) {
  return Buffer.from(input).toString("base64url");
}

function sign(payload, secret, expiresInSeconds) {
  const header = base64url(JSON.stringify({ alg: "HS256", typ: "SESSION" }));
  const body = base64url(JSON.stringify({ ...payload, exp: Math.floor(Date.now() / 1000) + expiresInSeconds }));
  const signature = crypto.createHmac("sha256", secret).update(`${header}.${body}`).digest("base64url");
  return `${header}.${body}.${signature}`;
}

function verify(token, secret) {
  if (!token || token.split(".").length !== 3) return null;
  const [header, body, signature] = token.split(".");
  const expected = crypto.createHmac("sha256", secret).update(`${header}.${body}`).digest("base64url");
  const a = Buffer.from(signature);
  const b = Buffer.from(expected);
  if (a.length !== b.length || !crypto.timingSafeEqual(a, b)) return null;
  let payload;
  try {
    payload = JSON.parse(Buffer.from(body, "base64url").toString("utf8"));
  } catch {
    return null;
  }
  if (payload.exp && Math.floor(Date.now() / 1000) > payload.exp) return null;
  return payload;
}

module.exports = { hashPassword, verifyPassword, sign, verify };
