import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
import admin_parts as ap
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "admin")


def build():
    form_modal = f'''<div class="modal-overlay" id="hotelFormModal">
    <div class="modal-box" style="position:relative; max-width:440px;">
      <button class="modal-close" data-modal-close type="button" aria-label="Close">{icon('x', 18)}</button>
      <h3 id="hotelFormTitle" style="margin-bottom:20px;" data-i18n="admin.add_hotel">Add Hotel</h3>
      <form id="hotelForm">
        <input type="hidden" id="hotelFormId">
        <div class="field">
          <label class="field-label" for="hotelFormName" data-i18n="admin.hotel_name">Hotel Name</label>
          <input class="input" id="hotelFormName" required autocomplete="off">
        </div>
        <div id="hotelFormErrorBox" class="field-error" style="display:none; margin-top:4px;">{icon('alert-triangle', 14)}<span></span></div>
        <div style="display:flex; gap:10px; justify-content:flex-end; margin-top:22px;">
          <button type="button" class="btn btn--ghost" data-modal-close data-i18n="admin.cancel">Cancel</button>
          <button type="submit" class="btn btn--primary" data-i18n="admin.save">Save</button>
        </div>
      </form>
    </div>
  </div>'''

    delete_modal = f'''<div class="modal-overlay" id="hotelDeleteModal">
    <div class="modal-box" style="max-width:400px; text-align:center;">
      <div style="width:52px; height:52px; border-radius:50%; background:var(--danger-100); color:var(--danger-600); display:flex; align-items:center; justify-content:center; margin:0 auto 16px;">
        {icon('alert-triangle', 24)}
      </div>
      <h3 data-i18n="admin.delete_hotel_title">Delete this hotel?</h3>
      <p style="color:var(--slate-500); font-size:.88rem; margin-bottom:24px;" data-i18n="admin.delete_hotel_body">This hotel will no longer appear in the booking page's hotel list. This can't be undone.</p>
      <div style="display:flex; gap:10px; justify-content:center;">
        <button type="button" class="btn btn--ghost" data-delete-cancel data-i18n="admin.cancel">Cancel</button>
        <button type="button" class="btn btn--danger" data-delete-confirm data-i18n="admin.delete">Delete</button>
      </div>
    </div>
  </div>'''

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {ap.admin_head("Otel Yönetimi", slug="hotels")}
</head>
{ap.shell_open("hotels", "Hotel Management", "admin.hotels_title")}
<div id="adminHotelsApp">
  <div class="panel" style="margin-bottom:20px;">
    <div class="calendar-note" style="margin:0;">
      {icon('info', 17)}<span data-i18n="admin.hotels_note">Hotels added here appear instantly in the searchable "Hotel Name" field on the booking page. Guests can still type a hotel that isn't on this list.</span>
    </div>
  </div>

  <div class="panel">
    <div style="display:flex; justify-content:space-between; align-items:center; gap:16px; margin-bottom:18px; flex-wrap:wrap;">
      <div class="search-box" style="max-width:320px; flex:1;">
        {icon('search', 16)}
        <input data-i18n-placeholder="admin.search_hotels_placeholder" id="hotelsSearch" placeholder="Otel ara..." type="text">
      </div>
      <button class="btn btn--primary" id="addHotelBtn" type="button">{icon('plus', 16)}<span data-i18n="admin.add_hotel">Add Hotel</span></button>
    </div>

    <div id="hotelsListWrap">
      <div class="data-table-wrap">
      <table class="data-table">
        <thead>
          <tr>
            <th data-i18n="admin.hotel_name">Hotel Name</th>
            <th data-i18n="admin.date_added">Date Added</th>
            <th style="width:110px;"></th>
          </tr>
        </thead>
        <tbody id="hotelsTableBody"></tbody>
      </table>
      </div>
      <div id="hotelsEmptyState" style="display:none; text-align:center; padding:40px 20px; color:var(--slate-500);">
        <span data-i18n="admin.no_hotels_found">No hotels found.</span>
      </div>
    </div>
  </div>
</div>

{form_modal}
{delete_modal}
{ap.shell_close(extra_scripts=["admin-hotels"])}
'''
    with open(os.path.join(OUT, "hotels.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print("  wrote admin/hotels.html")


if __name__ == "__main__":
    build()
