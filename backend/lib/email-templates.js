/**
 * lib/email-templates.js — plain text + HTML content for the emails this
 * system sends. Kept separate from mailer.js (which only knows how to
 * *deliver* mail) and from routes/reservations.js (which only knows
 * *when* to send).
 *
 * customerConfirmationEmail() and statusUpdateEmail() go to the guest, so
 * they're rendered in whatever language the guest was using on the site
 * when they booked (reservation.lang, sent by checkout.js and stored on
 * the reservation - falls back to English for older records or direct API
 * calls that don't send it). ownerNotificationEmail() goes to the business
 * owner running a Bodrum-based operation, so it's intentionally always
 * Turkish regardless of the guest's language - there's no "notification
 * language" setting for the owner, and Turkish is the correct default for
 * that audience.
 */
const SUPPORTED = ["en", "tr", "de", "ru", "pl"];
const LOCALE_MAP = { en: "en-GB", tr: "tr-TR", de: "de-DE", ru: "ru-RU", pl: "pl-PL" };

function resolveLang(lang) {
  return SUPPORTED.includes(lang) ? lang : "tr";
}

function fmtDate(iso, lang) {
  try {
    return new Date(iso + "T00:00:00").toLocaleDateString(LOCALE_MAP[resolveLang(lang)], { day: "2-digit", month: "long", year: "numeric" });
  } catch (e) {
    return iso;
  }
}

const STATUS_LABELS = {
  en: { Pending: "Pending", Confirmed: "Confirmed", Completed: "Completed", Cancelled: "Cancelled" },
  tr: { Pending: "Beklemede", Confirmed: "Onayland\u0131", Completed: "Tamamland\u0131", Cancelled: "\u0130ptal Edildi" },
  de: { Pending: "Ausstehend", Confirmed: "Best\u00e4tigt", Completed: "Abgeschlossen", Cancelled: "Storniert" },
  ru: { Pending: "\u0412 \u041e\u0436\u0438\u0434\u0430\u043d\u0438\u0438", Confirmed: "\u041f\u043e\u0434\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u043e", Completed: "\u0417\u0430\u0432\u0435\u0440\u0448\u0435\u043d\u043e", Cancelled: "\u041e\u0442\u043c\u0435\u043d\u0435\u043d\u043e" },
  pl: { Pending: "Oczekuj\u0105ca", Confirmed: "Potwierdzona", Completed: "Zako\u0144czona", Cancelled: "Anulowana" },
};

