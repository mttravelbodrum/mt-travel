import sys, os, json
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon
from helpers import load_all_tours, FOLDER_PREFIX

TOURS = load_all_tours()
TOURS_BY_SLUG = {t["slug"]: t for t in TOURS}
OUT = os.path.join(os.path.dirname(__file__), "..", "site", "tours")
os.makedirs(OUT, exist_ok=True)

FACT_ICONS = {
    "duration": "clock", "departure": "compass", "hotel_pickup": "map-pin", "live_guide": "headset"
}


def facts_grid(t, d):
    facts = [
        ("clock", "admin.departure_time", "Departure Time", t.get("departureTime", "08:00"), None, "departure_time"),
        ("compass", "admin.return_time", "Return Time", t.get("returnTime", "17:00"), None, "return_time"),
        ("map-pin", "tour.hotel_pickup", "Hotel Pick Up", "Dahil", "tour.included_value", None),
        ("headset", "tour.live_guide", "Live Guide", "İngilizce", "tour.english_value", None),
    ]
    items = []
    for icon_name, key, default, val, val_key, field_name in facts:
        val_attr = f' data-i18n="{val_key}"' if val_key else ""
        if field_name:
            val_attr += f' data-tour-field="{field_name}"'
            if field_name in ("departure_time", "return_time"):
                val_attr += ' class="is-syncing" data-tour-live-field'
        items.append(f'''<div class="tour-fact">
          <span class="tour-fact__icon">{icon(icon_name, 19)}</span>
          <div><strong{val_attr}>{val}</strong><span data-i18n="{key}">{default}</span></div>
        </div>''')
    return "\n          ".join(items)


def check_list(items, icon_name):
    lis = "\n          ".join(
        f'<li>{icon(icon_name, 18)}<span>{it}</span></li>' for it in items
    )
    return lis


def program_list(program):
    lis = []
    dep_idx, ret_idx = -1, -1
    for i, step in enumerate(program):
        # These two specific steps are the same "Departure Time" / "Return
        # Time" the admin sets on the tour - reusing the exact attribute
        # main.js already watches (see the tour detail header a few lines
        # up) means the existing live-sync loop picks these up too, with
        # no further JS change needed for the initial render. Every other
        # step is untouched. Matched by title text here (Turkish - this is
        # always the "tr" data), but language.js re-renders this list on
        # every page load from that language's own JSON, so the index
        # computed here also gets passed through so that re-render can
        # find the right step regardless of which language is showing.
        title = step.get("title", "")
        field_attr = ""
        if title == "Feribotla Hareket":
            field_attr = ' data-tour-field="departure_time"'
            dep_idx = i
        elif title == "Dönüş Yolculuğu":
            field_attr = ' data-tour-field="return_time"'
            ret_idx = i
        lis.append(f'''<li>
          <span class="program-time"{field_attr}>{step['time']}</span>
          <h5>{step['title']}</h5>
          <p>{step['text']}</p>
        </li>''')
    return "\n        ".join(lis), dep_idx, ret_idx


def related_tours_html(t):
    related_slugs = t.get("related", [])[:3]
    related = [TOURS_BY_SLUG[s] for s in related_slugs if s in TOURS_BY_SLUG]
    return "\n      ".join(f'<div>{cp.tour_card(rt, rel="../")}</div>' for rt in related)


def build_one(t):
    slug = t["slug"]
    d = t["i18n"]["tr"]
    PROGRAM_HTML, _dep_idx, _ret_idx = program_list(d['program'])
    PROGRAM_STEP_ATTRS = (
        (f' data-departure-step="{_dep_idx}"' if _dep_idx >= 0 else "") +
        (f' data-return-step="{_ret_idx}"' if _ret_idx >= 0 else "")
    )
    prefix = FOLDER_PREFIX[slug]
    folder = f"{prefix}_images"
    badge_map = {"best_seller": ("BEST SELLER", "badge--dark"), "popular": ("POPULAR", "badge--teal"), "new": ("NEW", "badge--gold")}
    badge_html = ""
    if t["badge"] in badge_map:
        label, cls = badge_map[t["badge"]]
        badge_html = f'<span class="badge {cls} tour-hero__badge">{label}</span>'

    # Full content for all 5 languages embedded for client-side language
    # switching (see language.js applyTourDetail)
    embed_data = {}
    for lang_code in ("en", "tr", "de", "ru", "pl"):
        ld = t["i18n"][lang_code]
        embed_data[lang_code] = {
            "location": ld["location"], "duration": ld["duration"], "departure": ld["departure"],
            "return_time": ld["return_time"], "meeting_point": ld["meeting_point"],
            "description": ld["description"], "highlights": ld["highlights"],
            "included": ld["included"], "excluded": ld["excluded"],
            "program": ld["program"],
        }
    embed_json = json.dumps(embed_data, ensure_ascii=False)

    map_query = d["location"].replace(" ", "+")

    schema = {
        "@context": "https://schema.org",
        "@type": "TouristTrip",
        "name": d["name"],
        "description": d["description"][0],
        "touristType": "Leisure",
        "offers": {"@type": "Offer", "price": t["price_online"], "priceCurrency": "EUR"}
    }

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title=f"{d['name']} | MT Travel Bodrum",
      description=d['short'],
      rel="../",
      canonical_path=f"tours/{slug}.html",
      og_image=f"../assets/images/{folder}/{prefix}_01.jpg"
  )}
  {cp.breadcrumb_schema("../", [("Turlar", "tours.html"), (d['name'], None)])}
  <script type="application/ld+json">{json.dumps(schema, ensure_ascii=False)}</script>
