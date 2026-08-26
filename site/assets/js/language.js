/* ==========================================================================
   language.js — arayüz ve tur verilerinin istemci tarafında çevirisi.
   Kaynak dil Türkçe'dir: bir ziyaretçi başka bir dil seçtiğinde, bu modül
   metni o dille değiştirir - sayfayı sıfırdan oluşturmaz. Daha fazla
   bilgi için README.md "Diller" bölümüne bakın.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa } = MTUtils;
  const FALLBACK_LANG = "tr";
  const SUPPORTED = ["en", "tr", "de", "ru", "pl"];

  function dict(lang) {
    return (typeof MT_I18N !== "undefined" && MT_I18N[lang]) ? MT_I18N[lang] : {};
  }

  function t(key, lang) {
    lang = lang || MTUtils.currentLang();
    const d = dict(lang);
    if (d[key] !== undefined) return d[key];
    return dict(FALLBACK_LANG)[key] !== undefined ? dict(FALLBACK_LANG)[key] : key;
  }
  window.mtT = t;

  function applyChrome(lang) {
    qsa("[data-i18n]").forEach((el) => {
      const key = el.getAttribute("data-i18n");
      const val = t(key, lang);
      if (val !== undefined) el.textContent = val;
    });
    qsa("[data-i18n-placeholder]").forEach((el) => {
      el.setAttribute("placeholder", t(el.getAttribute("data-i18n-placeholder"), lang));
    });
    qsa("[data-i18n-aria-label]").forEach((el) => {
      el.setAttribute("aria-label", t(el.getAttribute("data-i18n-aria-label"), lang));
    });
    qsa("[data-i18n-title]").forEach((el) => {
      el.setAttribute("title", t(el.getAttribute("data-i18n-title"), lang));
    });
    qsa("[data-i18n-alt]").forEach((el) => {
      el.setAttribute("alt", t(el.getAttribute("data-i18n-alt"), lang));
    });
  }

  function applyTourCards(lang) {
    if (typeof MT_TOURS === "undefined") return;
    const bySlug = {};
    MT_TOURS.forEach((tr) => { bySlug[tr.slug] = tr; });
    qsa("[data-tour-slug]").forEach((card) => {
      const slug = card.getAttribute("data-tour-slug");
      const tour = bySlug[slug];
      if (!tour) return;
      const nameEl = qs("[data-i18n-tour-name]", card);
      const shortEl = qs("[data-i18n-tour-short]", card);
      const locEl = qs("[data-i18n-tour-location]", card);
      const durEl = qs("[data-i18n-tour-duration]", card);
      if (nameEl) nameEl.textContent = (tour.name[lang] || tour.name[FALLBACK_LANG]);
      if (shortEl) shortEl.textContent = (tour.short[lang] || tour.short[FALLBACK_LANG]);
      if (locEl && tour.location) locEl.textContent = (tour.location[lang] || tour.location[FALLBACK_LANG]).split(",")[0];
      if (durEl && tour.duration_short) durEl.textContent = (tour.duration_short[lang] || tour.duration_short[FALLBACK_LANG]);
    });
    // The footer's "Top Destinations" links are plain <a> tags (name and
    // link target are the same element, not a card with nested fields),
    // so they get their own simpler pass: look up the tour by slug and
    // replace the link's own text directly.
    qsa("[data-footer-tour-slug]").forEach((link) => {
      const tour = bySlug[link.getAttribute("data-footer-tour-slug")];
      if (tour) link.textContent = (tour.name[lang] || tour.name[FALLBACK_LANG]);
    });
    // Same idea for the homepage's "pick a tour" <select> - each <option>
    // already carries the tour's slug as its value attribute, so no extra
    // marker is needed beyond flagging the <select> itself.
    qsa("select[data-tour-select] option[value]").forEach((opt) => {
      if (!opt.value) return; // skip the "Select Tour" placeholder option
      const tour = bySlug[opt.value];
      if (tour) opt.textContent = (tour.name[lang] || tour.name[FALLBACK_LANG]);
    });
  }

  /**
   * Tour detail pages embed a JSON blob (their own full EN+TR content -
   * description, highlights, program, FAQ...) in a <script type="application/json">
   * tag. When present, we swap the relevant DOM sections for that language.
   * Languages without long-form content for this tour (currently DE/RU/PL)
   * fall back to the English copy already sitting in the HTML - a real,
   * complete paragraph, never a placeholder string.
   */
  function applyTourDetail(lang) {
    const dataEl = qs("#tourI18nData");
    if (!dataEl) return;
    let data;
    try { data = JSON.parse(dataEl.textContent); } catch (e) { return; }
    const content = data[lang] || data[FALLBACK_LANG];
    if (!content) return;

    setText("[data-tour-field='location']", content.location);
    setText("[data-tour-field='duration']", content.duration);
    // The compact "quick facts" card shows only the part of the duration
    // before " - " (e.g. "10 Hours" rather than "10 Hours - Full Day") to
    // keep that card short - same split the page's initial Turkish render
    // already applies server-side, just re-applied here for whichever
    // language is now selected.
    if (content.duration) {
      setText("[data-tour-field='duration_short']", content.duration.split(" - ")[0]);
    }
    setText("[data-tour-field='departure']", content.departure);
    setText("[data-tour-field='return_time']", content.return_time);
    setText("[data-tour-field='meeting_point']", content.meeting_point);

    const descWrap = qs("[data-tour-field='description']");
    if (descWrap && content.description) {
      descWrap.innerHTML = content.description.map((p) => `<p>${MTUtils.escapeHtml(p)}</p>`).join("");
    }
    fillList("[data-tour-field='highlights']", content.highlights, "star");
    fillList("[data-tour-field='included']", content.included, "check");
    fillList("[data-tour-field='excluded']", content.excluded, "x");

    const programWrap = qs("[data-tour-field='program']");
    if (programWrap && content.program) {
      // Same two steps as the tour-detail header's own live-synced
      // Departure/Return Time - matched by position (set once, in the
      // Turkish source, by gen_tour_detail.py) rather than by title text,
      // since this re-render runs for every language and the title
      // itself is different in each one.
      const depStep = programWrap.dataset.departureStep !== undefined ? Number(programWrap.dataset.departureStep) : -1;
      const retStep = programWrap.dataset.returnStep !== undefined ? Number(programWrap.dataset.returnStep) : -1;
      programWrap.innerHTML = content.program.map((step, i) => {
        const fieldAttr = i === depStep ? ' data-tour-field="departure_time"' : i === retStep ? ' data-tour-field="return_time"' : "";
        return `
        <li>
          <span class="program-time"${fieldAttr}>${MTUtils.escapeHtml(step.time)}</span>
          <h5>${MTUtils.escapeHtml(step.title)}</h5>
          <p>${MTUtils.escapeHtml(step.text)}</p>
        </li>`;
      }).join("");
    }

    const faqWrap = qs("[data-tour-field='faq']");
    if (faqWrap && content.faq) {
      faqWrap.innerHTML = content.faq.map((item, i) => `
        <div class="accordion-item${i === 0 ? " is-open" : ""}">
          <button class="accordion-trigger" type="button" aria-expanded="${i === 0}">
            <span>${MTUtils.escapeHtml(item.q)}</span>
            <span class="accordion-trigger__icon">${window.MT_ICON_PLUS || "+"}</span>
          </button>
          <div class="accordion-panel" style="max-height:${i === 0 ? "400px" : "0"}">
            <div class="accordion-panel__inner">${MTUtils.escapeHtml(item.a)}</div>
          </div>
        </div>`).join("");
      if (window.MTAccordion) window.MTAccordion.rebind(faqWrap);
    }
  }

  function setText(sel, val) {
    if (!val) return;
    qsa(sel).forEach((el) => { el.textContent = val; });
  }
  const ICON_SVG = {
    star: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="12 2 15.09 8.58 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.58"/></svg>',
    check: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"/></svg>',
    x: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>',
  };
  function fillList(sel, items, iconName) {
    const el = qs(sel);
    if (!el || !items) return;
    const iconSvg = ICON_SVG[iconName] || "";
    el.innerHTML = items.map((txt) => `<li>${iconSvg}<span>${MTUtils.escapeHtml(txt)}</span></li>`).join("");
  }

  function updateSwitcherUI(lang) {
    qsa("[data-lang]").forEach((btn) => {
      btn.classList.toggle("is-active", btn.getAttribute("data-lang") === lang);
    });
    const label = qs("#currentLangLabel");
    if (label) label.textContent = lang.toUpperCase();
    const flag = qs("#currentLangFlag");
    if (flag) flag.src = `${flag.dataset.rel || ""}assets/icons/flags/${langFlag(lang)}.png`;
    document.documentElement.setAttribute("lang", lang);
  }

  function langFlag(lang) {
    const map = { en: "gb", tr: "tr", de: "de", ru: "ru", pl: "pl" };
    return map[lang] || "gb";
  }
  window.mtLangFlag = langFlag;

  /**
   * Legal pages (terms, privacy, cancellation policy, distance sales
   * agreement) embed their full text for every supported language in a
   * JSON blob, the same approach as a tour detail page's long-form
   * content - these are policy documents, not short UI labels, so they
   * don't fit the flat key -> string bundle used for the rest of the
   * interface.
   */
  function applyLegalContent(lang) {
    const dataEl = qs("#legalI18nData");
    if (!dataEl) return;
    let data;
    try { data = JSON.parse(dataEl.textContent); } catch (e) { return; }
    const sections = data[lang] || data[FALLBACK_LANG];
    const wrap = qs("[data-legal-content]");
    if (!sections || !wrap) return;
    wrap.innerHTML = sections.map(([heading, paragraphs]) => `
        <h3>${MTUtils.escapeHtml(heading)}</h3>
        ${paragraphs.map((p) => `<p>${MTUtils.escapeHtml(p)}</p>`).join("\n        ")}`).join("\n        ");
  }

  function setLanguage(lang, opts) {
    opts = opts || {};
    if (SUPPORTED.indexOf(lang) === -1) lang = FALLBACK_LANG;
    localStorage.setItem("mt_lang", lang);
    applyChrome(lang);
    applyTourCards(lang);
    applyTourDetail(lang);
    applyLegalContent(lang);
    updateSwitcherUI(lang);
    if (!opts.silent) {
      document.dispatchEvent(new CustomEvent("mt:langchange", { detail: { lang } }));
    }
  }
  window.mtSetLanguage = setLanguage;

  function initSwitcher() {
    qsa("[data-lang]").forEach((btn) => {
      btn.addEventListener("click", (e) => {
        e.preventDefault();
        setLanguage(btn.getAttribute("data-lang"));
      });
    });
  }

  // Runs immediately rather than waiting for DOMContentLoaded: this
  // script tag sits at the end of body (after all page content), so the
  // DOM is already fully parsed and available the moment this file
  // executes. Waiting for DOMContentLoaded here only added a delay
  // during which the page's build-time default (Turkish) text was
  // visible before the saved language got applied - on a slower
  // connection that shows up as the page "flashing" back to Turkish
  // for a moment on every navigation, even though the saved choice
  // was never actually lost.
  const lang = MTUtils.currentLang();
  setLanguage(lang, { silent: true });
  initSwitcher();
})();
