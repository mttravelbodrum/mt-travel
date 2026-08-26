/* ==========================================================================
   tour-calendar.js — custom month-grid date picker for booking.html.

   Why this exists instead of the native <input type="date">: a native
   date input can only set a minimum/maximum date - it has no way to
   visually greyed out specific days of the week (e.g. "this tour never
   runs on Sundays"), which is exactly what the Tour Calendar admin
   feature needs on the customer-facing side. This widget renders a real
   month grid so each day can be individually enabled or disabled, while
   still writing a plain ISO date into a regular hidden input so the
   rest of booking.js doesn't need to know this isn't a native control.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, todayISO } = MTUtils;

  function pad(n) { return String(n).padStart(2, "0"); }
  function toISO(y, m, d) { return `${y}-${pad(m + 1)}-${pad(d)}`; }
  const DAY_KEYS = ["sunday", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday"];

  function createTourCalendar(hiddenInput, wrapEl) {
    let viewYear, viewMonth;
    let minISO = null;
    let availableDays = null; // null = no restriction (all days allowed)
    let onSelect = null;

    // Turkey time, not the visitor's own device timezone - same reason
    // as everywhere else this matters: a browser set to a timezone behind
    // Istanbul could otherwise open the calendar on the wrong month for
    // a few hours around each month boundary.
    const [todayY, todayM] = todayISO().split("-").map(Number);
    viewYear = todayY;
    viewMonth = todayM - 1;

    wrapEl.innerHTML = `
      <div class="tcal">
        <div class="tcal__head">
          <button type="button" class="tcal__nav" data-tcal-prev aria-label="${mtT("calendar.prev_month")}">${icon("chevron-left")}</button>
          <span class="tcal__label" data-tcal-label></span>
          <button type="button" class="tcal__nav" data-tcal-next aria-label="${mtT("calendar.next_month")}">${icon("chevron-right")}</button>
        </div>
        <div class="tcal__weekdays" data-tcal-weekdays></div>
        <div class="tcal__grid" data-tcal-grid></div>
      </div>`;

    function icon(name) {
      const paths = {
        "chevron-left": '<polyline points="15 18 9 12 15 6"/>',
        "chevron-right": '<polyline points="9 18 15 12 9 6"/>',
      };
      return `<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">${paths[name]}</svg>`;
    }

    // Same language -> BCP-47 locale map utils.js's formatDate() uses, so
    // the calendar's month/weekday names always match the site's selected
    // language rather than whatever locale the visitor's browser happens
    // to be set to.
    const LOCALE_MAP = { en: "en-GB", tr: "tr-TR", de: "de-DE", ru: "ru-RU", pl: "pl-PL" };
    function calendarLocale() {
      return LOCALE_MAP[MTUtils.currentLang()] || "en-GB";
    }

    function isDisabled(y, m, d) {
      const iso = toISO(y, m, d);
      if (minISO && iso < minISO) return true;
      if (availableDays && availableDays.length) {
        const dow = new Date(y, m, d).getDay();
        if (!availableDays.includes(DAY_KEYS[dow])) return true;
      }
      return false;
    }

    function render() {
      const locale = calendarLocale();
      const label = new Date(viewYear, viewMonth, 1).toLocaleDateString(locale, { month: "long", year: "numeric" });
      qs("[data-tcal-label]", wrapEl).textContent = label;

      const weekdayEl = qs("[data-tcal-weekdays]", wrapEl);
      const shortDays = [0,1,2,3,4,5,6].map((i) => new Date(2024, 0, 7 + i).toLocaleDateString(locale, { weekday: "narrow" }));
      weekdayEl.innerHTML = shortDays.map((d) => `<span>${d}</span>`).join("");

      const firstOfMonth = new Date(viewYear, viewMonth, 1);
      const startOffset = firstOfMonth.getDay();
      const daysInMonth = new Date(viewYear, viewMonth + 1, 0).getDate();
      const selected = hiddenInput.value;

      let cells = [];
      for (let i = 0; i < startOffset; i++) cells.push(`<span class="tcal__day tcal__day--empty"></span>`);
      for (let d = 1; d <= daysInMonth; d++) {
        const iso = toISO(viewYear, viewMonth, d);
        const disabled = isDisabled(viewYear, viewMonth, d);
        const isSelected = iso === selected;
        cells.push(`<button type="button" class="tcal__day${disabled ? " is-disabled" : ""}${isSelected ? " is-selected" : ""}" data-tcal-date="${iso}" ${disabled ? "disabled" : ""}>${d}</button>`);
      }
      qs("[data-tcal-grid]", wrapEl).innerHTML = cells.join("");

      qsa("[data-tcal-date]", wrapEl).forEach((btn) => {
        btn.addEventListener("click", () => {
          hiddenInput.value = btn.dataset.tcalDate;
          hiddenInput.dispatchEvent(new Event("change", { bubbles: true }));
          render();
        });
      });
    }

    qs("[data-tcal-prev]", wrapEl).addEventListener("click", () => {
      viewMonth--; if (viewMonth < 0) { viewMonth = 11; viewYear--; }
      render();
    });
    qs("[data-tcal-next]", wrapEl).addEventListener("click", () => {
      viewMonth++; if (viewMonth > 11) { viewMonth = 0; viewYear++; }
      render();
    });

    render();

    return {
      setMin(iso) { minISO = iso; render(); },
      setAvailableDays(days) { availableDays = days; render(); },
      jumpToSelected() {
        if (hiddenInput.value) {
          const [y, m] = hiddenInput.value.split("-").map(Number);
          viewYear = y; viewMonth = m - 1;
          render();
        }
      },
      refresh: render,
    };
  }

  window.MTTourCalendar = { create: createTourCalendar };
})();
