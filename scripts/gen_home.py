import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon
from helpers import load_all_tours, load_reviews, FOLDER_PREFIX

TOURS = load_all_tours()
REVIEWS = load_reviews()
OUT = os.path.join(os.path.dirname(__file__), "..", "site")

# Hero slider slides: (slug, badge_key, badge_default, headline_key, headline_default,
#                       subtitle_key, subtitle_default, cta_key, cta_default)
HERO_SLIDES = [
    {
        "slug": None, "image": "common/hero-home.jpg",
        "badge_key": "hero.badge", "badge_default": "Bodrum'un 2005'ten Beri Güvenilir Tur Operatörü",
        "title1_key": "hero.title_1", "title1_default": "Güzelliklerini Keşfedin",
        "title2_key": "hero.title_2", "title2_default": "BODRUM'UN",
        "sub_key": "hero.subtitle", "sub_default": "En güzel yerlerde, otelden alış ve İngilizce konuşan rehberlerle unutulmaz turlar ve deneyimler.",
        "href": "tours.html",
    },
    {
        "slug": "kos-island", "image": None,
        "badge_key": "category.island", "badge_default": "Ada",
        "title1_key": "hero.slide2_title1", "title1_default": "Kaçış Zamanı",
        "title2_key": "hero.slide2_title2", "title2_default": "KOS ADASI",
        "sub_key": "hero.slide2_sub", "sub_default": "Kos'un Yunan adasında kaleler, antik kalıntılar ve Ege'nin en berrak sularıyla dolu tam bir gün.",
        "href": "tours/kos-island.html",
    },
    {
        "slug": "boat-trip", "image": None,
        "badge_key": "category.water", "badge_default": "Su Aktiviteleri",
        "title1_key": "hero.slide3_title1", "title1_default": "Yelken Açın",
        "title2_key": "hero.slide3_title2", "title2_default": "EGE KOYLARINDA",
        "sub_key": "hero.slide3_sub", "sub_default": "Bodrum'un koyları, kıyıları ve Kara Ada'nın mineralli çamur mağaraları etrafında klasik bir gulet turu.",
        "href": "tours/boat-trip.html",
    },
    {
        "slug": "pamukkale", "image": None,
        "badge_key": "category.land", "badge_default": "Kara Macerası",
        "title1_key": "hero.slide4_title1", "title1_default": "Yürüyün",
        "title2_key": "hero.slide4_title2", "title2_default": "PAMUKKALE'DE",
        "sub_key": "hero.slide4_sub", "sub_default": "Pamukkale'nin beyaz travertenleri ve Hierapolis'in antik kalıntıları.",
        "href": "tours/pamukkale.html",
    },
    {
        "slug": "scuba-diving", "image": None,
        "badge_key": "category.water", "badge_default": "Su Aktiviteleri",
        "title1_key": "hero.slide5_title1", "title1_default": "Keşfedin",
        "title2_key": "hero.slide5_title2", "title2_default": "MAVİ DERİNLİKLERİ",
        "sub_key": "hero.slide5_sub", "sub_default": "Bodrum'un berrak sularının altındaki renkli deniz yaşamını ve batıkları keşfedin.",
        "href": "tours/scuba-diving.html",
    },
]


def hero_slide_html(slide, i):
    if slide["slug"]:
        t = next(x for x in TOURS if x["slug"] == slide["slug"])
        prefix = FOLDER_PREFIX[slide["slug"]]
        img = f"assets/images/{prefix}_images/{prefix}_01.jpg"
    else:
        img = f"assets/images/{slide['image']}"
    badge_attr = f' data-i18n="{slide["badge_key"]}"' if slide["badge_key"] else ""
    return f'''<div class="hero-slider__slide{' is-active' if i == 0 else ''}" data-href="{slide['href']}">
        <div class="hero-slider__media">
          <img src="{img}" alt="{slide['title2_default']}" loading="eager">
        </div>
        <div class="container hero-slider__inner">
          <div class="hero-slider__content" data-reveal>
            <span class="hero__badge">{icon('award',14) if i == 0 else icon('compass',14)} <span{badge_attr}>{slide['badge_default']}</span></span>
            <h1 class="hero__title">{f'<span data-i18n="{slide["title1_key"]}">{slide["title1_default"]}</span>' if slide['title1_key'] else f'<span>{slide["title1_default"]}</span>'}{f'<span data-i18n="{slide["title2_key"]}">{slide["title2_default"]}</span>' if slide['title2_key'] else f'<span>{slide["title2_default"]}</span>'}</h1>
            <p class="hero__subtitle"{f' data-i18n="{slide["sub_key"]}"' if slide['sub_key'] else ''}>{slide['sub_default']}</p>
            <div class="hero__cta">
              <a href="{slide['href']}" class="btn btn--primary btn--lg" data-i18n="hero.cta_explore">Explore Tours</a>
            </div>
          </div>
        </div>
      </div>'''


