import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
import admin_parts as ap
from icons import icon
from helpers import load_site

SITE = load_site()
COMPANY = SITE["company"]
OUT = os.path.join(os.path.dirname(__file__), "..", "site", "admin")


def build():
    languages_html = "\n          ".join(
        f'<div class="coupon-card"><div style="display:flex; align-items:center; gap:12px;"><img src="../assets/icons/flags/{l["flag"]}.png" style="width:26px; height:19px; border-radius:3px;"><strong>{l["native"]}</strong></div></div>'
        for l in SITE["languages"]
    )

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {ap.admin_head("Ayarlar", slug="settings")}
</head>
{ap.shell_open("settings", "Settings", "admin.settings")}
<div id="adminSettingsApp">
  <div class="admin-grid-main settings-grid">
    <div class="panel" style="height:fit-content;">
      <div class="settings-tabs">
        <button class="settings-tab-btn is-active" data-settings-tab="company">{icon('globe',17)}<span data-i18n="admin.tab_company">Company Info</span></button>
        <button class="settings-tab-btn" data-settings-tab="booking">{icon('calendar',17)}<span data-i18n="admin.tab_booking">Booking Rules</span></button>
        <button class="settings-tab-btn" data-settings-tab="payment">{icon('credit-card',17)}<span data-i18n="admin.tab_payment">Payment</span></button>
        <button class="settings-tab-btn" data-settings-tab="languages">{icon('flag',17)}<span data-i18n="admin.tab_languages">Languages</span></button>
        <button class="settings-tab-btn" data-settings-tab="seo">{icon('bar-chart',17)}<span data-i18n="admin.tab_seo">SEO</span></button>
        <button class="settings-tab-btn" data-settings-tab="backup">{icon('download',17)}<span data-i18n="admin.tab_backup">Backup &amp; Restore</span></button>
      </div>
    </div>

    <div class="panel">
      <!-- COMPANY INFO -->
      <div data-settings-panel="company">
        <div class="admin-form-section">
          <div class="admin-form-section__head"><h4 data-i18n="admin.company_information">Company Information</h4><p data-i18n="admin.company_info_sub">Shown across the header, footer and contact page.</p></div>
          <form data-settings-save>
            <div class="field"><label class="field-label" for="settingCompanyName" data-i18n="admin.company_name">Company Name</label><input class="input" id="settingCompanyName" value="{COMPANY['name']}"></div>
            <div class="field-row">
              <div class="field"><label class="field-label" for="settingPhone" data-i18n="form.phone_label">Phone</label><input class="input" id="settingPhone" value="{COMPANY['phone_display']}"></div>
              <div class="field"><label class="field-label" for="settingWhatsapp" data-i18n="admin.whatsapp_number">WhatsApp Number</label><input class="input" id="settingWhatsapp" value="{COMPANY['whatsapp_link']}"></div>
            </div>
            <div class="field"><label class="field-label" for="settingEmail" data-i18n="form.email_label">Email</label><input class="input" id="settingEmail" value="{COMPANY['email']}"></div>
            <div class="field"><label class="field-label" for="settingAddress" data-i18n="admin.office_address">Office Address</label><input class="input" id="settingAddress" value="{COMPANY['address_en']}"></div>
            <button type="submit" class="btn btn--primary" data-i18n="admin.save_changes">Save Changes</button>
          </form>
        </div>
      </div>

      <!-- BOOKING RULES -->
      <div data-settings-panel="booking" style="display:none;">
        <div class="admin-form-section">
          <div class="admin-form-section__head"><h4 data-i18n="admin.booking_rules">Booking Rules</h4><p data-i18n="admin.booking_rules_sub">Controls the date validation rules used on the booking page.</p></div>
          <form data-settings-save>
            <div class="field">
              <label class="field-label" for="settingIslandAdvance" data-i18n="admin.island_advance">Island Tour Minimum Advance (days)</label>
              <input class="input" id="settingIslandAdvance" type="number" min="0" value="{COMPANY['island_min_advance_days']}">
              <div class="field-hint" data-i18n="admin.island_advance_hint">Applies to Kos, Leros, Kalymnos and any tour marked as an island tour.</div>
            </div>
            <div class="field">
              <label class="field-label" for="settingDefaultLanguage" data-i18n="admin.default_language">Default Language</label>
              <div class="select-wrap">
                <select class="select" id="settingDefaultLanguage">
                  <option value="en">English</option>
                  <option value="tr">Turkce</option>
                  <option value="de">Deutsch</option>
                  <option value="ru">Русский</option>
                  <option value="pl">Polski</option>
                </select>
                {icon('chevron-down',16)}
              </div>
            </div>
            <button type="submit" class="btn btn--primary" data-i18n="admin.save_changes">Save Changes</button>
          </form>
        </div>
      </div>

      <!-- PAYMENT -->
      <div data-settings-panel="payment" style="display:none;">
        <div class="admin-form-section">
          <div class="admin-form-section__head"><h4 data-i18n="admin.payment_settings">Payment Settings</h4><p data-i18n="admin.payment_settings_sub">MT Travel currently uses a single reservation method - no online payment is collected.</p></div>
          <form data-settings-save>
            <div class="field"><label class="field-label" for="settingCurrency" data-i18n="admin.default_currency">Default Currency</label>
              <div class="select-wrap"><select class="select" id="settingCurrency"><option>EUR</option><option>USD</option><option>GBP</option><option>TRY</option></select>{icon('chevron-down',16)}</div>
            </div>
            <div class="admin-form-section__head" style="margin-top:10px;"><h4 data-i18n="admin.active_method">Active Reservation Method</h4></div>
            <div class="checkbox-row" style="margin-bottom:12px;"><input type="checkbox" checked disabled><label data-i18n="payment.reserve_later">Reserve Now, Pay on Tour Day</label></div>
            <div class="field-hint" style="margin-bottom:16px;" data-i18n="admin.payment_removed_note">Online payment, bank transfer and coupon codes have been removed sitewide per your latest update. Guests reserve online and pay in person on the day of the tour.</div>
            <button type="submit" class="btn btn--primary" data-i18n="admin.save_changes">Save Changes</button>
          </form>
        </div>
      </div>

      <!-- LANGUAGES -->
      <div data-settings-panel="languages" style="display:none;">
        <div class="admin-form-section">
          <div class="admin-form-section__head"><h4 data-i18n="admin.language_management">Language Management</h4><p data-i18n="admin.language_management_sub">Each language is stored as its own translation file, so editing one never affects another.</p></div>
          {languages_html}
        </div>
      </div>

      <!-- SEO -->
      <div data-settings-panel="seo" style="display:none;">
        <div class="admin-form-section">
          <div class="admin-form-section__head"><h4 data-i18n="admin.seo_defaults">SEO Defaults</h4><p data-i18n="admin.seo_defaults_sub">Applied when a page doesn't specify its own title or description.</p></div>
          <form data-settings-save>
            <div class="field"><label class="field-label" data-i18n="admin.default_meta_title">Default Meta Title</label><input class="input" value="MT Travel | Bodrum, Türkiye'de Premium Turlar"></div>
            <div class="field"><label class="field-label" data-i18n="admin.default_meta_description">Default Meta Description</label><textarea class="textarea">Otelden alış ve İngilizce konuşan rehberlerle Bodrum'da premium turlar ayırtın.</textarea></div>
            <button type="submit" class="btn btn--primary" data-i18n="admin.save_changes">Save Changes</button>
          </form>
        </div>
      </div>

      <!-- BACKUP & RESTORE -->
      <div data-settings-panel="backup" style="display:none;">
        <div class="admin-form-section">
          <div class="admin-form-section__head">
            <h4 data-i18n="admin.tab_backup">Backup &amp; Restore</h4>
            <p data-i18n="admin.backup_sub">This admin panel runs entirely on the real backend now - there is no separate browser-only data to export from here.</p>
          </div>
          <div class="calendar-note">
            {icon('info',17)}<span data-i18n="admin.backup_note">Every reservation, tour, and setting lives in one file on the server: backend/data/db.json. Back it up by copying that file; restore by copying an old version back (with the server stopped). See backend/README.md section 3 for details.</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
{ap.shell_close(extra_scripts=["admin-settings"])}
'''
    with open(os.path.join(OUT, "settings.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  admin/settings.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
