import sys, os, json
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon
from helpers import load_site

SITE = load_site()
COMPANY = SITE["company"]
OUT = os.path.join(os.path.dirname(__file__), "..", "site")


def build_about():

    timeline = [
        ("2005", "about.timeline_2005"), ("2011", "about.timeline_2011"), ("2016", "about.timeline_2016"),
        ("2022", "about.timeline_2022"), ("Today", "about.timeline_today"),
    ]
    timeline_html = "\n          ".join(f'<li data-reveal><strong>{y}</strong><p data-i18n="{k}"></p></li>' for y, k in timeline)

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title="Hakkımızda | MT Travel Bodrum",
      description="MT Travel, 2005'ten bu yana Bodrum ve Ege'de gezginlere rehberlik ediyor - lisanslı yerel rehberler, güvenli rezervasyon ve her yıl binlerce mutlu misafir.",
      canonical_path="about.html"
  )}
</head>
<body>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>
  {cp.topbar()}
  {cp.header(active="about")}

  <main id="mainContent">
    {cp.page_banner("", "MT Travel Hakkında", "Bodrum ve Ege kıyılarının en güzellerini gezginlere gösterdiğimiz yirmi yıl.", [("Hakkımızda", None, "nav.about")], title_key="about.page_title", subtitle_key="about.page_sub")}

    <section class="section">
      <div class="container">
        <div class="contact-grid" style="align-items:center;">
          <div data-reveal="left">
            <span class="eyebrow" data-i18n="about.eyebrow_story">Our Story</span>
            <h2 data-i18n="about.story_title">Local Roots, International Standards</h2>
            <p data-i18n="about.story_p1"></p>
            <p style="margin-top:14px;" data-i18n="about.story_p2"></p>
            <div class="divider-gold"></div>
            <a href="contact.html" class="btn btn--primary" style="margin-top:10px;"><span data-i18n="about.get_in_touch">Get in Touch</span> {icon('arrow-right',16)}</a>
          </div>
          <div data-reveal="right">
            <img src="assets/images/common/banner-about.jpg" alt="MT Travel team on the water in Bodrum" style="border-radius:var(--radius-xl); box-shadow: var(--shadow-lg);">
          </div>
        </div>
      </div>
    </section>

    <section class="section" style="padding-bottom: var(--space-20);">
      <div class="container">
        <div class="section-head center" data-reveal>
          <span class="eyebrow" style="justify-content:center;" data-i18n="about.eyebrow_journey">Our Journey</span>
          <h2 data-i18n="about.journey_title">How We Got Here</h2>
        </div>
        <ul class="timeline" style="max-width:700px; margin-inline:auto;">
        {timeline_html}
        </ul>
      </div>
    </section>

    <section class="section">
      <div class="container">
        <div class="cta-banner" data-reveal="scale">
          <div class="cta-banner__inner">
            <h2 data-i18n="section.cta_title">Ready for Your Bodrum Adventure?</h2>
            <p data-i18n="section.cta_sub">Secure your spot in minutes.</p>
            <div class="cta-banner__actions">
              <a href="tours.html" class="btn btn--primary btn--lg" data-i18n="nav.book_now">Book Now</a>
              <a href="contact.html" class="btn btn--outline btn--lg" data-i18n="footer.contact_us">Contact Us</a>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>

  {cp.footer()}
  {cp.scripts()}