def discover_slide(t):
    prefix = FOLDER_PREFIX[t["slug"]]
    d = t["i18n"]["tr"]
    has_photos = t.get("image_count", 1) > 0
    media_html = (
        f'<img src="assets/images/{prefix}_images/{prefix}_01.jpg" alt="{d["name"]}" loading="lazy">'
        if has_photos else
        f'<div class="tour-card__pending">{icon("image", 26)}<span data-i18n="tour.photos_pending_short">Photos coming soon</span></div>'
    )
    return f'''<div class="carousel__slide">
          <a href="tours/{t['slug']}.html" class="tour-card" data-tour-slug="{t['slug']}" style="text-decoration:none;">
            <div class="tour-card__media">
              {media_html}
              <span class="badge badge--outline tour-card__badge" data-i18n="category.{t['category']}">{t['category'].replace('_',' ').title()}</span>
            </div>
            <div class="tour-card__body">
              <h3 class="tour-card__title" data-i18n-tour-name>{d['name']}</h3>
              <div class="tour-card__meta"><span>{icon('map-pin',14)}<span data-i18n-tour-location>{d['location'].split(',')[0]}</span></span></div>
            </div>
          </a>
        </div>'''


def why_item(icon_name, title_key, title_default, sub_key, sub_default):
    return f'''<div class="feature-card" data-reveal>
          <div class="feature-card__icon">{icon(icon_name, 26)}</div>
          <h4 data-i18n="{title_key}">{title_default}</h4>
          <p data-i18n="{sub_key}">{sub_default}</p>
        </div>'''


def build():
    discover = [t for t in TOURS if t["slug"] in
                ["boat-trip", "kos-island", "pamukkale", "scuba-diving", "leros-island", "dalyan", "ephesus", "horse-riding"]]

    trust_items = [
        ("shield-check", "trust.best_price_title", "Best Price Guarantee", "trust.best_price_sub", "Lowest online rate"),
        ("lock", "trust.easy_booking_title", "Easy Booking", "trust.easy_booking_sub", "No payment needed today"),
        ("headset", "trust.guides_title", "Professional Guides", "trust.guides_sub", "Licensed & local"),
        ("map-pin", "trust.pickup_title", "Hotel Pick-Up", "trust.pickup_sub", "Included on most tours"),
        ("clock", "trust.support_title", "24/7 Support", "trust.support_sub", "Always here to help"),
    ]
    trust_html = "\n        ".join(f'''<div class="trust-item">
          <span class="trust-item__icon">{icon(n, 21)}</span>
          <div><strong data-i18n="{tk}">{td}</strong><span data-i18n="{sk}">{sd}</span></div>
        </div>''' for n, tk, td, sk, sd in trust_items)

    why_items = [
        ("award", "why.experience_title", "20+ Years Experience", "why.experience_sub", "Trusted local expertise since 2005"),
        ("shield", "why.secure_title", "Secure Reservations", "why.secure_sub", "Your data is protected"),
        ("compass", "why.guides_title", "Local Expert Guides", "why.guides_sub", "Licensed, friendly, multilingual"),
        ("star", "why.service_title", "Premium Service", "why.service_sub", "Hotel pick-up on most tours"),
        ("zap", "why.support_title", "Fast Support", "why.support_sub", "Real answers, day or night"),
        ("thumbs-up", "why.satisfaction_title", "High Satisfaction", "why.satisfaction_sub", "Thousands of happy guests"),
    ]
    why_html = "\n        ".join(why_item(*args) for args in why_items)

    hero_slides_html = "\n      ".join(hero_slide_html(s, i) for i, s in enumerate(HERO_SLIDES))

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title="MT Travel | Bodrum, Türkiye'de Premium Turlar ve Deneyimler",
      description="Bodrum'da premium turlar ayırtın: Kos ve Leros adaları, tekne turları, Pamukkale, Efes, jeep safari ve daha fazlası. En iyi fiyat garantisi, kolay rezervasyon, otelden alış.",
      canonical_path=""
  )}
  {cp.organization_schema()}
