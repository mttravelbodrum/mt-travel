/* ==========================================================================
   booking.js — rezervasyon akışı (booking.html)
   Adımlar: 1) Tur, Tarih ve Misafirler -> 2) İletişim Bilgileri -> checkout.html
   Sadece Ad/Soyad, Ülke, Telefon, E-posta, Otel/Alış Oteli (zorunlu) ve
   Özel İstek (isteğe bağlı) alanları alınır.
   Alış noktası, acil durum kişisi veya kupon alanı yoktur.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, todayISO, addDaysISO, formatCurrency, formatDate, currentLang } = MTUtils;

  const state = {
    step: 1,
    tourSlug: null,
    date: "",
    adults: 2,
    children: 0,
    infants: 0,
    single: 1,
    double: 0,
    firstName: "", lastName: "", country: "", dialCode: "", phone: "",
    email: "", hotelName: "", notes: ""
  };

  function tourBySlug(slug) {
    return (typeof MT_TOURS !== "undefined") ? MT_TOURS.find((t) => t.slug === slug) : null;
  }

  let calendarWidget = null;
  let liveTourData = {}; // slug -> live data from backend (price, durationHours, availableDays), cached per page load
  // Minimum advance-booking window (in days) for tours with is_island set -
  // starts from the build-time value so there's a sensible number before
  // the network round-trip resolves, then syncSiteSettings() below refines
  // it to whatever Admin -> Settings -> Booking Rules currently says.
  let advanceDays = (typeof MT_SITE !== "undefined" && Number.isFinite(MT_SITE.island_min_advance_days)) ? MT_SITE.island_min_advance_days : 1;

  async function init() {
    if (!qs("#bookingApp")) return;
    hydrateFromQuery();
    renderTourPicks();
    renderCountryOptions();
    bindStepNav();
    bindGuestCounters();
    bindContactForm();
    // The calendar's "which dates are disabled" rule depends on two things
    // that can change after this static page was built: the admin's
    // island-tour advance-notice setting, and this tour's own is_island
    // flag. Resolving both BEFORE the calendar is created (rather than
    // firing them off in the background and correcting the calendar a
    // moment later) means the very first thing the visitor can click
    // already reflects the real rule - there's no window where a date
    // that looks selectable is actually going to be rejected once they
    // reach checkout. Both syncs already fail silently and fall back to
    // the build-time defaults if the backend is slow or unreachable, so
    // this adds a brief (typically well under a second) wait on a normal
    // connection and never hangs indefinitely.
    const calWrap = qs("#tourCalendarWidget");
    if (calWrap) calWrap.innerHTML = `<div class="tcal-loading">${mtT("calendar.loading")}</div>`;
    await Promise.all([syncSiteSettings(), syncLiveTourData(state.tourSlug)]);
    initCalendarWidget();
    bindDateField();
    updateAll();
    goToStep(1, true);
    watchForMidnightRollover();
  }

  // If a visitor leaves this page open across midnight Turkey time, the
  // day that was correctly disabled as "today" when the page loaded is
  // still "today" as far as the calendar is concerned until something
  // re-evaluates it - a plain page load only computes this once. Checking
  // every 30s (cheap: todayISO() is a single Intl call, no network) and
  // re-applying the constraint the moment the Turkey calendar date
  // actually changes means the newly-current day gets disabled and the
  // minimum selectable date rolls forward on its own, with no reload and
  // no action from the visitor.
  function watchForMidnightRollover() {
    let lastKnownDate = todayISO();
    setInterval(() => {
      const nowDate = todayISO();
      if (nowDate !== lastKnownDate) {
        lastKnownDate = nowDate;
        applyDateConstraints();
        updateAll();
      }
    }, 30000);
  }

  function initCalendarWidget() {
    const wrap = qs("#tourCalendarWidget");
    const hidden = qs("#tourDateInput");
    if (!wrap || !hidden || typeof MTTourCalendar === "undefined") return;
    calendarWidget = MTTourCalendar.create(hidden, wrap);
  }

  // Fetches the current islandMinAdvanceDays setting from the real backend
  // (Admin -> Settings -> Booking Rules), so changing that number there is
  // actually reflected here instead of a hardcoded "1 day" everywhere.
  // Falls back silently to the build-time MT_SITE value if unreachable.
  async function syncSiteSettings() {
    if (typeof MTApi === "undefined") return;
    try {
      const available = await MTApi.isAvailable();
      if (!available) return;
      const info = await MTApi.getCompanyInfo();
      const days = Number(info && info.islandMinAdvanceDays);
      if (Number.isFinite(days) && days >= 0) {
        advanceDays = days;
        applyDateConstraints();
        renderTourPicks();
      }
    } catch (e) { /* non-fatal - build-time default already applied */ }
  }

  // Fetches this tour's CURRENT price/duration/availableDays from the real
  // backend, so an admin's edit (Tour Calendar days, or a price change)
  // shows up here immediately - no rebuild, no restart. Falls back
  // silently to the static MT_TOURS data (already displayed) if the
  // backend isn't reachable, so booking still works either way.
  async function syncLiveTourData(slug) {
    if (!slug || typeof MTApi === "undefined") return;
    if (liveTourData[slug]) { applyLiveTourData(slug); return; }
    try {
      const available = await MTApi.isAvailable();
      if (!available) return;
      const live = await MTApi.getTourBySlug(slug);
      liveTourData[slug] = live;
      if (slug === state.tourSlug) applyLiveTourData(slug);
    } catch (e) { /* non-fatal - static data already shown */ }
  }

  function applyLiveTourData(slug) {
    const live = liveTourData[slug];
    const tour = tourBySlug(slug);
    if (!live || !tour) return;
    // Deliberately NOT syncing live.name here (or into the tour-pick list
    // below): the backend stores only one name per tour with no language
    // concept, so copying it over tour.name.tr (or straight into a shown
    // label) would silently replace a correct translation with whatever
    // the admin typed - wrong for every language, including Turkish. The
    // static, already-translated name stays as the source of truth; price,
    // availability and island status have no such conflict and still sync
    // live.
    tour.price_online = live.priceOnline;
    tour.price_adult = live.priceAdult;
    tour.price_child = live.priceChild;
    tour.price_infant = live.priceInfant;
    tour.pricing_mode = live.pricingMode;
    tour.price_single = live.priceSingle;
    tour.price_double = live.priceDouble;
    tour.is_island = live.isIsland;
    tour._liveAvailableDays = live.availableDays || null;
    tour._liveDurationHours = live.durationHours;
    if (slug === state.tourSlug) { applyDateConstraints(); updateAll(); }
    // Keep the tour-pick list's shown price in sync too
    const priceEl = qs(`[data-tour-pick="${slug}"] [data-price-eur]`);
    if (priceEl) priceEl.textContent = formatCurrency(live.priceAdult);
  }

  // "This tour requires at least N day(s) advance booking" - reuses the
  // exact wording (and correct singular/plural per language) already
  // built for the checkout-time version of this message, dropping its
  // "please choose a later date" tail since here it's describing the
  // tour up front, not responding to an invalid pick.
  function advanceNoticeText() {
    const key = advanceDays === 1 ? "error.advance_booking_singular" : "error.advance_booking_plural";
    return mtT(key).replace("{n}", advanceDays).split(".")[0] + ".";
  }

  function hydrateFromQuery() {
    const params = new URLSearchParams(location.search);
    const slug = params.get("tour");
    if (slug && tourBySlug(slug)) state.tourSlug = slug;
    else if (typeof MT_TOURS !== "undefined" && MT_TOURS.length) state.tourSlug = MT_TOURS[0].slug;
    const date = params.get("date");
    if (date) state.date = date;
  }

  function renderTourPicks() {
    const wrap = qs("#tourPickList");
    if (!wrap || typeof MT_TOURS === "undefined") return;
    const lang = currentLang();
    wrap.innerHTML = MT_TOURS.map((t) => `
      <div class="tour-pick${t.slug === state.tourSlug ? " is-selected" : ""}" data-tour-pick="${t.slug}">
        ${t.image_count > 0
          ? `<img src="assets/images/${t.folder}/${t.image_prefix}_01.jpg" alt="${MTUtils.escapeHtml(t.name[lang] || t.name.en)}" loading="lazy">`
          : `<div class="tour-pick__pending">${mtT("tour.photos_pending_short")}</div>`}
        <div class="tour-pick__info">
          <strong>${MTUtils.escapeHtml(t.name[lang] || t.name.en)}</strong>
          <span>${t.is_island ? advanceNoticeText() : mtT("tabs.overview")}</span>
        </div>
        <div class="tour-pick__price" data-price-eur="${t.price_online}">${formatCurrency(t.price_online)}</div>
      </div>
    `).join("");
    qsa("[data-tour-pick]", wrap).forEach((el) => {
      el.addEventListener("click", () => {
        state.tourSlug = el.dataset.tourPick;
        qsa("[data-tour-pick]", wrap).forEach((o) => o.classList.toggle("is-selected", o === el));
        updateAll();
        syncLiveTourData(state.tourSlug);
      });
    });
  }

  function renderCountryOptions() {
    const sel = qs("#countrySelect");
    if (!sel || typeof MT_COUNTRIES === "undefined") return;
    const lang = currentLang() === "tr" ? "name_tr" : "name_en";
    sel.innerHTML = `<option value="">${mtT("form.select_country")}</option>` +
      MT_COUNTRIES.map((c) => `<option value="${c.code}" data-dial="${c.dial}" data-len="${c.len.join(",")}">${c[lang]} (${c.dial})</option>`).join("");
    sel.addEventListener("change", () => {
      const opt = sel.selectedOptions[0];
      state.country = sel.value;
      state.dialCode = opt ? opt.dataset.dial : "";
      const dialLabel = qs("#dialCodeLabel");
      if (dialLabel) dialLabel.textContent = state.dialCode || "+--";
      clearFieldError("countrySelect");
    });
  }

  function bindGuestCounters() {
    ["adults", "children", "infants", "single", "double"].forEach((key) => {
      const counter = qs(`[data-counter="${key}"]`);
      if (!counter) return;
      counter.addEventListener("mt:counterchange", (e) => {
        state[key] = e.detail.value;
        updateAll();
      });
    });
  }

  function bindDateField() {
    const dateInput = qs("#tourDateInput");
    if (!dateInput) return;
    applyDateConstraints();
    if (state.date) dateInput.value = state.date;
    dateInput.addEventListener("change", () => {
      state.date = dateInput.value;
      validateDate();
      updateAll();
    });
  }

  function applyDateConstraints() {
    const dateInput = qs("#tourDateInput");
    if (!dateInput) return;
    const tour = tourBySlug(state.tourSlug);
    const min = tour && tour.is_island ? addDaysISO(todayISO(), advanceDays) : todayISO();
    dateInput.min = min;
    if (state.date && state.date < min) {
      state.date = "";
      dateInput.value = "";
    }
    if (calendarWidget) {
      calendarWidget.setMin(min);
      calendarWidget.setAvailableDays(tour ? tour._liveAvailableDays : null);
    }
    // Show the "requires N days advance notice" hint below the calendar
    // proactively, as soon as it's known this tour needs it - not just
    // reactively after the guest tries an invalid date and gets rejected.
    // Seeing it up front is what actually prevents the old "picks today,
    // fills in their details, gets an error at the end" complaint from
    // happening in the first place.
    const note = qs("#dateNote");
    if (note && tour && tour.is_island) {
      toggleNote(note, true, advanceNoticeText());
    } else if (note) {
      toggleNote(note, false);
    }
  }

  function validateDate() {
    const tour = tourBySlug(state.tourSlug);
    if (!tour || !state.date) return true;
    const min = tour.is_island ? addDaysISO(todayISO(), advanceDays) : todayISO();
    if (state.date < min) {
      state.date = "";
      const dateInput = qs("#tourDateInput");
      if (dateInput) dateInput.value = "";
      return false;
    }
    return true;
  }

  function toggleNote(el, show, text) {
    if (!el) return;
    el.style.display = show ? "flex" : "none";
    if (text) qs("span", el) && (qs("span", el).textContent = text);
  }

  function bindContactForm() {
    ["firstName", "lastName", "email", "phone", "hotelName", "notes"].forEach((key) => {
      const el = qs("#" + key);
      if (!el) return;
      el.addEventListener("input", () => { state[key] = el.value; clearFieldError(key); });
    });
    initHotelCombo();
  }

  let hotelsList = [];

  async function initHotelCombo() {
    const input = qs("#hotelName");
    const list = qs("#hotelComboList");
    if (!input || !list) return;

    try {
      if (typeof MTApi !== "undefined") hotelsList = await MTApi.getHotels();
    } catch (e) { hotelsList = []; /* combo just won't offer suggestions - typing still works */ }

    function renderSuggestions() {
      // toLocaleLowerCase("tr") specifically, not plain toLowerCase(): in
      // Turkish, "I" lowercases to "ı" (not "i") and "İ" lowercases to
      // "i" (not "i̇") - without this, someone typing e.g. "ILAVUZ" would
      // never match "Kılavuz Otel", since default lowercasing turns
      // "I" into "i" and "kılavuz" stays "kılavuz" (different letters).
      const query = input.value.trim().toLocaleLowerCase("tr");
      const matches = query
        ? hotelsList.filter((h) => h.name.toLocaleLowerCase("tr").includes(query)).slice(0, 8)
        : hotelsList.slice(0, 8);
      if (!matches.length) {
        // Never blocks typing a hotel that isn't in the admin-managed
        // list - this line is just a hint, not a restriction.
        list.innerHTML = query ? `<div class="hotel-combo__empty">${mtT("booking.hotel_no_matches")}</div>` : "";
        list.classList.toggle("is-open", !!query);
        return;
      }
      list.innerHTML = matches.map((h) => `<button type="button" class="hotel-combo__item" data-hotel-name="${h.name.replace(/"/g, "&quot;")}">${h.name}</button>`).join("");
      list.classList.add("is-open");
      qsa(".hotel-combo__item", list).forEach((btn) => {
        btn.addEventListener("mousedown", (e) => {
          // mousedown (not click) fires before the input's blur, so the
          // list is still open and readable at the moment of selection.
          e.preventDefault();
          input.value = btn.dataset.hotelName;
          state.hotelName = btn.dataset.hotelName;
          clearFieldError("hotelName");
          list.classList.remove("is-open");
        });
      });
    }

    input.addEventListener("input", renderSuggestions);
    input.addEventListener("focus", renderSuggestions);
    input.addEventListener("blur", () => { list.classList.remove("is-open"); });
  }

  function clearFieldError(id) {
    const field = qs("#" + id);
    if (!field) return;
    const wrap = field.closest(".field");
    if (wrap) wrap.classList.remove("has-error");
  }

  function setFieldError(id, show) {
    const field = qs("#" + id);
    if (!field) return;
    const wrap = field.closest(".field");
    if (wrap) wrap.classList.toggle("has-error", show);
  }

  function isValidEmail(v) { return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(v); }

  function isValidPhone() {
    const opt = qs("#countrySelect") ? qs("#countrySelect").selectedOptions[0] : null;
    const digits = (state.phone || "").replace(/\D/g, "");
    if (!opt || !digits) return false;
    const [min, max] = (opt.dataset.len || "6,14").split(",").map(Number);
    return digits.length >= min && digits.length <= max;
  }

  function validateStep1() {
    let ok = true;
    if (!state.tourSlug) ok = false;
    if (!state.date || !validateDate()) ok = false;
    const tour = tourBySlug(state.tourSlug);
    if (isAtvPricing(tour)) {
      if (state.single + state.double < 1) ok = false;
    } else if (state.adults < 1) ok = false;
    const err = qs("#step1Error");
    if (err) err.style.display = ok ? "none" : "flex";
    return ok;
  }

  function validateStep2() {
    let ok = true;
    if (!state.firstName.trim()) { setFieldError("firstName", true); ok = false; } else setFieldError("firstName", false);
    if (!state.lastName.trim()) { setFieldError("lastName", true); ok = false; } else setFieldError("lastName", false);
    if (!state.country) { setFieldError("countrySelect", true); ok = false; } else setFieldError("countrySelect", false);
    if (!isValidEmail(state.email)) { setFieldError("email", true); ok = false; } else setFieldError("email", false);
    if (!isValidPhone()) { setFieldError("phone", true); ok = false; } else setFieldError("phone", false);
    setFieldError("hotelName", false); // optional field - never blocks continuing
    return ok;
  }

  function bindStepNav() {
    qsa("[data-step-next]").forEach((btn) => {
      btn.addEventListener("click", () => {
        if (state.step === 1 && !validateStep1()) return;
        if (state.step === 2) { goToCheckout(); return; }
        goToStep(state.step + 1);
      });
    });
    qsa("[data-step-back]").forEach((btn) => btn.addEventListener("click", () => goToStep(state.step - 1)));
  }

  function goToStep(n, silent) {
    state.step = Math.max(1, Math.min(2, n));
    qsa(".flow-step").forEach((el) => el.classList.toggle("is-active", parseInt(el.dataset.step, 10) === state.step));
    qsa("[data-step-aside]").forEach((el) => el.style.display = (parseInt(el.dataset.stepAside, 10) === state.step) ? "" : "none");
    qsa(".stepper__item").forEach((el) => {
      const idx = parseInt(el.dataset.stepIndex, 10);
      el.classList.toggle("is-done", idx < state.step);
      el.classList.toggle("is-active", idx === state.step);
    });
    if (!silent) window.scrollTo({ top: qs("#bookingApp").offsetTop - 130, behavior: "smooth" });
    applyDateConstraints();
  }

  function isAtvPricing(tour) {
    return !!tour && tour.pricing_mode === "single_double";
  }

  function calcTotals() {
    const tour = tourBySlug(state.tourSlug);
    if (!tour) return { subtotal: 0, adultsTotal: 0, childrenTotal: 0, infantsTotal: 0, singleTotal: 0, doubleTotal: 0 };
    if (isAtvPricing(tour)) {
      const priceSingle = tour.price_single != null ? tour.price_single : tour.price_online;
      const priceDouble = tour.price_double != null ? tour.price_double : tour.price_online * 1.8;
      const singleTotal = priceSingle * state.single;
      const doubleTotal = priceDouble * state.double;
      return { tour, priceSingle, priceDouble, singleTotal, doubleTotal, subtotal: singleTotal + doubleTotal };
    }
    const priceAdult = tour.price_adult != null ? tour.price_adult : tour.price_online;
    const priceChild = tour.price_child != null ? tour.price_child : tour.price_online * 0.5;
    const priceInfant = tour.price_infant != null ? tour.price_infant : 0;
    const adultsTotal = priceAdult * state.adults;
    const childrenTotal = priceChild * state.children;
    const infantsTotal = priceInfant * state.infants;
    return { tour, priceAdult, priceChild, priceInfant, adultsTotal, childrenTotal, infantsTotal, subtotal: adultsTotal + childrenTotal + infantsTotal };
  }

  function updateAll() {
    const totals = calcTotals();
    const { tour, subtotal } = totals;
    const lang = currentLang();
    if (!tour) return;
    const atvMode = isAtvPricing(tour);

    qsa("[data-summary-tour-name]").forEach((el) => el.textContent = tour.name[lang] || tour.name.en);
    qsa("[data-summary-tour-img]").forEach((el) => {
      if (tour.image_count > 0) { el.src = `assets/images/${tour.folder}/${tour.image_prefix}_01.jpg`; el.style.display = ""; }
      else { el.style.display = "none"; }
    });
    qsa("[data-summary-date]").forEach((el) => el.textContent = state.date ? formatDate(state.date) : "\u2014");

    const standardCounters = qs("#standardGuestCounters");
    const atvCounters = qs("#atvGuestCounters");
    const standardRows = qs("#standardPriceRows");
    const atvRows = qs("#atvPriceRows");
    const asideStandardRows = qs("#asideStandardPriceRows");
    const asideAtvRows = qs("#asideAtvPriceRows");
    if (standardCounters) standardCounters.style.display = atvMode ? "none" : "";
    if (atvCounters) atvCounters.style.display = atvMode ? "" : "none";
    if (standardRows) standardRows.style.display = atvMode ? "none" : "";
    if (atvRows) atvRows.style.display = atvMode ? "" : "none";
    if (asideStandardRows) asideStandardRows.style.display = atvMode ? "none" : "";
    if (asideAtvRows) asideAtvRows.style.display = atvMode ? "" : "none";

    if (atvMode) {
      const { priceSingle, priceDouble, singleTotal, doubleTotal } = totals;
      qsa("[data-summary-guests]").forEach((el) => {
        const parts = [];
        if (state.single) parts.push(`${state.single} ${mtT("booking.single")}`);
        if (state.double) parts.push(`${state.double} ${mtT("booking.double")}`);
        el.textContent = parts.join(", ") || "\u2014";
      });
      qsa("[data-single-row]").forEach((el) => el.style.display = state.single > 0 ? "flex" : "none");
      qsa("[data-summary-single-line]").forEach((el) => el.textContent = `${mtT("booking.single")} (${state.single} x ${formatCurrency(priceSingle)})`);
      qsa("[data-summary-single-total]").forEach((el) => el.textContent = formatCurrency(singleTotal));
      qsa("[data-double-row]").forEach((el) => el.style.display = state.double > 0 ? "flex" : "none");
      qsa("[data-summary-double-line]").forEach((el) => el.textContent = `${mtT("booking.double")} (${state.double} x ${formatCurrency(priceDouble)})`);
      qsa("[data-summary-double-total]").forEach((el) => el.textContent = formatCurrency(doubleTotal));
      qsa("[data-summary-starting-price]").forEach((el) => el.textContent = formatCurrency(priceSingle));
    } else {
      const { priceAdult, priceChild, priceInfant, adultsTotal, childrenTotal, infantsTotal } = totals;
      qsa("[data-summary-guests]").forEach((el) => {
        const parts = [`${state.adults} ${mtT("search.adults")}`];
        if (state.children) parts.push(`${state.children} ${mtT("search.children")}`);
        if (state.infants) parts.push(`${state.infants} ${mtT("booking.infants")}`);
        el.textContent = parts.join(", ");
      });
      qsa("[data-summary-adults-line]").forEach((el) => el.textContent = `${mtT("search.adults")} (${state.adults} x ${formatCurrency(priceAdult)})`);
      qsa("[data-summary-adults-total]").forEach((el) => el.textContent = formatCurrency(adultsTotal));
      qsa("[data-children-row]").forEach((el) => el.style.display = state.children > 0 ? "flex" : "none");
      qsa("[data-summary-children-line]").forEach((el) => el.textContent = `${mtT("search.children")} (${state.children} x ${formatCurrency(priceChild)})`);
      qsa("[data-summary-children-total]").forEach((el) => el.textContent = formatCurrency(childrenTotal));
      qsa("[data-infants-row]").forEach((el) => el.style.display = (state.infants > 0 && priceInfant > 0) ? "flex" : "none");
      qsa("[data-summary-infants-line]").forEach((el) => el.textContent = `${mtT("booking.infants")} (${state.infants} x ${formatCurrency(priceInfant)})`);
      qsa("[data-summary-infants-total]").forEach((el) => el.textContent = formatCurrency(infantsTotal));
      qsa("[data-summary-starting-price]").forEach((el) => el.textContent = formatCurrency(priceAdult));
    }
    qsa("[data-summary-total]").forEach((el) => el.textContent = formatCurrency(subtotal));
    applyDateConstraints();
  }

  function goToCheckout() {
    if (!validateStep1() || !validateStep2()) { goToStep(!validateStep1() ? 1 : 2); return; }
    const totals = calcTotals();
    const { tour, subtotal } = totals;
    const atvMode = isAtvPricing(tour);
    const draft = {
      tourSlug: state.tourSlug,
      tourName: tour.name,
      date: state.date,
      pricingMode: atvMode ? "single_double" : "standard",
      adults: atvMode ? 0 : state.adults, children: atvMode ? 0 : state.children, infants: atvMode ? 0 : state.infants,
      single: atvMode ? state.single : 0, double: atvMode ? state.double : 0,
      firstName: state.firstName, lastName: state.lastName,
      country: state.country, dialCode: state.dialCode, phone: state.phone,
      email: state.email, hotelName: state.hotelName,
      notes: state.notes, subtotal: subtotal,
      priceOnline: atvMode ? totals.priceSingle : totals.priceAdult,
      priceAdult: totals.priceAdult, priceChild: totals.priceChild, priceInfant: totals.priceInfant,
      priceSingle: totals.priceSingle, priceDouble: totals.priceDouble,
      createdAt: new Date().toISOString()
    };
    MTUtils.storeSet("mt_booking_draft", draft);
    const btn = qs("[data-step-next]", qs('.flow-step[data-step="2"]'));
    if (btn) { btn.classList.add("is-loading"); btn.disabled = true; }
    setTimeout(() => { location.href = "checkout.html"; }, 350);
  }

  document.addEventListener("DOMContentLoaded", init);
  document.addEventListener("mt:langchange", () => { renderTourPicks(); renderCountryOptions(); updateAll(); });
})();
