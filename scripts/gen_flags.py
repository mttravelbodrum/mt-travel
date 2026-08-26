"""
Simplified, recognizable flag badges (24x18, rounded) drawn from basic
shapes only - no external assets or fonts needed. Good enough for a
small UI badge; not intended as a precise vexillological reference.
"""
import sys, os
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
from PIL import Image, ImageDraw

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "assets", "icons", "flags")
W, H = 60, 45  # 4:3, scaled down by CSS to 18x13 / 20x14 etc.

def save(img, code):
    os.makedirs(OUT, exist_ok=True)
    img.save(os.path.join(OUT, f"{code.lower()}.png"))

def stripes_h(colors):
    img = Image.new("RGB", (W, H))
    d = ImageDraw.Draw(img)
    n = len(colors)
    band = H / n
    for i, c in enumerate(colors):
        d.rectangle([0, i*band, W, (i+1)*band + 1], fill=c)
    return img

def stripes_v(colors):
    img = Image.new("RGB", (W, H))
    d = ImageDraw.Draw(img)
    n = len(colors)
    band = W / n
    for i, c in enumerate(colors):
        d.rectangle([i*band, 0, (i+1)*band + 1, H], fill=c)
    return img

def flag_tr():
    img = Image.new("RGB", (W, H), (227, 10, 23))
    d = ImageDraw.Draw(img)
    d.ellipse([18, 9, 36, 27], fill=(255, 255, 255))
    d.ellipse([22, 9, 40, 27], fill=(227, 10, 23))
    # star (simple diamond as compact stylised star)
    cx, cy = 39, 18
    d.polygon([(cx, cy-5), (cx+4, cy), (cx, cy+5), (cx-4, cy)], fill=(255, 255, 255))
    return img

def flag_gb():
    img = Image.new("RGB", (W, H), (12, 33, 92))
    d = ImageDraw.Draw(img)
    # white diagonals
    d.line([(0,0),(W,H)], fill=(255,255,255), width=10)
    d.line([(0,H),(W,0)], fill=(255,255,255), width=10)
    # red diagonals (thinner, offset)
    d.line([(0,0),(W,H)], fill=(200,16,46), width=4)
    d.line([(0,H),(W,0)], fill=(200,16,46), width=4)
    # white cross
    d.rectangle([0, H/2-7, W, H/2+7], fill=(255,255,255))
    d.rectangle([W/2-9, 0, W/2+9, H], fill=(255,255,255))
    # red cross
    d.rectangle([0, H/2-4, W, H/2+4], fill=(200,16,46))
    d.rectangle([W/2-5, 0, W/2+5, H], fill=(200,16,46))
    return img

def flag_us():
    img = stripes_h([(179,25,43)]*1 + [(255,255,255)]*1)
    img = Image.new("RGB", (W, H), (255,255,255))
    d = ImageDraw.Draw(img)
    band = H/7
    for i in range(7):
        if i % 2 == 0:
            d.rectangle([0, i*band, W, (i+1)*band+1], fill=(179,25,43))
    d.rectangle([0,0,W*0.42,H*0.55], fill=(10,49,97))
    for r in range(3):
        for c in range(4):
            d.ellipse([4+c*6, 4+r*6, 6+c*6, 6+r*6], fill=(255,255,255))
    return img

def flag_gr():
    img = Image.new("RGB", (W, H), (13, 94, 175))
    d = ImageDraw.Draw(img)
    band = H/9
    for i in range(9):
        if i % 2 == 0:
            d.rectangle([0, i*band, W, (i+1)*band+1], fill=(255,255,255))
    d.rectangle([0,0,W*0.42,H*0.55], fill=(13,94,175))
    d.rectangle([0, H*0.22, W*0.42, H*0.33], fill=(255,255,255))
    d.rectangle([W*0.17, 0, W*0.25, H*0.55], fill=(255,255,255))
    return img

def flag_ae():
    img = Image.new("RGB", (W, H))
    d = ImageDraw.Draw(img)
    d.rectangle([0,0,W,H/3], fill=(0,115,47))
    d.rectangle([0,H/3,W,2*H/3], fill=(255,255,255))
    d.rectangle([0,2*H/3,W,H], fill=(0,0,0))
    d.rectangle([0,0,W*0.22,H], fill=(237,28,36))
    return img

def flag_sa():
    img = Image.new("RGB", (W, H), (0,104,60))
    return img

def flag_ie():
    return stripes_v([(22,140,86),(255,255,255),(255,130,80)])

def flag_ca():
    img = Image.new("RGB", (W, H), (255,255,255))
    d = ImageDraw.Draw(img)
    d.rectangle([0,0,W*0.25,H], fill=(200,16,46))
    d.rectangle([W*0.75,0,W,H], fill=(200,16,46))
    d.polygon([(W/2,H*0.2),(W/2-4,H*0.45),(W/2-14,H*0.4),(W/2-6,H*0.55),(W/2-10,H*0.58),
                (W/2,H*0.68),(W/2+10,H*0.58),(W/2+6,H*0.55),(W/2+14,H*0.4),(W/2+4,H*0.45)], fill=(200,16,46))
    return img