</head>
<body data-page-tour-slug="{t['slug']}">
  <script>
    // Safety net for the name/price/duration skeleton below, independent
    // of main.js (which does the real sync but might itself still be
    // downloading on a slow connection). Registered here, at the very top
    // of body, so the countdown starts at first paint rather than
    // whenever main.js happens to finish loading - a real bound on how
    // long the skeleton can show, not just a bound on how long main.js's
    // OWN clock runs once it starts.
    setTimeout(function () {{
      var els = document.querySelectorAll(".is-syncing");
      for (var i = 0; i < els.length; i++) els[i].classList.remove("is-syncing");
    }}, 3000);
  </script>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>
  {cp.topbar(rel="../")}
  {cp.header(rel="../", active="tours")}

  <main id="mainContent">
    <div class="container" style="padding-top: 28px;">
      {cp.breadcrumb("../", [("Turlar", "tours.html", "nav.tours"), (d['name'], None, f"tour:{t['slug']}")])}
    </div>

    <div class="container">
      <div class="tour-layout">
        <div class="tour-main">
          <!-- HERO -->
          {f'''<div class="tour-hero" id="tourHeroWrap" data-index="1">
            <img id="tourHeroImg" src="../assets/images/{folder}/{prefix}_01.jpg" alt="{d['name']}" loading="eager">
            {badge_html}
          </div>
          <div class="tour-thumbs" id="tourThumbsStrip">
            {"".join(f'<button type="button" class="tour-thumbs__item{" is-active" if i == 1 else ""}" data-index="{i}" data-full="../assets/images/{folder}/{prefix}_{i:02d}.jpg"><img src="../assets/images/{folder}/{prefix}_{i:02d}.jpg" alt="{d["name"]} {i}" loading="{"eager" if i <= 3 else "lazy"}"></button>' for i in range(1, t['image_count'] + 1))}
          </div>''' if t['image_count'] > 0 else f'''<div class="tour-hero tour-hero--pending">
            {badge_html}
            <div class="tour-hero__pending-note">{icon('image', 28)}<span data-i18n="tour.photos_pending">Real photos for this tour are being added soon.</span></div>
          </div>'''}

          <!-- TITLE -->
          <div style="margin-top:32px;">
            <div class="tour-main__title">
              <h1 style="margin-bottom:0;" data-tour-slug="{t['slug']}"><span class="is-syncing" data-i18n-tour-name data-tour-live-field>{d['name']}</span></h1>
            </div>
            <div class="rating" style="margin-bottom:14px;">
              <span style="display:flex; align-items:center; gap:5px; color:var(--color-text-muted); font-size:.9rem;">{icon('map-pin',14)}<span data-tour-field="location">{d['location']}</span></span>
            </div>

            <div class="tour-facts">
          {facts_grid(t, d)}
            </div>

            <!-- TABS -->
            <div data-tabs>
              <div class="tabs__list">
                <button class="tabs__btn is-active" data-tab-target="overview" data-i18n="tabs.overview">Overview</button>
                <button class="tabs__btn" data-tab-target="program" data-i18n="tabs.program">Tour Program</button>
                <button class="tabs__btn" data-tab-target="included" data-i18n="tabs.included">Included / Excluded</button>
                <button class="tabs__btn" data-tab-target="info" data-i18n="tabs.important_info">Important Info</button>
              </div>

              <div class="tabs__panel is-active" data-tab-panel="overview">
                <h3 data-i18n="tabs.overview">Overview</h3>
                <div data-tour-field="description">
                  {"".join(f'<p>{p}</p>' for p in d['description'])}
                </div>
                <h4 style="margin-top:28px;" data-i18n="tour.highlights">Highlights</h4>
                <ul class="check-list check-list--included" data-tour-field="highlights">
                  {check_list(d['highlights'], 'star')}
                </ul>
              </div>

              <div class="tabs__panel" data-tab-panel="program">
                <h3 data-i18n="tour.tour_program">Tour Program</h3>
                <ul class="program-list" data-tour-field="program"{PROGRAM_STEP_ATTRS}>
                {PROGRAM_HTML}
                </ul>
              </div>

              <div class="tabs__panel" data-tab-panel="included">
                <h3 data-i18n="tour.whats_included">What's Included</h3>
                <ul class="check-list check-list--included" data-tour-field="included">
                  {check_list(d['included'], 'check')}
                </ul>
                <h3 style="margin-top:28px;" data-i18n="tour.whats_excluded">What's Excluded</h3>
                <ul class="check-list check-list--excluded" data-tour-field="excluded">
                  {check_list(d['excluded'], 'x')}
                </ul>
              </div>

              <div class="tabs__panel" data-tab-panel="info">
                <h3 data-i18n="tabs.important_info">Important Info</h3>
                <ul class="check-list check-list--included" style="grid-template-columns: 1fr;">
                  <li>{icon('map-pin',18)}<span><strong data-i18n="tour.meeting_point">Meeting Point</strong>: <span data-tour-field="meeting_point">{d['meeting_point']}</span></span></li>
                  <li>{icon('clock',18)}<span><strong data-i18n="admin.departure_time">Departure Time</strong>: <span data-tour-field="departure_time">{t.get('departureTime', d['departure'])}</span></span></li>
                  <li>{icon('clock',18)}<span><strong data-i18n="admin.return_time">Return Time</strong>: <span data-tour-field="return_time">{t.get('returnTime', d['return_time'])}</span></span></li>
                </ul>
                <h4 style="margin-top:24px;" data-i18n="tour.location_map">Location</h4>
                <div class="map-frame" style="margin-top:12px;">
                  <iframe src="https://maps.google.com/maps?q={map_query}&t=&z=12&ie=UTF8&iwloc=&output=embed" loading="lazy" referrerpolicy="no-referrer-when-downgrade" title="Map"></iframe>
                </div>
              </div>
            </div>
          </div>
        </div>

        <!-- BOOKING CARD -->
        <aside>
          <div class="booking-card">
            <h3 class="booking-card__title" data-tour-slug="{t['slug']}"><span class="is-syncing" data-i18n-tour-name data-tour-live-field>{d['name']}</span></h3>
            <div class="booking-card__price">
              <span class="now is-syncing" data-price-eur="{t['price_online']}" data-tour-live-field>\u20AC{t['price_online']}</span>
              <div class="unit" data-i18n="card.per_person">per person</div>
            </div>
            <div class="tour-facts">
          {facts_grid(t, d)}
            </div>
            <a href="../booking.html?tour={slug}" class="btn btn--primary btn--block" data-i18n="card.book_now">Book Now</a>
            <a href="https://wa.me/{cp.COMPANY['whatsapp_link']}?text=Hi!%20I%27d%20like%20to%20book%20the%20{d['name'].replace(' ', '%20')}." class="btn btn--outline btn--block" style="margin-top:10px;" target="_blank" rel="noopener">{icon('whatsapp',18)}<span data-i18n="tour.book_whatsapp">Book on WhatsApp</span></a>
            <div class="booking-card__note">{icon('shield-check',14)}<span data-i18n="payment.no_payment_note">No payment needed today - pay on the day of your tour.</span></div>
          </div>
        </aside>
      </div>
    </div>

    <!-- RELATED TOURS -->
    <section class="section">
      <div class="container">
        <div class="section-head" data-reveal>
          <span class="eyebrow" data-i18n="section.related_tours">You Might Also Like</span>
          <h2 data-i18n="section.related_tours">You Might Also Like</h2>
        </div>
        <div class="grid-3">
      {related_tours_html(t)}
        </div>
      </div>
    </section>
  </main>

  {cp.footer(rel="../")}
  <script type="application/json" id="tourI18nData">{embed_json}</script>
  {cp.scripts(rel="../")}
</body>
</html>'''

    with open(os.path.join(OUT, f"{slug}.html"), "w", encoding="utf-8") as f:
        f.write(html)
    return len(html)


def build():
    total = 0
    for t in TOURS:
        size = build_one(t)
        total += size
    print(f"  {len(TOURS)} tour detail pages written ({total:,} chars total)")


if __name__ == "__main__":
    build()
