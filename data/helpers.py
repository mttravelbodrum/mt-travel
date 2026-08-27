"""
Shared helpers for MT TRAVEL build scripts.
Single source of truth for slug -> image folder mapping so the
placeholder generator and the HTML site generator can never disagree
about where a tour's photos live (this is exactly the kind of
"wrong destination image" bug the spec warns about repeatedly).
"""
import json
import os

DATA_DIR = os.path.join(os.path.dirname(__file__))

# slug -> folder prefix (folder on disk is "<prefix>_images")
FOLDER_PREFIX = {
    "kos-island": "kos",
    "leros-island": "leros",
    "kalymnos-island": "kalymnos",
    "boat-trip": "boat_trip",
    "turkish-bath": "turkish_bath",
    "jeep-safari": "jeep_safari",
    "atv-safari": "atv_safari",
    "horse-riding": "horse_riding",
    "scuba-diving": "scuba_diving",
    "dolphin-park": "dolphin_park",
    "aquapark": "aquapark",
    "pamukkale": "pamukkale",
    "ephesus": "ephesus",
    "dalyan": "dalyan",
    "rafting": "rafting",
    "airport-transfer": "airport_transfer",
    "vip-transfer": "vip_transfer",
    "bodrum-transfer": "bodrum_transfer",
    "bodrum-city-tour": "bodrum_city",
}


def image_folder(slug):
    """Returns e.g. 'kos_images' for 'kos-island'."""
    return f"{FOLDER_PREFIX[slug]}_images"


def image_path(slug, index, ext="jpg"):
    """Returns e.g. 'assets/images/kos_images/kos_01.jpg'."""
    prefix = FOLDER_PREFIX[slug]
    return f"assets/images/{prefix}_images/{prefix}_{index:02d}.{ext}"


def load_json(name):
    with open(os.path.join(DATA_DIR, name), encoding="utf-8") as f:
        return json.load(f)


def load_all_tours():
    return load_json("tours.json")["tours"]


def tours_by_slug():
    return {t["slug"]: t for t in load_all_tours()}


def load_site():
    return load_json("site.json")


def load_reviews():
    return load_json("reviews.json")["reviews"]


def load_countries():
    return load_json("countries.json")["countries"]


def load_faq():
    return load_json("faq_general.json")["categories"]
