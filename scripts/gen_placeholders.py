"""
MT TRAVEL - placeholder image generator.

Produces tasteful, on-brand placeholder photography for every tour
(correctly sorted into its own destination folder - never mixed),
plus site-wide hero banners, review avatars and a favicon.

These are stand-ins only: each image is clearly labelled with its
destination name so there is zero risk of a "wrong destination photo"
mix-up. Swap in real photography by keeping the exact same file
names/paths documented in README.md.
"""
import sys, os, math, random, colorsys
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
from helpers import load_all_tours, FOLDER_PREFIX, load_reviews, load_site

from PIL import Image, ImageDraw, ImageFont, ImageFilter, ImageEnhance

random.seed(42)

ROOT = os.path.join(os.path.dirname(__file__), "..")
OUT = os.path.join(ROOT, "site", "assets", "images")

FDIR = "/usr/share/fonts/truetype/google-fonts/"
F_BLACK = FDIR + "Poppins-Bold.ttf"
F_SEMI = FDIR + "Poppins-Medium.ttf"
F_REG = FDIR + "Poppins-Regular.ttf"

def font(path, size):
    return ImageFont.truetype(path, size)

def hx(h):
    h = h.lstrip("#")
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

def lerp(a, b, t):
    return tuple(int(a[i] + (b[i]-a[i])*t) for i in range(3))

# Per-theme gradient pairs (2-3 variants each, rotated across a tour's photo set for variety)
THEMES = {
    "sea":       [("#0B4F6C", "#1FB6C9"), ("#0A3B57", "#17A99C"), ("#0E5E78", "#2FC2B4")],
    "spa":       [("#7A5A2E", "#E0B65C"), ("#5C4023", "#CE9B41"), ("#8A6A3B", "#F0D9A8")],
    "adventure": [("#33471F", "#8CAE52"), ("#4A3418", "#B98A4A"), ("#2E4C3A", "#6FAE7C")],
    "ruins":     [("#6B4E23", "#E0B65C"), ("#583A1E", "#C99A4E"), ("#4A3A26", "#B08A5C")],
    "family":    [("#0E5E78", "#4FD1C5"), ("#1B6E8C", "#38B6C2"), ("#0B4F6C", "#57C7D6")],
    "transfer":  [("#0B1D2E", "#2C5170"), ("#12283C", "#3E6084"), ("#081420", "#1C3A52")],
}

W, H = 1200, 900  # 4:3 base, matches .tour-card__media / thumb-strip aspect ratio

def diagonal_gradient(w, h, c1, c2):
    c1, c2 = hx(c1), hx(c2)
    base = Image.new("RGB", (w, h), c1)
    top = Image.new("RGB", (w, h), c2)
    mask = Image.new("L", (w, h))
    md = ImageDraw.Draw(mask)
    diag = w + h
    for i in range(diag):
        v = int(255 * (i / diag))
        md.line([(0, i), (i, 0)], fill=v)
    # Simpler & faster: build mask via numpy-free gradient using linear interpolation per row/col
    mask = Image.linear_gradient("L").rotate(-35, expand=True).resize((w, h))
    base.paste(top, (0, 0), mask)
    return base

