"""
Shared HTML partial builders. Every generated page calls into this module
so the header/footer/nav are pixel-identical everywhere and a single edit
here (e.g. fixing the header contrast, per Part 11 of the brief) fixes
every page at once instead of 40 separate manual edits.
"""
import sys, os, json, datetime
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
from helpers import load_site, load_all_tours
from icons import icon


SITE = load_site()
COMPANY = SITE["company"]
LANGS = SITE["languages"]
TOURS = load_all_tours()

NAV_ITEMS = [
    ("home", "index.html", "nav.home", "Home"),
    ("tours", "tours.html", "nav.tours", "Tours"),
    ("about", "about.html", "nav.about", "About"),
    ("contact", "contact.html", "nav.contact", "Contact"),
]

FOOTER_TOUR_LINKS = ["kos-island", "pamukkale", "ephesus", "dalyan", "boat-trip"]


def logo_mark_svg():
    return ('<svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">'
            '<path d="M3 19 8 6l4 9 4-9 5 13" stroke="white" stroke-width="2.3" '
            'stroke-linecap="round" stroke-linejoin="round"/></svg>')


def logo(rel="", extra_class=""):
    return f'''<a href="{rel}index.html" class="logo {extra_class}">
      <span class="logo__mark"><img src="{rel}assets/images/common/logo-mark.png" alt="MT Travel" width="388" height="200"></span>
      <span class="logo__text"><strong>MT</strong><span>TRAVEL</span></span>
    </a>'''


def head(title, description, rel="", canonical_path="", css_extra=None, og_image=None, page_type="website", noindex=False):
    css_extra = css_extra or []
    css_links = "\n    ".join(
        f'<link rel="stylesheet" href="{rel}assets/css/{f}.css">'
        for f in ["variables", "base", "layout", "components", "pages", "animations"] + css_extra
    )
    og_img = og_image or f"{rel}assets/images/common/og-image.jpg"
    robots = '<meta name="robots" content="noindex, nofollow">' if noindex else '<meta name="robots" content="index, follow">'
    canonical = f"https://www.mttravel.com/{canonical_path}"
    return f'''<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>{title}</title>
    <meta name="description" content="{description}">
    <link rel="canonical" href="{canonical}">
    {robots}
    <meta property="og:type" content="{page_type}">
    <meta property="og:title" content="{title}">
    <meta property="og:description" content="{description}">
    <meta property="og:image" content="{og_img}">
    <meta property="og:url" content="{canonical}">
    <meta name="twitter:card" content="summary_large_image">
    <meta name="twitter:title" content="{title}">
    <meta name="twitter:description" content="{description}">
    <meta name="twitter:image" content="{og_img}">
    <link rel="icon" type="image/png" sizes="32x32" href="{rel}assets/images/common/favicon-32.png">
    <link rel="icon" type="image/png" sizes="16x16" href="{rel}assets/images/common/favicon-16.png">
    <link rel="apple-touch-icon" href="{rel}assets/images/common/apple-touch-icon.png">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@500;600;700;800&family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    {css_links}'''


def topbar(rel=""):
    lang_items = "\n          ".join(
        f'<button class="tb-dropdown__item{" is-active" if l["code"] == "tr" else ""}" data-lang="{l["code"]}">'
        f'<img class="tb-dropdown__flag" src="{rel}assets/icons/flags/{l["flag"]}.png" alt=""> {l["native"]}</button>'
        for l in LANGS
    )
    return f'''<div class="topbar" id="topbar">
    <div class="container topbar__inner">
      <ul class="topbar__info">
        <li><a href="tel:{COMPANY['phone_link']}" data-company-field="phone_href">{icon('phone', 14)}<span data-company-field="phone_display">{COMPANY['phone_display']}</span></a></li>
        <li>{icon('clock', 14)}<span data-i18n="topbar.hours">{COMPANY['hours_en']}</span></li>
        <li><a href="mailto:{COMPANY['email']}" data-company-field="email_href">{icon('mail', 14)}<span data-company-field="email">{COMPANY['email']}</span></a></li>
      </ul>
      <div class="topbar__actions">
        <a class="topbar__whatsapp" href="https://wa.me/{COMPANY['whatsapp_link']}" target="_blank" rel="noopener" data-company-field="whatsapp_href">{icon('whatsapp', 15)}<span class="long" data-i18n="topbar.whatsapp">24/7 WhatsApp</span></a>
        <div class="tb-dropdown" id="languageDropdown">
          <button class="tb-dropdown__btn" type="button">
            <img class="tb-dropdown__flag" id="currentLangFlag" data-rel="{rel}" src="{rel}assets/icons/flags/tr.png" alt="">
            <span id="currentLangLabel">TR</span>{icon('chevron-down', 10, 'chev')}
          </button>
          <div class="tb-dropdown__menu">
          {lang_items}
          </div>
        </div>
      </div>
    </div>
  </div>'''


