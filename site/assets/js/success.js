/* ==========================================================================
   success.js — success.html: rezervasyon onayı
   Sadece arayüz. "Biletimi Görüntüle" butonu, aynı kayıtlı rezervasyonu
   okuyup gösteren/yazdıran ticket.html sayfasına düz bir bağlantıdır.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, formatCurrency, formatDate, currentLang, storeGet } = MTUtils;
  let currentRecord = null;

  function init() {
    if (!qs("#successApp")) return;
    const record = storeGet("mt_last_booking", null);
    if (!record) { location.href = "index.html"; return; }
    currentRecord = record;
    render(record);
    bindButtons(record);
  }

  function render(record) {
    const lang = currentLang();
    qsa("[data-confirm-number]").forEach((el) => el.textContent = record.id);
    qsa("[data-confirm-customer]").forEach((el) => el.textContent = record.customer);
    qsa("[data-confirm-tour]").forEach((el) => el.textContent = record.tourName[lang] || record.tourName.en);
    qsa("[data-confirm-date]").forEach((el) => el.textContent = formatDate(record.date));
    qsa("[data-confirm-adults]").forEach((el) => el.textContent = record.adults);
    qsa("[data-confirm-children]").forEach((el) => el.textContent = record.children);
    qsa("[data-confirm-infants]").forEach((el) => el.textContent = record.infants);
    qsa("[data-confirm-hotel]").forEach((el) => {
      const row = el.closest(".confirm-detail");
      if (record.hotelName) { el.textContent = record.hotelName; if (row) row.style.display = ""; }
      else if (row) row.style.display = "none";
    });
    qsa("[data-confirm-total]").forEach((el) => el.textContent = formatCurrency(record.total));
    qsa("[data-confirm-email]").forEach((el) => el.textContent = record.email);
    const statusEl = qs("[data-confirm-status]");
    if (statusEl) {
      statusEl.textContent = mtT("confirm.status_pending");
      statusEl.className = "status-pill status-pill--pending";
    }
  }

  function bindButtons(record) {
    const waBtn = qs("#whatsappContactBtn");
    if (waBtn && typeof MT_SITE !== "undefined") {
      const msg = encodeURIComponent(mtT("confirm.whatsapp_template").replace("{id}", record.id).replace("{tour}", record.tourName.en));
      waBtn.href = `https://wa.me/${MT_SITE.company.whatsapp_link}?text=${msg}`;
    }
    const dirBtn = qs("#getDirectionsBtn");
    if (dirBtn && typeof MT_SITE !== "undefined") {
      dirBtn.href = `https://maps.google.com/maps?q=${encodeURIComponent(MT_SITE.company.address_en)}`;
    }
  }

  document.addEventListener("DOMContentLoaded", init);
  document.addEventListener("mt:langchange", () => { if (currentRecord) render(currentRecord); });
})();
