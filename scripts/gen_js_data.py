"""
Exports data/*.json into plain <script> globals under
site/assets/js/data/*.js so booking.js / payment.js / language.js can
compute prices, validate phone numbers and translate the UI without
ever duplicating content that already lives in tours.json.
"""
import sys, os, json
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
from helpers import load_all_tours, load_countries, load_site, FOLDER_PREFIX

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "assets", "js", "data")
os.makedirs(OUT, exist_ok=True)

def write_js(filename, var_name, value, comment=""):
    path = os.path.join(OUT, filename)
    with open(path, "w", encoding="utf-8") as f:
        if comment:
            f.write(f"// {comment}\n")
        f.write(f"const {var_name} = ")
        json.dump(value, f, ensure_ascii=False, indent=2)
        f.write(";\n")
    print(f"  wrote {filename} ({os.path.getsize(path)} bytes)")

def main():
    tours = load_all_tours()
    # Slim client-side tour record: only what booking/payment/JS logic needs
    slim = []
    for t in tours:
        slim.append({
            "slug": t["slug"],
            "category": t["category"],
            "is_island": t["is_island"],
            "badge": t["badge"],
            "duration_hours": t["duration_hours"],
            "price_regular": t["price_regular"],
            "price_online": t["price_online"],
            # Only ATV Safari has these right now (single/double guest
            # pricing instead of adult/child) - included here, not just in
            # the backend seed data, so the page's build-time default
            # (before any live API fetch resolves, or if the backend is
            # ever unreachable) already matches the live behavior instead
            # of silently falling back to the old adult/child pricing UI.
            **({"pricing_mode": t["pricing_mode"], "price_single": t["price_single"], "price_double": t["price_double"]}
               if t.get("pricing_mode") else {}),
            "rating": t["rating"],
            "review_count": t["review_count"],
            "theme": t["theme"],
            "folder": f"{FOLDER_PREFIX[t['slug']]}_images",
            "image_prefix": FOLDER_PREFIX[t["slug"]],
            "image_count": t["image_count"],
            "name": {lang: t["i18n"][lang]["name"] for lang in t["i18n"]},
            "short": {lang: t["i18n"][lang]["short"] for lang in t["i18n"]},
            "location": {lang: t["i18n"][lang]["location"] for lang in t["i18n"]},
            # The compact duration shown on a tour card ("10 Saat", "45-70
            # Dakika") - each language's own full duration text before the
            # " - " that introduces a longer descriptor ("- Full Day"). Most
            # tours have that separator; a few (transfers, short activities)
            # don't, in which case the whole (already short) string is used
            # as-is. Computed per language so a transfer's "45-70 Minutes
            # (route dependent)" is never used to build a duration string in
            # a language it isn't from.
            "duration_short": {lang: t["i18n"][lang]["duration"].split(" - ")[0].strip() for lang in t["i18n"]},
        })
    write_js("tours-data.js", "MT_TOURS", slim, "Auto-generated from data/tours.json - do not hand-edit, edit the JSON and rebuild")
    write_js("countries-data.js", "MT_COUNTRIES", load_countries(), "Auto-generated from data/countries.json")
    write_js("site-data.js", "MT_SITE", load_site(), "Auto-generated from data/site.json")

    # Bundle the 5 i18n/*.json dictionaries into one JS file so translations
    # work even when the site is opened directly from disk (file://), where
    # fetch() of local JSON is blocked by the browser's CORS rules.
    i18n_dir = os.path.join(os.path.dirname(__file__), "..", "site", "assets", "js", "i18n")
    langs = ["en", "tr", "de", "ru", "pl"]
    bundle = {}
    for lang in langs:
        with open(os.path.join(i18n_dir, f"{lang}.json"), encoding="utf-8") as f:
            bundle[lang] = json.load(f)
    bundle_path = os.path.join(i18n_dir, "bundle.js")
    with open(bundle_path, "w", encoding="utf-8") as f:
        f.write("// Auto-generated bundle of all i18n/*.json files.\n")
        f.write("// Bundled (not fetched) so translations work even when the site is opened\n")
        f.write('// directly from disk (file://) and not just from a real web server.\n')
        f.write("// To edit translations: edit the individual en.json / tr.json / etc. files,\n")
        f.write("// then re-run this script to regenerate this bundle.\n")
        f.write("const MT_I18N = ")
        json.dump(bundle, f, ensure_ascii=False, indent=1)
        f.write(";\n")
    print(f"  wrote i18n/bundle.js ({os.path.getsize(bundle_path)} bytes)")


if __name__ == "__main__":
    main()