def flag_au():
    img = Image.new("RGB", (W, H), (10,32,79))
    d = ImageDraw.Draw(img)
    d.line([(0,0),(W*0.4,H)], fill=(255,255,255), width=5)
    d.line([(0,H),(W*0.4,0)], fill=(255,255,255), width=5)
    d.rectangle([0, H/2-4, W*0.4, H/2+4], fill=(255,255,255))
    d.rectangle([W*0.2-4, 0, W*0.2+4, H], fill=(255,255,255))
    for x,y,r in [(W*0.7,H*0.25,4),(W*0.85,H*0.5,4),(W*0.7,H*0.75,4),(W*0.55,H*0.9,3)]:
        d.ellipse([x-r,y-r,x+r,y+r], fill=(255,255,255))
    return img

SIMPLE = {
    "de": lambda: stripes_h([(0,0,0),(221,0,0),(255,206,0)]),
    "ru": lambda: stripes_h([(255,255,255),(0,57,166),(213,43,30)]),
    "pl": lambda: stripes_h([(255,255,255),(220,20,60)]),
    "fr": lambda: stripes_v([(0,85,164),(255,255,255),(239,65,53)]),
    "it": lambda: stripes_v([(0,146,70),(255,255,255),(206,43,55)]),
    "nl": lambda: stripes_h([(174,28,40),(255,255,255),(33,70,139)]),
    "es": lambda: stripes_h([(170,21,27),(255,196,0),(255,196,0),(170,21,27)]),
    "be": lambda: stripes_v([(0,0,0),(255,205,0),(237,41,57)]),
    "at": lambda: stripes_h([(237,41,57),(255,255,255),(237,41,57)]),
    "ch": lambda: _swiss(),
    "se": lambda: _nordic_cross((0,82,163),(255,205,0)),
    "no": lambda: _nordic_cross((186,12,47),(255,255,255),(0,32,91)),
    "dk": lambda: _nordic_cross((198,12,48),(255,255,255)),
    "ua": lambda: stripes_h([(0,87,183),(255,213,0)]),
    "cz": lambda: _czech(),
    "ro": lambda: stripes_v([(0,43,127),(252,209,22),(206,17,38)]),
    "pt": lambda: stripes_v([(0,102,52),(255,0,0),(255,0,0)]),
    "hu": lambda: stripes_h([(206,17,38),(255,255,255),(0,106,78)]),
    "fi": lambda: _nordic_cross((255,255,255),(0,53,128)),
    "bg": lambda: stripes_h([(255,255,255),(0,150,80),(214,38,18)]),
}

def _swiss():
    img = Image.new("RGB", (W,H), (255,0,0))
    d = ImageDraw.Draw(img)
    d.rectangle([W/2-3, H*0.22, W/2+3, H*0.78], fill=(255,255,255))
    d.rectangle([W*0.28, H/2-3, W*0.72, H/2+3], fill=(255,255,255))
    return img

def _nordic_cross(bg, cross, cross2=None):
    img = Image.new("RGB", (W,H), bg)
    d = ImageDraw.Draw(img)
    cx = W*0.36
    d.rectangle([0, H/2-6, W, H/2+6], fill=cross)
    d.rectangle([cx-6, 0, cx+6, H], fill=cross)
    if cross2:
        d.rectangle([0, H/2-2, W, H/2+2], fill=cross2)
        d.rectangle([cx-2, 0, cx+2, H], fill=cross2)
    return img

def _czech():
    img = stripes_h([(255,255,255),(211,15,36)])
    d = ImageDraw.Draw(img)
    d.polygon([(0,0),(W*0.42,H/2),(0,H)], fill=(17,55,121))
    return img

def flag_other():
    img = Image.new("RGB", (W,H), (100,117,127))
    d = ImageDraw.Draw(img)
    d.ellipse([W/2-16,H/2-16,W/2+16,H/2+16], outline=(255,255,255), width=2)
    d.line([(W/2-16,H/2),(W/2+16,H/2)], fill=(255,255,255), width=2)
    d.ellipse([W/2-8,H/2-16,W/2+8,H/2+16], outline=(255,255,255), width=2)
    return img

def main():
    flag_tr().save(os.path.join(OUT, "tr.png")) if False else save(flag_tr(), "tr")
    save(flag_gb(), "gb")
    save(flag_us(), "us")
    save(flag_gr(), "gr")
    save(flag_ae(), "ae")
    save(flag_sa(), "sa")
    save(flag_ie(), "ie")
    save(flag_ca(), "ca")
    save(flag_au(), "au")
    save(flag_other(), "other")
    for code, fn in SIMPLE.items():
        save(fn(), code)
    print("Flags generated:", len(SIMPLE) + 9)

if __name__ == "__main__":
    main()
