/**
 * lib/env.js — tiny .env file loader (replaces the "dotenv" package).
 * Reads KEY=VALUE lines from a .env file next to this project and puts
 * them into process.env, without overwriting anything already set by
 * the real environment (e.g. by your hosting provider).
 */
const fs = require("node:fs");
const path = require("node:path");

function loadEnv(envPath) {
  const file = envPath || path.join(__dirname, "..", ".env");
  if (!fs.existsSync(file)) return;
  const content = fs.readFileSync(file, "utf8");
  for (const line of content.split("\n")) {
    const trimmed = line.trim();
    if (!trimmed || trimmed.startsWith("#")) continue;
    const eq = trimmed.indexOf("=");
    if (eq === -1) continue;
    const key = trimmed.slice(0, eq).trim();
    let value = trimmed.slice(eq + 1).trim();
    if ((value.startsWith('"') && value.endsWith('"')) || (value.startsWith("'") && value.endsWith("'"))) {
      value = value.slice(1, -1);
    }
    if (process.env[key] === undefined) process.env[key] = value;
  }
}

module.exports = { loadEnv };
