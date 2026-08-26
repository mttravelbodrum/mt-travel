/* ==========================================================================
   admin-reservations.js — reservations.html (admin)
   BACKEND-ONLY. No demo data, no fallback. If the backend is unreachable,
   MTAdmin.requireBackend() renders a clear error and this script stops.
   Full status workflow, internal notes, and PDF/email/WhatsApp/print
   actions per reservation.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, formatCurrency, formatDate, toast, debounce } = MTUtils;

  let allBookings = [];
  let filtered = [];
  let page = 1;
  const PER_PAGE = 8;
  let search = "";
  let statusFilter = "all";
  let sortKey = "createdAt_desc";
  let activeDetailId = null;

  async function init() {
    if (!qs("#adminReservationsApp")) return;
    const ok = await MTAdmin.requireBackend("#adminReservationsApp");
    if (!ok) return;

    const params = new URLSearchParams(location.search);
    if (params.get("search")) search = params.get("search").toLowerCase();

    try {
      await load();
    } catch (err) {
      MTAdmin.renderBackendError("#adminReservationsApp", "backend_unreachable");
      return;
    }

    bindToolbar();
    bindModal();
    bindDeleteModal();
    bindEmailComposerModal();
    render();

    // If a notification linked here with a specific reservation ID and
    // there's exactly one match, open its detail view directly.
    if (search && filtered.length === 1) showDetail(filtered[0]);
  }

  async function load() {
    const result = await MTApi.getReservations({ perPage: 500 });
    allBookings = result.results;
  }

  function bindToolbar() {
    const searchInput = qs("#bookingsSearch");
    if (searchInput && search) searchInput.value = search;
    searchInput && searchInput.addEventListener("input", debounce((e) => {
      search = e.target.value.toLowerCase();
      page = 1;
      render();
    }, 200));

    const statusSelect = qs("#bookingsStatusFilter");
    statusSelect && statusSelect.addEventListener("change", (e) => {
      statusFilter = e.target.value;
      page = 1;
      render();
    });

    const sortSelect = qs("#bookingsSort");
    sortSelect && sortSelect.addEventListener("change", (e) => {
      sortKey = e.target.value;
      render();
    });

    const exportBtn = qs("#exportBookingsBtn");
    exportBtn && exportBtn.addEventListener("click", exportCsv);
    const printBtn = qs("#printBookingsBtn");
    printBtn && printBtn.addEventListener("click", () => window.print());
  }

  function applyFilters() {
    filtered = allBookings.filter((b) => {
      const matchesSearch = !search ||
        b.customer.toLowerCase().includes(search) ||
        b.id.toLowerCase().includes(search) ||
        (b.email || "").toLowerCase().includes(search) ||
        (b.tourName.en || b.tourName || "").toLowerCase().includes(search);
      const matchesStatus = statusFilter === "all" || b.status === statusFilter;
      return matchesSearch && matchesStatus;
    });
    filtered.sort((a, b) => {
      switch (sortKey) {
        case "createdAt_asc": return new Date(a.createdAt) - new Date(b.createdAt);
        case "total_desc": return b.total - a.total;
        case "total_asc": return a.total - b.total;
        case "date_asc": return a.date.localeCompare(b.date);
        case "date_desc": return b.date.localeCompare(a.date);
        default: return new Date(b.createdAt) - new Date(a.createdAt);
      }
    });
  }

  function render() {
    applyFilters();
    const tbody = qs("#bookingsTableBody");
    const countEl = qs("#bookingsResultsCount");
    if (countEl) countEl.textContent = `${filtered.length} ${mtT("admin.reservations_count_label")}`;
    if (!tbody) return;
    if (!filtered.length) {
      tbody.innerHTML = `<tr><td colspan="7"><div class="empty-state"><h4>${mtT("admin.no_reservations_found_title")}</h4><p>${allBookings.length === 0 ? mtT("admin.no_reservations_made_yet") : mtT("admin.try_different_search")}</p></div></td></tr>`;
    } else {
      const pageItems = MTAdmin.paginate(filtered, page, PER_PAGE);
      tbody.innerHTML = pageItems.map(rowHtml).join("");
      bindRowActions();
    }
    const pager = qs("#bookingsPagination");
    if (pager) MTAdmin.buildPagination(pager, filtered.length, page, PER_PAGE, (p) => { page = p; render(); });
  }

  function rowHtml(b) {
    return `
      <tr data-booking-id="${b.id}">
        <td><span class="dt-cell-main">${b.id}</span><br><span class="dt-cell-sub">${formatDate(b.createdAt.slice(0,10))}</span></td>
        <td><span class="dt-cell-main">${MTUtils.escapeHtml(b.customer)}</span><br><span class="dt-cell-sub">${MTUtils.escapeHtml(b.email || "")}</span></td>
        <td>${MTUtils.escapeHtml(b.tourName.en || b.tourName)}</td>
        <td>${formatDate(b.date)}</td>
        <td>${b.pricingMode === "single_double" ? (b.single + b.double * 2) : (b.adults + b.children)}</td>
        <td><span class="dt-cell-main">${formatCurrency(b.total)}</span></td>
        <td><span class="status-pill status-pill--${b.status.toLowerCase()}">${MTAdmin.statusLabel(b.status)}</span></td>
        <td>
          <div class="dt-actions">
            <button class="dt-action-btn" data-action="view" title="${mtT('admin.view_details')}">${iconEye()}</button>
            <button class="dt-action-btn danger" data-action="delete" title="${mtT('admin.delete')}">${iconTrash()}</button>
          </div>
        </td>
      </tr>`;
  }

  function iconEye() { return '<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8Z"/><circle cx="12" cy="12" r="3"/></svg>'; }
  function iconTrash() { return '<svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="3 6 5 6 21 6"/><path d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2"/></svg>'; }

  let pendingDeleteId = null;

  function bindRowActions() {
    qsa("[data-action]").forEach((btn) => {
      btn.addEventListener("click", (e) => {
        e.stopPropagation();
        const row = btn.closest("[data-booking-id]");
        const booking = allBookings.find((b) => b.id === row.dataset.bookingId);
        if (!booking) return;
        if (btn.dataset.action === "view") showDetail(booking);
        else if (btn.dataset.action === "delete") askDeleteConfirmation(booking.id);
      });
    });
    qsa("[data-booking-id]").forEach((row) => {
      row.style.cursor = "pointer";
      row.addEventListener("click", (e) => {
        if (e.target.closest("[data-action]")) return;
        const booking = allBookings.find((b) => b.id === row.dataset.bookingId);
        if (booking) showDetail(booking);
      });
    });
  }

  function askDeleteConfirmation(id) {
    pendingDeleteId = id;
    const modal = qs("#deleteConfirmModal");
    if (modal) modal.classList.add("is-open");
  }

  let emailComposerBookingId = null;

  function openEmailComposer(id) {
    const booking = allBookings.find((b) => b.id === id);
    if (!booking) return;
    emailComposerBookingId = id;
    const modal = qs("#emailCustomerModal");
    if (!modal) return;
    const recipientLine = qs("p[data-email-recipient-line]", modal);
    if (recipientLine) recipientLine.textContent = `${booking.customer} <${booking.email}>`;
    qs("#emailCustomerSubject", modal).value = `${mtT("admin.email_subject_reservation")} ${booking.id}`;
    qs("#emailCustomerMessage", modal).value = "";
    const errBox = qs("#emailCustomerErrorBox", modal);
    if (errBox) errBox.style.display = "none";
    modal.classList.add("is-open");
  }

  function bindEmailComposerModal() {
    const modal = qs("#emailCustomerModal");
    if (!modal) return;
    const close = () => { modal.classList.remove("is-open"); emailComposerBookingId = null; };
    qsa("[data-email-cancel]", modal).forEach((btn) => btn.addEventListener("click", close));

    const sendBtn = qs("#emailCustomerSendBtn", modal);
    const errBox = qs("#emailCustomerErrorBox", modal);
    const showErr = (msg) => { if (errBox) { qs("span", errBox).textContent = msg; errBox.style.display = "flex"; } };

    sendBtn.addEventListener("click", async () => {
      if (!emailComposerBookingId) return;
      const subject = qs("#emailCustomerSubject", modal).value.trim();
      const message = qs("#emailCustomerMessage", modal).value.trim();
      if (!subject || !message) { showErr(mtT("admin.email_fields_required")); return; }
      if (errBox) errBox.style.display = "none";
      sendBtn.disabled = true;
      try {
        await MTApi.emailReservationCustomer(emailComposerBookingId, { subject, message });
        toast(mtT("admin.email_sent_success"), "success");
        close();
      } catch (err) {
        showErr(MTUtils.translateApiError(err.message) || mtT("admin.email_send_failed"));
      } finally {
        sendBtn.disabled = false;
      }
    });
  }

  function bindDeleteModal() {
    const modal = qs("#deleteConfirmModal");
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
        await MTApi.deleteReservation(deletedId);
        allBookings = allBookings.filter((b) => b.id !== deletedId);
        pendingDeleteId = null;
        modal.classList.remove("is-open");
        qs("#bookingDetailModal").classList.remove("is-open");
        render();
        toast(mtT("admin.toast_deleted").replace("{name}", deletedId), "success");
      } catch (err) {
        toast(MTUtils.translateApiError(err.message) || mtT("admin.err_delete_unreachable"), "error");
      } finally {
        confirmBtn.disabled = false;
      }
    });
  }

  function showDetail(b) {
    activeDetailId = b.id;
    const modal = qs("#bookingDetailModal");
    if (!modal) return;
    qs("[data-detail-id]", modal).textContent = b.id;
    qs("[data-detail-customer]", modal).textContent = b.customer;
    qs("[data-detail-email]", modal).textContent = b.email || "\u2014";
    qs("[data-detail-phone]", modal).textContent = b.phone || "\u2014";
    qs("[data-detail-country]", modal).textContent = (b.country || "").toUpperCase();
    qs("[data-detail-tour]", modal).textContent = b.tourName.en || b.tourName;
    qs("[data-detail-date]", modal).textContent = formatDate(b.date);
    qs("[data-detail-created]", modal).textContent = formatDate(b.createdAt.slice(0, 10));
    qs("[data-detail-guests]", modal).textContent = b.pricingMode === "single_double"
      ? `${b.single} ${mtT("booking.single")}, ${b.double} ${mtT("booking.double")}`
      : `${b.adults} ${mtT("search.adults")}, ${b.children} ${mtT("search.children")}, ${b.infants || 0} ${mtT("booking.infants")}`;
    qs("[data-detail-hotel]", modal).textContent = b.hotelName || "\u2014";
    qs("[data-detail-total]", modal).textContent = formatCurrency(b.total);
    const notesField = qs("[data-detail-notes]", modal);
    if (notesField) notesField.value = b.notes || "";
    const statusSelect = qs("[data-detail-status-select]", modal);
    if (statusSelect) statusSelect.value = b.status;
    modal.classList.add("is-open");
  }

  function bindModal() {
    const modal = qs("#bookingDetailModal");
    if (!modal) return;
    const statusSelect = qs("[data-detail-status-select]", modal);
    statusSelect && statusSelect.addEventListener("change", async () => {
      const oldStatus = allBookings.find((b) => b.id === activeDetailId)?.status;
      const newStatus = statusSelect.value;
      statusSelect.disabled = true;
      try {
        const updated = await MTApi.updateReservation(activeDetailId, { status: newStatus });
        const idx = allBookings.findIndex((b) => b.id === activeDetailId);
        if (idx > -1) allBookings[idx] = updated;
        toast(mtT("admin.toast_reservation_updated").replace("{id}", activeDetailId).replace("{old}", MTAdmin.statusLabel(oldStatus)).replace("{new}", MTAdmin.statusLabel(newStatus)), "success");
        render();
      } catch (err) {
        toast(MTUtils.translateApiError(err.message) || mtT("admin.err_update_status_unreachable"), "error");
        statusSelect.value = oldStatus;
      } finally {
        statusSelect.disabled = false;
      }
    });

    const saveNotesBtn = qs("[data-detail-save-notes]", modal);
    saveNotesBtn && saveNotesBtn.addEventListener("click", async () => {
      const notes = qs("[data-detail-notes]", modal).value;
      saveNotesBtn.disabled = true;
      saveNotesBtn.classList.add("is-loading");
      try {
        const updated = await MTApi.updateReservation(activeDetailId, { notes });
        const idx = allBookings.findIndex((b) => b.id === activeDetailId);
        if (idx > -1) allBookings[idx] = updated;
        toast(mtT("admin.toast_notes_saved"), "success");
      } catch (err) {
        toast(MTUtils.translateApiError(err.message) || mtT("admin.err_save_notes_unreachable"), "error");
      } finally {
        saveNotesBtn.disabled = false;
        saveNotesBtn.classList.remove("is-loading");
      }
    });

    const printBtn = qs("[data-detail-print]", modal);
    printBtn && printBtn.addEventListener("click", () => window.print());

    const deleteBtn = qs("[data-detail-delete]", modal);
    deleteBtn && deleteBtn.addEventListener("click", () => askDeleteConfirmation(activeDetailId));

    const emailBtn = qs("[data-detail-email-btn]", modal);
    emailBtn && emailBtn.addEventListener("click", () => openEmailComposer(activeDetailId));

    const waBtn = qs("[data-detail-whatsapp-btn]", modal);
    waBtn && waBtn.addEventListener("click", () => {
      const booking = allBookings.find((b) => b.id === activeDetailId);
      if (!booking || typeof MT_SITE === "undefined") return;
      const tourName = MTAdmin.localizedTourName({ slug: booking.slug, tour: booking.tourName.en });
      const msg = encodeURIComponent(mtT("admin.whatsapp_template").replace("{customer}", booking.customer).replace("{id}", booking.id).replace("{tour}", tourName));
      window.open(`https://wa.me/?text=${msg}`, "_blank");
    });
  }

  function exportCsv() {
    const header = [mtT("admin.csv_reservation_id"), mtT("admin.csv_customer"), mtT("admin.csv_email"), mtT("admin.csv_tour"), mtT("admin.csv_date"), mtT("admin.csv_guests"), mtT("admin.csv_total"), mtT("admin.csv_hotel"), mtT("admin.csv_status")];
    const rows = filtered.map((b) => [b.id, b.customer, b.email, MTAdmin.localizedTourName({ slug: b.slug, tour: b.tourName.en || b.tourName }), b.date, b.pricingMode === "single_double" ? (b.single + b.double * 2) : (b.adults + b.children), b.total.toFixed(2), b.hotelName || "", b.status]);
    const csv = [header, ...rows].map((r) => r.map((v) => `"${String(v).replace(/"/g, '""')}"`).join(",")).join("\n");
    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url; a.download = "mt-group-travel-reservations.csv";
    document.body.appendChild(a); a.click(); document.body.removeChild(a);
    URL.revokeObjectURL(url);
    toast(mtT("admin.toast_exported_csv"), "success");
  }

  document.addEventListener("DOMContentLoaded", () => setTimeout(init, 0));
})();