def add_grain_and_vignette(img, strength=18):
    w, h = img.size
    # subtle radial vignette
    vign = Image.new("L", (w, h), 0)
    vd = ImageDraw.Draw(vign)
    vd.ellipse([-w*0.25, -h*0.25, w*1.25, h*1.25], fill=90)
    vign = vign.filter(ImageFilter.GaussianBlur(w // 4))
    dark = Image.new("RGB", (w, h), (5, 8, 12))
    img = Image.composite(img, dark, vign.point(lambda p: 255 - int(p * 0.35)))
    return img

def add_pattern(img, seed_offset=0):
    """Soft repeating diagonal lines for texture, low opacity."""
    w, h = img.size
    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    od = ImageDraw.Draw(overlay)
    spacing = 46
    for x in range(-h, w, spacing):
        od.line([(x, 0), (x + h, h)], fill=(255, 255, 255, 10), width=2)
    img = Image.alpha_composite(img.convert("RGBA"), overlay).convert("RGB")
    return img

def add_scene_motif(draw, w, h, theme, seed):
    """A few abstract geometric shapes hinting at the theme, kept subtle."""
    rnd = random.Random(seed)
    col_light = (255, 255, 255, 26)
    if theme == "sea":
        # horizon + simple boat silhouette
        horizon_y = int(h * 0.62)
        draw.line([(0, horizon_y), (w, horizon_y)], fill=(255, 255, 255, 40), width=2)
        bx = rnd.randint(int(w*0.15), int(w*0.7))
        by = horizon_y - 6
        draw.polygon([(bx, by), (bx+90, by), (bx+65, by-40), (bx+40,by-40)], fill=(10,20,28,140))
        draw.line([(bx+55, by-40), (bx+55, by-95)], fill=(10,20,28,160), width=4)
        draw.polygon([(bx+55, by-95),(bx+55, by-45),(bx+85, by-45)], fill=(255,255,255,60))
    elif theme == "ruins":
        base_y = int(h*0.78)
        for i, cx in enumerate(range(int(w*0.18), int(w*0.85), 90)):
            ch = rnd.randint(160, 260)
            draw.rectangle([cx, base_y-ch, cx+26, base_y], fill=(255,255,255,26))
            draw.rectangle([cx-6, base_y-ch-14, cx+32, base_y-ch], fill=(255,255,255,34))
    elif theme == "adventure":
        base_y = int(h*0.8)
        pts = [(0, base_y)]
        x = 0
        while x < w:
            x += rnd.randint(70, 140)
            pts.append((x, base_y - rnd.randint(60, 220)))
        pts.append((w, base_y))
        pts.append((w, h)); pts.append((0, h))
        draw.polygon(pts, fill=(10, 18, 12, 90))
    elif theme == "spa":
        for i in range(3):
            r = rnd.randint(60, 160)
            cx, cy = rnd.randint(0, w), rnd.randint(0, h)
            draw.ellipse([cx-r, cy-r, cx+r, cy+r], outline=(255,255,255,30), width=3)
    elif theme == "family":
        cx, cy = int(w*0.75), int(h*0.35)
        for r in (140, 100, 60):
            draw.ellipse([cx-r, cy-r*0.6, cx+r, cy+r*0.6], outline=(255,255,255,28), width=3)
    elif theme == "transfer":
        base_y = int(h*0.68)
        draw.rounded_rectangle([w*0.2, base_y, w*0.62, base_y+70], radius=14, fill=(255,255,255,26))
        draw.ellipse([w*0.26, base_y+55, w*0.34, base_y+75], fill=(255,255,255,60))
        draw.ellipse([w*0.5, base_y+55, w*0.58, base_y+75], fill=(255,255,255,60))

def wrap_text(text, fnt, max_w, draw):
    words = text.split()
    lines, cur = [], ""
    for wd in words:
        test = (cur + " " + wd).strip()
        if draw.textlength(test, font=fnt) <= max_w:
            cur = test
        else:
            if cur:
                lines.append(cur)
            cur = wd
    if cur:
        lines.append(cur)
    return lines

def make_placeholder(theme, title, subtitle, index, total, out_path, w=W, h=H):
    variants = THEMES[theme]
    c1, c2 = variants[index % len(variants)]
    img = diagonal_gradient(w, h, c1, c2)
    img = add_pattern(img, seed_offset=index)
    img = add_grain_and_vignette(img)

    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    od = ImageDraw.Draw(overlay)
    add_scene_motif(od, w, h, theme, seed=index * 7 + len(title))
    # bottom gradient scrim for text legibility
    scrim = Image.new("L", (1, h), 0)
    for y in range(h):
        t = max(0, (y - h*0.55) / (h*0.45))
        scrim.putpixel((0, y), int(190 * min(1, t)))
    scrim = scrim.resize((w, h))
    black = Image.new("RGBA", (w, h), (4, 8, 13, 255))
    overlay = Image.alpha_composite(overlay, Image.composite(black, Image.new("RGBA",(w,h),(0,0,0,0)), scrim))
    img = Image.alpha_composite(img.convert("RGBA"), overlay).convert("RGB")

    draw = ImageDraw.Draw(img)
    # Corner brand mark
    brand_f = font(F_SEMI, 22)
    draw.text((36, 32), "MT TRAVEL", font=brand_f, fill=(255, 255, 255, 210))
    # photo index pill
    pill_f = font(F_SEMI, 20)
    pill_txt = f"{index+1:02d} / {total:02d}"
    tw = draw.textlength(pill_txt, font=pill_f)
    px0, py0 = w - tw - 60, 30
    draw.rounded_rectangle([px0, py0, px0 + tw + 28, py0 + 38], radius=19, fill=(0,0,0,90))
    draw.text((px0 + 14, py0 + 8), pill_txt, font=pill_f, fill=(255,255,255,230))

    # Title / subtitle bottom-left
    title_f = font(F_BLACK, 54)
    sub_f = font(F_REG, 26)
    lines = wrap_text(title.upper(), title_f, w * 0.82, draw)
    ty = h - 70 - (len(lines) * 62) - (34 if subtitle else 0)
    for ln in lines:
        draw.text((44, ty), ln, font=title_f, fill=(255, 255, 255, 255))
        ty += 62
    if subtitle:
        draw.text((44, ty + 4), subtitle, font=sub_f, fill=(214, 224, 228, 235))

    img = img.convert("RGB")
    img.save(out_path, "JPEG", quality=82, optimize=True)

def make_wide_hero(theme, title, subtitle, out_path, w=1920, h=1080, seed=1):
    variants = THEMES[theme]
    c1, c2 = variants[seed % len(variants)]
    img = diagonal_gradient(w, h, c1, c2)
    img = add_pattern(img, seed_offset=seed)
    img = add_grain_and_vignette(img, strength=24)
    overlay = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    od = ImageDraw.Draw(overlay)
    add_scene_motif(od, w, h, theme, seed=seed * 3)
    img = Image.alpha_composite(img.convert("RGBA"), overlay).convert("RGB")
    img.save(out_path, "JPEG", quality=85, optimize=True)

def make_avatar(seed, initials, out_path, size=160):
    palette = ["#0E9186","#CE9B41","#2C5170","#B07E2E","#0B7C72","#1C3A52","#D4A853","#12283C"]
    c = hx(palette[seed % len(palette)])
    img = Image.new("RGB", (size, size), c)
    d = ImageDraw.Draw(img)
    # soft diagonal shading
    top = Image.new("RGB", (size, size), lerp(c, (255,255,255), 0.18))
    mask = Image.linear_gradient("L").rotate(45, expand=True).resize((size, size))
    img.paste(top, (0,0), mask)
    d = ImageDraw.Draw(img)
    f = font(F_BLACK, int(size*0.38))
    tw = d.textlength(initials, font=f)
    d.text(((size-tw)/2, size*0.28), initials, font=f, fill=(255,255,255,255))
    img.save(out_path, "PNG")

def make_favicon():
    for size, name in [(32,"favicon-32.png"), (16,"favicon-16.png"), (180,"apple-touch-icon.png"), (512,"icon-512.png")]:
        img = Image.new("RGBA", (size, size), (0,0,0,0))
        d = ImageDraw.Draw(img)
        c1, c2 = hx("#2FC2B4"), hx("#0B7C72")
        grad = Image.new("RGB", (size, size), c1)
        top = Image.new("RGB", (size,size), c2)
        mask = Image.linear_gradient("L").rotate(45, expand=True).resize((size,size))
        grad.paste(top,(0,0),mask)
        radius = int(size*0.26)
        rmask = Image.new("L", (size,size), 0)
        ImageDraw.Draw(rmask).rounded_rectangle([0,0,size,size], radius=radius, fill=255)
        img.paste(grad, (0,0), rmask)
        d = ImageDraw.Draw(img)
        f = font(F_BLACK, int(size*0.52))
        txt = "MT"
        tw = d.textlength(txt, font=f)
        d.text(((size-tw)/2, size*0.20), txt, font=f, fill=(255,255,255,255))
        img.save(os.path.join(OUT, "common", name))
    print("  favicon set (4 sizes) done")

def make_og_image(site):
    w,h = 1200, 630
    img = diagonal_gradient(w,h, "#081019", "#0B7C72")
    img = add_pattern(img)
    draw = ImageDraw.Draw(img)
    f_big = font(F_BLACK, 74)
    f_small = font(F_REG, 30)
    draw.text((70, 230), "MT TRAVEL", font=f_big, fill=(255,255,255,255))
    draw.text((72, 320), "Premium Tours & Experiences in Bodrum, Turkiye", font=f_small, fill=(214,224,228,255))
    img.save(os.path.join(OUT, "common", "og-image.jpg"), quality=88)
    print("  og-image.jpg done")

def make_payment_badges():
    """Simple text-based generic badges (not brand logo reproductions)."""
    labels = ["VISA", "Mastercard", "Amex", "Maestro"]
    for lbl in labels:
        w, h = 120, 76
        img = Image.new("RGB", (w, h), (255,255,255))
        d = ImageDraw.Draw(img)
        d.rounded_rectangle([2,2,w-3,h-3], radius=10, outline=(203,213,218), width=2)
        f = font(F_BLACK, 20 if len(lbl) < 6 else 16)
        tw = d.textlength(lbl, font=f)
        d.text(((w-tw)/2, (h-20)/2), lbl, font=f, fill=(20,32,44))
        img.save(os.path.join(OUT, "common", f"pay-{lbl.lower()}.png"))
    print("  payment badges done")


def main():
    os.makedirs(os.path.join(OUT, "common"), exist_ok=True)
    tours = load_all_tours()
    site = load_site()

    print("Generating tour destination photos...")
    total_imgs = 0
    for t in tours:
        slug = t["slug"]
        prefix = FOLDER_PREFIX[slug]
        folder = os.path.join(OUT, f"{prefix}_images")
        os.makedirs(folder, exist_ok=True)
        title = t["i18n"]["en"]["name"]
        loc = t["i18n"]["en"]["location"]
        n = t["image_count"]
        for i in range(n):
            out_path = os.path.join(folder, f"{prefix}_{i+1:02d}.jpg")
            make_placeholder(t["theme"], title, loc, i, n, out_path)
            total_imgs += 1
        print(f"  {slug:20s} -> {n} images in {prefix}_images/")
    print(f"Total tour images: {total_imgs}")

    print("Generating site-wide hero banners...")
    make_wide_hero("sea", "Bodrum", "Aegean coastline", os.path.join(OUT, "common", "hero-home.jpg"), seed=0)
    make_wide_hero("sea", "MT Travel", "About us", os.path.join(OUT, "common", "banner-about.jpg"), seed=1)
    make_wide_hero("transfer", "Contact", "Get in touch", os.path.join(OUT, "common", "banner-contact.jpg"), seed=2)
    make_wide_hero("adventure", "FAQ", "Answers", os.path.join(OUT, "common", "banner-faq.jpg"), seed=3)
    make_wide_hero("sea", "Tours", "All experiences", os.path.join(OUT, "common", "banner-tours.jpg"), seed=4)
    make_wide_hero("ruins", "Destinations", "Explore", os.path.join(OUT, "common", "banner-destinations.jpg"), seed=5)
    make_wide_hero("transfer", "Login", "Admin Panel", os.path.join(OUT, "common", "banner-admin-login.jpg"), seed=6)
    print("  7 hero/banner images done")

    print("Generating review avatars...")
    reviews = load_reviews()
    for r in reviews:
        initials = "".join([p[0] for p in r["name"].split()[:2]]).upper()
        make_avatar(int(r["avatar_bg"]), initials, os.path.join(OUT, "common", f"avatar-{r['id']}.png"))
    # admin user + team placeholders
    make_avatar(3, "AU", os.path.join(OUT, "common", "avatar-admin.png"), size=160)
    for i, initials in enumerate(["MT","EK","SD","YA"]):
        make_avatar(i+4, initials, os.path.join(OUT, "common", f"team-{i+1}.png"), size=440)
    print(f"  {len(reviews)} review avatars + admin + 4 team photos done")

    make_favicon()
    make_og_image(site)
    make_payment_badges()

    print("\nAll placeholder assets generated successfully.")

if __name__ == "__main__":
    main()
