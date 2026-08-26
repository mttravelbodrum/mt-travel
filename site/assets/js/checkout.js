/* ==========================================================================
   checkout.js — checkout.html: rezervasyon özeti + Rezervasyonu Tamamla
   SADECE GERÇEK ARKA UÇ. Bir rezervasyon, ancak gerçek arka uç bunun
   gerçek veritabanına kaydedildiğini onayladığında tamamlanmış sayılır.
   Arka uca ulaşılamıyorsa veya istek reddedilirse, müşteriye net bir
   hata gösterilir ve hiçbir şey başarılıymış gibi gösterilmez.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, formatCurrency, formatDate, currentLang, storeGet, storeSet, toast } = MTUtils;

  let draft = null;
  let submitted = false;

  function init() {
    if (!qs("#checkoutApp")) return;
    draft = storeGet("mt_booking_draft", null);
    if (!draft) { location.href = "booking.html"; return; }
    renderSummary();
    bindAgreement();
    bindSubmit();
  }

  function tourBySlug(slug) {
    return (typeof MT_TOURS !== "undefined") ? MT_TOURS.find((t) => t.slug === slug) : null;
  }

  function renderSummary() {
    const lang = currentLang();
    const tour = tourBySlug(draft.tourSlug);
    qsa("[data-summary-tour-name]").forEach((el) => el.textContent = draft.tourName[lang] || draft.tourName.en);
    if (tour) qsa("[data-summary-tour-img]").forEach((el) => {
      if (tour.image_count > 0) { el.src = `assets/images/${tour.folder}/${tour.image_prefix}_01.jpg`; el.style.display = ""; }
      else { el.style.display = "none"; }
    });
    qsa("[data-summary-date]").forEach((el) => el.textContent = formatDate(draft.date));
    const atvMode = draft.pricingMode === "single_double";
    const stdRows = qs("#checkoutStandardRows");
    const atvRows = qs("#checkoutAtvRows");
    if (stdRows) stdRows.style.display = atvMode ? "none" : "";
    if (atvRows) atvRows.style.display = atvMode ? "" : "none";
    qsa("[data-summary-adults]").forEach((el) => el.textContent = draft.adults);
    qsa("[data-summary-children]").forEach((el) => el.textContent = draft.children);
    qsa("[data-summary-infants]").forEach((el) => el.textContent = draft.infants);
    qsa("[data-summary-single]").forEach((el) => el.textContent = draft.single || 0);
    qsa("[data-summary-double]").forEach((el) => el.textContent = draft.double || 0);
    qsa("[data-summary-name]").forEach((el) => el.textContent = `${draft.firstName} ${draft.lastName}`);
    qsa("[data-summary-email]").forEach((el) => el.textContent = draft.email);
    qsa("[data-summary-hotel]").forEach((el) => el.textContent = draft.hotelName);
    qsa("[data-price-starting]").forEach((el) => el.textContent = formatCurrency(draft.priceOnline));
    qsa("[data-price-total]").forEach((el) => el.textContent = formatCurrency(draft.subtotal));
  }

  function bindAgreement() {
    const box = qs("#agreeCheckout");
    const btn = qs("#completeReservationBtn");
    if (!box || !btn) return;
    const sync = () => { btn.disabled = !box.checked; };
    box.addEventListener("change", sync);
    sync();
  }

  function bindSubmit() {
    const btn = qs("#completeReservationBtn");
    if (!btn) return;
    btn.addEventListener("click", (e) => {
      e.preventDefault();
      if (submitted) return; // guard against double-booking from repeated clicks
      submitted = true;
      btn.classList.add("is-loading");
      btn.disabled = true;
      completeReservation();
    });
  }

  function showError(message) {
    let box = qs("#checkoutErrorBox");
    if (!box) {
      box = document.createElement("div");
      box.id = "checkoutErrorBox";
      box.className = "field-error";
      box.style.cssText = "display:flex; margin-bottom:16px;";
      const btn = qs("#completeReservationBtn");
      btn.parentElement.insertBefore(box, btn.parentElement.firstChild);
    }
    box.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg><span>${message}</span>`;
    box.style.display = "flex";
  }

  async function completeReservation() {
    const btn = qs("#completeReservationBtn");

    const available = await MTApi.isAvailable().catch(() => false);
    if (!available) {
      const reason = MTApi.getLastFailureReason();
      showError(reason === "file_protocol" ? mtT("admin.login_error_file_protocol") : mtT("checkout.error_unreachable"));
      btn.classList.remove("is-loading");
      btn.disabled = false;
      submitted = false;
      return;
    }

    try {
      const record = await MTApi.createReservation({
        slug: draft.tourSlug,
        tourNameEn: draft.tourName.en, tourNameTr: draft.tourName.tr,
        date: draft.date, adults: draft.adults, children: draft.children, infants: draft.infants,
        single: draft.single, double: draft.double, pricingMode: draft.pricingMode,
        firstName: draft.firstName, lastName: draft.lastName,
        email: draft.email, phone: `${draft.dialCode} ${draft.phone}`, country: draft.country,
        hotelName: draft.hotelName, notes: draft.notes,
        paymentMethod: "reserve_pay_later", total: draft.subtotal,
        lang: MTUtils.currentLang(),
      });
      storeSet("mt_last_booking", record);
      location.href = "success.html";
    } catch (err) {
      showError(MTUtils.translateApiError(err.message) || mtT("checkout.error_generic"));
      btn.classList.remove("is-loading");
      btn.disabled = false;
      submitted = false;
    }
  }

  document.addEventListener("DOMContentLoaded", init);
  document.addEventListener("mt:langchange", () => { if (draft) renderSummary(); });
})();
