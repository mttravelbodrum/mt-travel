/**
 * hash-password.js — generates a password hash to put in your .env file
 * as ADMIN_PASSWORD_HASH. Run this any time you want to set or change
 * the admin password.
 *
 * Usage:  node hash-password.js "your-new-password"
 */
const { hashPassword } = require("./lib/auth");

const password = process.argv[2];
if (!password) {
  console.error("Usage: node hash-password.js \"your-new-password\"");
  process.exit(1);
}
if (password.length < 8) {
  console.error("Please choose a password of at least 8 characters.");
  process.exit(1);
}
console.log("\nAdd this line to your .env file:\n");
console.log(`ADMIN_PASSWORD_HASH=${hashPassword(password)}\n`);
