import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon
from helpers import load_countries

COUNTRIES = load_countries()
OUT = os.path.join(os.path.dirname(__file__), "..", "site")


def stepper_html():
    steps = [(1, "booking.step_tour_date", "Tour, Date & Guests"), (2, "booking.step_contact_info", "Contact Info")]
    items = []
    for i, (idx, key, label) in enumerate(steps):
        items.append(f'''<li class="stepper__item{' is-active' if idx==1 else ''}" data-step-index="{idx}">
          <span class="stepper__circle">{idx}</span>
          <span class="stepper__label" data-i18n="{key}">{label}</span>
        </li>''')
        if i < len(steps) - 1:
            items.append('<div class="stepper__line"></div>')
    return "\n        ".join(items)


def counter_html(key, label_key, label_default, sub_key, sub_default, minv, maxv, default):
    return f'''<div class="counter" data-counter="{key}" data-min="{minv}" data-max="{maxv}">
              <div class="counter__label"><span data-i18n="{label_key}">{label_default}</span><small data-i18n="{sub_key}">{sub_default}</small></div>
              <div class="counter__controls">
                <button type="button" class="counter__btn" data-counter-action="minus">{icon('minus',14)}</button>
                <span class="counter__value">{default}</span>
                <button type="button" class="counter__btn" data-counter-action="plus">{icon('plus',14)}</button>
              </div>
            </div>'''


def build():
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(
      title="Rezervasyon | MT Travel",
      description="Bodrum turunuzu birkaç basit adımda ayırtın - turunuzu, tarih ve misafir sayınızı seçin, iletişim bilgilerinizi ekleyin ve rezervasyon özetinizi gözden geçirin.",
      canonical_path="booking.html", noindex=True
  )}
