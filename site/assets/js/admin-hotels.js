/* ==========================================================================
   admin-hotels.js — hotels.html (admin)
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, formatDate, toast, debounce } = MTUtils;

  let hotels = [];
  let search = "";
  let pendingDeleteId = null;

  async function init() {
    if (!qs("#adminHotelsApp")) return;
    const ok = await MTAdmin.requireBackend("#adminHotelsApp");
    if (!ok) return;
    try {
      await load();
    } catch (err) {
      MTAdmin.renderBackendError("#adminHotelsApp", "backend_unreachable");
      return;
    }
    bindToolbar();
    bindFormModal();
    bindDeleteModal();
    render();
  }

  async function load() {
    hotels = await MTApi.getHotels();
  }

  function bindToolbar() {
    const searchInput = qs("#hotelsSearch");
    searchInput && searchInput.addEventListener("input", debounce((e) => { search = e.target.value.toLocaleLowerCase("tr"); render(); }, 200));
    const addBtn = qs("#addHotelBtn");
    addBtn && addBtn.addEventListener("click", () => openFormModal(null));
  }

  function filtered() {
    if (!search) return hotels;
    return hotels.filter((h) => h.name.toLocaleLowerCase("tr").includes(search));
  }

  function render() {
    const tbody = qs("#hotelsTableBody");
    const wrap = qs("#hotelsListWrap");
    const empty = qs("#hotelsEmptyState");
    if (!tbody) return;
    const items = filtered();

    if (!items.length) {
      wrap.querySelector(".data-table-wrap").style.display = "none";
      empty.style.display = "block";
      return;
    }
    wrap.querySelector(".data-table-wrap").style.display = "";
    empty.style.display = "none";

    tbody.innerHTML = items.map((h) => `
      <tr>
        <td><strong>${escapeHtml(h.name)}</strong></td>
        <td>${h.createdAt ? formatDate(h.createdAt.slice(0, 10)) : "\u2014"}</td>
        <td style="text-align:right;">
          <button class="dt-action-btn" data-action="edit" data-id="${h.id}" title="${mtT('admin.edit')}">${editIconSvg()}</button>
          <button class="dt-action-btn danger" data-action="delete" data-id="${h.id}" title="${mtT('admin.delete')}">${trashIconSvg()}</button>
        </td>
      </tr>
    `).join("");

    qsa("[data-action]", tbody).forEach((btn) => {
      btn.addEventListener("click", () => {
        const hotel = hotels.find((h) => h.id === btn.dataset.id);
        if (!hotel) return;
        if (btn.dataset.action === "edit") openFormModal(hotel);
        else if (btn.dataset.action === "delete") askDeleteConfirmation(hotel.id);
      });
    });
  }

  function escapeHtml(s) {
    const div = document.createElement("div");
    div.textContent = s;
    return div.innerHTML;
  }

  // Small inline icons so this file doesn't need the icon-generation
  // pipeline at render time - same paths as the shared edit/trash icons
  // used elsewhere in the admin panel.
  function editIconSvg() {
    return '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.12 2.12 0 0 1 3 3L12 15l-4 1 1-4Z"></path></svg>';
  }
  function trashIconSvg() {
    return '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 6h18"></path><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"></path></svg>';
  }

  function openFormModal(hotel) {
    const modal = qs("#hotelFormModal");
    if (!modal) return;
    qs("#hotelFormTitle").textContent = hotel ? mtT("admin.edit_hotel") : mtT("admin.add_hotel");
    qs("#hotelFormId").value = hotel ? hotel.id : "";
    qs("#hotelFormName").value = hotel ? hotel.name : "";
    const errBox = qs("#hotelFormErrorBox");
    if (errBox) errBox.style.display = "none";
    modal.classList.add("is-open");
    qs("#hotelFormName").focus();
  }

  function bindFormModal() {
    const modal = qs("#hotelFormModal");
    if (!modal) return;
    qsa("[data-modal-close]", modal).forEach((btn) => btn.addEventListener("click", () => modal.classList.remove("is-open")));

    const form = qs("#hotelForm");
    const errBox = qs("#hotelFormErrorBox");
    const showErr = (msg) => { if (errBox) { qs("span", errBox).textContent = msg; errBox.style.display = "flex"; } };

    form.addEventListener("submit", async (e) => {
      e.preventDefault();
      const id = qs("#hotelFormId").value;
      const name = qs("#hotelFormName").value.trim();
      if (!name) { showErr(mtT("admin.hotel_name_required")); return; }
      if (errBox) errBox.style.display = "none";
      const submitBtn = qs('#hotelForm button[type="submit"]');
      submitBtn.disabled = true;
      try {
        if (id) {
          const updated = await MTApi.updateHotel(id, { name });
          hotels = hotels.map((h) => (h.id === id ? updated : h));
          toast(mtT("admin.toast_hotel_updated"), "success");
        } else {
          const created = await MTApi.createHotel({ name });
          hotels.push(created);
          toast(mtT("admin.toast_hotel_added"), "success");
        }
        modal.classList.remove("is-open");
        render();
      } catch (err) {
        showErr(MTUtils.translateApiError(err.message) || mtT("admin.err_hotel_save_failed"));
      } finally {
        submitBtn.disabled = false;
      }
    });
  }

  function askDeleteConfirmation(id) {
    pendingDeleteId = id;
    const modal = qs("#hotelDeleteModal");
    if (modal) modal.classList.add("is-open");
  }

  function bindDeleteModal() {
    const modal = qs("#hotelDeleteModal");
    if (!modal) return;
    qs("[data-delete-cancel]", modal).addEventListener("click", () => {
      pendingDeleteId = null;
      modal.classList.remove("is-open");
    });
    qs("[data-delete-confirm]", modal).addEventListener("click", async () => {
      if (!pendingDeleteId) return;
      const deletedId = pendingDeleteId;
      const confirmBtn = qs("[data-delete-confirm]", modal);
      confirmBtn.disabled = true;
      try {
        await MTApi.deleteHotel(deletedId);
        hotels = hotels.filter((h) => h.id !== deletedId);
        pendingDeleteId = null;
        modal.classList.remove("is-open");
        toast(mtT("admin.toast_hotel_deleted"), "info");
        render();
      } catch (err) {
        toast(MTUtils.translateApiError(err.message) || mtT("admin.err_hotel_delete_failed"), "error");
      } finally {
        confirmBtn.disabled = false;
      }
    });
  }

  document.addEventListener("DOMContentLoaded", init);
})();