</body>
</html>'''
    with open(os.path.join(OUT, "about.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  about.html written ({len(html)} chars)")


def build_contact():
    map_query = COMPANY["address_en"].replace(" ", "+").replace(",", "%2C")
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title="Bize Ulaşın | MT Travel Bodrum",
      description="MT Travel ile iletişime geçin - telefon, WhatsApp, e-posta veya Bodrum'daki ofisimizi ziyaret edin. Ekibimiz her gün 08:00-20:00 arası yanıt veriyor.",
      canonical_path="contact.html"
  )}
  {cp.local_business_schema()}
  {cp.breadcrumb_schema("", [("Contact", None)])}
</head>
<body>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>
  {cp.topbar()}
  {cp.header(active="contact")}

  <main id="mainContent">
    {cp.page_banner("", "Bize Ulaşın", "Bir tur, rezervasyon veya özel bir planlama hakkında sorularınız mı var? Yardımcı olmak için buradayız.", [("İletişim", None, "nav.contact")], title_key="contact.page_title", subtitle_key="contact.page_sub")}

    <section class="section">
      <div class="container">
        <div class="contact-grid">
          <div data-reveal="left">
            <span class="eyebrow" data-i18n="contact.eyebrow">Get In Touch</span>
            <h2 data-i18n="contact.title">We'd Love to Hear From You</h2>
            <p style="margin-bottom:28px;" data-i18n="contact.subtitle">Reach us directly, or send a message and our team will reply the same day.</p>

            <div class="contact-info-card">
              <span class="icon-circle">{icon('phone',21)}</span>
              <div><h6 data-i18n="contact.call_us">Call Us</h6><p><a href="tel:{COMPANY['phone_link']}" data-company-field="phone_href"><span data-company-field="phone_display">{COMPANY['phone_display']}</span></a></p></div>
            </div>
            <div class="contact-info-card">
              <span class="icon-circle">{icon('whatsapp',21)}</span>
              <div><h6>WhatsApp</h6><p><a href="https://wa.me/{COMPANY['whatsapp_link']}" target="_blank" rel="noopener" data-company-field="whatsapp_href"><span data-company-field="phone_display">{COMPANY['phone_display']}</span></a> &middot; 24/7</p></div>
            </div>
            <div class="contact-info-card">
              <span class="icon-circle">{icon('mail',21)}</span>
              <div><h6 data-i18n="form.email">Email</h6><p><a href="mailto:{COMPANY['email']}" data-company-field="email_href"><span data-company-field="email">{COMPANY['email']}</span></a></p></div>
            </div>
            <div class="contact-info-card">
              <span class="icon-circle">{icon('map-pin',21)}</span>
              <div><h6 data-i18n="contact.office">Office</h6><p data-company-field="address">{COMPANY['address_en']}</p></div>
            </div>
            <div class="contact-info-card">
              <span class="icon-circle">{icon('clock',21)}</span>
              <div><h6 data-i18n="topbar.hours">Working Hours</h6><p data-i18n="topbar.hours">{COMPANY['hours_en']}</p></div>
            </div>
          </div>

          <div data-reveal="right">
            <div class="flow-card">
              <h3 data-i18n="contact.send_message_title">Send a Message</h3>
              <form id="contactForm">
                <div class="field-row">
                  <div class="field">
                    <label class="field-label" for="contactFirstName" data-i18n="form.first_name">First Name</label>
                    <input class="input" id="contactFirstName" required>
                  </div>
                  <div class="field">
                    <label class="field-label" for="contactLastName" data-i18n="form.last_name">Last Name</label>
                    <input class="input" id="contactLastName" required>
                  </div>
                </div>
                <div class="field">
                  <label class="field-label" for="contactEmail" data-i18n="form.email">Email Address</label>
                  <input class="input" type="email" id="contactEmail" required>
                </div>
                <div class="field">
                  <label class="field-label" for="contactPhone"><span data-i18n="form.phone">Phone Number</span> <span class="optional" data-i18n="form.optional">optional</span></label>
                  <input class="input" type="tel" id="contactPhone" autocomplete="tel" inputmode="tel">
                </div>
                <div class="field">
                  <label class="field-label" for="contactSubject" data-i18n="form.subject">Subject</label>
                  <div class="select-wrap">
                    <select class="select" id="contactSubject">
                      <option value="general" data-i18n="contact.subject_general">General Enquiry</option>
                      <option value="booking" data-i18n="contact.subject_booking">Booking Question</option>
                      <option value="private" data-i18n="contact.subject_private">Private Tour Request</option>
                      <option value="feedback" data-i18n="contact.subject_feedback">Feedback</option>
                    </select>
                    {icon('chevron-down',16)}
                  </div>
                </div>
                <div class="field">
                  <label class="field-label" for="contactMessage" data-i18n="form.message">Message</label>
                  <textarea class="textarea" id="contactMessage" required></textarea>
                </div>
                <button type="submit" class="btn btn--primary btn--block" data-i18n="form.send">Send Message</button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section class="section section-alt">
      <div class="container">
        <div class="map-frame" style="aspect-ratio:16/6;" data-reveal>
          <iframe src="https://maps.google.com/maps?q={map_query}&t=&z=14&ie=UTF8&iwloc=&output=embed" loading="lazy" referrerpolicy="no-referrer-when-downgrade" title="MT Travel office location" data-i18n-title="contact.map_title"></iframe>
        </div>
      </div>
    </section>
  </main>

  {cp.footer()}
  {cp.scripts(extra=["contact"])}
</body>
</html>'''
    with open(os.path.join(OUT, "contact.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  contact.html written ({len(html)} chars)")


def build():
    build_about()
    build_contact()


if __name__ == "__main__":
    build()