const T = {
  en: {
    subject: (id) => `Your MT Travel Reservation ${id}`,
    greeting: (name) => `Hi ${name},`,
    thankYou: "Thank you for reserving with MT Travel! Your reservation is confirmed as received.",
    labelResNumber: "Reservation Number", labelTour: "Tour", labelDate: "Date", labelGuests: "Guests",
    guestsLine: (a, c, i) => `${a} Adults, ${c} Children, ${i} Infants`,
    guestsLineAtv: (s, d) => `${s} Single, ${d} Double`,
    labelHotel: "Hotel / Pickup", labelTotal: "Total (payable on the day of your tour)",
    paymentNote: "No payment is needed now - you pay the full amount on the day of your tour.",
    questions: "Questions? Reply to this email or reach us on WhatsApp:",
    phoneLabel: "Phone", closing: "We look forward to welcoming you!",
    htmlThankYou: (name) => `Thank you, ${name}!`,
    htmlIntro: "Your reservation has been received and is confirmed.",
    footerLocation: "MT Travel \u00b7 Bodrum, T\u00fcrkiye",
    statusSubject: (id, status) => `Update on Your Reservation ${id}: ${status}`,
    statusIntro: (id, tour, date) => `Your reservation ${id} for ${tour} on ${date} is now:`,
    statusQuestions: "Questions? Reply to this email or reach us on WhatsApp.",
    statusHeading: (id) => `Reservation ${id} Update`,
    contactConfirmSubject: "We've Received Your Message",
    contactConfirmIntro: "Thank you for contacting MT Travel. We've received your message and will get back to you within 24 hours.",
    contactYourMessage: "Your message:",
  },
  tr: {
    subject: (id) => `MT Travel Rezervasyonunuz ${id}`,
    greeting: (name) => `Merhaba ${name},`,
    thankYou: "MT Travel ile rezervasyon yapt\u0131\u011f\u0131n\u0131z i\u00e7in te\u015fekk\u00fcr ederiz! Rezervasyonunuz al\u0131nd\u0131 ve onayland\u0131.",
    labelResNumber: "Rezervasyon Numaras\u0131", labelTour: "Tur", labelDate: "Tarih", labelGuests: "Misafirler",
    guestsLine: (a, c, i) => `${a} Yeti\u015fkin, ${c} \u00c7ocuk, ${i} Bebek`,
    guestsLineAtv: (s, d) => `${s} Tek Ki\u015filik, ${d} \u00c7ift Ki\u015filik`,
    labelHotel: "Otel / Al\u0131\u015f Noktas\u0131", labelTotal: "Toplam (tur g\u00fcn\u00fc \u00f6denecek)",
    paymentNote: "\u015eimdi \u00f6deme yapman\u0131za gerek yok - tam tutar\u0131 tur g\u00fcn\u00fcnde \u00f6deyeceksiniz.",
    questions: "Sorular\u0131n\u0131z m\u0131 var? Bu e-postay\u0131 yan\u0131tlayabilir veya WhatsApp'tan bize ula\u015fabilirsiniz:",
    phoneLabel: "Telefon", closing: "Sizi a\u011f\u0131rlamak i\u00e7in sab\u0131rs\u0131zlan\u0131yoruz!",
    htmlThankYou: (name) => `Te\u015fekk\u00fcrler, ${name}!`,
    htmlIntro: "Rezervasyonunuz al\u0131nd\u0131 ve onayland\u0131.",
    footerLocation: "MT Travel \u00b7 Bodrum, T\u00fcrkiye",
    statusSubject: (id, status) => `Rezervasyonunuzda G\u00fcncelleme ${id}: ${status}`,
    statusIntro: (id, tour, date) => `${tour} turu i\u00e7in ${date} tarihli ${id} numaral\u0131 rezervasyonunuzun durumu:`,
    statusQuestions: "Sorular\u0131n\u0131z m\u0131 var? Bu e-postay\u0131 yan\u0131tlayabilir veya WhatsApp'tan bize ula\u015fabilirsiniz.",
    statusHeading: (id) => `${id} Numaral\u0131 Rezervasyon G\u00fcncellemesi`,
    contactConfirmSubject: "Mesaj\u0131n\u0131z\u0131 Ald\u0131k",
    contactConfirmIntro: "MT Travel ile ileti\u015fime ge\u00e7ti\u011finiz i\u00e7in te\u015fekk\u00fcr ederiz. Mesaj\u0131n\u0131z\u0131 ald\u0131k ve 24 saat i\u00e7inde size geri d\u00f6nece\u011fiz.",
    contactYourMessage: "Mesaj\u0131n\u0131z:",
  },
  de: {
    subject: (id) => `Ihre MT Travel Reservierung ${id}`,
    greeting: (name) => `Hallo ${name},`,
    thankYou: "Vielen Dank f\u00fcr Ihre Reservierung bei MT Travel! Ihre Reservierung wurde als eingegangen best\u00e4tigt.",
    labelResNumber: "Reservierungsnummer", labelTour: "Tour", labelDate: "Datum", labelGuests: "G\u00e4ste",
    guestsLine: (a, c, i) => `${a} Erwachsene, ${c} Kinder, ${i} Kleinkinder`,
    guestsLineAtv: (s, d) => `${s} Einzel, ${d} Doppel`,
    labelHotel: "Hotel / Abholung", labelTotal: "Gesamtbetrag (zahlbar am Tourtag)",
    paymentNote: "Jetzt ist keine Zahlung erforderlich - Sie zahlen den vollen Betrag am Tag Ihrer Tour.",
    questions: "Fragen? Antworten Sie auf diese E-Mail oder erreichen Sie uns \u00fcber WhatsApp:",
    phoneLabel: "Telefon", closing: "Wir freuen uns darauf, Sie willkommen zu hei\u00dfen!",
    htmlThankYou: (name) => `Vielen Dank, ${name}!`,
    htmlIntro: "Ihre Reservierung wurde erhalten und best\u00e4tigt.",
    footerLocation: "MT Travel \u00b7 Bodrum, T\u00fcrkiye",
    statusSubject: (id, status) => `Aktualisierung Ihrer Reservierung ${id}: ${status}`,
    statusIntro: (id, tour, date) => `Ihre Reservierung ${id} f\u00fcr ${tour} am ${date} hat jetzt den Status:`,
    statusQuestions: "Fragen? Antworten Sie auf diese E-Mail oder erreichen Sie uns \u00fcber WhatsApp.",
    statusHeading: (id) => `Aktualisierung zur Reservierung ${id}`,
    contactConfirmSubject: "Wir Haben Ihre Nachricht Erhalten",
    contactConfirmIntro: "Vielen Dank, dass Sie MT Travel kontaktiert haben. Wir haben Ihre Nachricht erhalten und melden uns innerhalb von 24 Stunden bei Ihnen.",
    contactYourMessage: "Ihre Nachricht:",
  },
  ru: {
    subject: (id) => `\u0412\u0430\u0448\u0435 \u0431\u0440\u043e\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435 MT Travel ${id}`,
    greeting: (name) => `\u0417\u0434\u0440\u0430\u0432\u0441\u0442\u0432\u0443\u0439\u0442\u0435, ${name},`,
    thankYou: "\u0421\u043f\u0430\u0441\u0438\u0431\u043e \u0437\u0430 \u0431\u0440\u043e\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435 \u0441 MT Travel! \u0412\u0430\u0448\u0435 \u0431\u0440\u043e\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435 \u043f\u043e\u043b\u0443\u0447\u0435\u043d\u043e \u0438 \u043f\u043e\u0434\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u043e.",
    labelResNumber: "\u041d\u043e\u043c\u0435\u0440 \u0431\u0440\u043e\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u044f", labelTour: "\u0422\u0443\u0440", labelDate: "\u0414\u0430\u0442\u0430", labelGuests: "\u0413\u043e\u0441\u0442\u0438",
    guestsLine: (a, c, i) => `${a} \u0432\u0437\u0440\u043e\u0441\u043b\u044b\u0445, ${c} \u0434\u0435\u0442\u0435\u0439, ${i} \u043c\u043b\u0430\u0434\u0435\u043d\u0446\u0435\u0432`,
    guestsLineAtv: (s, d) => `${s} \u043e\u0434\u0438\u043d\u043e\u0447\u043d\u044b\u0445, ${d} \u0434\u0432\u043e\u0439\u043d\u044b\u0445`,
    labelHotel: "\u041e\u0442\u0435\u043b\u044c / \u041c\u0435\u0441\u0442\u043e \u043f\u043e\u0441\u0430\u0434\u043a\u0438", labelTotal: "\u0418\u0442\u043e\u0433\u043e (\u043e\u043f\u043b\u0430\u0442\u0430 \u0432 \u0434\u0435\u043d\u044c \u0442\u0443\u0440\u0430)",
    paymentNote: "\u041e\u043f\u043b\u0430\u0442\u0430 \u0441\u0435\u0439\u0447\u0430\u0441 \u043d\u0435 \u0442\u0440\u0435\u0431\u0443\u0435\u0442\u0441\u044f - \u0432\u044b \u043e\u043f\u043b\u0430\u0442\u0438\u0442\u0435 \u043f\u043e\u043b\u043d\u0443\u044e \u0441\u0443\u043c\u043c\u0443 \u0432 \u0434\u0435\u043d\u044c \u0442\u0443\u0440\u0430.",
    questions: "\u0415\u0441\u0442\u044c \u0432\u043e\u043f\u0440\u043e\u0441\u044b? \u041e\u0442\u0432\u0435\u0442\u044c\u0442\u0435 \u043d\u0430 \u044d\u0442\u043e \u043f\u0438\u0441\u044c\u043c\u043e \u0438\u043b\u0438 \u0441\u0432\u044f\u0436\u0438\u0442\u0435\u0441\u044c \u0441 \u043d\u0430\u043c\u0438 \u0432 WhatsApp:",
    phoneLabel: "\u0422\u0435\u043b\u0435\u0444\u043e\u043d", closing: "\u041c\u044b \u0431\u0443\u0434\u0435\u043c \u0440\u0430\u0434\u044b \u0432\u0430\u0441 \u0432\u0438\u0434\u0435\u0442\u044c!",
    htmlThankYou: (name) => `\u0421\u043f\u0430\u0441\u0438\u0431\u043e, ${name}!`,
    htmlIntro: "\u0412\u0430\u0448\u0435 \u0431\u0440\u043e\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u0435 \u043f\u043e\u043b\u0443\u0447\u0435\u043d\u043e \u0438 \u043f\u043e\u0434\u0442\u0432\u0435\u0440\u0436\u0434\u0435\u043d\u043e.",
    footerLocation: "MT Travel \u00b7 \u0411\u043e\u0434\u0440\u0443\u043c, \u0422\u0443\u0440\u0446\u0438\u044f",
    statusSubject: (id, status) => `\u041e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u0438\u0435 \u0431\u0440\u043e\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u044f ${id}: ${status}`,
    statusIntro: (id, tour, date) => `\u0421\u0442\u0430\u0442\u0443\u0441 \u0432\u0430\u0448\u0435\u0433\u043e \u0431\u0440\u043e\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u044f ${id} \u043d\u0430 \u0442\u0443\u0440 ${tour} ${date}:`,
    statusQuestions: "\u0415\u0441\u0442\u044c \u0432\u043e\u043f\u0440\u043e\u0441\u044b? \u041e\u0442\u0432\u0435\u0442\u044c\u0442\u0435 \u043d\u0430 \u044d\u0442\u043e \u043f\u0438\u0441\u044c\u043c\u043e \u0438\u043b\u0438 \u0441\u0432\u044f\u0436\u0438\u0442\u0435\u0441\u044c \u0441 \u043d\u0430\u043c\u0438 \u0432 WhatsApp.",
    statusHeading: (id) => `\u041e\u0431\u043d\u043e\u0432\u043b\u0435\u043d\u0438\u0435 \u0431\u0440\u043e\u043d\u0438\u0440\u043e\u0432\u0430\u043d\u0438\u044f ${id}`,
    contactConfirmSubject: "\u041c\u044b \u041f\u043e\u043b\u0443\u0447\u0438\u043b\u0438 \u0412\u0430\u0448\u0435 \u0421\u043e\u043e\u0431\u0449\u0435\u043d\u0438\u0435",
    contactConfirmIntro: "\u0421\u043f\u0430\u0441\u0438\u0431\u043e, \u0447\u0442\u043e \u0441\u0432\u044f\u0437\u0430\u043b\u0438\u0441\u044c \u0441 MT Travel. \u041c\u044b \u043f\u043e\u043b\u0443\u0447\u0438\u043b\u0438 \u0432\u0430\u0448\u0435 \u0441\u043e\u043e\u0431\u0449\u0435\u043d\u0438\u0435 \u0438 \u043e\u0442\u0432\u0435\u0442\u0438\u043c \u0432 \u0442\u0435\u0447\u0435\u043d\u0438\u0435 24 \u0447\u0430\u0441\u043e\u0432.",
    contactYourMessage: "\u0412\u0430\u0448\u0435 \u0441\u043e\u043e\u0431\u0449\u0435\u043d\u0438\u0435:",
  },
  pl: {
    subject: (id) => `Twoja rezerwacja MT Travel ${id}`,
    greeting: (name) => `Cze\u015b\u0107 ${name},`,
    thankYou: "Dzi\u0119kujemy za rezerwacj\u0119 w MT Travel! Twoja rezerwacja zosta\u0142a odebrana i potwierdzona.",
    labelResNumber: "Numer rezerwacji", labelTour: "Wycieczka", labelDate: "Data", labelGuests: "Go\u015bcie",
    guestsLine: (a, c, i) => `${a} doros\u0142ych, ${c} dzieci, ${i} niemowl\u0105t`,
    guestsLineAtv: (s, d) => `${s} pojedynczych, ${d} podw\u00f3jnych`,
    labelHotel: "Hotel / Miejsce odbioru", labelTotal: "Razem (p\u0142atne w dniu wycieczki)",
    paymentNote: "P\u0142atno\u015b\u0107 nie jest teraz wymagana - pe\u0142n\u0105 kwot\u0119 zap\u0142acisz w dniu wycieczki.",
    questions: "Masz pytania? Odpowiedz na tego e-maila lub skontaktuj si\u0119 z nami przez WhatsApp:",
    phoneLabel: "Telefon", closing: "Nie mo\u017cemy si\u0119 doczeka\u0107, aby Ci\u0119 powita\u0107!",
    htmlThankYou: (name) => `Dzi\u0119kujemy, ${name}!`,
    htmlIntro: "Twoja rezerwacja zosta\u0142a odebrana i potwierdzona.",
    footerLocation: "MT Travel \u00b7 Bodrum, Turcja",
    statusSubject: (id, status) => `Aktualizacja rezerwacji ${id}: ${status}`,
    statusIntro: (id, tour, date) => `Twoja rezerwacja ${id} na wycieczk\u0119 ${tour} w dniu ${date} ma teraz status:`,
    statusQuestions: "Masz pytania? Odpowiedz na tego e-maila lub skontaktuj si\u0119 z nami przez WhatsApp.",
    statusHeading: (id) => `Aktualizacja rezerwacji ${id}`,
    contactConfirmSubject: "Otrzymali\u015bmy Twoj\u0105 Wiadomo\u015b\u0107",
    contactConfirmIntro: "Dzi\u0119kujemy za kontakt z MT Travel. Otrzymali\u015bmy Twoj\u0105 wiadomo\u015b\u0107 i odpowiemy w ci\u0105gu 24 godzin.",
    contactYourMessage: "Twoja wiadomo\u015b\u0107:",
  },
};

