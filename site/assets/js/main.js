/* ==========================================================================
   main.js — global site behaviour: header, mobile nav, dropdowns, reveal
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, debounce, storeGet, storeSet } = MTUtils;

  document.addEventListener("DOMContentLoaded", () => {
    initStickyHeader();
    initMobileNav();
    initTopbarDropdowns();
    initScrollReveal();
    initSmoothAnchors();
    initFooterYear();
    applyCurrencyToDom();
    initFabWhatsapp();
    syncCompanyInfoFromBackend();
    syncTourDataFromBackend();
  });

  // Progressive enhancement: if the real backend is reachable, pull the
  // current company settings and update phone/email/WhatsApp/address on
  // the page - so a change saved in the Admin Panel's Settings page shows
  // up on the live site immediately, not just after the next rebuild.
  // If the backend isn't reachable, the page keeps its normal static text,
  // exactly as it did before this ran - nothing breaks either way.
  async function syncCompanyInfoFromBackend() {
    const fields = qsa("[data-company-field]");
    if (!fields.length || typeof MTApi === "undefined") return;
    try {
      const available = await MTApi.isAvailable();
      if (!available) return;
      const s = await MTApi.getCompanyInfo();
      const map = {
        phone_display: s.phone, phone_href: s.phone ? `tel:${s.phone.replace(/[^\d+]/g, "")}` : null,
        email: s.email, email_href: s.email ? `mailto:${s.email}` : null,
        whatsapp_href: s.whatsapp ? `https://wa.me/${s.whatsapp}` : null,
        address: s.address,
      };
      fields.forEach((el) => {
        const field = el.dataset.companyField;
        const val = map[field];
        if (val === undefined || val === null) return;
        if (field.endsWith("_href")) el.setAttribute("href", val);
        else el.textContent = val;
      });
    } catch (e) { console.error("Live sync failed (non-fatal, static content still shown):", e); }
  }

  // Same progressive-enhancement pattern as company info: pulls the
  // CURRENT name/price/duration/category for every tour from the real
  // backend and overwrites the static (build-time) values wherever they
  // appear on this page - catalog cards, homepage cards, related-tour
  // cards, and (via data-page-tour-slug) a tour's own detail page. This
  // is what makes an admin's edit show up on the Tours page and detail
  // pages immediately, not just on the booking page.
  async function syncTourDataFromBackend() {
    const cardEls = qsa("[data-tour-slug]");
    const pageSlug = document.body.dataset.pageTourSlug;
    if (!cardEls.length && !pageSlug) return;
    if (typeof MTApi === "undefined") return;
    try {
      const available = await MTApi.isAvailable();
      if (!available) return;
      const tours = await MTApi.getTours();
      const bySlug = Object.fromEntries(tours.map((t) => [t.slug, t]));

      cardEls.forEach((card) => {
        const t = bySlug[card.dataset.tourSlug];
        if (!t) return;
        const isOwnPage = card.dataset.tourSlug === pageSlug;
        // Names are the one field where "always sync" and "always correct
        // per language" pull against each other: the backend keeps a
        // single name string with no language concept, so overwriting the
        // translated name on every card the visitor scrolls past would
        // reintroduce the wrong-language bug fixed earlier. On the tour's
        // OWN detail page, an admin's rename is important to get right
        // immediately - but only when it IS a rename: if the live name
        // still matches the tour's own build-time English name, nothing
        // has changed, so the already-correct, already-translated static
        // name stays exactly as it was for every language. Only when the
        // live value has actually diverged (someone edited it in Admin ->
        // Tours) does this fall back to showing that raw value - in
        // whatever language the admin typed it in - rather than an
        // outdated name in the visitor's own language.
        if (isOwnPage && t.name) {
          const staticTour = typeof MT_TOURS !== "undefined" ? MT_TOURS.find((x) => x.slug === card.dataset.tourSlug) : null;
          if (!staticTour || t.name !== staticTour.name.en) {
            const nameEl = qs("[data-i18n-tour-name]", card);
            if (nameEl) nameEl.textContent = t.name;
          }
        }
        const priceEl = qs("[data-price-eur]", card);
        if (priceEl) priceEl.textContent = "\u20AC" + t.priceOnline;
        const durEl = qs("[data-tour-duration]", card);
        if (durEl && t.durationHours) durEl.textContent = t.durationHours + (mtT("card.hours_suffix") || "h");
        if (t.category) {
          card.dataset.category = t.category;
          const catEl = qs("[data-tour-category-label]", card);
          if (catEl) { catEl.dataset.i18n = "category." + t.category; catEl.textContent = mtT("category." + t.category) || catEl.textContent; }
        }
      });

      if (pageSlug && bySlug[pageSlug]) {
        const t = bySlug[pageSlug];
        qsa("[data-price-eur]").forEach((el) => { if (!el.closest("[data-tour-slug]")) el.textContent = "\u20AC" + t.priceOnline; });
        qsa("[data-tour-field='departure_time']").forEach((el) => { if (t.departureTime) el.textContent = t.departureTime; });
        qsa("[data-tour-field='return_time']").forEach((el) => { if (t.returnTime) el.textContent = t.returnTime; });
      }
      revealTourHero();
    } catch (e) {
      console.error("Live sync failed (non-fatal, static content still shown):", e);
      revealTourHero();
    }
  }

  // The tour detail page's own name/price/duration start hidden (see the
  // inline style in gen_tour_detail.py) specifically so a stale build-time
  // value is never the first thing a returning admin or guest sees after a
  // price/name/duration edit - there's nothing to "flash" to the correct
  // value if the wrong one was never painted. This reveals them once the
  // sync above has resolved (or failed - either way there's a final answer
  // to show), and again after a short timeout as a safety net so a slow or
  // unreachable backend never leaves the page blank.
  let revealed = false;
  function revealTourHero() {
    if (revealed) return;
    revealed = true;
    qsa("[data-tour-live-field]").forEach((el) => el.classList.remove("is-syncing"));
  }

  function initStickyHeader() {
    const header = qs("#siteHeader");
    if (!header) return;
    const onScroll = () => {
      if (window.scrollY > 30) header.classList.add("is-scrolled");
      else header.classList.remove("is-scrolled");
    };
    window.addEventListener("scroll", debounce(onScroll, 10));
    onScroll();
  }

  function initMobileNav() {
    const toggle = qs("#navToggle");
    const nav = qs("#mobileNav");
    const overlay = qs("#mobileNavOverlay");
    const close = qs("#mobileNavClose");
    if (!toggle || !nav) return;
    const open = () => {
      nav.classList.add("is-open");
      overlay && overlay.classList.add("is-open");
      toggle.classList.add("is-active");
      document.body.classList.add("no-scroll");
    };
    const shut = () => {
      nav.classList.remove("is-open");
      overlay && overlay.classList.remove("is-open");
      toggle.classList.remove("is-active");
      document.body.classList.remove("no-scroll");
    };
    toggle.addEventListener("click", () => {
      nav.classList.contains("is-open") ? shut() : open();
    });
    close && close.addEventListener("click", shut);
    overlay && overlay.addEventListener("click", shut);
    qsa("a", nav).forEach((a) => a.addEventListener("click", shut));
    document.addEventListener("keydown", (e) => { if (e.key === "Escape") shut(); });
  }

  function initTopbarDropdowns() {
    qsa(".tb-dropdown").forEach((dd) => {
      const btn = qs(".tb-dropdown__btn", dd);
      if (!btn) return;
      btn.addEventListener("click", (e) => {
        e.stopPropagation();
        const wasOpen = dd.classList.contains("is-open");
        qsa(".tb-dropdown.is-open").forEach((o) => o.classList.remove("is-open"));
        if (!wasOpen) dd.classList.add("is-open");
      });
    });
    document.addEventListener("click", () => {
      qsa(".tb-dropdown.is-open").forEach((o) => o.classList.remove("is-open"));
    });
  }

  function applyCurrencyToDom() {
    qsa("[data-price-eur]").forEach((el) => {
      const eur = parseFloat(el.dataset.priceEur);
      if (!isNaN(eur)) el.textContent = MTUtils.formatCurrency(eur);
    });
  }
  window.applyCurrencyToDom = applyCurrencyToDom;

  function initScrollReveal() {
    const items = qsa("[data-reveal], [data-reveal-group]");
    if (!items.length) return;
    if (!("IntersectionObserver" in window)) {
      items.forEach((el) => el.classList.add("is-visible"));
      return;
    }
    const io = new IntersectionObserver((entries) => {
      entries.forEach((entry) => {
        if (entry.isIntersecting) {
          entry.target.classList.add("is-visible");
          io.unobserve(entry.target);
        }
      });
    }, { threshold: 0.12, rootMargin: "0px 0px -60px 0px" });
    items.forEach((el) => io.observe(el));
  }

  function initSmoothAnchors() {
    qsa('a[href^="#"]:not([href="#"])').forEach((a) => {
      a.addEventListener("click", (e) => {
        const target = qs(a.getAttribute("href"));
        if (target) {
          e.preventDefault();
          const headerOffset = 120;
          const y = target.getBoundingClientRect().top + window.pageYOffset - headerOffset;
          window.scrollTo({ top: y, behavior: "smooth" });
        }
      });
    });
  }

  function initFooterYear() {
    qsa("[data-current-year]").forEach((el) => { el.textContent = new Date().getFullYear(); });
  }

  function initFabWhatsapp() {
    // Hide on payment/booking forms to avoid overlapping sticky CTAs on small screens
    const fab = qs(".fab-whatsapp");
    if (!fab) return;
    if (qs(".flow-layout") && window.innerWidth < 720) fab.style.display = "none";
  }
})();
