/* ==========================================================================
   admin-customers.js — customers.html (admin)
   BACKEND-ONLY. Customers have no record of their own - they're computed
   from reservations by email. Deleting one deletes every reservation
   under that email on the real backend (there's nothing else to remove).
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, formatCurrency, formatDate, debounce, toast } = MTUtils;

  let customers = [];
  let search = "";
  let page = 1;
  const PER_PAGE = 8;
  let pendingDeleteEmail = null;

  async function init() {
    if (!qs("#adminCustomersApp")) return;
    const ok = await MTAdmin.requireBackend("#adminCustomersApp");
    if (!ok) return;
    try {
      customers = (await MTApi.getCustomers()).sort((a, b) => b.bookings - a.bookings);
    } catch (err) {
      MTAdmin.renderBackendError("#adminCustomersApp", "backend_unreachable");
      return;
    }
    const searchInput = qs("#customersSearch");
    searchInput && searchInput.addEventListener("input", debounce((e) => { search = e.target.value.toLowerCase(); page = 1; render(); }, 200));
    bindDeleteModal();
    render();
  }

  function filtered() {
    if (!search) return customers;
    return customers.filter((c) => c.name.toLowerCase().includes(search) || c.email.toLowerCase().includes(search) || c.country.toLowerCase().includes(search));
  }

  function render() {
    const items = filtered();
    const tbody = qs("#customersTableBody");
    const countEl = qs("#customersResultsCount");
    if (countEl) countEl.textContent = `${items.length} ${mtT("admin.customers_count_label")}`;
    if (!tbody) return;
    if (!items.length) {
      tbody.innerHTML = `<tr><td colspan="6"><div class="empty-state"><h4>${mtT("admin.no_customers_found")}</h4></div></td></tr>`;
    } else {
      tbody.innerHTML = MTAdmin.paginate(items, page, PER_PAGE).map((c) => `
        <tr>
          <td>
            <div style="display:flex; align-items:center; gap:10px;">
              <div class="mini-booking-row__avatar">${initials(c.name)}</div>
              <div><span class="dt-cell-main">${MTUtils.escapeHtml(c.name)}</span><br><span class="dt-cell-sub">${MTUtils.escapeHtml(c.country || "")}</span></div>
            </div>
          </td>
          <td>${MTUtils.escapeHtml(c.email)}<br><span class="dt-cell-sub">${MTUtils.escapeHtml(c.phone || "")}</span></td>
          <td>${c.bookings}</td>
          <td>${formatCurrency(c.totalSpent)}</td>
          <td>${formatDate(c.lastBooking)}</td>
          <td>
            <div class="dt-actions">
              <button class="dt-action-btn danger" data-delete-email="${MTUtils.escapeHtml(c.email)}" title="${mtT('admin.delete')}">${iconTrash()}</button>
            </div>
          </td>
        </tr>
      `).join("");
      qsa("[data-delete-email]", tbody).forEach((btn) => {
        btn.addEventListener("click", () => askDeleteConfirmation(btn.dataset.deleteEmail));
      });
    }
    const pager = qs("#customersPagination");
    if (pager) MTAdmin.buildPagination(pager, items.length, page, PER_PAGE, (p) => { page = p; render(); });
  }

  function initials(name) { return name.split(" ").map((p) => p[0]).slice(0, 2).join("").toUpperCase(); }
  function iconTrash() { return '<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>'; }

  function askDeleteConfirmation(email) {
    pendingDeleteEmail = email;
    const modal = qs("#deleteConfirmModal");
    if (modal) modal.classList.add("is-open");
  }

  function bindDeleteModal() {
    const modal = qs("#deleteConfirmModal");
    if (!modal) return;
    qs("[data-delete-cancel]", modal).addEventListener("click", () => {
      pendingDeleteEmail = null;
      modal.classList.remove("is-open");
    });
    qs("[data-delete-confirm]", modal).addEventListener("click", async () => {
      if (!pendingDeleteEmail) return;
      const deletedEmail = pendingDeleteEmail;
      const confirmBtn = qs("[data-delete-confirm]", modal);
      confirmBtn.disabled = true;
      try {
        await MTApi.deleteCustomer(deletedEmail);
        customers = customers.filter((c) => c.email !== deletedEmail);
        pendingDeleteEmail = null;
        modal.classList.remove("is-open");
        render();
        toast(mtT("admin.toast_deleted").replace("{name}", deletedEmail), "success");
      } catch (err) {
        toast(MTUtils.translateApiError(err.message) || mtT("admin.err_delete_unreachable"), "error");
      } finally {
        confirmBtn.disabled = false;
      }
    });
  }

  document.addEventListener("DOMContentLoaded", () => setTimeout(init, 0));
})();