function customerConfirmationEmail(r, company) {
  const lang = resolveLang(r.lang);
  const t = T[lang];
  const date = fmtDate(r.date, lang);
  const subject = t.subject(r.id);

  const text = `${t.greeting(r.firstName)}

${t.thankYou}

${t.labelResNumber}: ${r.id}
${t.labelTour}: ${r.tourName[lang] || r.tourName.en}
${t.labelDate}: ${date}
${t.labelGuests}: ${r.pricingMode === "single_double" ? t.guestsLineAtv(r.single, r.double) : t.guestsLine(r.adults, r.children, r.infants)}
${t.labelHotel}: ${r.hotelName || "-"}
${t.labelTotal}: EUR ${r.total}

${t.paymentNote}

${t.questions} https://wa.me/${company.whatsapp}
${t.phoneLabel}: ${company.phone}

${t.closing}
MT Travel`;

  const html = `
    <div style="font-family:Arial,sans-serif; max-width:520px; margin:0 auto; color:#16232E;">
      <div style="background:#0B1D2E; padding:24px; border-radius:12px 12px 0 0;">
        <h1 style="color:#fff; margin:0; font-size:20px;">MT TRAVEL</h1>
      </div>
      <div style="padding:24px; border:1px solid #E7ECEE; border-top:none; border-radius:0 0 12px 12px;">
        <h2 style="color:#0B1D2E;">${t.htmlThankYou(r.firstName)}</h2>
        <p>${t.htmlIntro}</p>
        <table style="width:100%; border-collapse:collapse; margin:20px 0;">
          <tr><td style="padding:8px 0; color:#64757F;">${t.labelResNumber}</td><td style="padding:8px 0; font-weight:bold;">${r.id}</td></tr>
          <tr><td style="padding:8px 0; color:#64757F;">${t.labelTour}</td><td style="padding:8px 0; font-weight:bold;">${r.tourName[lang] || r.tourName.en}</td></tr>
          <tr><td style="padding:8px 0; color:#64757F;">${t.labelDate}</td><td style="padding:8px 0; font-weight:bold;">${date}</td></tr>
          <tr><td style="padding:8px 0; color:#64757F;">${t.labelGuests}</td><td style="padding:8px 0;">${r.pricingMode === "single_double" ? t.guestsLineAtv(r.single, r.double) : t.guestsLine(r.adults, r.children, r.infants)}</td></tr>
          <tr><td style="padding:8px 0; color:#64757F;">${t.labelHotel}</td><td style="padding:8px 0;">${r.hotelName || "-"}</td></tr>
          <tr><td style="padding:12px 0 8px; color:#64757F; border-top:1px solid #E7ECEE;">${t.labelTotal}</td><td style="padding:12px 0 8px; font-weight:bold; border-top:1px solid #E7ECEE;">&euro;${r.total}</td></tr>
        </table>
        <p style="background:#F6F3EC; padding:12px 16px; border-radius:8px; font-size:14px;">${t.paymentNote}</p>
        <p>${t.questions} <a href="https://wa.me/${company.whatsapp}">WhatsApp</a> ${t.phoneLabel}: ${company.phone}.</p>
        <p style="color:#64757F; font-size:13px; margin-top:24px;">${t.footerLocation}</p>
      </div>
    </div>`;
  return { subject, text, html };
}

