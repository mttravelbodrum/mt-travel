import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site", "admin")
os.makedirs(OUT, exist_ok=True)


def build():
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title="Yönetici Girişi | MT Travel",
      description="MT Travel yönetici paneli girişi.",
      rel="../", canonical_path="admin/login.html", css_extra=["admin"], noindex=True
  )}
</head>
<body class="admin-body">
  <div class="login-shell">
    <div class="login-shell__art">
      <div class="login-art-content">
        <img src="../assets/images/common/banner-admin-login.jpg" alt="">
        <h2 style="color:#fff;" data-i18n="admin.login_art_title">Manage MT Travel</h2>
        <p style="color:var(--slate-300);" data-i18n="admin.login_art_sub">Reservations, tours, customers and reports - all in one place.</p>
      </div>
    </div>
    <div class="login-shell__form">
      <div class="login-box">
        {cp.logo(rel="../")}
        <h2 style="margin-top:28px;" data-i18n="admin.login_title">Welcome Back</h2>
        <p style="margin-bottom:28px;" data-i18n="admin.login_sub">Sign in to manage MT Travel</p>
        <form id="adminLoginForm">
          <div class="field">
            <label class="field-label" for="loginEmail" data-i18n="form.email">Email Address</label>
            <div class="input-icon-wrap">
              {icon('mail', 18)}
              <input class="input" type="email" id="loginEmail" autocomplete="username" placeholder="admin@mttravel.com">
            </div>
            <div class="field-error">{icon('alert-triangle',14)}<span data-i18n="validate.email">Please enter a valid email address.</span></div>
          </div>
          <div class="field">
            <label class="field-label" for="loginPassword" data-i18n="form.password">Password</label>
            <div class="input-icon-wrap">
              {icon('lock', 18)}
              <input class="input" type="password" id="loginPassword" autocomplete="current-password">
            </div>
            <div class="field-error">{icon('alert-triangle',14)}<span data-i18n="validate.password_length">Password must be at least 4 characters.</span></div>
          </div>
          <div style="display:flex; align-items:center; margin-bottom:24px;">
            <div class="checkbox-row" style="align-items:center;">
              <input type="checkbox" id="rememberMe" checked>
              <label for="rememberMe" data-i18n="admin.remember_me">Remember me</label>
            </div>
          </div>
          <button type="submit" class="btn btn--primary btn--block" id="adminLoginBtn" data-i18n="admin.login_btn">Sign In</button>
          <p style="text-align:center; margin-top:20px; font-size:.8rem; color:var(--slate-400);" data-i18n="admin.login_note">Requires the backend server to be running (cd backend, then node server.js). Change the default seeded admin password before going live (see backend/README.md).</p>
        </form>
      </div>
    </div>
  </div>
  {cp.admin_scripts(rel="../", extra=["admin-login"])}
</body>
</html>'''
    with open(os.path.join(OUT, "login.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  admin/login.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
