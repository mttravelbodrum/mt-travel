import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
import admin_parts as ap
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "admin")


def build():
    status_options = '''<option value="Pending" data-i18n="admin.status_pending">Pending</option>
            <option value="Confirmed" data-i18n="admin.status_confirmed">Confirmed</option>
            <option value="Completed" data-i18n="admin.status_completed">Completed</option>
            <option value="Cancelled" data-i18n="admin.status_cancelled">Cancelled</option>'''

    modal = f'''<div class="modal-overlay" id="bookingDetailModal">
    <div class="modal-box" style="position:relative; max-width:600px;">
      <button class="modal-close" data-modal-close type="button" aria-label="Close">{icon('x', 18)}</button>
      <div style="display:flex; align-items:center; justify-content:space-between; margin-bottom:20px; padding-right:30px;">
        <h3 style="margin:0;"><span data-i18n="admin.reservation">Reservation</span> <span data-detail-id></span></h3>
        <div class="select-wrap" style="width:170px;">
          <select class="select" data-detail-status-select>
            {status_options}
          </select>
          {icon('chevron-down',16)}
        </div>
      </div>
      <ul class="check-list" style="grid-template-columns:1fr 1fr;">
        <li>{icon('user',18)}<span><strong data-i18n="admin.customer_label">Customer:</strong> <span data-detail-customer></span></span></li>
        <li>{icon('globe',18)}<span><strong data-i18n="form.country_label">Country:</strong> <span data-detail-country></span></span></li>
        <li>{icon('mail',18)}<span><strong data-i18n="form.email_label">Email:</strong> <span data-detail-email></span></span></li>
        <li>{icon('phone',18)}<span><strong data-i18n="form.phone_label">Phone:</strong> <span data-detail-phone></span></span></li>
        <li>{icon('map',18)}<span><strong data-i18n="confirm.tour_label">Tour:</strong> <span data-detail-tour></span></span></li>
        <li>{icon('calendar',18)}<span><strong data-i18n="admin.date_label">Date:</strong> <span data-detail-date></span></span></li>
        <li>{icon('users',18)}<span><strong data-i18n="admin.guests_label">Guests:</strong> <span data-detail-guests></span></span></li>
        <li>{icon('map-pin',18)}<span><strong data-i18n="admin.hotel_label">Hotel:</strong> <span data-detail-hotel></span></span></li>
        <li>{icon('credit-card',18)}<span><strong data-i18n="admin.total_label">Total:</strong> <span data-detail-total></span></span></li>
        <li>{icon('clock',18)}<span><strong data-i18n="admin.created_label">Created:</strong> <span data-detail-created></span></span></li>
      </ul>
      <div class="field" style="margin-top:16px;">
        <label class="field-label" data-i18n="admin.internal_notes">Internal Notes</label>
        <textarea class="textarea" data-detail-notes style="min-height:70px;" placeholder="Add a private note about this reservation..." data-i18n-placeholder="admin.notes_placeholder"></textarea>
        <button type="button" class="btn btn--ghost btn--sm" data-detail-save-notes style="margin-top:8px;">{icon('check',14)}<span data-i18n="admin.save_notes">Save Notes</span></button>
      </div>
      <div class="dt-actions" style="margin-top:18px; justify-content:space-between; gap:10px; flex-wrap:wrap;">
        <div style="display:flex; gap:10px; flex-wrap:wrap;">
          <button type="button" class="btn btn--outline-dark btn--sm" data-detail-print>{icon('printer',14)}<span data-i18n="admin.print">Print</span></button>
          <button type="button" class="btn btn--outline-dark btn--sm" data-detail-email-btn>{icon('mail',14)}<span data-i18n="admin.email_customer">Email Customer</span></button>
          <button type="button" class="btn btn--whatsapp btn--sm" data-detail-whatsapp-btn>{icon('whatsapp',14)}<span data-i18n="admin.whatsapp_customer">WhatsApp Customer</span></button>
        </div>
        <button type="button" class="btn btn--danger btn--sm" data-detail-delete>{icon('trash',14)}<span data-i18n="admin.delete">Delete</span></button>
      </div>
    </div>
  </div>

  <div class="modal-overlay" id="deleteConfirmModal">
    <div class="modal-box" style="max-width:400px; text-align:center;">
      <div style="width:52px; height:52px; border-radius:50%; background:var(--danger-100); color:var(--danger-600); display:flex; align-items:center; justify-content:center; margin:0 auto 16px;">
        {icon('alert-triangle', 24)}
      </div>
      <h3 data-i18n="admin.delete_reservation_confirm_title">Are you sure you want to delete this reservation?</h3>
      <p style="color:var(--slate-500); font-size:.88rem; margin-bottom:24px;" data-i18n="admin.delete_irreversible">This action cannot be undone.</p>
      <div style="display:flex; gap:10px; justify-content:center;">
        <button type="button" class="btn btn--ghost" data-delete-cancel data-i18n="admin.cancel">Cancel</button>
        <button type="button" class="btn btn--danger" data-delete-confirm data-i18n="admin.delete">Delete</button>
      </div>
    </div>
  </div>

  <div class="modal-overlay" id="emailCustomerModal">
    <div class="modal-box" style="max-width:480px;">
      <div class="modal-header">
        <h3 data-i18n="admin.email_customer_title">Email Customer</h3>
        <button type="button" class="modal-close" data-email-cancel>{icon('x', 18)}</button>
      </div>
      <p style="color:var(--slate-500); font-size:.86rem; margin-top:-8px; margin-bottom:16px;" data-email-recipient-line></p>
      <div class="field">
        <label class="field-label" data-i18n="admin.email_subject_label">Subject</label>
        <input class="input" id="emailCustomerSubject" type="text">
      </div>
      <div class="field" style="margin-top:12px;">
        <label class="field-label" data-i18n="admin.email_message_label">Message</label>
        <textarea class="textarea" id="emailCustomerMessage" style="min-height:140px;"></textarea>
      </div>
      <div id="emailCustomerErrorBox" class="field-error" style="display:none; margin-top:12px;">{icon('alert-triangle', 14)}<span></span></div>
      <div style="display:flex; gap:10px; justify-content:flex-end; margin-top:20px;">
        <button type="button" class="btn btn--ghost" data-email-cancel data-i18n="admin.cancel">Cancel</button>
        <button type="button" class="btn btn--primary" id="emailCustomerSendBtn">{icon('mail', 14)}<span data-i18n="admin.email_send">Send Email</span></button>
      </div>
    </div>
  </div>'''

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {ap.admin_head("Rezervasyonlar", slug="reservations")}
</head>
{ap.shell_open("reservations", "Reservations", "admin.bookings")}
<div id="adminReservationsApp">
  <div class="panel">
    <div class="toolbar">
      <div class="toolbar__left">
        <div class="search-box">
          {icon('search', 16)}
          <input type="text" id="bookingsSearch" placeholder="Search by name, ID or email..." data-i18n-placeholder="admin.search_reservations_placeholder">
        </div>
        <div class="select-wrap">
          <select class="filter-select" id="bookingsStatusFilter">
            <option value="all" data-i18n="admin.all_statuses">All Statuses</option>
            {status_options}
          </select>
        </div>
        <div class="select-wrap">
          <select class="filter-select" id="bookingsSort">
            <option value="createdAt_desc" data-i18n="admin.sort_newest">Newest First</option>
            <option value="createdAt_asc" data-i18n="admin.sort_oldest">Oldest First</option>
            <option value="date_asc" data-i18n="admin.sort_date_asc">Tour Date &uarr;</option>
            <option value="date_desc" data-i18n="admin.sort_date_desc">Tour Date &darr;</option>
            <option value="total_desc" data-i18n="admin.sort_total_desc">Total: High to Low</option>
            <option value="total_asc" data-i18n="admin.sort_total_asc">Total: Low to High</option>
          </select>
        </div>
      </div>
      <div class="toolbar__right">
        <span id="bookingsResultsCount" style="font-size:.85rem; color:var(--slate-500);"></span>
        <button class="btn btn--ghost btn--sm" id="printBookingsBtn">{icon('printer',15)}<span data-i18n="admin.print">Print</span></button>
        <button class="btn btn--outline-dark btn--sm" id="exportBookingsBtn">{icon('download',15)}<span data-i18n="admin.export_csv">Export CSV</span></button>
      </div>
    </div>

    <div class="data-table-wrap">
      <table class="data-table">
        <thead>
          <tr>
            <th data-i18n="admin.reservation">Reservation</th><th data-i18n="admin.customer">Customer</th><th data-i18n="confirm.tour">Tour</th><th data-i18n="admin.date">Date</th><th data-i18n="admin.guests">Guests</th><th data-i18n="admin.total">Total</th><th data-i18n="admin.status">Status</th><th data-i18n="admin.actions">Actions</th>
          </tr>
        </thead>
        <tbody id="bookingsTableBody"></tbody>
      </table>
    </div>
    <div class="pagination" id="bookingsPagination"></div>
  </div>
</div>
{modal}
{ap.shell_close(extra_scripts=["admin-reservations"])}
'''
    with open(os.path.join(OUT, "reservations.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  admin/reservations.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
