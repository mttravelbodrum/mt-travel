/* ==========================================================================
   admin-reports.js — reports.html (admin)
   BACKEND-ONLY. Reservations are fetched once from the real backend, then
   filtered client-side by the selected date range.
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, formatCurrency, toast } = MTUtils;

  let allBookings = [];

  async function init() {
    if (!qs("#adminReportsApp")) return;
    const ok = await MTAdmin.requireBackend("#adminReportsApp");
    if (!ok) return;

    try {
      allBookings = (await MTApi.getReservations({ perPage: 500 })).results;
    } catch (err) {
      MTAdmin.renderBackendError("#adminReportsApp", "backend_unreachable");
      return;
    }

    const today = new Date().toISOString().slice(0, 10);
    // Matches the "Son 7 Gün" quick-range button, which is marked active
    // by default in the HTML - the loaded range has to agree with what
    // the highlighted button claims, or the two visibly contradict each
    // other the moment the page opens.
    const weekAgo = MTUtils.addDaysISO(today, -7);
    qs("#reportFrom").value = weekAgo;
    qs("#reportTo").value = today;
    bindQuickRanges();
    bindGenerate();
    generate(weekAgo, today);
  }

  function bindQuickRanges() {
    qsa("[data-range]").forEach((btn) => {
      btn.addEventListener("click", () => {
        qsa("[data-range]").forEach((b) => b.classList.remove("is-active"));
        btn.classList.add("is-active");
        const days = parseInt(btn.dataset.range, 10);
        const to = new Date().toISOString().slice(0, 10);
        const from = MTUtils.addDaysISO(to, -days);
        qs("#reportFrom").value = from;
        qs("#reportTo").value = to;
        generate(from, to);
      });
    });
  }

  function bindGenerate() {
    const btn = qs("#generateReportBtn");
    btn && btn.addEventListener("click", () => {
      generate(qs("#reportFrom").value, qs("#reportTo").value);
      toast(mtT("admin.toast_report_updated"), "success");
    });
    const exportBtn = qs("#exportReportBtn");
    exportBtn && exportBtn.addEventListener("click", () => exportCsv(qs("#reportFrom").value, qs("#reportTo").value));
  }

  function inRange(dateStr, from, to) {
    return dateStr >= from && dateStr <= to;
  }

  function generate(from, to) {
    const bookings = allBookings.filter((b) => inRange(b.date, from, to));
    const revenue = bookings.filter((b) => b.status !== "Cancelled").reduce((s, b) => s + b.total, 0);
    const guests = bookings.reduce((s, b) => s + b.adults + b.children, 0);
    const cancelled = bookings.filter((b) => b.status === "Cancelled").length;

    setText("#reportBookingsCount", bookings.length);
    setText("#reportRevenue", formatCurrency(revenue));
    setText("#reportGuests", guests);
    setText("#reportCancelled", cancelled);

    const byTour = {};
    bookings.forEach((b) => {
      const name = b.tourName.en || b.tourName;
      byTour[name] = (byTour[name] || 0) + 1;
    });
    const rows = Object.entries(byTour).sort((a, b) => b[1] - a[1]).slice(0, 8);
    const tbody = qs("#reportTourBreakdown");
    if (tbody) {
      tbody.innerHTML = rows.length ? rows.map(([name, count]) => `
        <tr><td>${MTUtils.escapeHtml(name)}</td><td>${count}</td><td>${Math.round((count / bookings.length) * 100) || 0}%</td></tr>
      `).join("") : `<tr><td colspan="3"><div class="empty-state"><p>${mtT("admin.no_reservations_in_range")}</p></div></td></tr>`;
    }

    const byCountry = {};
    bookings.forEach((b) => { byCountry[b.country || "other"] = (byCountry[b.country || "other"] || 0) + 1; });
    const countryWrap = qs("#reportCountryBreakdown");
    if (countryWrap) {
      const entries = Object.entries(byCountry).sort((a, b) => b[1] - a[1]).slice(0, 6);
      countryWrap.innerHTML = entries.map(([c, n]) => `
        <li><span class="legend-dot" style="background:var(--teal-500)"></span><span class="legend-label">${c.toUpperCase()}</span><strong>${n}</strong></li>
      `).join("") || `<li>${mtT("admin.no_data")}</li>`;
    }
  }

  function setText(sel, val) { const el = qs(sel); if (el) el.textContent = val; }

  function exportCsv(from, to) {
    const bookings = allBookings.filter((b) => inRange(b.date, from, to));
    const header = [mtT("admin.csv_date"), mtT("admin.csv_booking_id"), mtT("admin.csv_tour"), mtT("admin.csv_customer"), mtT("admin.csv_guests"), mtT("admin.csv_total"), mtT("admin.csv_status")];
    const rows = bookings.map((b) => [b.date, b.id, MTAdmin.localizedTourName({ slug: b.slug, tour: b.tourName.en || b.tourName }), b.customer, b.adults + b.children, b.total.toFixed(2), b.status]);
    const csv = [header, ...rows].map((r) => r.map((v) => `"${String(v).replace(/"/g, '""')}"`).join(",")).join("\n");
    const blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url; a.download = `mt-group-travel-report-${from}-to-${to}.csv`;
    document.body.appendChild(a); a.click(); document.body.removeChild(a);
    URL.revokeObjectURL(url);
    toast(mtT("admin.toast_exported_csv"), "success");
  }

  document.addEventListener("DOMContentLoaded", () => setTimeout(init, 0));
})();
