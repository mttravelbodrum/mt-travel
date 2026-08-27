/**
 * assets/js/contact.js - wires up the contact page's form to the real
 * backend (POST /api/contact). Mirrors checkout.js's loading/error
 * pattern: disable the button while the request is in flight, show a
 * translated error inline on failure, and confirm success without
 * losing what the visitor typed if something goes wrong.
 */
(function () {
  const { qs, toast, currentLang, translateApiError } = MTUtils;

  function showError(form, message) {
    let box = qs("#contactErrorBox", form);
    if (!box) {
      box = document.createElement("div");
      box.id = "contactErrorBox";
      box.className = "field-error";
      box.style.cssText = "display:flex; margin-bottom:16px;";
      const btn = qs("button[type=submit]", form);
      btn.parentElement.insertBefore(box, btn);
    }
    box.innerHTML = `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="m21.73 18-8-14a2 2 0 0 0-3.48 0l-8 14A2 2 0 0 0 4 21h16a2 2 0 0 0 1.73-3Z"/><line x1="12" y1="9" x2="12" y2="13"/><line x1="12" y1="17" x2="12.01" y2="17"/></svg><span>${message}</span>`;
    box.style.display = "flex";
  }

  function clearError(form) {
    const box = qs("#contactErrorBox", form);
    if (box) box.style.display = "none";
  }

  function bindContactForm() {
    const form = qs("#contactForm");
    if (!form) return;
    const btn = qs("button[type=submit]", form);
    const originalLabelKey = btn ? btn.getAttribute("data-i18n") : null;

    form.addEventListener("submit", async (e) => {
      e.preventDefault();
      if (!form.checkValidity()) { form.reportValidity(); return; }
      clearError(form);

      const payload = {
        firstName: qs("#contactFirstName", form).value.trim(),
        lastName: qs("#contactLastName", form).value.trim(),
        email: qs("#contactEmail", form).value.trim(),
        phone: qs("#contactPhone", form) ? qs("#contactPhone", form).value.trim() : "",
        subject: qs("#contactSubject", form).value,
        message: qs("#contactMessage", form).value.trim(),
        lang: currentLang(),
      };

      btn.disabled = true;
      btn.textContent = mtT("contact.sending");

      try {
        const available = await MTApi.isAvailable();
        if (!available) { showError(form, mtT("contact.error_unreachable")); return; }
        await MTApi.submitContactForm(payload);
        toast(mtT("contact.success_message"), "success");
        form.reset();
      } catch (err) {
        showError(form, translateApiError(err.message) || mtT("contact.error_generic"));
      } finally {
        btn.disabled = false;
        if (originalLabelKey) btn.textContent = mtT(originalLabelKey);
      }
    });
  }

  document.addEventListener("DOMContentLoaded", bindContactForm);
})();
