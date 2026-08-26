/* ==========================================================================
   admin-tours.js — tours.html (admin)
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, formatCurrency, toast, debounce, uid } = MTUtils;

  let tours = [];
  let search = "";
  let categoryFilter = "all";

  async function init() {
    if (!qs("#adminToursApp")) return;
    const ok = await MTAdmin.requireBackend("#adminToursApp");
    if (!ok) return;
    try {
      await load();
    } catch (err) {
      MTAdmin.renderBackendError("#adminToursApp", "backend_unreachable");
      return;
    }
    bindToolbar();
    bindModal();
    render();
  }

  async function load() {
    tours = await MTApi.getTours();
  }

  function bindToolbar() {
    const searchInput = qs("#toursSearch");
    searchInput && searchInput.addEventListener("input", debounce((e) => { search = e.target.value.toLowerCase(); render(); }, 200));
    const catSelect = qs("#toursCategoryFilter");
    catSelect && catSelect.addEventListener("change", (e) => { categoryFilter = e.target.value; render(); });
  }

  function filtered() {
    return tours.filter((t) => {
      const matchesSearch = !search || t.name.toLowerCase().includes(search) || t.slug.includes(search);
      const matchesCat = categoryFilter === "all" || t.category === categoryFilter;
      return matchesSearch && matchesCat;
    });
  }

  function render() {
    const grid = qs("#toursGrid");
    if (!grid) return;
    const items = filtered();
    const countEl = qs("#toursResultsCount");
    if (countEl) countEl.textContent = `${items.length} tour${items.length === 1 ? "" : "s"}`;
    if (!items.length) {
      grid.innerHTML = `<div class="empty-state" style="grid-column:1/-1"><h4>No tours found</h4><p>Try a different search or filter.</p></div>`;
      return;
    }
    grid.innerHTML = items.map(cardHtml).join("");
    bindCardActions();
  }

  function cardHtml(t) {
    const meta = (typeof MT_TOURS !== "undefined") ? MT_TOURS.find((x) => x.slug === t.slug) : null;
    const hasPhoto = meta && meta.image_count > 0;
    const mediaHtml = hasPhoto
      ? `<img src="../assets/images/${meta.folder}/${meta.image_prefix}_01.jpg" alt="${MTUtils.escapeHtml(t.name)}" style="width:100%; height:100%; object-fit:cover;" loading="lazy">`
      : `<div style="position:absolute; inset:0; display:flex; flex-direction:column; align-items:center; justify-content:center; gap:6px; background:var(--slate-100); color:var(--slate-400); font-size:.78rem; font-weight:600; text-align:center; padding:0 12px;">${MTUtils.escapeHtml(t.name)}<span style="font-weight:400;">${mtT("tour.photos_pending_short")}</span></div>`;
    return `
    <div class="panel" data-tour-row="${t.slug}" style="padding:0; overflow:hidden;">
      <div style="aspect-ratio:16/10; background:var(--sand-100); position:relative;">
        ${mediaHtml}
        <div style="position:absolute; top:10px; left:10px; display:flex; gap:6px;">
          ${t.featured ? '<span class="badge badge--gold">Featured</span>' : ""}
          ${!t.visible ? '<span class="badge badge--outline">Hidden</span>' : ""}
        </div>
      </div>
      <div style="padding:16px 18px;">
        <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:6px;">
          <strong style="font-family:var(--font-display); font-size:.98rem;">${MTUtils.escapeHtml(t.name)}</strong>
        </div>
        <div style="display:flex; align-items:center; justify-content:space-between; font-size:.82rem; color:var(--slate-500); margin-bottom:12px;">
          <span>${t.category}${t.isIsland ? " &middot; " + mtT("admin.island_label") : ""}</span>
          <span>${formatCurrency(t.priceOnline)}</span>
        </div>
        <div class="dt-actions" style="justify-content:flex-end;">
          <button class="dt-action-btn" data-action="edit" title="${mtT('admin.edit')}">${icon("edit")}</button>
          <button class="dt-action-btn" data-action="duplicate" title="${mtT('admin.duplicate')}">${icon("copy")}</button>
          <button class="dt-action-btn" data-action="feature" title="${t.featured ? mtT('admin.unfeature') : mtT('admin.feature')}">${icon("star")}</button>
          <button class="dt-action-btn" data-action="toggle" title="${t.visible ? mtT('admin.hide') : mtT('admin.show')}">${icon("eye")}</button>
          <button class="dt-action-btn danger" data-action="delete" title="${mtT('admin.delete')}">${icon("trash")}</button>
        </div>
      </div>
    </div>`;
  }

  function icon(name) {
    const paths = {
      edit: '<path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"/><path d="M18.5 2.5a2.1 2.1 0 0 1 3 3L12 15l-4 1 1-4Z"/>',
      copy: '<rect x="9" y="9" width="13" height="13" rx="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/>',
      star: '<polygon points="12 2 15.09 8.58 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.58"/>',
      eye: '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8Z"/><circle cx="12" cy="12" r="3"/>',
      trash: '<polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/>'
    };
    return `<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">${paths[name]}</svg>`;
  }

  function bindCardActions() {
    qsa("[data-tour-row]").forEach((card) => {
      const slug = card.dataset.tourRow;
      const t = tours.find((x) => x.slug === slug);
      qsa("[data-action]", card).forEach((btn) => {
        btn.addEventListener("click", async () => {
          const action = btn.dataset.action;
          if (action === "edit") openModal(t);
          else if (action === "duplicate") duplicateTour(t);
          else if (action === "feature") {
            t.featured = !t.featured;
            const ok = await syncTour(t, { featured: t.featured });
            if (ok) { render(); toast(mtT(t.featured ? "admin.toast_featured" : "admin.toast_unfeatured").replace("{name}", t.name), "success"); }
          }
          else if (action === "toggle") {
            t.visible = !t.visible;
            const ok = await syncTour(t, { visible: t.visible });
            if (ok) { render(); toast(mtT(t.visible ? "admin.toast_shown" : "admin.toast_hidden").replace("{name}", t.name), "success"); }
          }
          else if (action === "delete") deleteTour(t);
        });
      });
    });
  }

  // Applies a partial update to one tour on the real backend. If it fails,
  // the in-memory list is reverted so the UI never shows an unsaved change
  // as if it succeeded.
  async function syncTour(t, changes) {
    try {
      await MTApi.updateTour(t.slug, changes);
      return true;
    } catch (e) {
      Object.keys(changes).forEach((k) => { t[k] = !changes[k]; }); // best-effort revert for boolean toggles
      toast(MTUtils.translateApiError(e.message) || mtT("admin.err_save_unreachable"), "error");
      render();
      return false;
    }
  }

  async function duplicateTour(t) {
    const copy = Object.assign({}, t, { slug: t.slug + "-copy-" + Math.floor(Math.random() * 1000), name: t.name + " (Copy)", featured: false, createdAt: new Date().toISOString() });
    try {
      const created = await MTApi.createTour({ ...copy, price: copy.priceOnline });
      tours.unshift(created);
      render();
      toast(mtT("admin.toast_duplicated").replace("{name}", t.name), "success");
    } catch (e) {
      toast(MTUtils.translateApiError(e.message) || mtT("admin.err_duplicate_unreachable"), "error");
    }
  }

  async function deleteTour(t) {
    if (!confirm(mtT("admin.confirm_delete_tour").replace("{name}", t.name))) return;
    try {
      await MTApi.deleteTour(t.slug);
      tours = tours.filter((x) => x.slug !== t.slug);
      render();
      toast(mtT("admin.toast_deleted").replace("{name}", t.name), "info");
    } catch (e) {
      toast(MTUtils.translateApiError(e.message) || mtT("admin.err_delete_unreachable"), "error");
    }
  }

  /* ---------------- Create / edit modal ---------------- */
  function bindModal() {
    const form = qs("#tourForm");
    if (!form) return;
    form.addEventListener("submit", async (e) => {
      e.preventDefault();
      if (!form.checkValidity()) {
        const invalid = form.querySelector(":invalid");
        toast(invalid ? `${mtT("admin.form_invalid_field")}: ${invalid.validationMessage}` : mtT("admin.form_invalid"), "error");
        if (invalid) invalid.focus();
        return;
      }
      await saveFromForm();
    });
  }

  function openModal(tour) {
    const modal = qs("#tourFormModal");
    if (!modal || !tour) return;
    const saveBtn = qs('#tourForm button[type="submit"]');
    if (saveBtn) { saveBtn.disabled = false; saveBtn.classList.remove("is-loading"); }
    qs("#tourFormTitle").textContent = mtT("admin.edit_tour");
    qs("#tourFormSlug").value = tour.slug;
    qs("#tourFormName").value = tour.name;
    qs("#tourFormCategory").value = tour.category;
    qs("#tourFormPriceAdult").value = tour.priceAdult;
    qs("#tourFormPriceChild").value = tour.priceChild;
    qs("#tourFormPriceInfant").value = tour.priceInfant;
    qs("#tourFormDepartureTime").value = tour.departureTime || "";
    qs("#tourFormReturnTime").value = tour.returnTime || "";
    qs("#tourFormIsland").checked = !!tour.isIsland;
    const activeDays = Array.isArray(tour.availableDays) ? tour.availableDays : ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"];
    qsa('input[name="tourFormDay"]').forEach((cb) => { cb.checked = activeDays.includes(cb.value); });
    // ATV Safari is rented per single/double vehicle, not per adult/child/
    // infant head count - this is the one tour with pricingMode set to
    // "single_double" (see backend/seed.js), so it gets its own pair of
    // price fields in place of the normal three. Every other tour keeps
    // the standard fields; nothing else about how they work changes.
    const isAtvPricing = tour.pricingMode === "single_double";
    qs("#tourFormStandardPricing").style.display = isAtvPricing ? "none" : "";
    qs("#tourFormAtvPricing").style.display = isAtvPricing ? "" : "none";
    qs("#tourFormPriceSingle").value = tour.priceSingle != null ? tour.priceSingle : "";
    qs("#tourFormPriceDouble").value = tour.priceDouble != null ? tour.priceDouble : "";
    modal.dataset.pricingMode = tour.pricingMode || "standard";
    modal.dataset.editingSlug = tour.slug;
    modal.classList.add("is-open");
  }

  async function saveFromForm() {
    const modal = qs("#tourFormModal");
    const editingSlug = modal.dataset.editingSlug;
    const pricingMode = modal.dataset.pricingMode || "standard";
    const name = qs("#tourFormName").value.trim();
    if (!name) { toast(mtT("admin.enter_tour_name"), "error"); return; }
    const availableDays = qsa('input[name="tourFormDay"]:checked').map((cb) => cb.value);
    let payload;
    const departureTime = qs("#tourFormDepartureTime").value;
    const returnTime = qs("#tourFormReturnTime").value;
    if (pricingMode === "single_double") {
      const priceSingle = parseFloat(qs("#tourFormPriceSingle").value) || 0;
      const priceDouble = parseFloat(qs("#tourFormPriceDouble").value) || 0;
      payload = {
        name,
        category: qs("#tourFormCategory").value,
        // priceOnline/priceRegular (the "from €X" figure shown on cards
        // and the tour's own detail page) follow the single price - the
        // cheapest way to book this tour, same convention as using the
        // adult price for standard tours.
        priceRegular: priceSingle,
        priceOnline: priceSingle,
        priceSingle, priceDouble,
        pricingMode,
        departureTime, returnTime,
        isIsland: qs("#tourFormIsland").checked,
        availableDays,
      };
    } else {
      const priceAdult = parseFloat(qs("#tourFormPriceAdult").value) || 0;
      const priceChild = parseFloat(qs("#tourFormPriceChild").value) || 0;
      const priceInfant = parseFloat(qs("#tourFormPriceInfant").value) || 0;
      payload = {
        name,
        category: qs("#tourFormCategory").value,
        priceRegular: priceAdult,
        priceOnline: priceAdult,
        priceAdult, priceChild, priceInfant,
        pricingMode,
        departureTime, returnTime,
        isIsland: qs("#tourFormIsland").checked,
        availableDays,
      };
    }

    // Disabled only for the Save button itself - closing the modal (X,
    // Escape, backdrop) stays available the whole time, even mid-save,
    // so a slow/stuck request can never trap the user in the modal.
    const saveBtn = qs('#tourForm button[type="submit"]');
    if (saveBtn) { saveBtn.disabled = true; saveBtn.classList.add("is-loading"); }

    try {
      const updated = await MTApi.updateTour(editingSlug, { ...payload, price: payload.priceOnline });
      const idx = tours.findIndex((x) => x.slug === editingSlug);
      if (idx > -1) tours[idx] = updated;
      toast(mtT("admin.toast_updated").replace("{name}", name), "success");
    } catch (err) {
      toast(MTUtils.translateApiError(err.message) || mtT("admin.err_save_tour_unreachable"), "error");
      return;
    } finally {
      if (saveBtn) { saveBtn.disabled = false; saveBtn.classList.remove("is-loading"); }
    }

    modal.classList.remove("is-open");
    render();
  }

  document.addEventListener("DOMContentLoaded", () => setTimeout(init, 0));
})();
