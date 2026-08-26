/**
 * lib/mailer.js — a real SMTP client using only Node's built-in `net`/`tls`
 * modules (no nodemailer, no dependency). Speaks enough SMTP (EHLO, STARTTLS,
 * AUTH LOGIN, MAIL FROM, RCPT TO, DATA) to deliver mail through any standard
 * provider (Gmail, Outlook, SendGrid SMTP, Postmark SMTP, your own mail
 * server, etc.) once real credentials are set in .env.
 *
 * Configure via .env: SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASS, SMTP_FROM.
 * If SMTP_HOST is not set, sendMail() logs a warning and resolves without
 * sending - the rest of the app keeps working, it just won't email anyone
 * until real credentials are configured. This is intentional: a missing
 * mail provider should never break a reservation.
 */
const net = require("node:net");
const tls = require("node:tls");

function readLine(socket) {
  return new Promise((resolve, reject) => {
    let buf = "";
    const onData = (chunk) => {
      buf += chunk.toString("utf8");
      if (buf.includes("\r\n")) {
        socket.removeListener("data", onData);
        resolve(buf);
      }
    };
    socket.on("data", onData);
    socket.once("error", reject);
  });
}

function writeLine(socket, line) {
  return new Promise((resolve, reject) => {
    socket.write(line + "\r\n", (err) => (err ? reject(err) : resolve()));
  });
}

async function expect(socket, expectedCodes) {
  const line = await readLine(socket);
  const code = parseInt(line.slice(0, 3), 10);
  if (!expectedCodes.includes(code)) {
    throw new Error(`SMTP error: expected ${expectedCodes.join("/")}, got: ${line.trim()}`);
  }
  return line;
}

function b64(s) {
  return Buffer.from(s, "utf8").toString("base64");
}

function buildMessage({ from, to, subject, text, html, attachment, replyTo }) {
  const altBoundary = "mtgroup_alt_" + Math.random().toString(36).slice(2);
  const altPart = [
    `--${altBoundary}`,
    `Content-Type: text/plain; charset="UTF-8"`,
    ``,
    text || "",
    ``,
    `--${altBoundary}`,
    `Content-Type: text/html; charset="UTF-8"`,
    ``,
    html || `<p>${(text || "").replace(/\n/g, "<br>")}</p>`,
    ``,
    `--${altBoundary}--`,
  ].join("\r\n");

  const replyToLine = replyTo ? [`Reply-To: ${replyTo}`] : [];

  if (!attachment) {
    return [
      `From: ${from}`,
      `To: ${to}`,
      ...replyToLine,
      `Subject: ${subject}`,
      `MIME-Version: 1.0`,
      `Content-Type: multipart/alternative; boundary="${altBoundary}"`,
      ``,
      altPart,
    ].join("\r\n");
  }

  // With an attachment, wrap the text/html alternative INSIDE a multipart/mixed
  // envelope alongside the attachment part - the standard structure every
  // mail client expects for "message body + attached file".
  const mixedBoundary = "mtgroup_mix_" + Math.random().toString(36).slice(2);
  const base64Data = attachment.content.toString("base64").replace(/(.{76})/g, "$1\r\n");
  return [
    `From: ${from}`,
    `To: ${to}`,
    ...replyToLine,
    `Subject: ${subject}`,
    `MIME-Version: 1.0`,
    `Content-Type: multipart/mixed; boundary="${mixedBoundary}"`,
    ``,
    `--${mixedBoundary}`,
    `Content-Type: multipart/alternative; boundary="${altBoundary}"`,
    ``,
    altPart,
    ``,
    `--${mixedBoundary}`,
    `Content-Type: ${attachment.contentType || "application/octet-stream"}; name="${attachment.filename}"`,
    `Content-Transfer-Encoding: base64`,
    `Content-Disposition: attachment; filename="${attachment.filename}"`,
    ``,
    base64Data,
    ``,
    `--${mixedBoundary}--`,
  ].join("\r\n");
}

/**
 * Sends one email. Resolves { sent: true } on success, or { sent: false,
 * reason } if SMTP isn't configured. Throws if SMTP IS configured but the
 * send genuinely fails (bad credentials, provider rejected it, etc.) - the
 * caller decides whether that should block the request or just be logged.
 */
async function sendMail({ to, subject, text, html, attachment, replyTo }) {
  const host = process.env.SMTP_HOST;
  const port = parseInt(process.env.SMTP_PORT || "587", 10);
  const user = process.env.SMTP_USER;
  const pass = process.env.SMTP_PASS;
  const from = process.env.SMTP_FROM || user;

  if (!host) {
    console.warn(`[mailer] SMTP_HOST not set - skipping email to ${to} ("${subject}"). Set SMTP_* in .env to enable real email.`);
    return { sent: false, reason: "SMTP not configured" };
  }

  const useTls = port === 465;
  const socket = useTls
    ? tls.connect({ host, port, servername: host })
    : net.connect({ host, port });

  await new Promise((resolve, reject) => {
    socket.once("connect", resolve);
    socket.once("secureConnect", resolve);
    socket.once("error", reject);
  });

  try {
    await expect(socket, [220]);
    await writeLine(socket, `EHLO mttravel.local`);
    await expect(socket, [250]);

    if (!useTls && port === 587) {
      await writeLine(socket, "STARTTLS");
      await expect(socket, [220]);
      // Upgrade the existing socket to TLS for port 587 (STARTTLS).
      const secured = await new Promise((resolve, reject) => {
        const s = tls.connect({ socket, servername: host }, () => resolve(s));
        s.once("error", reject);
      });
      return await sendOverSecuredSocket(secured, { host, user, pass, from, to, subject, text, html, attachment, replyTo });
    }

    return await continueAfterEhlo(socket, { user, pass, from, to, subject, text, html, attachment, replyTo });
  } finally {
    try { socket.end(); } catch (e) { /* already closed */ }
  }
}

async function sendOverSecuredSocket(socket, opts) {
  await writeLine(socket, `EHLO mttravel.local`);
  await expect(socket, [250]);
  return continueAfterEhlo(socket, opts);
}

async function continueAfterEhlo(socket, { user, pass, from, to, subject, text, html, attachment, replyTo }) {
  if (user && pass) {
    await writeLine(socket, "AUTH LOGIN");
    await expect(socket, [334]);
    await writeLine(socket, b64(user));
    await expect(socket, [334]);
    await writeLine(socket, b64(pass));
    await expect(socket, [235]);
  }

  await writeLine(socket, `MAIL FROM:<${from}>`);
  await expect(socket, [250]);
  await writeLine(socket, `RCPT TO:<${to}>`);
  await expect(socket, [250, 251]);
  await writeLine(socket, "DATA");
  await expect(socket, [354]);

  const message = buildMessage({ from, to, subject, text, html, attachment, replyTo });
  const dataEscaped = message.replace(/\r\n\./g, "\r\n..");
  await writeLine(socket, dataEscaped + "\r\n.");
  await expect(socket, [250]);
  await writeLine(socket, "QUIT");

  return { sent: true };
}

module.exports = { sendMail };