</head>
<body>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>
  {cp.topbar()}
  {cp.header(active="tours")}

  <main id="mainContent">
    {cp.page_banner("", "Turunuzu Rezerve Edin", "Yerinizi ayırtmak için aşağıdaki adımları tamamlayın - sadece birkaç dakika sürer.", [("Hemen Rezerve Et", None, "nav.book_now")], title_key="booking.page_title", subtitle_key="booking.page_sub")}

    <section class="section" id="bookingApp">
      <div class="container">
        <ul class="stepper" style="margin-bottom:40px;">
        {stepper_html()}
        </ul>

        <div class="flow-layout">
          <div class="flow-card">

            <!-- STEP 1: TOUR SELECTION (left column - list only, per the requested layout) -->
            <div class="flow-step is-active" data-step="1">
              <div class="flow-step__head">
                <h3 data-i18n="booking.choose_tour">Choose a Tour</h3>
              </div>
              <div id="tourPickList"></div>
            </div>

            <!-- STEP 2: CONTACT INFORMATION -->
            <div class="flow-step" data-step="2">
              <div class="flow-step__head">
                <h3 data-i18n="booking.step_contact_info">Contact Information</h3>
              </div>
              <div class="field-row">
                <div class="field">
                  <label class="field-label" for="firstName" data-i18n="form.first_name">First Name</label>
                  <input class="input" id="firstName" autocomplete="given-name">
                  <div class="field-error">{icon('alert-triangle',14)}<span data-i18n="validate.required">This field is required.</span></div>
                </div>
                <div class="field">
                  <label class="field-label" for="lastName" data-i18n="form.last_name">Last Name</label>
                  <input class="input" id="lastName" autocomplete="family-name">
                  <div class="field-error">{icon('alert-triangle',14)}<span data-i18n="validate.required">This field is required.</span></div>
                </div>
              </div>
              <div class="field">
                <label class="field-label" for="countrySelect" data-i18n="form.country">Country</label>
                <div class="select-wrap">
                  <select class="select" id="countrySelect"></select>
                  {icon('chevron-down',16)}
                </div>
                <div class="field-error">{icon('alert-triangle',14)}<span data-i18n="validate.country">Please select a country.</span></div>
              </div>
              <div class="field">
                <label class="field-label" for="phone" data-i18n="form.phone">Phone Number</label>
                <div class="phone-field">
                  <span class="dial-code" id="dialCodeLabel">+--</span>
                  <input class="input" id="phone" type="tel" inputmode="numeric" autocomplete="tel">
                </div>
                <div class="field-error">{icon('alert-triangle',14)}<span data-i18n="validate.phone">Please enter a valid phone number.</span></div>
              </div>
              <div class="field">
                <label class="field-label" for="email" data-i18n="form.email">Email Address</label>
                <input class="input" id="email" type="email" autocomplete="email">
                <div class="field-error">{icon('alert-triangle',14)}<span data-i18n="validate.email">Please enter a valid email address.</span></div>
              </div>
              <div class="field">
                <label class="field-label" for="hotelName"><span data-i18n="form.hotel_name">Hotel Name</span> <span class="optional" data-i18n="form.optional">(optional)</span></label>
                <div class="hotel-combo" id="hotelCombo">
                  <input class="input" id="hotelName" placeholder="e.g. Hilton Bodrum" data-i18n-placeholder="booking.hotel_search_placeholder" autocomplete="off">
                  <div class="hotel-combo__list" id="hotelComboList"></div>
                </div>
              </div>
              <div class="field">
                <label class="field-label" for="notes"><span data-i18n="form.special_requests">Special Requests</span> <span class="optional" data-i18n="form.optional">(optional)</span></label>
                <textarea class="textarea" id="notes" style="min-height:80px;"></textarea>
              </div>

              <div class="flow-nav">
                <button type="button" class="btn btn--ghost" data-step-back data-i18n="booking.back">Back</button>
                <button type="button" class="btn btn--primary" data-step-next><span data-i18n="booking.next">Continue</span></button>
              </div>
            </div>

          </div>

          <!-- RIGHT SIDEBAR: summary + (step 1) date/guests/total/continue -->
          <aside>
            <div class="summary-card">
              <div class="summary-card__media">
                <img data-summary-tour-img src="assets/images/common/hero-home.jpg" alt="">
                <div>
                  <h5 data-summary-tour-name style="margin-bottom:2px;" data-i18n="booking.select_a_tour">Select a tour</h5>
                  <p data-summary-date>&mdash;</p>
                </div>
              </div>
              <div class="summary-card__body">
                <div id="asideStandardPriceRows">
                  <div class="price-row"><span data-summary-adults-line>Adults</span><strong data-summary-adults-total>\u20AC0</strong></div>
                  <div class="price-row" data-children-row style="display:none;"><span data-summary-children-line>Children</span><strong data-summary-children-total>\u20AC0</strong></div>
                  <div class="price-row" data-infants-row style="display:none;"><span data-summary-infants-line>Infants</span><strong data-summary-infants-total>\u20AC0</strong></div>
                </div>
                <div id="asideAtvPriceRows" style="display:none;">
                  <div class="price-row" data-single-row style="display:none;"><span data-summary-single-line>Single</span><strong data-summary-single-total>\u20AC0</strong></div>
                  <div class="price-row" data-double-row style="display:none;"><span data-summary-double-line>Double</span><strong data-summary-double-total>\u20AC0</strong></div>
                </div>
              </div>
              <div class="summary-card__foot">
                <div class="price-row total"><span data-i18n="payment.total">Total Amount</span><span data-summary-total>\u20AC0</span></div>
              </div>
            </div>

            <div data-step-aside="1">
              <div class="calendar-note" style="margin-top:20px;">
                {icon('info',17)}<span data-i18n="payment.reserve_later_desc">Reserve now, pay the full amount on the day of your tour.</span>
              </div>

              <div class="flow-step__head" style="margin-top:22px;">
                <h3 data-i18n="booking.choose_date">Choose a Date</h3>
              </div>
              <div class="field">
                <label class="field-label" for="tourDateInput" data-i18n="tour.select_date">Select Date</label>
                <input type="hidden" id="tourDateInput">
                <div id="tourCalendarWidget"></div>
                <div class="calendar-note" id="dateNote" style="display:none; margin-top:12px;">
                  {icon('info',17)}<span data-i18n="validate.island_notice">This tour requires advance booking. Please choose a later date.</span>
                </div>
              </div>

              <div class="flow-step__head" style="margin-top:20px;">
                <h3 data-i18n="booking.guests_title">Number of Guests</h3>
              </div>
              <div class="stack-gap-sm" id="standardGuestCounters">
                {counter_html('adults', 'search.adults', 'Adults', 'booking.adults_sub', 'Age 12+', 1, 12, 2)}
                {counter_html('children', 'search.children', 'Children', 'booking.children_sub', 'Age 6-11', 0, 10, 0)}
                {counter_html('infants', 'booking.infants', 'Infants', 'booking.infants_sub', 'Age 0-5, free', 0, 6, 0)}
              </div>
              <div class="stack-gap-sm" id="atvGuestCounters" style="display:none;">
                {counter_html('single', 'booking.single', 'Single', 'booking.single_sub', '1 rider per ATV', 0, 10, 1)}
                {counter_html('double', 'booking.double', 'Double', 'booking.double_sub', '2 riders per ATV (tandem)', 0, 10, 0)}
              </div>

              <div class="price-box" style="margin-top:22px;">
                <div id="standardPriceRows">
                  <div class="price-row"><span data-summary-adults-line>Adults</span><strong data-summary-adults-total>\u20AC0</strong></div>
                  <div class="price-row" data-children-row style="display:none;"><span data-summary-children-line>Children</span><strong data-summary-children-total>\u20AC0</strong></div>
                  <div class="price-row" data-infants-row style="display:none;"><span data-summary-infants-line>Infants</span><strong data-summary-infants-total>\u20AC0</strong></div>
                </div>
                <div id="atvPriceRows" style="display:none;">
                  <div class="price-row" data-single-row style="display:none;"><span data-summary-single-line>Single</span><strong data-summary-single-total>\u20AC0</strong></div>
                  <div class="price-row" data-double-row style="display:none;"><span data-summary-double-line>Double</span><strong data-summary-double-total>\u20AC0</strong></div>
                </div>
                <div class="price-row total"><span data-i18n="payment.total">Total Amount</span><span data-summary-total>\u20AC0</span></div>
              </div>

              <div class="field-error" id="step1Error" style="display:flex; margin-top:16px;">
                {icon('alert-triangle',14)}<span data-i18n="validate.date">Please select a date.</span>
              </div>

              <div class="flow-nav">
                <span></span>
                <button type="button" class="btn btn--primary" data-step-next data-i18n="booking.next">Continue</button>
              </div>
            </div>

            <div data-step-aside="2" style="display:none;">
              <div class="calendar-note" style="margin-top:20px;">
                {icon('info',17)}<span data-i18n="payment.reserve_later_desc">Reserve now, pay the full amount on the day of your tour.</span>
              </div>
            </div>
          </aside>
        </div>
      </div>
    </section>
  </main>

  {cp.footer()}
  {cp.scripts(extra=["tour-calendar", "booking"])}
</body>
</html>'''
    with open(os.path.join(OUT, "booking.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  booking.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