def _nav_links(rel, active, mobile=False):
    items = []
    for key, href, i18n_key, label in NAV_ITEMS:
        cls = "is-active" if key == active else ""
        items.append(f'<li><a href="{rel}{href}" data-i18n="{i18n_key}" class="{cls}">{label}</a></li>')
    return "\n        ".join(items)


def header(rel="", active="home"):
    nav_links = _nav_links(rel, active)
    mobile_links = _nav_links(rel, active, mobile=True)
    return f'''<header class="site-header" id="siteHeader">
    <div class="container site-header__inner">
      {logo(rel)}
      <nav class="main-nav" id="mainNav">
        <ul>
        {nav_links}
        </ul>
      </nav>
      <div class="header-actions">
        <a href="{rel}booking.html" class="btn btn--primary btn--sm" data-i18n="nav.book_now">Book Now</a>
        <button class="nav-toggle" id="navToggle" aria-label="Open menu" data-i18n-aria-label="a11y.open_menu"><span></span><span></span><span></span></button>
      </div>
    </div>
  </header>
  <div class="mobile-nav-overlay" id="mobileNavOverlay"></div>
  <div class="mobile-nav" id="mobileNav">
    <div class="mobile-nav__head">
      {logo(rel)}
      <button class="mobile-nav__close" id="mobileNavClose" aria-label="Close menu" data-i18n-aria-label="a11y.close_menu">{icon('x', 18)}</button>
    </div>
    <ul>
    {mobile_links}
      <li><a href="{rel}booking.html" data-i18n="nav.book_now" style="color:var(--teal-600);">Book Now</a></li>
    </ul>
    <div class="mobile-nav__foot">
      <a href="tel:{COMPANY['phone_link']}" data-company-field="phone_href">{icon('phone', 18)}<span data-company-field="phone_display">{COMPANY['phone_display']}</span></a>
      <a href="https://wa.me/{COMPANY['whatsapp_link']}" target="_blank" rel="noopener" data-company-field="whatsapp_href">{icon('whatsapp', 18)}WhatsApp</a>
      <a href="mailto:{COMPANY['email']}" data-company-field="email_href">{icon('mail', 18)}<span data-company-field="email">{COMPANY['email']}</span></a>
    </div>
  </div>'''


def footer(rel=""):
    quick_links = "\n          ".join(
        f'<li><a href="{rel}{href}" data-i18n="{i18n_key}">{label}</a></li>' for _, href, i18n_key, label in NAV_ITEMS[:6]
    )
    dest_links = "\n          ".join(
        f'<li><a href="{rel}tours/{slug}.html" data-footer-tour-slug="{slug}">{next(t for t in TOURS if t["slug"] == slug)["i18n"]["tr"]["name"]}</a></li>'
        for slug in FOOTER_TOUR_LINKS
    )
    social = COMPANY["social"]
    social_icons = [("facebook", social["facebook"]), ("instagram", social["instagram"]), ("twitter", social["twitter"]), ("youtube", social["youtube"]), ("telegram", social["telegram"])]
    social_html = "\n        ".join(f'<a href="{url}" target="_blank" rel="noopener" aria-label="{name}">{icon(name, 16)}</a>' for name, url in social_icons)
    return f'''<footer class="site-footer">
    <div class="container">
      <div class="footer__grid">
        <div class="footer__brand">
          {logo(rel)}
          <p data-i18n="footer.tagline">Your trusted travel partner in Bodrum. We create unforgettable memories.</p>
          <div class="footer__social">
        {social_html}
          </div>
        </div>
        <div class="footer__col">
          <h6 data-i18n="footer.quick_links">Quick Links</h6>
          <ul>
          {quick_links}
          </ul>
        </div>
        <div class="footer__col">
          <h6 data-i18n="footer.top_destinations">Top Destinations</h6>
          <ul>
          {dest_links}
          </ul>
        </div>
        <div class="footer__col">
          <h6 data-i18n="footer.support">Support</h6>
          <ul>
            <li><a href="{rel}contact.html" data-i18n="footer.contact_us">Contact Us</a></li>
            <li><a href="{rel}terms.html" data-i18n="footer.terms">Terms of Service</a></li>
            <li><a href="{rel}privacy.html" data-i18n="footer.privacy">Privacy Policy</a></li>
            <li><a href="{rel}cancellation-policy.html" data-i18n="footer.cancellation">Cancellation Policy</a></li>
          </ul>
        </div>
      </div>
      <div class="footer__bottom">
        <div>&copy; <span data-current-year>2026</span> {COMPANY['name']}. <span data-i18n="footer.rights">All rights reserved.</span></div>
        <ul class="footer__legal">
          <li><a href="{rel}privacy.html" data-i18n="footer.privacy">Privacy Policy</a></li>
          <li><a href="{rel}terms.html" data-i18n="footer.terms">Terms of Service</a></li>
        </ul>
      </div>
    </div>
  </footer>
  <a href="https://wa.me/{COMPANY['whatsapp_link']}" class="fab-whatsapp" target="_blank" rel="noopener" aria-label="Chat on WhatsApp" data-i18n-aria-label="a11y.chat_whatsapp" data-company-field="whatsapp_href">{icon('whatsapp', 28)}</a>'''


