/* ==========================================================================
   api-client.js — çalışıyorsa /backend içindeki gerçek arka uçla konuşur;
   çalışmıyorsa (örn. site sadece diskten açıldığında veya arka uç henüz
   dağıtılmadığında) durumu net şekilde "kullanılamıyor" olarak bildirir.
   Başarısızlık durumunda ne yapılacağına çağıran taraf karar verir - her
   sayfa, arka uca ulaşılamadığında sahte veri göstermek yerine net bir
   hata durumu gösterir (bkz. admin-common.js requireBackend()).

   To point this at your deployed backend, change MT_API_BASE below (or
   set it before this script loads, e.g. from a small inline <script> in
   your HTML: <script>window.MT_API_BASE = 'https://api.yoursite.com/api';</script>).
   ========================================================================== */

const MT_API_BASE = window.MT_API_BASE || (window.location.hostname === "localhost" || window.location.hostname === "127.0.0.1" ? "http://localhost:4000/api" : "/api");
const MT_IS_FILE_PROTOCOL = window.location.protocol === "file:";

const MTApi = (function () {
  "use strict";

  let availability = null; // null = unknown, true/false = cached result
  let availabilityCheckedAt = 0;
  let lastFailureReason = null; // "file_protocol" | "unreachable" | null

  async function isAvailable() {
    const now = Date.now();
    if (availability !== null && now - availabilityCheckedAt < 15000) return availability;
    if (MT_IS_FILE_PROTOCOL) {
      // fetch() to a real HTTP server can never succeed from a file:// page -
      // this is a browser security restriction, not something retrying fixes.
      availability = false;
      lastFailureReason = "file_protocol";
      availabilityCheckedAt = now;
      return availability;
    }
    try {
      const res = await fetch(`${MT_API_BASE}/health`, { method: "GET", signal: AbortSignal.timeout(1500) });
      availability = res.ok;
      lastFailureReason = availability ? null : "unreachable";
    } catch (e) {
      availability = false;
      lastFailureReason = "unreachable";
    }
    availabilityCheckedAt = now;
    return availability;
  }

  function getLastFailureReason() {
    return lastFailureReason;
  }

  function authHeaders() {
    const token = MTUtils.getAdminToken();
    return token ? { Authorization: `Bearer ${token}` } : {};
  }

  async function request(method, path, body, auth) {
    const res = await fetch(`${MT_API_BASE}${path}`, {
      method,
      headers: { "Content-Type": "application/json", ...(auth ? authHeaders() : {}) },
      body: body ? JSON.stringify(body) : undefined,
      signal: AbortSignal.timeout(6000),
    });
    let data = null;
    try { data = await res.json(); } catch (e) { /* no body */ }
    if (!res.ok) {
      const err = new Error((data && data.error) || `Request failed (${res.status})`);
      err.status = res.status;
      throw err;
    }
    return data;
  }

  const base = {
    isAvailable,
    getLastFailureReason,
    // ---- Public ----
    createReservation: (payload) => request("POST", "/reservations", payload, false),
    submitContactForm: (payload) => request("POST", "/contact", payload, false),
    getTours: (params) => request("GET", `/tours${params ? "?" + new URLSearchParams(params) : ""}`, null, false),
    getHotels: () => request("GET", "/hotels", null, false),
    createHotel: (payload) => request("POST", "/hotels", payload, true),
    updateHotel: (id, payload) => request("PUT", `/hotels/${encodeURIComponent(id)}`, payload, true),
    deleteHotel: (id) => request("DELETE", `/hotels/${encodeURIComponent(id)}`, null, true),
    submitContact: (payload) => request("POST", "/contact", payload, false),
    // ---- Admin auth ----
    login: (email, password) => request("POST", "/auth/login", { email, password }, false),
    // ---- Admin (require a token from login()) ----
    getReservations: (params) => request("GET", `/reservations${params ? "?" + new URLSearchParams(params) : ""}`, null, true),
    updateReservation: (id, payload) => request("PATCH", `/reservations/${encodeURIComponent(id)}`, payload, true),
    emailReservationCustomer: (id, payload) => request("POST", `/reservations/${encodeURIComponent(id)}/email`, payload, true),
    deleteReservation: (id) => request("DELETE", `/reservations/${encodeURIComponent(id)}`, null, true),
    getStats: () => request("GET", "/stats", null, true),
    getActivityLog: () => request("GET", "/activity-log", null, true),
    getNotifications: () => request("GET", "/notifications", null, true),
    markNotificationsRead: () => request("PATCH", "/notifications/read-all", null, true),
    getCustomers: () => request("GET", "/customers", null, true),
    deleteCustomer: (email) => request("DELETE", `/customers/${encodeURIComponent(email)}`, null, true),
    getSettings: () => request("GET", "/settings", null, true),
    getCompanyInfo: () => request("GET", "/company-info", null, false),
    updateSettings: (payload) => request("PUT", "/settings", payload, true),
    createTour: (payload) => request("POST", "/tours", payload, true),
    updateTour: (slug, payload) => request("PUT", `/tours/${encodeURIComponent(slug)}`, payload, true),
    deleteTour: (slug) => request("DELETE", `/tours/${encodeURIComponent(slug)}`, null, true),
    getTourBySlug: (slug) => request("GET", `/tours/${encodeURIComponent(slug)}`, null, false),
  };

  // ---- Shape normalization ----
  // The backend's tour records use a single `price` field (see backend/db
  // schema - the online-discount concept was removed sitewide). The admin
  // UI historically reads `priceRegular`/`priceOnline`; rather than touch
  // every call site, alias both onto whatever the backend returns.
  function normalizeTour(t) {
    return { ...t, priceRegular: t.price, priceOnline: t.price };
  }
  const _getTours = base.getTours;
  base.getTours = async (params) => (await _getTours(params)).map(normalizeTour);
  const _createTour = base.createTour;
  base.createTour = async (payload) => normalizeTour(await _createTour({ ...payload, price: payload.priceOnline ?? payload.price }));
  const _updateTour = base.updateTour;
  base.updateTour = async (slug, payload) => normalizeTour(await _updateTour(slug, { ...payload, price: payload.priceOnline ?? payload.price }));
  const _getTourBySlug = base.getTourBySlug;
  base.getTourBySlug = async (slug) => normalizeTour(await _getTourBySlug(slug));

  return base;
})();
