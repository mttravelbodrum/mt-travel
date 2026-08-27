/* ==========================================================================
   admin-media.js — media.html (admin)
   Sadece görüntüleme. Her turun gerçek görsellerini kendi klasöründen
   listeler. Yeniden adlandırma/silme/yükleme işlemleri BURADA YOKTUR:
   bunlar gerçek dosya sistemi erişimi gerektiren backend işlemleridir ve
   var olmayan bir işlemi başarılıymış gibi göstermek yerine, görseller
   şu an olduğu gibi - doğrudan assets/images/ klasörlerine dosya
   kopyalayarak - yönetiliyor (bkz. backend/README.md).
   ========================================================================== */

(function () {
  "use strict";
  const { qs, qsa, currentLang } = MTUtils;

  let activeFolder = "all";

  function init() {
    if (!qs("#adminMediaApp")) return;
    if (typeof MT_TOURS === "undefined") return;
    renderFolderTabs();
    render();
  }

  function renderFolderTabs() {
    const wrap = qs("#mediaFolderTabs");
    if (!wrap) return;
    const folders = [{ folder: "all", label: mtT("admin.all_folders") }].concat(
      MT_TOURS.map((t) => ({ folder: t.folder, label: t.name[currentLang()] || t.name.en, count: t.image_count }))
    );
    wrap.innerHTML = folders.map((f) => `<button class="filter-chip${f.folder === activeFolder ? " is-active" : ""}" data-folder="${f.folder}">${MTUtils.escapeHtml(f.label)} (${f.count === undefined ? MT_TOURS.reduce((s,t)=>s+t.image_count,0) : f.count})</button>`).join("");
    qsa("[data-folder]", wrap).forEach((btn) => btn.addEventListener("click", () => {
      activeFolder = btn.dataset.folder;
      renderFolderTabs();
      render();
    }));
  }

  function render() {
    const grid = qs("#mediaGrid");
    if (!grid) return;
    const tours = activeFolder === "all" ? MT_TOURS : MT_TOURS.filter((t) => t.folder === activeFolder);
    let tiles = [];
    tours.forEach((t) => {
      const n = activeFolder === "all" ? Math.min(4, t.image_count) : t.image_count;
      for (let i = 1; i <= n; i++) {
        tiles.push({ src: `../assets/images/${t.folder}/${t.image_prefix}_${String(i).padStart(2, "0")}.jpg`, name: `${t.image_prefix}_${String(i).padStart(2, "0")}.jpg` });
      }
    });
    const countEl = qs("#mediaResultsCount");
    if (countEl) countEl.textContent = `${tiles.length} ${mtT("admin.images_count_label")}`;
    if (!tiles.length) {
      grid.innerHTML = `<div class="empty-state"><h4>${mtT("tour.photos_pending_short")}</h4></div>`;
      return;
    }
    grid.innerHTML = tiles.map((tile) => `
      <div class="media-tile" data-media-name="${tile.name}">
        <img src="${tile.src}" alt="${tile.name}" loading="lazy">
        <div class="media-tile__overlay">
          <button type="button" data-media-action="preview" title="${mtT('admin.preview')}">${icon("eye")}</button>
        </div>
        <div class="media-tile__name">${tile.name}</div>
      </div>
    `).join("");
    bindTileActions();
  }

  function icon(name) {
    const paths = {
      eye: '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8Z"/><circle cx="12" cy="12" r="3"/>',
    };
    return `<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">${paths[name]}</svg>`;
  }

  function bindTileActions() {
    qsa("[data-media-action]").forEach((btn) => {
      btn.addEventListener("click", () => {
        const tile = btn.closest(".media-tile");
        window.open(qs("img", tile).src, "_blank");
      });
    });
  }

  document.addEventListener("DOMContentLoaded", () => setTimeout(init, 0));
})();
