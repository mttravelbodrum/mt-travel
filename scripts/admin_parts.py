import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon
from helpers import load_site

SITE = load_site()
COMPANY = SITE["company"]

ADMIN_NAV = [
    ("dashboard", "dashboard.html", "grid", "admin.dashboard", "Dashboard"),
    ("reservations", "reservations.html", "clipboard-check", "admin.bookings", "Reservations"),
    ("tours", "tours.html", "map", "admin.tours", "Tours"),
    ("hotels", "hotels.html", "bank", "admin.hotels", "Hotels"),
    ("customers", "customers.html", "users", "admin.customers", "Customers"),
    ("media", "media.html", "image", "admin.media", "Media Library"),
    ("reports", "reports.html", "bar-chart", "admin.reports", "Reports"),
    ("settings", "settings.html", "settings", "admin.settings", "Settings"),
]


def admin_head(title, slug=None, extra_css=None):
    extra_css = extra_css or []
    slug = slug or title.lower()
    return cp.head(
        title=f"{title} | MT Travel Admin",
        description="MT Travel yönetim paneli.",
        rel="../",
        canonical_path=f"admin/{slug}.html",
        css_extra=["admin"] + extra_css,
        noindex=True
    )


def sidebar(active):
    items = []
    for key, href, icon_name, i18n_key, label in ADMIN_NAV:
        cls = "is-active" if key == active else ""
        items.append(f'<li><a href="{href}" class="{cls}">{icon(icon_name, 18)}<span data-i18n="{i18n_key}">{label}</span></a></li>')
    nav_html = "\n        ".join(items)
    return f'''<aside class="admin-sidebar" id="adminSidebar">
      <div class="admin-sidebar__brand">
        {cp.logo(rel="../")}
      </div>
      <div class="admin-sidebar__scroll">
        <p class="admin-nav-label" data-i18n="admin.management">Management</p>
        <ul class="admin-nav">
        {nav_html}
        </ul>
      </div>
      <div class="admin-sidebar__foot">
        <a href="../index.html" target="_blank">{icon('globe',17)}<span data-i18n="admin.view_website">View Website</span></a>
        <a href="login.html" data-admin-logout style="margin-top:10px;">{icon('log-out',17)}<span data-i18n="admin.logout">Logout</span></a>
      </div>
    </aside>'''


def topbar(page_title, page_title_key=None):
    title_attr = f' data-i18n="{page_title_key}"' if page_title_key else ""
    return f'''<div class="admin-topbar">
      <div class="admin-topbar__title">
        <button class="admin-burger" id="adminBurger" aria-label="Toggle menu" data-i18n-aria-label="a11y.toggle_menu">{icon('menu', 20)}</button>
        <h1{title_attr}>{page_title}</h1>
        <span class="badge badge--outline" id="globalDataSourceBadge" style="margin-left:10px;" data-i18n="admin.connecting">Connecting...</span>
      </div>
      <div class="admin-topbar__actions">
        <div class="tb-dropdown" id="adminLangDropdown">
          <button class="tb-dropdown__btn" type="button" style="color:var(--ink-900);">
            <img class="tb-dropdown__flag" id="currentLangFlag" data-rel="../" src="../assets/icons/flags/tr.png" alt="">
            <span id="currentLangLabel">TR</span>{icon('chevron-down', 10, 'chev')}
          </button>
          <div class="tb-dropdown__menu">
          {"".join(f'<button class="tb-dropdown__item{" is-active" if l["code"]=="en" else ""}" data-lang="{l["code"]}"><img class="tb-dropdown__flag" src="../assets/icons/flags/{l["flag"]}.png" alt=""> {l["native"]}</button>' for l in SITE["languages"])}
          </div>
        </div>
        <button class="admin-notif" id="adminNotifBtn" aria-label="Notifications">
          {icon('bell', 19)}<span class="admin-notif__dot"></span>
        </button>
        <div class="tb-dropdown" id="adminNotifWrap" style="position:relative;">
          <div class="tb-dropdown__menu" id="adminNotifPanel" style="right:0; left:auto; min-width:300px;">
            <div style="padding:10px 12px; font-weight:800; font-size:.85rem; color:var(--navy-900);" data-i18n="admin.recent_notifications">Recent Notifications</div>
            <div style="padding:16px 12px; font-size:.82rem; color:var(--slate-400);" data-i18n="admin.loading">Loading...</div>
          </div>
        </div>
        <div class="admin-user">
          <img src="../assets/images/common/avatar-admin.png" alt="Admin user" data-i18n-alt="a11y.admin_user">
          <div><strong data-i18n="admin.user_name">Admin User</strong><span data-i18n="admin.user_role">Administrator</span></div>
        </div>
      </div>
    </div>'''


def shell_open(active, page_title, page_title_key=None):
    return f'''<body class="admin-body">
  <div class="admin-shell">
    {sidebar(active)}
    <div class="admin-main">
      {topbar(page_title, page_title_key)}
      <div class="admin-content">'''


def shell_close(extra_scripts=None):
    extra_scripts = extra_scripts or []
    return f'''      </div>
    </div>
  </div>
  {cp.admin_scripts(rel="../", extra=extra_scripts)}
</body>
</html>'''


def modal(id_, title, body_html, footer_html=""):
    return f'''<div class="modal-overlay" id="{id_}">
    <div class="modal-box" style="position:relative;">
      <button class="modal-close" data-modal-close aria-label="Close">{icon('x', 18)}</button>
      <h3 style="margin-bottom:20px;">{title}</h3>
      {body_html}
      {footer_html}
    </div>
  </div>'''
