import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
import admin_parts as ap
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "admin")


def build():
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {ap.admin_head("Raporlar", slug="reports")}
</head>
{ap.shell_open("reports", "Reports", "admin.reports")}
<div id="adminReportsApp">
  <div class="panel" style="margin-bottom:24px;">
    <div class="toolbar">
      <div class="toolbar__left">
        <button class="filter-chip is-active" data-range="7" data-i18n="admin.last_7_days">Last 7 Days</button>
        <button class="filter-chip" data-range="30" data-i18n="admin.last_30_days">Last 30 Days</button>
        <button class="filter-chip" data-range="90" data-i18n="admin.last_90_days">Last 90 Days</button>
        <button class="filter-chip" data-range="365" data-i18n="admin.this_year">This Year</button>
      </div>
      <div class="toolbar__right">
        <input class="input" type="date" id="reportFrom" style="width:150px;">
        <span style="color:var(--slate-400);">&ndash;</span>
        <input class="input" type="date" id="reportTo" style="width:150px;">
        <button class="btn btn--ghost btn--sm" id="generateReportBtn">{icon('bar-chart',15)}<span data-i18n="admin.generate">Generate</span></button>
        <button class="btn btn--outline-dark btn--sm" id="exportReportBtn">{icon('download',15)}<span data-i18n="admin.export_csv">Export CSV</span></button>
      </div>
    </div>
  </div>

  <div class="admin-grid-stats">
    <div class="panel stat-card"><div><div class="stat-card__label" data-i18n="admin.bookings_count">Bookings</div><div class="stat-card__value" id="reportBookingsCount">0</div></div><span class="stat-card__icon" style="background:var(--teal-100); color:var(--teal-700);">{icon('clipboard-check',22)}</span></div>
    <div class="panel stat-card"><div><div class="stat-card__label" data-i18n="admin.revenue">Revenue</div><div class="stat-card__value" id="reportRevenue">\u20AC0</div></div><span class="stat-card__icon" style="background:var(--gold-100); color:var(--gold-600);">{icon('credit-card',22)}</span></div>
    <div class="panel stat-card"><div><div class="stat-card__label" data-i18n="admin.total_guests">Total Guests</div><div class="stat-card__value" id="reportGuests">0</div></div><span class="stat-card__icon" style="background:var(--success-100); color:var(--success-700);">{icon('users',22)}</span></div>
    <div class="panel stat-card"><div><div class="stat-card__label" data-i18n="admin.status_cancelled">Cancelled</div><div class="stat-card__value" id="reportCancelled">0</div></div><span class="stat-card__icon" style="background:var(--danger-100); color:var(--danger-700);">{icon('x',22)}</span></div>
  </div>

  <div class="admin-grid-main">
    <div class="panel">
      <div class="panel__head"><h3 data-i18n="admin.bookings_by_tour">Bookings by Tour</h3></div>
      <div class="data-table-wrap">
        <table class="data-table">
          <thead><tr><th data-i18n="confirm.tour">Tour</th><th data-i18n="admin.bookings_count">Bookings</th><th data-i18n="admin.share">Share</th></tr></thead>
          <tbody id="reportTourBreakdown"></tbody>
        </table>
      </div>
    </div>
    <div class="panel">
      <div class="panel__head"><h3 data-i18n="admin.bookings_by_country">Bookings by Country</h3></div>
      <ul class="legend-list" id="reportCountryBreakdown"></ul>
    </div>
  </div>
</div>
{ap.shell_close(extra_scripts=["admin-reports"])}
'''
    with open(os.path.join(OUT, "reports.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  admin/reports.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
