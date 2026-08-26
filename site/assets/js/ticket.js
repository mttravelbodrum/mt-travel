/* ==========================================================================
   ticket.js — ticket.html: yazdırılabilir/indirilebilir rezervasyon bileti.
   success.html'nin kullandığı aynı kayıtlı rezervasyonu okur. "İndir"
   butonu tarayıcının kendi PDF'e yazdırma özelliğini kullanır
   (window.print()) - harici kütüphane veya sunucu isteği yoktur. İstendiği
   gibi sadece arayüz; gerçek bir arka uç PDF üretimi, sayfanın kendisini
   değiştirmeden bunun yerini alabilir.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, formatCurrency, formatDate, currentLang, storeGet } = MTUtils;
  let currentRecord = null;

  function init() {
    if (!qs("#ticketApp")) return;
    const record = storeGet("mt_last_booking", null);
    if (!record) { location.href = "index.html"; return; }
    currentRecord = record;
    render(record);
    bindActions();
  }

  function render(record) {
    const lang = currentLang();
    qsa("[data-ticket-number]").forEach((el) => el.textContent = record.id);
    qsa("[data-ticket-customer]").forEach((el) => el.textContent = record.customer);
    qsa("[data-ticket-tour]").forEach((el) => el.textContent = record.tourName[lang] || record.tourName.en);
    qsa("[data-ticket-date]").forEach((el) => el.textContent = formatDate(record.date));
    qsa("[data-ticket-guests]").forEach((el) => {
      if (record.pricingMode === "single_double") {
        const parts = [];
        if (record.single) parts.push(`${record.single} ${mtT("booking.single")}`);
        if (record.double) parts.push(`${record.double} ${mtT("booking.double")}`);
        el.textContent = parts.join(", ") || "\u2014";
        return;
      }
      const parts = [`${record.adults} ${mtT("search.adults")}`];
      if (record.children) parts.push(`${record.children} ${mtT("search.children")}`);
      if (record.infants) parts.push(`${record.infants} ${mtT("booking.infants")}`);
      el.textContent = parts.join(", ");
    });
    qsa("[data-ticket-hotel]").forEach((el) => {
      const row = el.closest("[data-ticket-row-hotel]");
      if (record.hotelName) { el.textContent = record.hotelName; if (row) row.style.display = ""; }
      else if (row) row.style.display = "none";
    });
    qsa("[data-ticket-total]").forEach((el) => el.textContent = formatCurrency(record.total));
    qsa("[data-ticket-email]").forEach((el) => el.textContent = record.email);
    qsa("[data-ticket-phone]").forEach((el) => el.textContent = record.phone || "\u2014");
  }

  function bindActions() {
    const printBtn = qs("#printTicketBtn");
    const downloadBtn = qs("#downloadTicketBtn");
    // Both trigger the browser's own print dialog - "Print" for a physical
    // printer, "Download PDF" for the dialog's own "Save as PDF" option.
    // This is the same real capability either way (no separate PDF
    // library), just labeled for what the person is trying to do.
    printBtn && printBtn.addEventListener("click", () => window.print());
    downloadBtn && downloadBtn.addEventListener("click", () => window.print());
  }

  document.addEventListener("DOMContentLoaded", init);
  document.addEventListener("mt:langchange", () => { if (currentRecord) render(currentRecord); });
})();