def scripts(rel="", extra=None, admin_extra=None):
    extra = extra or []
    core = ["utils", "data/site-data", "data/tours-data", "data/countries-data",
            "i18n/bundle", "api-client", "language", "main", "slider", "interactions"] + extra
    tags = "\n  ".join(f'<script src="{rel}assets/js/{f}.js"></script>' for f in core)
    return tags


def admin_scripts(rel="", extra=None):
    extra = extra or []
    core = ["utils", "data/site-data", "data/tours-data", "data/countries-data",
            "i18n/bundle", "api-client", "language", "main", "admin-common"] + extra
    tags = "\n  ".join(f'<script src="{rel}assets/js/{f}.js"></script>' for f in core)
    return tags


def breadcrumb(rel, items):
    """items: list of (label, href_or_None) or (label, href_or_None, i18n_key_or_None).
    label is the Turkish default text (shown before JS runs, and as the
    fallback if no key is given); the optional i18n_key makes the crumb
    re-translate on language change exactly like the page's own title.
    A key of the form "tour:<slug>" instead re-translates using that
    tour's own name in MT_TOURS (for the "current tour" crumb on a tour
    detail page), since a tour name isn't a fixed bundle string the way
    other crumbs like "Tours" are - it comes from data/tours.json."""
    lis = []
    lis.append(f'<li><a href="{rel}index.html" data-i18n="nav.home">Ana Sayfa</a></li>')
    for item in items:
        label, href = item[0], item[1]
        key = item[2] if len(item) > 2 else None
        if key and key.startswith("tour:"):
            slug = key[len("tour:"):]
            inner = f'<span data-i18n-tour-name>{label}</span>'
            tour_attr = f' data-tour-slug="{slug}"'
            i18n_attr = ""
        else:
            inner = label
            tour_attr = ""
            i18n_attr = f' data-i18n="{key}"' if key else ""
        if href:
            lis.append(f'<li><a href="{rel}{href}"{i18n_attr}{tour_attr}>{inner}</a></li>')
        else:
            lis.append(f'<li aria-current="page"{i18n_attr}{tour_attr}>{inner}</li>')
    return f'<ul class="breadcrumb">{"".join(lis)}</ul>'


def page_banner(rel, title, subtitle, crumb_items, bg="banner-tours.jpg", title_key=None, subtitle_key=None):
    title_attr = f' data-i18n="{title_key}"' if title_key else ""
    subtitle_attr = f' data-i18n="{subtitle_key}"' if subtitle_key else ""
    return f'''<section class="page-banner">
    <div class="container page-banner__inner">
      {breadcrumb(rel, crumb_items)}
      <h1{title_attr}>{title}</h1>
      <p{subtitle_attr}>{subtitle}</p>
    </div>
  </section>'''


