# MT Travel — Backend API

A real, working REST API — reservations, tours, customers, settings, an
activity log, admin authentication with hashed passwords, signed
sessions, rate limiting, real email (customer confirmations with a PDF
ticket attached, owner notifications, status updates), and real PDF
generation.

**Almost zero third-party dependencies.** Everything - the server,
routing, auth, rate limiting, and email/SMTP - runs on Node.js's own
built-in modules. The one exception is `pdf-lib`, used to generate the
PDF ticket attached to confirmation emails; generating a valid PDF from
raw bytes by hand isn't practical, so this is the one place a library
earns its keep (`npm install` is needed for this one package - see
Setup below). This was a deliberate rewrite: an earlier version of this
backend used Express, better-sqlite3, bcrypt and jsonwebtoken, but
could never actually be run or tested in the environment building it
(no internet access to fetch packages). Rather than hand you more
unverified code, everything here was rewritten dependency-light
specifically so it could be **run and tested for real** — see "What was
actually tested" below.

---

## 1. Setup (2 minutes)

You need [Node.js](https://nodejs.org) 18 or newer.

```bash
cd backend
npm install
cp .env.example .env
```

(`npm install` fetches the one dependency, pdf-lib, for PDF ticket
generation - everything else is Node's own built-ins.)

Open `.env` and set a real `SESSION_SECRET` (any long random string —
generate one with `node -e "console.log(require('crypto').randomBytes(32).toString('hex'))"`).

The default admin login in `.env.example` is
`admin@mttravel.com` / `demo12345` — change it before deploying
for real:
```bash
node hash-password.js "your-new-password"
```
Copy the line it prints into `.env` as `ADMIN_PASSWORD_HASH`.

Then seed the database (21 tours + default settings) and start:
```bash
node seed.js
node server.js
```

You should see:
```
MT Travel API listening on http://localhost:4000
Database file: ./data/db.json
```

Test it's alive: open `http://localhost:4000/api/health` — you should
see `{"status":"ok", ...}`.

---

## 2. What was actually tested

Every endpoint below was run and verified with real HTTP requests
during development — not just written and assumed correct:

- Health check, and full CRUD on tours (public reads, admin-only writes)
- Guest reservation creation, including rejecting missing fields and
  invalid emails
- Admin login: correct password succeeds, wrong password is rejected,
  and both give the same generic error (never reveals which was wrong)
- Every admin route correctly rejects requests with no token and with
  an invalid/expired token
- Reservation status updates and notes, with each change appearing in
  the activity log
- Dashboard stats, customer list (derived from reservations), activity
  log, contact form
- **Rate limiting, explicitly**: the 11th login attempt in 15 minutes
  gets HTTP 429, not the usual 401; the 6th reservation submission in
  an hour from the same IP gets 429 too
- Malformed JSON and empty request bodies are rejected cleanly (400),
  never crash the server
- **Email, genuinely sent and received**: a local test SMTP server was
  used to verify the mailer speaks valid SMTP (EHLO/AUTH/MAIL FROM/
  RCPT TO/DATA) and that both the customer confirmation and the owner
  notification actually arrive with correct content.
- **The PDF ticket attachment**: generated server-side, then the actual
  base64 attachment was extracted from the actual received email and
  independently verified as a valid PDF using pdfjs-dist - a different
  library than pdf-lib, which generated it - so this isn't "the
  generator says its own output is valid," it's a second, unrelated
  tool confirming the same thing.
- **The full reservation → admin panel pipeline, end to end**: a real
  browser (Playwright) filled out and submitted an actual reservation
  through booking.html → checkout.html → success.html, then logged into
  the admin panel and confirmed the reservation appeared in the
  Reservations list and the Dashboard, the dashboard stats updated, the
  notification bell showed an unread indicator, the "You have a new
  reservation" banner appeared with the correct details, and clicking
  it opened that exact reservation's detail view.
- **Backend-down behavior**: with the backend switched off, verified
  that the login page shows a clear error (not a fake successful
  login), the reservations page shows zero rows plus an error (not old
  cached data), and submitting a reservation shows a clear error and
  stays on the checkout page (does not pretend the booking succeeded).

This testing caught and fixed several real bugs during development (a
router path-matching issue that made list endpoints silently 404, the
health check accepting any HTTP method, and - in the version before
email support existed - nothing; email/PDF were built and verified
together in the same pass) — which is exactly why this rewrite
prioritized being testable over following the most conventional
dependency stack.

**What wasn't tested**: real production deployment (behind a reverse
proxy, under real concurrent load, over HTTPS), delivery through a real
email provider (Gmail/SendGrid/etc. - the SMTP client was verified
against a local test server since no real provider credentials are
available in this environment; the protocol implementation is the same
either way), and WhatsApp notifications to the business owner, which
were not built at all - see section 6.

---

## 3. The database

`data/db.json` — one plain JSON file, containing everything: tours,
reservations, settings, and the activity log. No database server to
install, no ORM, no migrations.

- **Back it up** by copying this file.
- **Inspect it** by opening it in any text editor — it's just JSON.
- **Restore it** by copying an old version back over the current one
  (with the server stopped).

If you outgrow this later (very high traffic, several staff editing
concurrently), migrating to a real database is a contained change
limited to `lib/store.js` — every route calls only the functions it
exports (`readAll`, `transaction`), never touches the file directly.

---

## 4. API reference

Base URL: `http://localhost:4000/api` (or wherever you deploy it).

| Method | Path | Auth | Purpose |
|---|---|---|---|
| GET | `/health` | none | Liveness check |
| GET | `/tours` | none | List tours (`?category=island`, `?visibleOnly=true`) |
| GET | `/tours/:slug` | none | One tour |
| POST | `/tours` | admin | Create a tour |
| PUT | `/tours/:slug` | admin | Update a tour |
| DELETE | `/tours/:slug` | admin | Delete a tour |
| POST | `/reservations` | none | Guest creates a reservation (rate limited: 5/hour/IP) |
| GET | `/reservations` | admin | List/search/filter/sort/paginate |
| GET | `/reservations/:id` | admin | One reservation |
| PATCH | `/reservations/:id` | admin | Update status and/or notes |
| POST | `/auth/login` | none | Returns a session token (rate limited: 10/15min/IP) |
| GET | `/settings` | admin | Read company settings |
| PUT | `/settings` | admin | Update settings (partial merge) |
| GET | `/customers` | admin | Derived from reservations, grouped by email |
| GET | `/activity-log` | admin | Recent actions, newest first |
| GET | `/stats` | admin | Dashboard numbers |
| POST | `/contact` | none | Contact form submission |

Admin routes need `Authorization: Bearer <token>` from `/auth/login`.
Tokens expire after 12 hours.

---

## 5. Connecting the frontend

The site already knows how to talk to this API — see
`site/assets/js/api-client.js`. By default it looks for the backend at
`http://localhost:4000/api` when the site itself is on `localhost`, or
at `/api` (same origin) otherwise.

**It's wired up and working for**: guest reservation creation
(`checkout.js`), admin login, the Reservations page, the Dashboard, the
Tours page, the Customers page, and Settings. Each of these tries the
real API first and *automatically falls back* to the browser-only demo
mode if the backend isn't running or reachable - open any admin page
and check the small badge next to the page title: "Live data from
backend" or "Local demo data" tells you which one you're looking at.

**Not yet wired up**: the Media Library and Reports pages still read
demo data only (the backend has everything needed for Reports via
`/stats` and `/reservations` - it just isn't called from that page's
JS yet).

To point the frontend at a deployed (non-localhost) backend on a
different domain than the site itself, set this before the other
scripts load, e.g. in a small inline `<script>` near the top of each
page's `<head>`:
```html
<script>window.MT_API_BASE = 'https://api.yoursite.com/api';</script>
```
And add that origin to `FRONTEND_ORIGIN` in the backend's `.env`.

---

## 6. Email (real, working) and WhatsApp-to-owner (not built - here's why)

**Email is real.** `lib/mailer.js` is a raw SMTP client (no dependency -
speaks EHLO/STARTTLS/AUTH/MAIL FROM/RCPT TO/DATA directly over
`node:net`/`node:tls`) and is wired into `routes/reservations.js`: every
new reservation sends the customer a confirmation with a PDF ticket
attached (`lib/pdf-ticket.js`, via pdf-lib - the one dependency in this
project) and sends the address in `OWNER_NOTIFICATION_EMAIL` a
new-reservation alert. Every status change sends the customer an update.
Configure a provider in `.env` (`SMTP_HOST`/`SMTP_PORT`/`SMTP_USER`/
`SMTP_PASS`/`SMTP_FROM`) - Gmail with an App Password, SendGrid,
Postmark, Mailgun, or your own mail server all work identically since
this speaks standard SMTP. Leave `SMTP_HOST` empty and reservations
still work - they just won't trigger email until it's configured, and
this is logged to the activity log either way so a silent failure is
never actually silent in the Admin Panel.

**WhatsApp notifications to the business owner were not built, and I
want to be direct about why rather than fake it.** The WhatsApp button
customers see (on the success page, and in the Admin Panel's
reservation detail) is a `wa.me` link - a real, working, zero-setup
click-to-chat that opens a pre-filled conversation. That's different
from what's being asked for here: an automatic message that arrives on
the owner's phone the moment a reservation comes in. That requires the
WhatsApp Business API (Meta), which needs a verified Meta Business
account, an approved message template, and API credentials - none of
which exist in this project or this environment, and none of which I
can sign up for on your behalf. If you get WhatsApp Business API
credentials, the correct place to add this is right next to the email
sending in `routes/reservations.js`'s `POST /` handler - same pattern,
same non-blocking `Promise.allSettled` alongside the two email sends.

---

## 7. Deploying

This is a plain Node.js HTTP server — deploy it anywhere that runs
Node: a small VPS with a process manager (`pm2` or a systemd service),
Render, Railway, Fly.io, or similar. Since `data/db.json` is a real
file on disk, make sure your host gives you persistent storage (not
every serverless/edge platform does - check before choosing one).

Put a real reverse proxy (nginx, Caddy, or your platform's built-in
one) in front of it for HTTPS; this server speaks plain HTTP itself.
