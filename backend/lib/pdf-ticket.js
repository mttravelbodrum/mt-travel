/**
 * lib/pdf-ticket.js — generates the reservation voucher PDF.
 * Uses embedded Arial fonts so Turkish characters are supported.
 */
const fs = require("fs");
const path = require("path");

let PDFDocument, rgb, fontkit;

try {
  ({ PDFDocument, rgb } = require("pdf-lib"));
  fontkit = require("@pdf-lib/fontkit");
} catch (e) {
  // Handled in generateTicketPdf() below.
}

function fmtDate(iso) {
  try {
    return new Date(iso + "T00:00:00").toLocaleDateString("en-GB", {
      day: "2-digit",
      month: "long",
      year: "numeric",
    });
  } catch (e) {
    return iso;
  }
}

async function generateTicketPdf(r, company, tourTimes) {
  if (!PDFDocument || !fontkit) return null;

  const doc = await PDFDocument.create();
  doc.registerFontkit(fontkit);

  const page = doc.addPage([595.28, 841.89]);
  const { width, height } = page.getSize();

  const regularBytes = fs.readFileSync(
    path.join(__dirname, "..", "fonts", "Arial.ttf")
  );

  const boldBytes = fs.readFileSync(
    path.join(__dirname, "..", "fonts", "Arial-Bold.ttf")
  );

  const regular = await doc.embedFont(regularBytes);
  const bold = await doc.embedFont(boldBytes);

  const navy = rgb(0.043, 0.114, 0.180);
  const gold = rgb(0.808, 0.608, 0.255);
  const slate = rgb(0.392, 0.459, 0.498);
  const white = rgb(1, 1, 1);

  // Watermark
  page.drawText("MT TRAVEL", {
    x: 60,
    y: height / 2,
    size: 60,
    font: bold,
    color: navy,
    opacity: 0.06,
    rotate: { type: "degrees", angle: 30 },
  });

  // Header band
  page.drawRectangle({
    x: 0,
    y: height - 90,
    width,
    height: 90,
    color: navy,
  });

  page.drawText("MT TRAVEL", {
    x: 40,
    y: height - 45,
    size: 20,
    font: bold,
    color: white,
  });

  page.drawText("Bodrum, Turkiye - Premium Tours & Experiences", {
    x: 40,
    y: height - 62,
    size: 10,
    font: regular,
    color: rgb(0.78, 0.82, 0.84),
  });

  page.drawText("RESERVATION No.", {
    x: width - 200,
    y: height - 40,
    size: 10,
    font: bold,
    color: white,
  });

  page.drawText(r.id, {
    x: width - 200,
    y: height - 58,
    size: 15,
    font: bold,
    color: white,
  });

  let y = height - 130;

  page.drawText("Reservation Voucher", {
    x: 40,
    y,
    size: 17,
    font: bold,
    color: navy,
  });

  y -= 8;

  page.drawLine({
    start: { x: 40, y },
    end: { x: 130, y },
    thickness: 2,
    color: gold,
  });

  y -= 34;

  function row(label, value) {
    page.drawText(label.toUpperCase(), {
      x: 40,
      y,
      size: 9,
      font: regular,
      color: slate,
    });

    page.drawText(String(value || "-"), {
      x: 40,
      y: y - 16,
      size: 12,
      font: bold,
      color: navy,
    });

    y -= 42;
  }

  row("Customer Name", r.customer);
  row("Country", r.country);
  row("Phone Number", r.phone);
  row("Email Address", r.email);
  row("Tour", r.tourName.en);
  row("Reservation Date", fmtDate(r.date));

  if (tourTimes && tourTimes.departureTime) {
    row("Departure Time", tourTimes.departureTime);
  }

  if (tourTimes && tourTimes.returnTime) {
    row("Return Time", tourTimes.returnTime);
  }

  if (r.pricingMode === "single_double") {
    row("Single", r.single || 0);
    row("Double", r.double || 0);
  } else {
    row(
      "Guests",
      `${r.adults} Adults, ${r.children} Children, ${r.infants} Infants`
    );
  }

  row("Hotel / Pickup Hotel", r.hotelName);
  row("Reservation Status", "Pending (Pay on Tour Day)");
  row("Total Amount", `EUR ${r.total}`);

  const footY = 80;

  page.drawLine({
    start: { x: 40, y: footY },
    end: { x: width - 40, y: footY },
    thickness: 1,
    color: rgb(0.9, 0.9, 0.9),
  });

  const contactLine = `${company.phone || ""}   |   WhatsApp: ${
    company.phone || ""
  }   |   ${company.email || ""}`;

  const contactWidth = bold.widthOfTextAtSize(contactLine, 9);

  page.drawText(contactLine, {
    x: (width - contactWidth) / 2,
    y: footY - 20,
    size: 9,
    font: bold,
    color: navy,
  });

  const note =
    "This voucher confirms your reservation. Please present it to your guide on the day of the tour.";

  const noteWidth = regular.widthOfTextAtSize(note, 8);

  page.drawText(note, {
    x: (width - noteWidth) / 2,
    y: footY - 34,
    size: 8,
    font: regular,
    color: slate,
  });

  const bytes = await doc.save();
  return Buffer.from(bytes);
}

module.exports = { generateTicketPdf };
