"""
turkify_source.py — post-processing pass that makes Turkish the actual
HTML source, not just a language JS switches to. Runs AFTER build_all.py.

For every element with data-i18n="key" / data-i18n-placeholder="key" /
data-i18n-aria-label="key" / data-i18n-title="key", replaces the current
(English) default text/attribute with the Turkish translation from
tr.json - the same key the JS uses, so this stays perfectly in sync with
the translation system already in place.
"""
import json, os, re
from bs4 import BeautifulSoup, NavigableString

SITE = os.path.join(os.path.dirname(__file__), "..", "site")
I18N = os.path.join(SITE, "assets", "js", "i18n")

with open(os.path.join(I18N, "tr.json"), encoding="utf-8") as f:
    TR = json.load(f)

def process_file(path):
    with open(path, encoding="utf-8") as f:
        content = f.read()
    soup = BeautifulSoup(content, "html.parser")
    changed = 0
    skipped = []

    for el in soup.find_all(attrs={"data-i18n": True}):
        key = el.get("data-i18n")
        if key not in TR:
            continue
        # Only replace pure-text elements (no child tags) - elements with
        # nested icons/spans were already fixed to wrap just the text
        # portion in an earlier pass; anything with child elements here
        # would be a new instance of that same bug, so we skip + report
        # instead of silently breaking it.
        child_tags = [c for c in el.children if not isinstance(c, NavigableString)]
        if child_tags:
            skipped.append((path, key, str(el)[:80]))
            continue
        new_val = TR[key]
        if el.string != new_val:
            el.string = new_val
            changed += 1

    for el in soup.find_all(attrs={"data-i18n-placeholder": True}):
        key = el.get("data-i18n-placeholder")
        if key in TR:
            el["placeholder"] = TR[key]
            changed += 1

    for el in soup.find_all(attrs={"data-i18n-aria-label": True}):
        key = el.get("data-i18n-aria-label")
        if key in TR:
            el["aria-label"] = TR[key]
            changed += 1

    for el in soup.find_all(attrs={"data-i18n-title": True}):
        key = el.get("data-i18n-title")
        if key in TR:
            el["title"] = TR[key]
            changed += 1

    if changed:
        with open(path, "w", encoding="utf-8") as f:
            f.write(str(soup))
    return changed, skipped


def main():
    total = 0
    all_skipped = []
    files_touched = 0
    for root, dirs, files in os.walk(SITE):
        for fn in files:
            if fn.endswith(".html"):
                path = os.path.join(root, fn)
                changed, skipped = process_file(path)
                if changed:
                    files_touched += 1
                    total += changed
                all_skipped.extend(skipped)
    print(f"Replaced {total} default-text instances with Turkish across {files_touched} files.")
    if all_skipped:
        print(f"\n{len(all_skipped)} elements SKIPPED (have child elements - need manual review):")
        for path, key, snippet in all_skipped[:20]:
            print(f"  {os.path.relpath(path, SITE)} | key={key} | {snippet}")


if __name__ == "__main__":
    main()
