/* ==========================================================================
   utils.js — small shared helpers used across the site
   ========================================================================== */

const MTUtils = (function () {
  "use strict";

  function qs(sel, ctx) { return (ctx || document).querySelector(sel); }
  function qsa(sel, ctx) { return Array.from((ctx || document).querySelectorAll(sel)); }

  function debounce(fn, wait) {
    let t;
    return function (...args) {
      clearTimeout(t);
      t = setTimeout(() => fn.apply(this, args), wait);
    };
  }

  function currentLang() {
    return localStorage.getItem("mt_lang") || "tr";
  }

  function formatCurrency(amountInEur) {
    const decimals = amountInEur % 1 === 0 ? 0 : 2;
    return "\u20AC" + amountInEur.toFixed(decimals);
  }

  function formatDate(dateStr, lang) {
    lang = lang || currentLang();
    const d = (dateStr instanceof Date) ? dateStr : new Date(dateStr + "T00:00:00");
    if (isNaN(d)) return dateStr;
    const localeMap = { en: "en-GB", tr: "tr-TR", de: "de-DE", ru: "ru-RU", pl: "pl-PL" };
    try {
      return d.toLocaleDateString(localeMap[lang] || "en-GB", { day: "2-digit", month: "short", year: "numeric" });
    } catch (e) {
      return dateStr;
    }
  }

  function todayISO() {
    // Always Turkey time (Europe/Istanbul), regardless of the visitor's
    // own device/browser timezone or the server's. new Date() itself is
    // timezone-agnostic (an absolute instant), but the two obvious ways
    // to turn that into a calendar date are NOT: toISOString() reads off
    // the UTC date, and getFullYear()/getMonth()/getDate() read off
    // whatever timezone the browser is set to - both silently disagree
    // with Turkey for part of every day (e.g. anywhere west of Turkey
    // still shows "yesterday" for hours after Istanbul has already
    // rolled over to a new day). en-CA happens to format as YYYY-MM-DD,
    // which is what every date computation and comparison in this
    // codebase expects - same approach the backend uses so the two can
    // never disagree about what day it is.
    return new Date().toLocaleDateString("en-CA", { timeZone: "Europe/Istanbul" });
  }

  function addDaysISO(isoDate, days) {
    // Deliberately UTC-anchored (Date.UTC / getUTCDate), not a plain
    // `new Date(isoDate + "T00:00:00")`: that form is parsed in the
    // browser's OWN local timezone, so the same "2026-08-09" input could
    // silently shift a calendar day in either direction depending on
    // where the visitor's device thinks it is - including for visitors
    // physically in Turkey but with a misconfigured device timezone.
    // This is pure Y/M/D arithmetic with no timezone in play at all, so
    // it gives the same answer everywhere, which is what a calendar
    // ("N days after this date") should do.
    const [y, m, d] = isoDate.split("-").map(Number);
    const dt = new Date(Date.UTC(y, m - 1, d));
    dt.setUTCDate(dt.getUTCDate() + days);
    return dt.toISOString().slice(0, 10);
  }

  function generateBookingNumber() {
    const ts = Date.now().toString().slice(-6);
    const rnd = Math.floor(1000 + Math.random() * 9000);
    return `MTG-${ts}${rnd}`;
  }

  function uid(prefix) {
    return (prefix || "id") + "-" + Math.random().toString(36).slice(2, 10);
  }

  function escapeHtml(str) {
    const div = document.createElement("div");
    div.textContent = String(str == null ? "" : str);
    return div.innerHTML;
  }

  // ---- tiny localStorage JSON store (used as the mock database) ----
  function storeGet(key, fallback) {
    try {
      const raw = localStorage.getItem(key);
      return raw ? JSON.parse(raw) : fallback;
    } catch (e) {
      return fallback;
    }
  }
  function storeSet(key, value) {
    try {
      localStorage.setItem(key, JSON.stringify(value));
      return true;
    } catch (e) {
      return false;
    }
  }

  // Admin session token may live in localStorage (Remember Me checked at
  // login) or sessionStorage (unchecked) - callers just need "am I logged
  // in / what's my token", not which one, so this checks both.
  function getAdminToken() {
    return localStorage.getItem("mt_admin_token") || sessionStorage.getItem("mt_admin_token");
  }
  function clearAdminToken() {
    localStorage.removeItem("mt_admin_token");
    sessionStorage.removeItem("mt_admin_token");
  }

  // The backend has no i18n of its own - every error it returns (bad
  // credentials, a tour not being available on a given day, etc.) is a
  // fixed English string. This maps the ones a real user can actually
  // reach through normal use (not the admin-only/defense-in-depth
  // validation errors that the UI already prevents from happening) to
  // the current language. Same idea as MTAdmin.translateActivityAction()
  // for the activity log. An unrecognized message is shown as-is rather
  // than hidden - better an English sentence than nothing.
  function translateApiError(message) {
    if (!message || typeof mtT === "undefined") return message;
    const exact = {
      "Tour not found.": "error.tour_not_found",
      "Reservation not found.": "error.reservation_not_found",
      "This tour is not available on the selected day. Please choose a different date.": "error.day_not_available",
      "Invalid email or password.": "error.invalid_credentials",
      "Invalid or expired session. Please log in again.": "error.session_expired",
      "Too many login attempts. Please try again later.": "error.too_many_login_attempts",
      "Too many requests. Please try again shortly.": "error.too_many_requests",
      "Too many reservations submitted. Please contact us directly if you need to book more.": "error.too_many_reservations",
      "Please fill in all required fields.": "error.fill_required_fields",
      "No reservations found for this customer.": "error.no_customer_reservations",
    };
    if (exact[message]) return mtT(exact[message]);

    const advance = message.match(/^This tour requires at least (\d+) days?' advance booking\. Please choose a later date\.$/);
    if (advance) {
      const n = advance[1];
      const key = n === "1" ? "error.advance_booking_singular" : "error.advance_booking_plural";
      return mtT(key).replace("{n}", n);
    }

    return message;
  }

  function toast(message, type) {
    type = type || "info";
    let stack = qs(".toast-stack");
    if (!stack) {
      stack = document.createElement("div");
      stack.className = "toast-stack";
      document.body.appendChild(stack);
    }
    const icons = {
      success: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/><polyline points="22 4 12 14.01 9 11.01"/></svg>',
      error: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="15" y1="9" x2="9" y2="15"/><line x1="9" y1="9" x2="15" y2="15"/></svg>',
      info: '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>'
    };
    const el = document.createElement("div");
    el.className = "toast toast--" + type;
    el.innerHTML = (icons[type] || icons.info) + "<span>" + escapeHtml(message) + "</span>";
    stack.appendChild(el);
    setTimeout(() => {
      el.style.transition = "opacity .3s ease, transform .3s ease";
      el.style.opacity = "0";
      el.style.transform = "translateX(30px)";
      setTimeout(() => el.remove(), 300);
    }, 3400);
  }

  return {
    qs, qsa, debounce, currentLang,
    formatCurrency, formatDate, todayISO, addDaysISO,
    generateBookingNumber, uid, escapeHtml,
    storeGet, storeSet, toast, getAdminToken, clearAdminToken, translateApiError,
      };
})();
