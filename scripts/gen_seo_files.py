import sys, os
from datetime import date
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
from helpers import load_all_tours

TOURS = load_all_tours()
OUT = os.path.join(os.path.dirname(__file__), "..", "site")
BASE_URL = "https://www.mttravel.com"
TODAY = date.today().isoformat()


def build_robots():
    content = f'''User-agent: *
Allow: /
Disallow: /admin/
Disallow: /booking.html
Disallow: /checkout.html
Disallow: /success.html

Sitemap: {BASE_URL}/sitemap.xml
'''
    with open(os.path.join(OUT, "robots.txt"), "w", encoding="utf-8") as f:
        f.write(content)
    print(f"  robots.txt written")


def build_sitemap():
    static_pages = [
        ("", "1.0", "weekly"),
        ("tours.html", "0.9", "weekly"),
        ("about.html", "0.6", "monthly"),
        ("contact.html", "0.6", "monthly"),
        ("privacy.html", "0.2", "yearly"),
        ("terms.html", "0.2", "yearly"),
        ("cancellation-policy.html", "0.2", "yearly"),
        ("distance-sales-agreement.html", "0.2", "yearly"),
    ]
    urls = []
    for path, priority, freq in static_pages:
        urls.append((f"{BASE_URL}/{path}", priority, freq))
    for t in TOURS:
        urls.append((f"{BASE_URL}/tours/{t['slug']}.html", "0.8", "weekly"))

    entries = "\n  ".join(
        f'''<url>
    <loc>{loc}</loc>
    <lastmod>{TODAY}</lastmod>
    <changefreq>{freq}</changefreq>
    <priority>{priority}</priority>
  </url>''' for loc, priority, freq in urls
    )
    content = f'''<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  {entries}
</urlset>
'''
    with open(os.path.join(OUT, "sitemap.xml"), "w", encoding="utf-8") as f:
        f.write(content)
    print(f"  sitemap.xml written ({len(urls)} URLs)")


if __name__ == "__main__":
    build_robots()
    build_sitemap()