def tour_card(t, rel="", lang="tr"):
    d = t["i18n"][lang]
    badge_map = {"best_seller": ("BEST SELLER", "badge--dark", "tour.badge_best_seller"), "popular": ("POPULAR", "badge--teal", "tour.badge_popular"), "new": ("NEW", "badge--gold", "tour.badge_new")}
    badge_html = ""
    if t["badge"] in badge_map:
        label, cls, key = badge_map[t["badge"]]
        badge_html = f'<span class="badge {cls} tour-card__badge" data-i18n="{key}">{label}</span>'
    prefix = t["slug"]
    from helpers import FOLDER_PREFIX
    img_prefix = FOLDER_PREFIX[t["slug"]]
    img_folder = f"{img_prefix}_images"
    has_photos = t.get("image_count", 1) > 0
    media_html = (
        f'<img src="{rel}assets/images/{img_folder}/{img_prefix}_01.jpg" alt="{d["name"]}" loading="lazy">'
        if has_photos else
        f'<div class="tour-card__pending">{icon("image", 26)}<span data-i18n="tour.photos_pending_short">Photos coming soon</span></div>'
    )
    return f'''<div class="tour-card" data-tour-slug="{t['slug']}" data-category="{t['category']}" data-reveal>
        <div class="tour-card__media">
          <a href="{rel}tours/{t['slug']}.html">
            {media_html}
          </a>
          {badge_html}
        </div>
        <div class="tour-card__body">
          <span class="tour-card__cat" data-i18n="category.{t['category']}" data-tour-category-label>{t['category'].replace('_',' ')}</span>
          <h3 class="tour-card__title"><a href="{rel}tours/{t['slug']}.html" data-i18n-tour-name>{d['name']}</a></h3>
          <div class="tour-card__meta">
            <span>{icon('clock', 14)}<span data-i18n-tour-duration data-tour-duration>{d['duration'].split(' - ')[0].strip()}</span></span>
          </div>
          <div class="tour-card__footer">
            <div class="tour-card__price">
              <span class="from" data-i18n="card.from">From</span>
              <span class="now" data-price-eur="{t['price_online']}">\u20AC{t['price_online']}</span>
            </div>
            <a href="{rel}tours/{t['slug']}.html" class="btn btn--primary btn--sm" data-i18n="card.details">Details</a>
          </div>
        </div>
      </div>'''


def organization_schema():
    import json as _json
    data = {
        "@context": "https://schema.org",
        "@type": "TravelAgency",
        "name": COMPANY["name"],
        "url": "https://www.mttravel.com/",
        "logo": "https://www.mttravel.com/assets/images/common/favicon-32.png",
        "telephone": COMPANY["phone_display"],
        "email": COMPANY["email"],
        "address": {
            "@type": "PostalAddress",
            "streetAddress": COMPANY["address_en"],
            "addressCountry": "TR"
        },
        "sameAs": list(COMPANY["social"].values())
    }
    return f'<script type="application/ld+json">{_json.dumps(data, ensure_ascii=False)}</script>'


def local_business_schema():
    import json as _json
    data = {
        "@context": "https://schema.org",
        "@type": "LocalBusiness",
        "name": COMPANY["name"],
        "image": "https://www.mttravel.com/assets/images/common/og-image.jpg",
        "telephone": COMPANY["phone_display"],
        "email": COMPANY["email"],
        "address": {
            "@type": "PostalAddress",
            "streetAddress": COMPANY["address_en"],
            "addressCountry": "TR"
        },
        "geo": {"@type": "GeoCoordinates", "latitude": COMPANY["map_lat"], "longitude": COMPANY["map_lng"]},
        "openingHours": "Mo-Su 08:00-20:00",
        "priceRange": "\u20AC\u20AC"
    }
    return f'<script type="application/ld+json">{_json.dumps(data, ensure_ascii=False)}</script>'


def breadcrumb_schema(rel, items):
    import json as _json
    base = "https://www.mttravel.com/"
    elements = [{"@type": "ListItem", "position": 1, "name": "Home", "item": base}]
    pos = 2
    for label, href in items:
        url = base + href if href else None
        entry = {"@type": "ListItem", "position": pos, "name": label}
        if url:
            entry["item"] = url
        elements.append(entry)
        pos += 1
    data = {"@context": "https://schema.org", "@type": "BreadcrumbList", "itemListElement": elements}
    return f'<script type="application/ld+json">{_json.dumps(data, ensure_ascii=False)}</script>'