function ownerNotificationEmail(r) {
  const subject = `Yeni Rezervasyon Olu\u015fturuldu - ${r.id} - MT Travel`;
  const text = `Yeni bir rezervasyon al\u0131nd\u0131.

Rezervasyon Numaras\u0131: ${r.id}
M\u00fc\u015fteri: ${r.customer}
\u00dclke: ${r.country}
Telefon: ${r.phone}
E-posta: ${r.email}
Tur: ${r.tourName.tr || r.tourName.en}
Tarih: ${fmtDate(r.date, "tr")}
Misafirler: ${r.pricingMode === "single_double" ? `${r.single} Tek Ki\u015filik, ${r.double} \u00c7ift Ki\u015filik` : `${r.adults} Yeti\u015fkin, ${r.children} \u00c7ocuk, ${r.infants} Bebek`}
Otel / Al\u0131\u015f: ${r.hotelName || "-"}
Toplam: ${r.total} EUR
Notlar: ${r.notes || "-"}
Olu\u015fturulma Tarihi: ${new Date(r.createdAt).toLocaleString("tr-TR")}

Admin Panelinde G\u00f6r\u00fcnt\u00fcle: Rezervasyonlar > ${r.id}`;

  const html = `
    <div style="font-family:Arial,sans-serif; max-width:520px; margin:0 auto; color:#16232E;">
      <h2 style="color:#0B1D2E;">\u{1F514} Yeni Rezervasyon</h2>
      <table style="width:100%; border-collapse:collapse;">
        <tr><td style="padding:6px 0; color:#64757F;">Rezervasyon Numaras\u0131</td><td style="padding:6px 0; font-weight:bold;">${r.id}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">M\u00fc\u015fteri</td><td style="padding:6px 0; font-weight:bold;">${r.customer}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">\u00dclke</td><td style="padding:6px 0;">${r.country}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">Telefon</td><td style="padding:6px 0;">${r.phone}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">E-posta</td><td style="padding:6px 0;">${r.email}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">Tur</td><td style="padding:6px 0; font-weight:bold;">${r.tourName.tr || r.tourName.en}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">Tarih</td><td style="padding:6px 0; font-weight:bold;">${fmtDate(r.date, "tr")}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">Misafirler</td><td style="padding:6px 0;">${r.pricingMode === "single_double" ? `${r.single} Tek Ki\u015filik, ${r.double} \u00c7ift Ki\u015filik` : `${r.adults} Yeti\u015fkin, ${r.children} \u00c7ocuk, ${r.infants} Bebek`}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">Otel / Al\u0131\u015f</td><td style="padding:6px 0;">${r.hotelName || "-"}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">Toplam</td><td style="padding:6px 0; font-weight:bold;">&euro;${r.total}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">Notlar</td><td style="padding:6px 0;">${r.notes || "-"}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">Olu\u015fturulma Tarihi</td><td style="padding:6px 0;">${new Date(r.createdAt).toLocaleString("tr-TR")}</td></tr>
      </table>
    </div>`;
  return { subject, text, html };
}

