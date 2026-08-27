import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon
from helpers import load_site

SITE = load_site()
COMPANY = SITE["company"]
OUT = os.path.join(os.path.dirname(__file__), "..", "site")


def build():
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title="Rezervasyon Başarılı | MT Travel",
      description="MT Travel rezervasyonunuz başarıyla oluşturuldu.",
      canonical_path="success.html", noindex=True
  )}
</head>
<body>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>
  {cp.topbar()}
  {cp.header(active="tours")}

  <main id="mainContent">
    <section class="section" id="successApp">
      <div class="container container-narrow">
        <div class="confirm-hero">
          <div class="confirm-check">{icon('check', 46)}</div>
          <h1 data-i18n="confirm.title">Reservation Successfully Created</h1>
          <p data-i18n="confirm.subtitle" style="max-width:480px; margin-inline:auto;">Thank you - your reservation has been received. A confirmation has been sent to your email.</p>
          <div class="confirm-number">{icon('tag', 18)}<span data-i18n="confirm.booking_number">Reservation Number</span>:&nbsp;<span data-confirm-number></span></div>
        </div>

        <div class="flow-card">
          <dl class="confirm-details">
            <div class="confirm-detail"><dt data-i18n="confirm.customer">Customer</dt><dd data-confirm-customer></dd></div>
            <div class="confirm-detail"><dt data-i18n="confirm.tour">Tour</dt><dd data-confirm-tour></dd></div>
            <div class="confirm-detail"><dt data-i18n="confirm.date">Reservation Date</dt><dd data-confirm-date></dd></div>
            <div class="confirm-detail"><dt data-i18n="form.hotel_name">Hotel Name</dt><dd data-confirm-hotel></dd></div>
          </dl>

          <div class="confirm-actions" style="flex-wrap:wrap;">
            <a href="ticket.html" id="viewTicketBtn" class="btn btn--primary btn--lg">
              {icon('ticket',18)}<span data-i18n="confirm.view_ticket">View My Ticket</span>
            </a>
            <a href="#" id="whatsappContactBtn" class="btn btn--whatsapp btn--lg" target="_blank" rel="noopener">
              {icon('whatsapp',18)}<span data-i18n="confirm.contact_whatsapp">Contact us on WhatsApp</span>
            </a>
            <a href="#" id="getDirectionsBtn" class="btn btn--outline-dark btn--lg" target="_blank" rel="noopener">
              {icon('map-pin',18)}<span data-i18n="confirm.get_directions">Get Directions</span>
            </a>
            <a href="index.html" class="btn btn--ghost btn--lg">
              {icon('arrow-left',18)}<span data-i18n="confirm.back_home">Return to Homepage</span>
            </a>
          </div>

          <div class="confirm-support">
            <div class="confirm-support__item">
              <span class="icon-circle">{icon('phone',19)}</span>
              <div><strong>{COMPANY['phone_display']}</strong><span data-i18n="topbar.hours">{COMPANY['hours_en']}</span></div>
            </div>
            <div class="confirm-support__item">
              <span class="icon-circle">{icon('mail',19)}</span>
              <div><strong>{COMPANY['email']}</strong><span data-confirm-email></span></div>
            </div>
          </div>
        </div>
      </div>
    </section>
  </main>

  {cp.footer()}
  {cp.scripts(extra=["success"])}
</body>
</html>'''
    with open(os.path.join(OUT, "success.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  success.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
