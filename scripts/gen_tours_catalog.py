import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon
from helpers import load_all_tours

TOURS = load_all_tours()
OUT = os.path.join(os.path.dirname(__file__), "..", "site")

CATEGORIES = [
    ("all", "All Tours", "section.all_tours"),
    ("island", "Island Tours", "category.island_tours"),
    ("water", "Water Activities", "category.water_activities"),
    ("land", "Land Adventure", "category.land"),
    ("wellness", "Wellness", "category.wellness"),
    ("transfer", "Transfers", "nav.transfers"),
]


def build():
    cards = "\n      ".join(cp.tour_card(t, rel="") for t in TOURS)
    chips = "\n          ".join(
        f'<button class="filter-chip{" is-active" if key=="all" else ""}" data-filter-category="{key}" data-i18n="{i18n_key}">{label}</button>'
        for key, label, i18n_key in CATEGORIES
    )

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title="Bodrum'daki Tüm Turlar ve Aktiviteler | MT Travel",
      description="Bodrum'daki 19 turun tamamına göz atın: Yunan adası günübirlik turları, tekne turları, Pamukkale, Efes, jeep safari ve transferler.",
      canonical_path="tours.html"
  )}
</head>
<body>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>
  {cp.topbar()}
  {cp.header(active="tours")}

  <main id="mainContent">
    {cp.page_banner("", "Tüm Turlar", "Sunduğumuz her deneyim tek bir yerde - ada kaçamakları, antik kalıntılar, su sporları ve transferler.", [("Turlar", None, "nav.tours")], title_key="section.all_tours", subtitle_key="tours_catalog.subtitle")}

    <section class="section">
      <div class="container">
        <div class="catalog-toolbar">
          <div class="filter-chips" id="categoryChips">
          {chips}
          </div>
          <div class="catalog-sort">
            <label for="sortSelect" data-i18n="catalog.sort_label">Sırala</label>
            <div class="select-wrap">
              <select class="filter-select" id="sortSelect">
                <option value="popular" data-i18n="catalog.sort_popular">En Popüler</option>
                <option value="price_asc" data-i18n="catalog.sort_price_asc">Fiyat: Düşükten Yükseğe</option>
                <option value="price_desc" data-i18n="catalog.sort_price_desc">Fiyat: Yüksekten Düşüğe</option>
                <option value="rating" data-i18n="catalog.sort_rating">En Yüksek Puanlı</option>
              </select>
            </div>
          </div>
        </div>
        <p class="results-count" id="resultsCount"><span id="resultsCountNumber">{len(TOURS)}</span> <span data-i18n="catalog.tours_found">tur bulundu</span></p>
        <div class="grid-3" id="toursGridCatalog">
      {cards}
        </div>
        <div class="empty-state" id="catalogEmptyState" style="display:none;">
          {icon('search', 48)}
          <h4 data-i18n="common.no_results">No results found.</h4>
        </div>
      </div>
    </section>
  </main>

  {cp.footer()}
  {cp.scripts()}
  <script>
    (function() {{
      var chips = document.querySelectorAll('[data-filter-category]');
      var cards = Array.from(document.querySelectorAll('#toursGridCatalog > [data-tour-slug]'));
      var countEl = document.getElementById('resultsCount');
      var emptyState = document.getElementById('catalogEmptyState');
      var sortSelect = document.getElementById('sortSelect');
      var grid = document.getElementById('toursGridCatalog');

      function applyFilter(cat) {{
        var visible = 0;
        cards.forEach(function(card) {{
          var match = cat === 'all' || card.dataset.category === cat ||
            (cat === 'island' && card.dataset.category === 'island') ||
            (cat === 'private' && card.dataset.category === 'private');
          card.style.display = match ? '' : 'none';
          if (match) visible++;
        }});
        // Only the number updates here - the "tours found" label next to it
        // was already translated into the page's language when the server
        // rendered this page (data-i18n="catalog.tours_found"), so leaving
        // that span alone keeps it in that language. Rebuilding the whole
        // string in JS (the old code) always wrote it in English, no
        // matter what language was selected.
        var numberEl = document.getElementById('resultsCountNumber');
        if (numberEl) numberEl.textContent = visible;
        if (emptyState) emptyState.style.display = visible === 0 ? 'block' : 'none';
      }}

      chips.forEach(function(chip) {{
        chip.addEventListener('click', function() {{
          chips.forEach(function(c) {{ c.classList.remove('is-active'); }});
          chip.classList.add('is-active');
          applyFilter(chip.dataset.filterCategory);
          var url = new URL(window.location);
          if (chip.dataset.filterCategory === 'all') url.searchParams.delete('category');
          else url.searchParams.set('category', chip.dataset.filterCategory);
          window.history.replaceState(null, '', url);
        }});
      }});

      sortSelect && sortSelect.addEventListener('change', function() {{
        var sorted = cards.slice().sort(function(a, b) {{
          var pa = parseFloat(a.querySelector('[data-price-eur]').dataset.priceEur);
          var pb = parseFloat(b.querySelector('[data-price-eur]').dataset.priceEur);
          if (sortSelect.value === 'price_asc') return pa - pb;
          if (sortSelect.value === 'price_desc') return pb - pa;
          return 0;
        }});
        sorted.forEach(function(card) {{ grid.appendChild(card); }});
      }});

      var params = new URLSearchParams(window.location.search);
      var initialCat = params.get('category') || 'all';
      var matchChip = document.querySelector('[data-filter-category="' + initialCat + '"]');
      if (matchChip) {{
        chips.forEach(function(c) {{ c.classList.remove('is-active'); }});
        matchChip.classList.add('is-active');
      }}
      applyFilter(initialCat);
    }})();
  </script>
</body>
</html>'''

    with open(os.path.join(OUT, "tours.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  tours.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