function statusUpdateEmail(r) {
  const lang = resolveLang(r.lang);
  const t = T[lang];
  const date = fmtDate(r.date, lang);
  const tourName = r.tourName[lang] || r.tourName.en;
  const statusLabel = (STATUS_LABELS[lang] && STATUS_LABELS[lang][r.status]) || r.status;
  const subject = t.statusSubject(r.id, statusLabel);

  const text = `${t.greeting(r.firstName)}

${t.statusIntro(r.id, tourName, date)} ${statusLabel}.

${t.statusQuestions}

MT Travel`;
  const html = `<div style="font-family:Arial,sans-serif; max-width:520px; margin:0 auto; color:#16232E;">
    <h2 style="color:#0B1D2E;">${t.statusHeading(r.id)}</h2>
    <p>${t.statusIntro(r.id, `<strong>${tourName}</strong>`, date)}</p>
    <p style="font-size:18px; font-weight:bold; color:#0E9186;">${statusLabel}</p>
    <p style="color:#64757F; font-size:13px; margin-top:24px;">MT Travel</p>
  </div>`;
  return { subject, text, html };
}

function contactFormEmail(data) {
  const subjectLabels = {
    general: "Genel Soru", booking: "Rezervasyon Sorusu",
    private: "\u00d6zel Tur Talebi", feedback: "Geri Bildirim",
  };
  const subjectLabel = subjectLabels[data.subject] || data.subject || "Genel Soru";
  const subject = `Yeni \u0130leti\u015fim Formu Mesaj\u0131 - ${subjectLabel}`;
  const phoneLine = data.phone ? `Telefon: ${data.phone}\n` : "";
  const text = `Web sitesinden yeni bir ileti\u015fim formu mesaj\u0131 al\u0131nd\u0131.

Ad Soyad: ${data.firstName} ${data.lastName}
E-posta: ${data.email}
${phoneLine}Konu: ${subjectLabel}

Mesaj:
${data.message}`;
  const phoneRow = data.phone ? `<tr><td style="padding:6px 0; color:#64757F;">Telefon</td><td style="padding:6px 0;"><a href="tel:${data.phone}">${data.phone}</a></td></tr>` : "";
  const html = `
    <div style="font-family:Arial,sans-serif; max-width:520px; margin:0 auto; color:#16232E;">
      <h2 style="color:#0B1D2E;">\u{1F4E9} Yeni \u0130leti\u015fim Formu Mesaj\u0131</h2>
      <table style="width:100%; border-collapse:collapse;">
        <tr><td style="padding:6px 0; color:#64757F;">Ad Soyad</td><td style="padding:6px 0; font-weight:bold;">${data.firstName} ${data.lastName}</td></tr>
        <tr><td style="padding:6px 0; color:#64757F;">E-posta</td><td style="padding:6px 0;"><a href="mailto:${data.email}">${data.email}</a></td></tr>
        ${phoneRow}
        <tr><td style="padding:6px 0; color:#64757F;">Konu</td><td style="padding:6px 0; font-weight:bold;">${subjectLabel}</td></tr>
      </table>
      <p style="margin-top:16px; color:#64757F;">Mesaj:</p>
      <p style="background:#F6F3EC; padding:12px 16px; border-radius:8px; white-space:pre-wrap;">${data.message.replace(/</g, "&lt;")}</p>
    </div>`;
  return { subject, text, html };
}

