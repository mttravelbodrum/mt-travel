import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
import admin_parts as ap
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "admin")


def stat_card(icon_name, bg, color, label_key, label_default, value_id):
    return f'''<div class="panel stat-card" data-reveal>
      <div>
        <div class="stat-card__label" data-i18n="{label_key}">{label_default}</div>
        <div class="stat-card__value" id="{value_id}">0</div>
      </div>
      <span class="stat-card__icon" style="background:{bg}; color:{color};">{icon(icon_name, 22)}</span>
    </div>'''


def quick_action(icon_name, label_key, label_default, href_js):
    return f'''<button type="button" class="quick-action" onclick="{href_js}">
        <span class="icon-circle">{icon(icon_name, 21)}</span>
        <strong data-i18n="{label_key}">{label_default}</strong>
      </button>'''


def build():
    stats_html = "\n      ".join([
        stat_card("clipboard-check", "var(--teal-100)", "var(--teal-700)", "admin.bookings", "Total Reservations", "statTotalBookings"),
        stat_card("credit-card", "var(--gold-100)", "var(--gold-600)", "payment.total", "Total Revenue", "statTotalRevenue"),
        stat_card("zap", "var(--success-100)", "var(--success-700)", "admin.today_reservations", "Today's Reservations", "statTodayBookings"),
        stat_card("users", "var(--slate-100)", "var(--slate-600)", "admin.customers", "Total Customers", "statTotalCustomers"),
    ])

    quick_actions = "\n      ".join([
        quick_action("clipboard-check", "admin.qa_view_reservations", "View Reservations", "location.href='reservations.html'"),
        quick_action("bar-chart", "admin.qa_generate_report", "Generate Report", "location.href='reports.html'"),
        quick_action("clipboard-check", "admin.qa_create_reservation", "Create Reservation", "location.href='../booking.html'"),
        quick_action("settings", "admin.settings", "Settings", "location.href='settings.html'"),
    ])

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {ap.admin_head("Panel", slug="dashboard")}
</head>
{ap.shell_open("dashboard", "Dashboard", "admin.dashboard")}
<div id="adminDashboardApp">

  <div class="admin-grid-stats">
  {stats_html}
  </div>

  <div class="panel" style="margin-bottom:24px;">
    <div class="panel__head"><h3 data-i18n="admin.quick_actions">Quick Actions</h3></div>
    <div class="quick-actions-grid">
    {quick_actions}
    </div>
  </div>

  <div class="admin-grid-main">
    <div class="panel">
      <div class="panel__head">
        <h3 data-i18n="admin.recent_reservations">Recent Reservations</h3>
        <a href="reservations.html" class="link-arrow"><span data-i18n="admin.view_all_reservations">View All Reservations</span> {icon('arrow-right',15)}</a>
      </div>
      <div id="recentBookingsList"></div>
    </div>

    <div>
      <div class="panel" style="margin-bottom:24px;">
        <div class="panel__head"><h3 data-i18n="admin.reservations_overview">Reservations Overview</h3></div>
        <svg id="bookingsLineChart" class="chart-svg"></svg>
      </div>
      <div class="panel">
        <div class="panel__head"><h3 data-i18n="admin.top_tours">Top Tours</h3></div>
        <div style="display:flex; align-items:center; gap:20px;">
          <svg id="topToursDonut" width="140" height="140" style="flex-shrink:0;"></svg>
          <ul class="legend-list" id="topToursLegend" style="flex:1; margin:0;"></ul>
        </div>
      </div>
    </div>
  </div>

  <div class="panel" style="margin-top:24px;">
    <div class="panel__head"><h3 data-i18n="admin.recent_activity">Recent Activity</h3></div>
    <div id="activityLogList"></div>
  </div>

</div>
{ap.shell_close(extra_scripts=["admin-dashboard"])}
'''
    with open(os.path.join(OUT, "dashboard.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  admin/dashboard.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
