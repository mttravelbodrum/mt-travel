import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
import admin_parts as ap
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "admin")


def build():
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {ap.admin_head("Medya Kütüphanesi", slug="media")}
</head>
{ap.shell_open("media", "Media Library", "admin.media")}
<div id="adminMediaApp">
  <div class="panel" style="margin-bottom:24px;">
    <div class="calendar-note" style="margin:0;">
      {icon('info', 17)}<span data-i18n="admin.media_management_note">Photos are managed by placing image files directly in each tour's folder under assets/images/ - see backend/README.md. This page shows what's currently there.</span>
    </div>
  </div>

  <div class="panel">
    <div class="media-folder-tabs" id="mediaFolderTabs"></div>
    <p style="font-size:.85rem; color:var(--slate-500); margin-bottom:16px;" id="mediaResultsCount"></p>
    <div class="media-grid" id="mediaGrid"></div>
  </div>
</div>
{ap.shell_close(extra_scripts=["admin-media"])}
'''
    with open(os.path.join(OUT, "media.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  admin/media.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
