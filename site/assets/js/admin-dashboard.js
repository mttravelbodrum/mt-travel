/* ==========================================================================
   admin-dashboard.js — dashboard.html (admin)
   BACKEND-ONLY. No demo data, no fake fallback numbers, no fake chart
   shapes when data is empty - empty means empty and is shown as such.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, formatCurrency, formatDate } = MTUtils;

  async function init() {
    if (!qs("#adminDashboardApp")) return;
    const ok = await MTAdmin.requireBackend("#adminDashboardApp");
    if (!ok) return;

    let bookings, tours, customers, activityLog, notifications;
    try {
      [bookings, tours, customers, activityLog, notifications] = await Promise.all([
        MTApi.getReservations({ perPage: 500 }).then((r) => r.results),
        MTApi.getTours(),
        MTApi.getCustomers(),
        MTApi.getActivityLog(),
        MTApi.getNotifications(),
      ]);
    } catch (err) {
      MTAdmin.renderBackendError("#adminDashboardApp", "backend_unreachable");
      return;
    }

    renderNewReservationBanner(notifications);
    renderStats(bookings, customers);
    renderRecentBookings(bookings);
    renderLineChart(bookings);
    renderTopTours(bookings, tours);
    renderActivityLog(activityLog);
  }

  // Requirement: "The Admin Dashboard displays: 'You have a new reservation.'"
  // whenever there's an unread notification.
  function renderNewReservationBanner(notifications) {
    const existing = qs("#newReservationBanner");
    if (existing) existing.remove();
    const unread = notifications.notifications.filter((n) => !n.read);
    if (!unread.length) return;
    const app = qs("#adminDashboardApp");
    if (!app) return;
    const banner = document.createElement("div");
    banner.id = "newReservationBanner";
    banner.className = "calendar-note";
    banner.style.cssText = "background:var(--teal-50); border:1px solid var(--teal-200); margin-bottom:20px; cursor:pointer;";
    const latest = unread[0];
    banner.innerHTML = `<svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M18 8a6 6 0 0 0-12 0c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.7 21a2 2 0 0 1-3.4 0"/></svg>
      <span>${mtT("admin.new_reservation_banner")} <strong>${MTUtils.escapeHtml(latest.customer)}</strong> ${mtT("admin.notif_booked")} ${MTUtils.escapeHtml(MTAdmin.localizedTourName(latest))} (${latest.reservationId}).</span>`;
    banner.addEventListener("click", async () => {
      try { await MTApi.markNotificationsRead(); } catch (e) { /* non-fatal */ }
      location.href = `reservations.html?search=${encodeURIComponent(latest.reservationId)}`;
    });
    app.insertBefore(banner, app.firstChild);
  }

  function isToday(dateStr) {
    return dateStr === new Date().toISOString().slice(0, 10);
  }

  function renderStats(bookings, customers) {
    const totalBookings = bookings.length;
    const totalRevenue = bookings.filter((b) => b.status !== "Cancelled").reduce((s, b) => s + b.total, 0);
    const todays = bookings.filter((b) => isToday(b.createdAt.slice(0, 10)) || isToday(b.date)).length;
    setText("#statTotalBookings", totalBookings.toLocaleString());
    setText("#statTotalRevenue", formatCurrency(totalRevenue));
    setText("#statTodayBookings", todays);
    setText("#statTotalCustomers", customers.length.toLocaleString());
  }

  function setText(sel, val) { const el = qs(sel); if (el) el.textContent = val; }

  function renderRecentBookings(bookings) {
    const wrap = qs("#recentBookingsList");
    if (!wrap) return;
    const recent = bookings.slice(0, 5);
    if (!recent.length) { wrap.innerHTML = `<div class="empty-state"><p>${mtT("admin.no_reservations_yet_dashboard")}</p></div>`; return; }
    wrap.innerHTML = recent.map((b) => `
      <div class="mini-booking-row">
        <div class="mini-booking-row__avatar">${initials(b.customer)}</div>
        <div class="mini-booking-row__info">
          <strong>${MTUtils.escapeHtml(b.customer)}</strong>
          <span>${MTUtils.escapeHtml(b.tourName.en || b.tourName)} &middot; ${formatDate(b.date)}</span>
        </div>
        <div class="mini-booking-row__price">${formatCurrency(b.total)}</div>
        <span class="status-pill status-pill--${b.status.toLowerCase()}">${MTAdmin.statusLabel(b.status)}</span>
      </div>
    `).join("");
  }

  function initials(name) {
    return name.split(" ").map((p) => p[0]).slice(0, 2).join("").toUpperCase();
  }

  function renderLineChart(bookings) {
    const svg = qs("#bookingsLineChart");
    if (!svg) return;
    const days = 7;
    const counts = [];
    for (let i = days - 1; i >= 0; i--) {
      const d = new Date(); d.setDate(d.getDate() - i);
      const iso = d.toISOString().slice(0, 10);
      counts.push(bookings.filter((b) => (b.createdAt || "").slice(0, 10) === iso).length);
    }
    // Real counts, always - including all zeros if there truly is no activity.
    MTAdmin.lineChart(svg, counts);
  }

  function renderTopTours(bookings, tours) {
    const svg = qs("#topToursDonut");
    const legend = qs("#topToursLegend");
    if (!svg || !legend) return;
    if (!bookings.length) {
      svg.innerHTML = "";
      legend.innerHTML = `<li style="color:var(--slate-400);">${mtT("admin.no_reservations_yet_short")}</li>`;
      return;
    }
    const counts = {};
    bookings.forEach((b) => { counts[b.slug] = (counts[b.slug] || 0) + 1; });
    let entries = Object.entries(counts).sort((a, b) => b[1] - a[1]);
    const colors = ["#14A99C", "#CE9B41", "#2C5170", "#D14343", "#64757F"];
    let top = entries.slice(0, 3);
    const othersTotal = entries.slice(3).reduce((s, e) => s + e[1], 0);
    if (othersTotal > 0) top.push(["others", othersTotal]);
    const tourMap = {};
    tours.forEach((t) => { tourMap[t.slug] = t.name; });
    const segments = top.map((([slug, count], i) => ({
      label: slug === "others" ? mtT("admin.others_label") : (tourMap[slug] || slug),
      value: count,
      color: colors[i % colors.length]
    })));
    MTAdmin.donutChart(svg, segments);
    legend.innerHTML = segments.map((s) => `
      <li>
        <span class="legend-dot" style="background:${s.color}"></span>
        <span class="legend-label">${MTUtils.escapeHtml(s.label)}<span class="sub">${s.value} ${mtT("admin.bookings_suffix")}</span></span>
        <strong>${Math.round((s.value / segments.reduce((a, b) => a + b.value, 0)) * 100)}%</strong>
      </li>
    `).join("");
  }

  function renderActivityLog(log) {
    const wrap = qs("#activityLogList");
    if (!wrap) return;
    if (!log.length) {
      wrap.innerHTML = `<div class="empty-state"><p>${mtT("admin.no_activity_yet")}</p></div>`;
      return;
    }
    wrap.innerHTML = log.slice(0, 8).map((entry) => `
      <div class="mini-booking-row">
        <div class="mini-booking-row__avatar" style="background:var(--sand-100); color:var(--teal-700);">${iconActivity()}</div>
        <div class="mini-booking-row__info">
          <strong>${MTUtils.escapeHtml(MTAdmin.translateActivityAction(entry.action))}${entry.reservationId ? " &middot; " + entry.reservationId : ""}</strong>
          <span>${MTUtils.escapeHtml(entry.customer || "")}${entry.tour ? " &middot; " + MTUtils.escapeHtml(MTAdmin.localizedTourName(entry)) : ""}</span>
        </div>
        <div class="mini-booking-row__price" style="color:var(--slate-400); font-weight:600; font-size:.78rem;">${MTAdmin.timeAgo(entry.at)}</div>
      </div>
    `).join("");
  }

  function iconActivity() {
    return '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="22 12 18 12 15 21 9 3 6 12 2 12"/></svg>';
  }

  document.addEventListener("DOMContentLoaded", () => setTimeout(init, 0));
})();
