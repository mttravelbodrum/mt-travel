/* ==========================================================================
   admin-settings.js — settings.html (admin)
   BACKEND-ONLY. Settings are read from and saved to the real backend.
   The old browser-only backup/restore tools were removed - the backend's
   data/db.json file is the real backup now (see backend/README.md).
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, toast } = MTUtils;

  async function init() {
    if (!qs("#adminSettingsApp")) return;
    const ok = await MTAdmin.requireBackend("#adminSettingsApp");
    if (!ok) return;
    bindTabs();
    try {
      await loadIntoForm();
    } catch (err) {
      MTAdmin.renderBackendError("#adminSettingsApp", "backend_unreachable");
      return;
    }
    bindSave();
  }

  function bindTabs() {
    const tabBtns = qsa(".settings-tab-btn");
    const panels = qsa("[data-settings-panel]");
    tabBtns.forEach((btn) => {
      btn.addEventListener("click", () => {
        tabBtns.forEach((b) => b.classList.toggle("is-active", b === btn));
        panels.forEach((p) => p.style.display = p.dataset.settingsPanel === btn.dataset.settingsTab ? "block" : "none");
      });
    });
  }

  async function loadIntoForm() {
    const s = await MTApi.getSettings();
    setVal("#settingCompanyName", s.companyName);
    setVal("#settingPhone", s.phone);
    setVal("#settingWhatsapp", s.whatsapp);
    setVal("#settingEmail", s.email);
    setVal("#settingAddress", s.address);
    setVal("#settingCurrency", s.currency);
    setVal("#settingIslandAdvance", s.islandMinAdvanceDays);
    setVal("#settingDefaultLanguage", s.defaultLanguage);
  }

  function setVal(sel, val) { const el = qs(sel); if (el && val !== undefined) el.value = val; }

  function bindSave() {
    qsa("[data-settings-save]").forEach((form) => {
      form.addEventListener("submit", async (e) => {
        e.preventDefault();
        const updates = {
          companyName: valOf("#settingCompanyName"),
          phone: valOf("#settingPhone"),
          whatsapp: valOf("#settingWhatsapp"),
          email: valOf("#settingEmail"),
          address: valOf("#settingAddress"),
          currency: valOf("#settingCurrency"),
          islandMinAdvanceDays: intValOf("#settingIslandAdvance"),
          defaultLanguage: valOf("#settingDefaultLanguage"),
        };
        Object.keys(updates).forEach((k) => { if (updates[k] === undefined) delete updates[k]; });

        const submitBtn = form.querySelector('button[type="submit"]');
        if (submitBtn) { submitBtn.disabled = true; submitBtn.classList.add("is-loading"); }
        try {
          await MTApi.updateSettings(updates);
          toast(mtT("admin.toast_settings_saved"), "success");
        } catch (err) {
          toast(MTUtils.translateApiError(err.message) || mtT("admin.err_save_unreachable"), "error");
        } finally {
          if (submitBtn) { submitBtn.disabled = false; submitBtn.classList.remove("is-loading"); }
        }
      });
    });
  }

  function valOf(sel) {
    const el = qs(sel);
    return el ? el.value : undefined;
  }

  // Number inputs (like "Island Tour Minimum Advance (days)") must be saved
  // as real numbers, not the string el.value always is - otherwise every
  // consumer that checks typeof/Number.isFinite on this setting (the
  // booking calendar, the backend's own reservation validation) would see
  // a string and silently fall back to its default instead of the value
  // the admin actually set.
  function intValOf(sel) {
    const el = qs(sel);
    if (!el || el.value === "") return undefined;
    const n = parseInt(el.value, 10);
    return Number.isFinite(n) && n >= 0 ? n : undefined;
  }

  document.addEventListener("DOMContentLoaded", () => setTimeout(init, 0));
})();