function contactConfirmationEmail(data) {
  const lang = resolveLang(data.lang);
  const t = T[lang];
  const subject = t.contactConfirmSubject;
  const text = `${t.greeting(data.firstName)}

${t.contactConfirmIntro}

${t.contactYourMessage}
${data.message}

MT Travel`;
  const html = `
    <div style="font-family:Arial,sans-serif; max-width:520px; margin:0 auto; color:#16232E;">
      <div style="background:#0B1D2E; padding:24px; border-radius:12px 12px 0 0;">
        <h1 style="color:#fff; margin:0; font-size:20px;">MT TRAVEL</h1>
      </div>
      <div style="padding:24px; border:1px solid #E7ECEE; border-top:none; border-radius:0 0 12px 12px;">
        <h2 style="color:#0B1D2E;">${t.htmlThankYou(data.firstName)}</h2>
        <p>${t.contactConfirmIntro}</p>
        <p style="margin-top:16px; color:#64757F;">${t.contactYourMessage}</p>
        <p style="background:#F6F3EC; padding:12px 16px; border-radius:8px; white-space:pre-wrap;">${data.message.replace(/</g, "&lt;")}</p>
        <p style="color:#64757F; font-size:13px; margin-top:24px;">${t.footerLocation}</p>
      </div>
    </div>`;
  return { subject, text, html };
}

function adminCustomEmail(r, subject, message) {
  const lang = resolveLang(r.lang);
  const t = T[lang];
  const text = `${t.greeting(r.firstName)}

${message}

${t.closing}
MT Travel`;
  const html = `
    <div style="font-family:Arial,sans-serif; max-width:520px; margin:0 auto; color:#16232E;">
      <div style="background:#0B1D2E; padding:24px; border-radius:12px 12px 0 0;">
        <h1 style="color:#fff; margin:0; font-size:20px;">MT TRAVEL</h1>
      </div>
      <div style="padding:24px; border:1px solid #E7ECEE; border-top:none; border-radius:0 0 12px 12px;">
        <p>${t.greeting(r.firstName)}</p>
        <p style="white-space:pre-wrap;">${message.replace(/</g, "&lt;")}</p>
        <p style="color:#64757F; font-size:13px; margin-top:24px;">${t.labelResNumber}: ${r.id} &middot; ${t.footerLocation}</p>
      </div>
    </div>`;
  return { subject, text, html };
}

module.exports = { customerConfirmationEmail, ownerNotificationEmail, statusUpdateEmail, contactFormEmail, contactConfirmationEmail, adminCustomEmail };