</head>
<body>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>

  <!-- TOP INFORMATION BAR -->
  {cp.topbar()}

  <!-- HEADER / NAVIGATION -->
  {cp.header(active="home")}

  <main id="mainContent">
    <!-- HERO SLIDER: auto-advances every 5s, swipe/arrows/dots, pauses on hover -->
    <section class="hero-slider" id="heroSlider">
      {hero_slides_html}
      <div class="hero-slider__nav container">
        <button class="hero-slider__arrow prev" id="heroSliderPrev" aria-label="Previous slide" data-i18n-aria-label="hero.prev_slide">{icon('chevron-left',20)}</button>
        <button class="hero-slider__arrow next" id="heroSliderNext" aria-label="Next slide" data-i18n-aria-label="hero.next_slide">{icon('chevron-right',20)}</button>
      </div>
      <div class="hero-slider__dots" id="heroSliderDots"></div>
    </section>

    <!-- TRUST STRIP (moved below slider so every slide shares one strip, no repetition) -->
    <div class="container" style="margin-top: -50px; position: relative; z-index: 2;">
      <div class="card" style="padding: 22px 28px; box-shadow: var(--shadow-lg);">
        <div class="trust-strip">
        {trust_html}
        </div>
      </div>
    </div>

    <!-- VIEW ALL TOURS CTA (replaces the old quick-booking search card) -->
    <div class="container booking-search-wrap" style="margin-top: 32px; text-align: center;" data-reveal="scale">
      <div class="hero-cta-card">
        <a href="tours.html" class="btn btn--primary btn--lg hero-cta-card__btn">{icon('compass',20)}<span data-i18n="hero.view_all_tours">Tüm Turları Görüntüle</span></a>
      </div>
    </div>

    <!-- DISCOVER BODRUM -->
    <section class="section" id="discover">
      <div class="container">
        <div class="section-head section-head--split" data-reveal>
          <div>
            <span class="eyebrow" data-i18n="section.discover_bodrum">Discover Bodrum</span>
            <h2 data-i18n="section.discover_bodrum">Discover Bodrum</h2>
            <p data-i18n="section.discover_bodrum_sub">A first look at the destinations and experiences waiting for you.</p>
          </div>
          <a href="tours.html" class="link-arrow"><span data-i18n="section.view_all">View All Tours</span> {icon('arrow-right',16)}</a>
        </div>
        <div class="carousel" data-carousel data-autoplay="true" data-speed="3200" id="discoverCarousel">
          <div class="carousel__viewport">
            <div class="carousel__track">
        {"".join(discover_slide(t) for t in discover)}
            </div>
          </div>
        </div>
        <div style="display:flex; justify-content:center; gap:10px; margin-top:24px;">
          <button class="carousel__arrow prev" data-carousel-prev="discoverCarousel" aria-label="Previous">{icon('chevron-left',18)}</button>
          <button class="carousel__arrow next" data-carousel-next="discoverCarousel" aria-label="Next">{icon('chevron-right',18)}</button>
        </div>
      </div>
    </section>

    <!-- WHY CHOOSE US -->
    <section class="section section-alt">
      <div class="container">
        <div class="section-head center" data-reveal>
          <span class="eyebrow" style="justify-content:center;" data-i18n="section.why_choose_us">Why Choose Us</span>
          <h2 data-i18n="section.why_choose_us">Why Choose Us</h2>
          <p data-i18n="section.why_choose_us_sub">Two decades of showing travellers the very best of the Aegean coast.</p>
        </div>
        <div class="grid-3" data-reveal-group>
        {why_html}
        </div>
      </div>
    </section>

    <!-- CALL TO ACTION -->
    <section class="section">
      <div class="container">
        <div class="cta-banner" data-reveal="scale">
          <div class="cta-banner__inner">
            <h2 data-i18n="section.cta_title">Ready for Your Bodrum Adventure?</h2>
            <p data-i18n="section.cta_sub">Secure your spot in minutes - no payment needed until the day of your tour.</p>
            <div class="cta-banner__actions">
              <a href="tours.html" class="btn btn--primary btn--lg" data-i18n="nav.book_now">Book Now</a>
              <a href="https://wa.me/{cp.COMPANY['whatsapp_link']}" class="btn btn--whatsapp btn--lg" target="_blank" rel="noopener">{icon('whatsapp',18)}WhatsApp</a>
              <a href="tel:{cp.COMPANY['phone_link']}" class="btn btn--outline btn--lg">{icon('phone',18)}{cp.COMPANY['phone_display']}</a>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>

  <!-- FOOTER -->
  {cp.footer()}

  {cp.scripts(extra=["hero-slider"])}
</body>
</html>'''

    with open(os.path.join(OUT, "index.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  index.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
