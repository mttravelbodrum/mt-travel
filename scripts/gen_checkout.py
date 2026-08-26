import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site")


def build():
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title="Rezervasyon Özeti | MT Travel",
      description="Rezervasyon özetinizi gözden geçirin ve MT Travel ile rezervasyonunuzu tamamlayın.",
      canonical_path="checkout.html", noindex=True
  )}
</head>
<body>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>
  {cp.topbar()}
  {cp.header(active="tours")}

  <main id="mainContent">
    {cp.page_banner("", "Rezervasyon Özeti", "Lütfen aşağıdaki bilgilerinizi gözden geçirin, ardından rezervasyonunuzu tamamlayın.", [("Hemen Rezerve Et", "booking.html", "nav.book_now"), ("Özet", None, "checkout.summary_crumb")], title_key="checkout.page_title", subtitle_key="checkout.page_sub")}

    <section class="section" id="checkoutApp">
      <div class="container">
        <ul class="stepper" style="margin-bottom:40px;">
          <li class="stepper__item is-done" data-step-index="1"><span class="stepper__circle">{icon('check',16)}</span><span class="stepper__label" data-i18n="booking.step_tour_date">Tour, Date &amp; Guests</span></li>
          <div class="stepper__line"></div>
          <li class="stepper__item is-done" data-step-index="2"><span class="stepper__circle">{icon('check',16)}</span><span class="stepper__label" data-i18n="booking.step_contact_info">Contact Info</span></li>
          <div class="stepper__line"></div>
          <li class="stepper__item is-active" data-step-index="3"><span class="stepper__circle">3</span><span class="stepper__label" data-i18n="booking.summary_title">Summary</span></li>
        </ul>

        <div class="flow-layout">
          <div class="flow-card">
            <h3 data-i18n="booking.summary_title" style="margin-bottom:24px;">Reservation Summary</h3>

            <div class="summary-card__media" style="border:1px solid var(--slate-100); border-radius:var(--radius-md); margin-bottom:24px;">
              <img data-summary-tour-img src="assets/images/common/hero-home.jpg" alt="" style="width:76px; height:76px; border-radius:var(--radius-md); object-fit:cover;">
              <div>
                <h5 data-summary-tour-name style="margin-bottom:4px;"></h5>
                <p data-summary-date style="margin:0;"></p>
              </div>
            </div>

            <ul class="check-list" style="grid-template-columns:1fr; margin-bottom:24px;">
              <li>{icon('user',18)}<span data-summary-name></span></li>
              <li>{icon('mail',18)}<span data-summary-email></span></li>
              <li>{icon('map-pin',18)}<span data-summary-hotel></span></li>
            </ul>

            <div class="price-box" style="margin-bottom:24px;">
              <div id="checkoutStandardRows">
                <div class="price-row"><span data-i18n="search.adults">Adults</span><strong data-summary-adults>2</strong></div>
                <div class="price-row"><span data-i18n="search.children">Children</span><strong data-summary-children>0</strong></div>
                <div class="price-row"><span data-i18n="booking.infants">Infants</span><strong data-summary-infants>0</strong></div>
              </div>
              <div id="checkoutAtvRows" style="display:none;">
                <div class="price-row"><span data-i18n="booking.single">Single</span><strong data-summary-single>0</strong></div>
                <div class="price-row"><span data-i18n="booking.double">Double</span><strong data-summary-double>0</strong></div>
              </div>
              <div class="price-row"><span data-i18n="payment.starting_price">Starting Price</span><strong data-price-starting>\u20AC0</strong></div>
              <div class="price-row total"><span data-i18n="payment.total">Total Price</span><span data-price-total>\u20AC0</span></div>
            </div>

            <div class="pay-option is-selected" style="cursor:default;">
              <span style="width:20px; height:20px; border-radius:50%; background:var(--teal-500); display:flex; align-items:center; justify-content:center; flex-shrink:0; margin-top:2px;">{icon('check', 13)}</span>
              <div class="pay-option__body">
                <div class="pay-option__title" data-i18n="payment.reserve_later">Reserve Now, Pay on Tour Day</div>
                <div class="pay-option__desc" data-i18n="payment.reserve_later_desc">Book now and pay the full amount on the day of the tour.</div>
              </div>
            </div>

            <div class="agreements">
              <div class="checkbox-row">
                <input type="checkbox" id="agreeCheckout">
                <label for="agreeCheckout"><span data-i18n="payment.agree_terms">I agree to the</span> <a href="terms.html" target="_blank"><span data-i18n="payment.terms">Terms &amp; Conditions</span></a> <span data-i18n="payment.and">and</span> <a href="cancellation-policy.html" target="_blank"><span data-i18n="payment.cancellation">Cancellation Policy</span></a>.</label>
              </div>
            </div>

            <div class="flow-nav">
              <a href="booking.html" class="btn btn--ghost" data-i18n="booking.back">Back</a>
              <button type="button" class="btn btn--primary btn--lg" id="completeReservationBtn" disabled>
                {icon('check-circle',18)}<span data-i18n="booking.continue_payment">Complete Reservation</span>
              </button>
            </div>
          </div>

          <aside>
            <div class="security-badges" style="flex-direction:column; align-items:flex-start; gap:14px;">
              <span class="security-badge">{icon('shield-check',18)}<span data-i18n="checkout.no_payment_badge">No payment taken today</span></span>
              <span class="security-badge">{icon('lock',18)}<span data-i18n="checkout.privacy_badge">Your details are kept private</span></span>
              <span class="security-badge">{icon('award',18)}<span data-i18n="checkout.trusted_badge">Trusted since 2005</span></span>
            </div>
          </aside>
        </div>
      </div>
    </section>
  </main>

  {cp.footer()}
  {cp.scripts(extra=["checkout"])}
</body>
</html>'''
    with open(os.path.join(OUT, "checkout.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  checkout.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
