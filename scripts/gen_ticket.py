import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon
from helpers import load_site

SITE = load_site()
COMPANY = SITE["company"]
OUT = os.path.join(os.path.dirname(__file__), "..", "site")


def info_row(label_key, label_default, data_attr, hideable=False):
    hide_attr = f' data-ticket-row-hotel' if hideable else ""
    return f'''<div class="a4doc__row"{hide_attr}>
              <span class="a4doc__row-label" data-i18n="{label_key}">{label_default}</span>
              <span class="a4doc__row-value" data-ticket-{data_attr}></span>
            </div>'''


def build():
    info_rows = "\n            ".join([
        info_row("confirm.customer", "Customer Name", "customer"),
        info_row("form.phone", "Phone Number", "phone"),
        info_row("form.email", "Email Address", "email"),
        info_row("confirm.tour", "Tour Name", "tour"),
        info_row("confirm.date", "Tour Date", "date"),
        info_row("search.guests_label", "Number of Guests", "guests"),
        info_row("form.hotel_name", "Hotel Name", "hotel", hideable=True),
        info_row("payment.total", "Total Amount", "total"),
    ])

    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title="Rezervasyon Bileti | MT Travel",
      description="MT Travel rezervasyon biletiniz.",
      canonical_path="ticket.html", noindex=True
  )}
</head>
<body>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>
  {cp.topbar()}
  {cp.header(active="tours")}

  <main id="mainContent">
    <section class="a4doc-page" id="ticketApp">

      <div class="a4doc" id="ticketDocument">

        <div class="a4doc__header">
          <div class="a4doc__brand">
            <div class="a4doc__logo">{icon('map-pin', 22)}<span>MT TRAVEL</span></div>
          </div>
          <div class="a4doc__brand-contact">
            <p>{COMPANY['phone_display']}</p>
            <p>{COMPANY['email']}</p>
            <p data-i18n="topbar.hours">{COMPANY['hours_en']}</p>
            <p>WhatsApp: {COMPANY['phone_display']}</p>
          </div>
        </div>

        <div class="a4doc__title-row">
          <h1 data-i18n="ticket.document_title">RESERVATION TICKET</h1>
          <div class="a4doc__ref">
            <span data-i18n="confirm.booking_number">Reservation Reference Number</span>
            <strong data-ticket-number></strong>
          </div>
        </div>

        <div class="a4doc__section">
          <h2 data-i18n="ticket.reservation_info">Reservation Information</h2>
          <div class="a4doc__info">
            {info_rows}
            <div class="a4doc__row">
              <span class="a4doc__row-label" data-i18n="ticket.payment_method_label">Payment Method</span>
              <span class="a4doc__row-value" data-i18n="payment.reserve_later_short">Reserve Now, Pay on Tour Day</span>
            </div>
          </div>
        </div>

        <div class="a4doc__footer">
          <p class="a4doc__footer-contact">{COMPANY['phone_display']} &middot; {COMPANY['email']} &middot; {COMPANY['address_en']}</p>
          <p data-i18n="ticket.whatsapp_support_note">For any questions, reach us anytime on WhatsApp.</p>
          <p data-i18n="ticket.presentation_note">Please present this ticket (printed or on your phone) to your guide on the day of the tour.</p>
        </div>

      </div>

      <div class="ticket-actions">
        <button type="button" class="btn btn--primary btn--lg" id="downloadTicketBtn">
          {icon('download',18)}<span data-i18n="ticket.download_pdf">Download PDF</span>
        </button>
        <button type="button" class="btn btn--outline-dark btn--lg" id="printTicketBtn">
          {icon('printer',18)}<span data-i18n="ticket.print">Print</span>
        </button>
        <a href="success.html" class="btn btn--ghost btn--lg">
          {icon('arrow-left',18)}<span data-i18n="ticket.back_to_confirmation">Back to Confirmation</span>
        </a>
      </div>

    </section>
  </main>

  {cp.footer()}
  {cp.scripts(extra=["ticket"])}
</body>
</html>'''
    with open(os.path.join(OUT, "ticket.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  ticket.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
