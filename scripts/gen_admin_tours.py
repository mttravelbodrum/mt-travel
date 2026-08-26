import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
import admin_parts as ap
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "admin")


def build():
    cat_options = '''<option value="island" data-i18n="category.island">Island</option>
                <option value="water" data-i18n="category.water">Water Activities</option>
                <option value="land" data-i18n="category.land">Land Adventure</option>
                <option value="wellness" data-i18n="category.wellness">Wellness</option>
                <option value="transfer" data-i18n="category.transfer">Transfer</option>
                <option value="private" data-i18n="category.private">Private</option>'''

    modal = f'''<div class="modal-overlay" id="tourFormModal">
    <div class="modal-box" style="position:relative;">
      <button class="modal-close" data-modal-close type="button" aria-label="Close">{icon('x', 18)}</button>
      <h3 id="tourFormTitle" style="margin-bottom:20px;" data-i18n="admin.edit_tour">Edit Tour</h3>
      <form id="tourForm">
        <input type="hidden" id="tourFormSlug">
        <div class="field">
          <label class="field-label" for="tourFormName" data-i18n="admin.tour_name">Tour Name</label>
          <input class="input" id="tourFormName" required>
        </div>
        <div class="field-row">
          <div class="field">
            <label class="field-label" for="tourFormCategory" data-i18n="admin.category">Category</label>
            <div class="select-wrap">
              <select class="select" id="tourFormCategory">
                {cat_options}
              </select>
              {icon('chevron-down',16)}
            </div>
          </div>
          <div class="field-row">
            <div class="field">
              <label class="field-label" for="tourFormDepartureTime" data-i18n="admin.departure_time">Departure Time</label>
              <input class="input" id="tourFormDepartureTime" type="time">
            </div>
            <div class="field">
              <label class="field-label" for="tourFormReturnTime" data-i18n="admin.return_time">Return Time</label>
              <input class="input" id="tourFormReturnTime" type="time">
            </div>
          </div>
        </div>
        <div id="tourFormStandardPricing">
          <div class="field-row">
            <div class="field">
              <label class="field-label" for="tourFormPriceAdult" data-i18n="admin.price_adult">Adult Price (&euro;)</label>
              <input class="input" id="tourFormPriceAdult" type="number" step="0.01" min="0">
            </div>
            <div class="field">
              <label class="field-label" for="tourFormPriceChild" data-i18n="admin.price_child">Child Price (&euro;)</label>
              <input class="input" id="tourFormPriceChild" type="number" step="0.01" min="0">
            </div>
          </div>
          <div class="field">
            <label class="field-label" for="tourFormPriceInfant" data-i18n="admin.price_infant">Infant Price (&euro;)</label>
            <input class="input" id="tourFormPriceInfant" type="number" step="0.01" min="0">
          </div>
        </div>
        <div id="tourFormAtvPricing" style="display:none;">
          <div class="field-row">
            <div class="field">
              <label class="field-label" for="tourFormPriceSingle" data-i18n="admin.price_single">Single Price (&euro;)</label>
              <input class="input" id="tourFormPriceSingle" type="number" step="0.01" min="0">
            </div>
            <div class="field">
              <label class="field-label" for="tourFormPriceDouble" data-i18n="admin.price_double">Double Price (&euro;)</label>
              <input class="input" id="tourFormPriceDouble" type="number" step="0.01" min="0">
            </div>
          </div>
          <p style="color:var(--slate-500); font-size:.8rem; margin:-8px 0 16px;" data-i18n="admin.atv_pricing_note">This tour uses single/double vehicle pricing instead of adult/child/infant.</p>
        </div>
        <div class="checkbox-row" style="margin-bottom:20px;">
          <input type="checkbox" id="tourFormIsland">
          <label for="tourFormIsland" data-i18n="admin.island_tour_note">Requires 1-day advance booking</label>
        </div>
        <div class="field" style="margin-bottom:24px;">
          <label class="field-label" data-i18n="admin.available_days">Available Days</label>
          <p style="font-size:.8rem; color:var(--slate-500); margin-bottom:10px;" data-i18n="admin.available_days_note">Customers can only book this tour on the days checked below.</p>
          <div class="day-toggle-grid">
            <label class="day-toggle"><input type="checkbox" name="tourFormDay" value="monday" checked><span data-i18n="admin.day_mon">Mon</span></label>
            <label class="day-toggle"><input type="checkbox" name="tourFormDay" value="tuesday" checked><span data-i18n="admin.day_tue">Tue</span></label>
            <label class="day-toggle"><input type="checkbox" name="tourFormDay" value="wednesday" checked><span data-i18n="admin.day_wed">Wed</span></label>
            <label class="day-toggle"><input type="checkbox" name="tourFormDay" value="thursday" checked><span data-i18n="admin.day_thu">Thu</span></label>
            <label class="day-toggle"><input type="checkbox" name="tourFormDay" value="friday" checked><span data-i18n="admin.day_fri">Fri</span></label>
            <label class="day-toggle"><input type="checkbox" name="tourFormDay" value="saturday" checked><span data-i18n="admin.day_sat">Sat</span></label>
            <label class="day-toggle"><input type="checkbox" name="tourFormDay" value="sunday" checked><span data-i18n="admin.day_sun">Sun</span></label>
          </div>
        </div>
        <button type="submit" class="btn btn--primary btn--block" data-i18n="admin.save_tour">Save Tour</button>
      </form>
    </div>
  </div>'''

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {ap.admin_head("Turlar", slug="tours")}
</head>
{ap.shell_open("tours", "Tours", "admin.tours")}
<div id="adminToursApp">
  <div class="toolbar">
    <div class="toolbar__left">
      <div class="search-box">
        {icon('search', 16)}
        <input type="text" id="toursSearch" placeholder="Search tours..." data-i18n-placeholder="admin.search_tours_placeholder">
      </div>
      <div class="select-wrap">
        <select class="filter-select" id="toursCategoryFilter">
          <option value="all" data-i18n="admin.all_categories">All Categories</option>
          {cat_options}
        </select>
      </div>
    </div>
    <div class="toolbar__right">
      <span id="toursResultsCount" style="font-size:.85rem; color:var(--slate-500);"></span>
    </div>
  </div>
  <div class="grid-4" id="toursGrid"></div>
</div>
{modal}
{ap.shell_close(extra_scripts=["admin-tours"])}
'''
    with open(os.path.join(OUT, "tours.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  admin/tours.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
