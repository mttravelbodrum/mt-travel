import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
import admin_parts as ap
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "admin")


def build():
    delete_modal = f'''<div class="modal-overlay" id="deleteConfirmModal">
    <div class="modal-box" style="max-width:400px; text-align:center;">
      <div style="width:52px; height:52px; border-radius:50%; background:var(--danger-100); color:var(--danger-600); display:flex; align-items:center; justify-content:center; margin:0 auto 16px;">
        {icon('alert-triangle', 24)}
      </div>
      <h3 data-i18n="admin.delete_customer_confirm_title">Are you sure you want to delete this customer?</h3>
      <p style="color:var(--slate-500); font-size:.88rem; margin-bottom:24px;" data-i18n="admin.delete_customer_note">This will permanently delete all of their reservations. This action cannot be undone.</p>
      <div style="display:flex; gap:10px; justify-content:center;">
        <button type="button" class="btn btn--ghost" data-delete-cancel data-i18n="admin.cancel">Cancel</button>
        <button type="button" class="btn btn--danger" data-delete-confirm data-i18n="admin.delete">Delete</button>
      </div>
    </div>
  </div>'''

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {ap.admin_head("Müşteriler", slug="customers")}
</head>
{ap.shell_open("customers", "Customers", "admin.customers")}
<div id="adminCustomersApp">
  <div class="panel">
    <div class="toolbar">
      <div class="toolbar__left">
        <div class="search-box">
          {icon('search', 16)}
          <input type="text" id="customersSearch" placeholder="Search by name, email or country..." data-i18n-placeholder="admin.search_customers_placeholder">
        </div>
      </div>
      <div class="toolbar__right">
        <span id="customersResultsCount" style="font-size:.85rem; color:var(--slate-500);"></span>
      </div>
    </div>
    <div class="data-table-wrap">
      <table class="data-table">
        <thead><tr><th data-i18n="admin.customer">Customer</th><th data-i18n="admin.contact">Contact</th><th data-i18n="admin.bookings_count">Bookings</th><th data-i18n="admin.total_spent">Total Spent</th><th data-i18n="admin.last_booking">Last Booking</th><th data-i18n="admin.actions">Actions</th></tr></thead>
        <tbody id="customersTableBody"></tbody>
      </table>
    </div>
    <div class="pagination" id="customersPagination"></div>
  </div>
</div>
{delete_modal}
{ap.shell_close(extra_scripts=["admin-customers"])}
'''
    with open(os.path.join(OUT, "customers.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  admin/customers.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
