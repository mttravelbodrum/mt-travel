/* ==========================================================================
   admin-login.js — admin/login.html
   BACKEND-ONLY. Real authentication against the backend's hashed admin
   password. No demo-mode fallback login of any kind.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, toast } = MTUtils;

  function init() {
    const form = qs("#adminLoginForm");
    if (!form) return;
    form.addEventListener("submit", async (e) => {
      e.preventDefault();
      const email = qs("#loginEmail");
      const password = qs("#loginPassword");
      let ok = true;
      if (!/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.value)) { toggleErr(email, true); ok = false; } else toggleErr(email, false);
      if (password.value.length < 4) { toggleErr(password, true); ok = false; } else toggleErr(password, false);
      if (!ok) return;

      const btn = qs("#adminLoginBtn");
      btn.classList.add("is-loading");
      btn.disabled = true;

      const available = await MTApi.isAvailable().catch(() => false);
      if (!available) {
        const reason = MTApi.getLastFailureReason();
        if (reason === "file_protocol") {
          showFormError(mtT("admin.login_error_file_protocol"));
        } else {
          showFormError(mtT("admin.login_error_unreachable"));
        }
        btn.classList.remove("is-loading");
        btn.disabled = false;
        return;
      }

      try {
        const result = await MTApi.login(email.value, password.value);
        const remember = qs("#rememberMe") ? qs("#rememberMe").checked : true;
        (remember ? localStorage : sessionStorage).setItem("mt_admin_token", result.token);
        const params = new URLSearchParams(location.search);
        location.href = params.get("next") || "dashboard.html";
      } catch (err) {
        showFormError(MTUtils.translateApiError(err.message) || mtT("error.invalid_credentials"));
        btn.classList.remove("is-loading");
        btn.disabled = false;
      }
    });
  }

  function toggleErr(el, show) {
    const wrap = el.closest(".field");
    if (wrap) wrap.classList.toggle("has-error", show);
  }

  function showFormError(message) {
    let box = qs("#loginErrorBox");
    const form = qs("#adminLoginForm");
    if (!box) {
      box = document.createElement("div");
      box.id = "loginErrorBox";
      box.className = "field-error";
      box.style.cssText = "display:flex; margin-bottom:16px;";
      form.insertBefore(box, form.firstChild);
    }
    box.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg><span>${message}</span>`;
    box.style.display = "flex";
  }

  document.addEventListener("DOMContentLoaded", init);
})();
