import sys, os, json
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon
from helpers import load_site

SITE = load_site()
COMPANY = SITE["company"]
OUT = os.path.join(os.path.dirname(__file__), "..", "site")


def legal_page(slug, title_by_lang, description, sections_by_lang, title_key=None):
    """sections_by_lang: {lang: [(heading, [paragraphs]), ...]} for every
    supported language. Turkish renders as the actual page HTML (matching
    every other page's TR-by-default convention); all five languages are
    also embedded as JSON so language.js can swap the content client-side
    exactly like a tour detail page's long-form content."""
    title = title_by_lang["tr"]
    body = "\n        ".join(
        f'<h3>{h}</h3>\n        {"".join(f"<p>{p}</p>" for p in paras)}'
        for h, paras in sections_by_lang["tr"]
    )
    blob = json.dumps(sections_by_lang, ensure_ascii=False)
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(title=f"{title} | MT Travel", description=description, canonical_path=f"{slug}.html")}
</head>
<body>
  <a class="skip-link" href="#mainContent" data-i18n="a11y.skip_to_content">Skip to content</a>
  {cp.topbar()}
  {cp.header(active="")}

  <main id="mainContent">
    {cp.page_banner("", title, "Son güncelleme: Ocak 2026", [(title, None, title_key)], title_key=title_key, subtitle_key="legal.last_updated")}
    <section class="section">
      <div class="container container-narrow">
        <div class="stack-gap-md" data-legal-content>
        {body}
        </div>
      </div>
    </section>
  </main>

  {cp.footer()}
  <script type="application/json" id="legalI18nData">{blob}</script>
  {cp.scripts()}
</body>
</html>'''
    with open(os.path.join(OUT, f"{slug}.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  {slug}.html written ({len(html)} chars)")


EMAIL = COMPANY["email"]
ADDRESS_EN = COMPANY["address_en"]
LEGAL_NAME = COMPANY["legal_name"]


def build():
    # ------------------------------------------------------------------
    # PRIVACY POLICY
    # ------------------------------------------------------------------
    privacy_sections = {
        "tr": [
            ("Topladığımız Bilgiler", [
                "Bir rezervasyon yaptığınızda, bizimle iletişime geçtiğinizde veya bültenimize abone olduğunuzda; adınız, e-posta adresiniz, telefon numaranız, ülkeniz ve belirttiğiniz otel veya özel istek bilgileri gibi bilgileri topluyoruz.",
                "Web sitemizi gezinirken, yalnızca site deneyimini geliştirmek amacıyla kullanılan tarayıcı türü ve ziyaret edilen sayfalar gibi temel teknik bilgileri de toplayabiliriz.",
            ]),
            ("Bilgilerinizi Nasıl Kullanıyoruz", [
                "Bilgilerinizi rezervasyonları işlemek, onay göndermek, sorulara yanıt vermek ve - onay verdiğiniz durumlarda - e-posta yoluyla ara sıra teklifler göndermek için kullanıyoruz. Kişisel verilerinizi asla üçüncü taraflara satmayız.",
                "Ödeme sırasında girilen bilgiler şifreli, güvenli bir bağlantı üzerinden işlenir ve sunucularımızda tam olarak saklanmaz.",
            ]),
            ("Bilgilerinizin Paylaşılması", [
                "Rezervasyon bilgilerini yalnızca turunuzu gerçekleştirmek için gerekli olduğunda paylaşırız - örneğin, ayırttığınız hizmeti sağlayan tekne, transfer veya aktivite operatörüyle.",
            ]),
            ("Haklarınız", [
                f"Kişisel verilerinize erişim talep etme, düzeltme veya silme hakkınızı, {EMAIL} adresinden bizimle iletişime geçerek istediğiniz zaman kullanabilirsiniz.",
            ]),
            ("Çerezler", [
                "Web sitemiz, dil ve para birimi tercihinizi hatırlamak için gerekli çerezleri kullanır. Onayınız olmadan reklam veya takip çerezleri kullanılmaz.",
            ]),
            ("İletişim", [
                f"Bu politika hakkındaki sorular {EMAIL} adresine veya {ADDRESS_EN} adresine posta yoluyla gönderilebilir.",
            ]),
        ],
        "en": [
            ("Information We Collect", [
                "When you make a reservation, contact us, or subscribe to our newsletter, we collect information such as your name, email address, phone number, country, and any hotel or special request details you provide.",
                "While browsing our website, we may also collect basic technical information such as browser type and pages visited, used only to improve the site experience.",
            ]),
            ("How We Use Your Information", [
                "We use your information to process reservations, send confirmations, respond to inquiries, and - where you've given consent - send occasional offers by email. We never sell your personal data to third parties.",
                "Information entered during payment is processed over an encrypted, secure connection and is not stored in full on our servers.",
            ]),
            ("Sharing Your Information", [
                "We share reservation information only when necessary to carry out your tour - for example, with the boat, transfer, or activity operator providing the service you booked.",
            ]),
            ("Your Rights", [
                f"You may exercise your right to request access to, correction of, or deletion of your personal data at any time by contacting us at {EMAIL}.",
            ]),
            ("Cookies", [
                "Our website uses necessary cookies to remember your language and currency preference. No advertising or tracking cookies are used without your consent.",
            ]),
            ("Contact", [
                f"Questions about this policy can be sent to {EMAIL} or by post to {ADDRESS_EN}.",
            ]),
        ],
        "de": [
            ("Von Uns Erfasste Informationen", [
                "Wenn Sie eine Reservierung vornehmen, uns kontaktieren oder unseren Newsletter abonnieren, erfassen wir Informationen wie Ihren Namen, Ihre E-Mail-Adresse, Telefonnummer, Ihr Land sowie alle von Ihnen angegebenen Hotel- oder Sonderwunschdetails.",
                "Beim Durchsuchen unserer Website können wir auch grundlegende technische Informationen wie Browsertyp und besuchte Seiten erfassen, die ausschließlich zur Verbesserung des Website-Erlebnisses verwendet werden.",
            ]),
            ("Wie Wir Ihre Informationen Verwenden", [
                "Wir verwenden Ihre Informationen, um Reservierungen zu bearbeiten, Bestätigungen zu senden, Anfragen zu beantworten und - sofern Sie zugestimmt haben - gelegentlich Angebote per E-Mail zu senden. Wir verkaufen Ihre persönlichen Daten niemals an Dritte.",
                "Bei der Zahlung eingegebene Informationen werden über eine verschlüsselte, sichere Verbindung verarbeitet und nicht vollständig auf unseren Servern gespeichert.",
            ]),
            ("Weitergabe Ihrer Informationen", [
                "Wir geben Reservierungsinformationen nur dann weiter, wenn dies für die Durchführung Ihrer Tour erforderlich ist - zum Beispiel an den Boots-, Transfer- oder Aktivitätsanbieter, der die von Ihnen gebuchte Leistung erbringt.",
            ]),
            ("Ihre Rechte", [
                f"Sie können Ihr Recht auf Zugang zu, Berichtigung oder Löschung Ihrer personenbezogenen Daten jederzeit ausüben, indem Sie uns unter {EMAIL} kontaktieren.",
            ]),
            ("Cookies", [
                "Unsere Website verwendet notwendige Cookies, um Ihre Sprach- und Währungspräferenz zu speichern. Ohne Ihre Zustimmung werden keine Werbe- oder Tracking-Cookies verwendet.",
            ]),
            ("Kontakt", [
                f"Fragen zu dieser Richtlinie können an {EMAIL} oder per Post an {ADDRESS_EN} gesendet werden.",
            ]),
        ],
        "ru": [
            ("Собираемая Нами Информация", [
                "Когда вы делаете бронирование, связываетесь с нами или подписываетесь на нашу рассылку, мы собираем такую информацию, как ваше имя, адрес электронной почты, номер телефона, страну и любые данные об отеле или особых пожеланиях, которые вы указываете.",
                "При просмотре нашего веб-сайта мы также можем собирать базовую техническую информацию, такую как тип браузера и посещенные страницы, используемую исключительно для улучшения работы сайта.",
            ]),
            ("Как Мы Используем Вашу Информацию", [
                "Мы используем вашу информацию для обработки бронирований, отправки подтверждений, ответов на запросы и - при наличии вашего согласия - для отправки периодических предложений по электронной почте. Мы никогда не продаем ваши личные данные третьим лицам.",
                "Информация, введенная при оплате, обрабатывается через зашифрованное защищенное соединение и не хранится полностью на наших серверах.",
            ]),
            ("Передача Вашей Информации", [
                "Мы передаем информацию о бронировании только тогда, когда это необходимо для проведения вашего тура - например, оператору лодки, трансфера или мероприятия, предоставляющему забронированную вами услугу.",
            ]),
            ("Ваши Права", [
                f"Вы можете в любое время воспользоваться своим правом на доступ, исправление или удаление ваших персональных данных, связавшись с нами по адресу {EMAIL}.",
            ]),
            ("Файлы Cookie", [
                "Наш веб-сайт использует необходимые файлы cookie для запоминания ваших предпочтений в отношении языка и валюты. Рекламные файлы cookie или файлы cookie для отслеживания не используются без вашего согласия.",
            ]),
            ("Контакты", [
                f"Вопросы об этой политике можно направлять на {EMAIL} или по почте на {ADDRESS_EN}.",
            ]),
        ],
        "pl": [
            ("Informacje, Które Zbieramy", [
                "Kiedy dokonujesz rezerwacji, kontaktujesz się z nami lub zapisujesz się do naszego newslettera, zbieramy informacje takie jak Twoje imię i nazwisko, adres e-mail, numer telefonu, kraj oraz wszelkie podane przez Ciebie dane dotyczące hotelu lub specjalnych próśb.",
                "Podczas przeglądania naszej witryny możemy również zbierać podstawowe informacje techniczne, takie jak typ przeglądarki i odwiedzane strony, wykorzystywane wyłącznie w celu poprawy jakości korzystania z witryny.",
            ]),
            ("Jak Wykorzystujemy Twoje Informacje", [
                "Wykorzystujemy Twoje informacje do przetwarzania rezerwacji, wysyłania potwierdzeń, odpowiadania na zapytania oraz - jeśli wyraziłeś zgodę - do okazjonalnego wysyłania ofert e-mailem. Nigdy nie sprzedajemy Twoich danych osobowych stronom trzecim.",
                "Informacje wprowadzone podczas płatności są przetwarzane za pośrednictwem szyfrowanego, bezpiecznego połączenia i nie są przechowywane w pełni na naszych serwerach.",
            ]),
            ("Udostępnianie Twoich Informacji", [
                "Udostępniamy informacje o rezerwacji tylko wtedy, gdy jest to konieczne do realizacji Twojej wycieczki - na przykład operatorowi łodzi, transferu lub atrakcji świadczącemu zarezerwowaną przez Ciebie usługę.",
            ]),
            ("Twoje Prawa", [
                f"Możesz skorzystać z prawa do żądania dostępu, poprawienia lub usunięcia swoich danych osobowych w dowolnym momencie, kontaktując się z nami pod adresem {EMAIL}.",
            ]),
            ("Pliki Cookie", [
                "Nasza witryna wykorzystuje niezbędne pliki cookie, aby zapamiętać Twoje preferencje dotyczące języka i waluty. Reklamowe pliki cookie ani pliki cookie śledzące nie są używane bez Twojej zgody.",
            ]),
            ("Kontakt", [
                f"Pytania dotyczące tej polityki można kierować na adres {EMAIL} lub pocztą na adres {ADDRESS_EN}.",
            ]),
        ],
    }
    legal_page("privacy",
        {"tr": "Gizlilik Politikası", "en": "Privacy Policy", "de": "Datenschutzrichtlinie", "ru": "Политика Конфиденциальности", "pl": "Polityka Prywatności"},
        "MT Travel'in kişisel bilgilerinizi nasıl topladığı, kullandığı ve koruduğu.",
        privacy_sections, title_key="footer.privacy")

    # ------------------------------------------------------------------
    # TERMS OF SERVICE
    # ------------------------------------------------------------------
    terms_sections = {
        "tr": [
            ("Rezervasyon Onayı", [
                "Bir rezervasyon, e-posta yoluyla bir rezervasyon numarası aldığınızda onaylanmış sayılır. Misafirler çevrimiçi rezervasyon yapar ve tam tutarı tur günü şahsen öder - rezervasyon sırasında çevrimiçi ödeme alınmaz.",
                "Onaylamadan önce tüm rezervasyon bilgilerini - tur, tarih ve misafir sayısını - kontrol etmek müşterinin sorumluluğundadır.",
            ]),
            ("Fiyatlar", [
                "Tüm fiyatlar web sitesinde seçilen para biriminde gösterilir ve aksi belirtilmedikçe kişi başınadır. Ödeme sayfasında gösterilen fiyat, tur günü ödenecek fiyattır.",
                "Rezervasyonlar, ekibimiz tarafından onaylanana kadar 'Beklemede' olarak tutulur ve incelendikten sonra 'Onaylandı' durumuna geçer.",
            ]),
            ("Seyahat Belgeleri", [
                "Ada turlarına (Kos, Leros, Kalymnos) katılan misafirlerin geçerli bir pasaport taşıması gerekir. MT Travel, eksik veya geçersiz seyahat belgeleri nedeniyle biniş reddi durumlarından sorumlu değildir.",
            ]),
            ("MT Travel Tarafından Yapılan Değişiklikler", [
                "Zaman zaman hava koşulları, deniz durumu veya operasyonel nedenlerle bir tur programında değişiklik yapılabilir. Mümkün olduğunda misafirler önceden bilgilendirilir ve uygun bir alternatif sunulur.",
            ]),
            ("Sorumluluk", [
                "MT Travel, lisanslı yerel operatörler tarafından sunulan turların organizatörü olarak hareket eder ve bu operatörleri seçerken gerekli özeni gösterir. Misafirler; tekne turları, jeep safari ve dalış gibi fiziksel aktivitelere kendi sorumlulukları altında katılır ve rezervasyon öncesinde ilgili sağlık durumlarını bildirmelidir.",
            ]),
            ("Geçerli Hukuk", [
                "Bu şartlar Türkiye Cumhuriyeti yasalarına tabidir. Herhangi bir uyuşmazlık Muğla, Türkiye mahkemelerinin yargı yetkisine tabi olacaktır.",
            ]),
        ],
        "en": [
            ("Reservation Confirmation", [
                "A reservation is considered confirmed once you receive a reservation number by email. Guests book online and pay the full amount in person on the day of the tour - no online payment is taken at the time of reservation.",
                "It is the customer's responsibility to check all reservation details - tour, date, and number of guests - before confirming.",
            ]),
            ("Prices", [
                "All prices are shown in the currency selected on the website and are per person unless stated otherwise. The price shown on the payment page is the price payable on the day of the tour.",
                "Reservations are held as 'Pending' until confirmed by our team, then move to 'Confirmed' once reviewed.",
            ]),
            ("Travel Documents", [
                "Guests joining island tours (Kos, Leros, Kalymnos) must carry a valid passport. MT Travel is not responsible for boarding refusals due to missing or invalid travel documents.",
            ]),
            ("Changes Made by MT Travel", [
                "From time to time, a tour itinerary may be changed due to weather conditions, sea state, or operational reasons. Where possible, guests are notified in advance and offered a suitable alternative.",
            ]),
            ("Liability", [
                "MT Travel acts as the organizer of tours delivered by licensed local operators and exercises due care in selecting them. Guests take part in physical activities such as boat trips, jeep safaris, and diving at their own risk, and should disclose any relevant health conditions before booking.",
            ]),
            ("Governing Law", [
                "These terms are governed by the laws of the Republic of Türkiye. Any dispute shall be subject to the jurisdiction of the courts of Muğla, Türkiye.",
            ]),
        ],
        "de": [
            ("Reservierungsbestätigung", [
                "Eine Reservierung gilt als bestätigt, sobald Sie eine Reservierungsnummer per E-Mail erhalten. Gäste buchen online und zahlen den vollen Betrag persönlich am Tag der Tour - bei der Reservierung wird keine Online-Zahlung erhoben.",
                "Es liegt in der Verantwortung des Kunden, alle Reservierungsdetails - Tour, Datum und Anzahl der Gäste - vor der Bestätigung zu überprüfen.",
            ]),
            ("Preise", [
                "Alle Preise werden in der auf der Website ausgewählten Währung angezeigt und verstehen sich pro Person, sofern nicht anders angegeben. Der auf der Zahlungsseite angezeigte Preis ist der am Tag der Tour zu zahlende Preis.",
                "Reservierungen werden bis zur Bestätigung durch unser Team als 'Ausstehend' geführt und wechseln nach Prüfung zu 'Bestätigt'.",
            ]),
            ("Reisedokumente", [
                "Gäste, die an Inseltouren (Kos, Leros, Kalymnos) teilnehmen, müssen einen gültigen Reisepass mitführen. MT Travel übernimmt keine Verantwortung für die Verweigerung des Bordens aufgrund fehlender oder ungültiger Reisedokumente.",
            ]),
            ("Änderungen Durch MT Travel", [
                "Von Zeit zu Zeit kann ein Tourenprogramm aufgrund von Wetterbedingungen, Seegang oder betrieblichen Gründen geändert werden. Wo möglich, werden Gäste im Voraus benachrichtigt und eine geeignete Alternative angeboten.",
            ]),
            ("Haftung", [
                "MT Travel fungiert als Veranstalter von Touren, die von lizenzierten lokalen Anbietern durchgeführt werden, und lässt bei deren Auswahl die gebotene Sorgfalt walten. Gäste nehmen an körperlichen Aktivitäten wie Bootstouren, Jeep-Safaris und Tauchgängen auf eigenes Risiko teil und sollten vor der Buchung relevante gesundheitliche Beschwerden angeben.",
            ]),
            ("Anwendbares Recht", [
                "Diese Bedingungen unterliegen den Gesetzen der Republik Türkei. Jede Streitigkeit unterliegt der Zuständigkeit der Gerichte von Muğla, Türkei.",
            ]),
        ],
        "ru": [
            ("Подтверждение Бронирования", [
                "Бронирование считается подтвержденным после получения номера бронирования по электронной почте. Гости бронируют онлайн и оплачивают полную сумму лично в день тура - онлайн-оплата при бронировании не взимается.",
                "Клиент несет ответственность за проверку всех деталей бронирования - тура, даты и количества гостей - перед подтверждением.",
            ]),
            ("Цены", [
                "Все цены указаны в валюте, выбранной на веб-сайте, и указаны за человека, если не указано иное. Цена, указанная на странице оплаты, - это цена, подлежащая оплате в день тура.",
                "Бронирования сохраняются со статусом «В ожидании» до подтверждения нашей командой, а затем переходят в статус «Подтверждено» после проверки.",
            ]),
            ("Проездные Документы", [
                "Гости, участвующие в островных турах (Кос, Лерос, Калимнос), должны иметь при себе действительный паспорт. MT Travel не несет ответственности за отказ в посадке из-за отсутствующих или недействительных проездных документов.",
            ]),
            ("Изменения, Вносимые MT Travel", [
                "Время от времени программа тура может быть изменена из-за погодных условий, состояния моря или по эксплуатационным причинам. По возможности гости уведомляются заранее, и им предлагается подходящая альтернатива.",
            ]),
            ("Ответственность", [
                "MT Travel выступает в качестве организатора туров, предоставляемых лицензированными местными операторами, и проявляет должную осмотрительность при их выборе. Гости участвуют в таких физических активностях, как поездки на лодке, джип-сафари и дайвинг, на свой страх и риск и должны сообщать о соответствующих проблемах со здоровьем перед бронированием.",
            ]),
            ("Применимое Право", [
                "Настоящие условия регулируются законодательством Турецкой Республики. Любой спор подлежит юрисдикции судов Мугла, Турция.",
            ]),
        ],
        "pl": [
            ("Potwierdzenie Rezerwacji", [
                "Rezerwacja jest uważana za potwierdzoną po otrzymaniu numeru rezerwacji e-mailem. Goście rezerwują online i płacą pełną kwotę osobiście w dniu wycieczki - podczas rezerwacji nie jest pobierana płatność online.",
                "Obowiązkiem klienta jest sprawdzenie wszystkich szczegółów rezerwacji - wycieczki, daty i liczby gości - przed potwierdzeniem.",
            ]),
            ("Ceny", [
                "Wszystkie ceny są podane w walucie wybranej na stronie internetowej i dotyczą jednej osoby, chyba że zaznaczono inaczej. Cena widoczna na stronie płatności to cena płatna w dniu wycieczki.",
                "Rezerwacje mają status „Oczekująca” do czasu potwierdzenia przez nasz zespół, a następnie zmieniają się na „Potwierdzona” po weryfikacji.",
            ]),
            ("Dokumenty Podróży", [
                "Goście uczestniczący w wycieczkach na wyspy (Kos, Leros, Kalymnos) muszą posiadać ważny paszport. MT Travel nie ponosi odpowiedzialności za odmowę wejścia na pokład z powodu brakujących lub nieważnych dokumentów podróży.",
            ]),
            ("Zmiany Wprowadzane Przez MT Travel", [
                "Od czasu do czasu program wycieczki może ulec zmianie z powodu warunków pogodowych, stanu morza lub przyczyn operacyjnych. Tam, gdzie to możliwe, goście są powiadamiani z wyprzedzeniem i otrzymują odpowiednią alternatywę.",
            ]),
            ("Odpowiedzialność", [
                "MT Travel działa jako organizator wycieczek realizowanych przez licencjonowanych lokalnych operatorów i zachowuje należytą staranność przy ich wyborze. Goście uczestniczą w aktywnościach fizycznych, takich jak wycieczki łodzią, safari jeepami i nurkowanie, na własne ryzyko i powinni zgłosić wszelkie istotne problemy zdrowotne przed dokonaniem rezerwacji.",
            ]),
            ("Prawo Właściwe", [
                "Niniejsze warunki podlegają prawu Republiki Turcji. Wszelkie spory podlegają jurysdykcji sądów w Muğli, Turcja.",
            ]),
        ],
    }
    legal_page("terms",
        {"tr": "Kullanım Şartları", "en": "Terms of Service", "de": "Nutzungsbedingungen", "ru": "Условия Использования", "pl": "Warunki Korzystania"},
        "MT Travel ile bir tur ayırttığınızda geçerli olan hüküm ve koşullar.",
        terms_sections, title_key="footer.terms")

    # ------------------------------------------------------------------
    # CANCELLATION POLICY
    # ------------------------------------------------------------------
    cancellation_sections = {
        "tr": [
            ("Standart İptal Koşulları", [
                "Tur kalkış saatinden en az 48 saat önce yapılan iptaller, ödeme yalnızca tur günü alındığından, ücretsiz olarak tam iptal hakkına sahiptir.",
                "Kalkıştan 48 saat içinde yapılan iptaller veya gelmeyen misafirler, MT Travel'in takdirine bağlı olarak yine de tam ücretlendirilebilir.",
            ]),
            ("Ada Turları (Kos, Leros, Kalymnos)", [
                "Bu turlar önceden satın alınmış feribot biletleri içerdiğinden, kalkıştan 24 saat içinde yapılan iptaller, ödeme henüz alınmamış olsa bile tam olarak ücretlendirilebilir.",
            ]),
            ("Hava Durumu ve Güvenlik İptalleri", [
                "MT Travel bir turu güvensiz hava veya deniz koşulları nedeniyle iptal ederse, misafirlere ek ücret ödemeden başka bir tarihe erteleme seçeneği sunulur - ödeme yalnızca tur günü alındığından her iki durumda da ücret uygulanmaz.",
            ]),
            ("Nasıl İptal Edilir", [
                f"Bir rezervasyonu iptal etmek veya ertelemek için, rezervasyon numaranızla birlikte mümkün olan en kısa sürede telefon, WhatsApp veya {EMAIL} adresinden ekibimizle iletişime geçin.",
            ]),
        ],
        "en": [
            ("Standard Cancellation Terms", [
                "Cancellations made at least 48 hours before the tour's departure time are entitled to a full, free cancellation, since payment is only taken on the day of the tour.",
                "Cancellations made within 48 hours of departure, or no-shows, may still be charged in full at MT Travel's discretion.",
            ]),
            ("Island Tours (Kos, Leros, Kalymnos)", [
                "Because these tours include ferry tickets purchased in advance, cancellations made within 24 hours of departure may be charged in full even though payment has not yet been taken.",
            ]),
            ("Weather and Safety Cancellations", [
                "If MT Travel cancels a tour due to unsafe weather or sea conditions, guests are offered the option to reschedule to another date at no extra cost - no charge applies either way, since payment is only taken on the day of the tour.",
            ]),
            ("How to Cancel", [
                f"To cancel or reschedule a reservation, contact our team as soon as possible by phone, WhatsApp, or {EMAIL}, along with your reservation number.",
            ]),
        ],
        "de": [
            ("Standard-Stornierungsbedingungen", [
                "Stornierungen, die mindestens 48 Stunden vor der Abfahrtszeit der Tour erfolgen, berechtigen zu einer vollständigen, kostenlosen Stornierung, da die Zahlung erst am Tag der Tour erfolgt.",
                "Stornierungen innerhalb von 48 Stunden vor Abfahrt oder Nichterscheinen können nach Ermessen von MT Travel dennoch in voller Höhe berechnet werden.",
            ]),
            ("Inseltouren (Kos, Leros, Kalymnos)", [
                "Da diese Touren im Voraus gekaufte Fährtickets beinhalten, können Stornierungen innerhalb von 24 Stunden vor Abfahrt in voller Höhe berechnet werden, auch wenn die Zahlung noch nicht erfolgt ist.",
            ]),
            ("Wetter- und Sicherheitsbedingte Stornierungen", [
                "Wenn MT Travel eine Tour aufgrund unsicherer Wetter- oder Seebedingungen storniert, wird den Gästen die Möglichkeit angeboten, kostenlos auf ein anderes Datum umzubuchen - in beiden Fällen entstehen keine Kosten, da die Zahlung erst am Tag der Tour erfolgt.",
            ]),
            ("So Stornieren Sie", [
                f"Um eine Reservierung zu stornieren oder zu verschieben, kontaktieren Sie unser Team so schnell wie möglich telefonisch, über WhatsApp oder per {EMAIL} unter Angabe Ihrer Reservierungsnummer.",
            ]),
        ],
        "ru": [
            ("Стандартные Условия Отмены", [
                "Отмена, произведенная не менее чем за 48 часов до времени отправления тура, дает право на полную бесплатную отмену, поскольку оплата взимается только в день тура.",
                "Отмена в течение 48 часов до отправления или неявка могут быть оплачены в полном объеме по усмотрению MT Travel.",
            ]),
            ("Островные Туры (Кос, Лерос, Калимнос)", [
                "Поскольку эти туры включают заранее приобретенные билеты на паром, отмена в течение 24 часов до отправления может быть оплачена в полном объеме, даже если оплата еще не была произведена.",
            ]),
            ("Отмена по Погодным Условиям и Соображениям Безопасности", [
                "Если MT Travel отменяет тур из-за небезопасных погодных условий или состояния моря, гостям предлагается возможность перенести тур на другую дату без дополнительной оплаты - в любом случае плата не взимается, поскольку оплата производится только в день тура.",
            ]),
            ("Как Отменить Бронирование", [
                f"Чтобы отменить или перенести бронирование, как можно скорее свяжитесь с нашей командой по телефону, WhatsApp или {EMAIL}, указав номер своего бронирования.",
            ]),
        ],
        "pl": [
            ("Standardowe Warunki Anulowania", [
                "Anulowanie dokonane co najmniej 48 godzin przed godziną odjazdu wycieczki uprawnia do pełnego, bezpłatnego anulowania, ponieważ płatność jest pobierana dopiero w dniu wycieczki.",
                "Anulowanie w ciągu 48 godzin przed odjazdem lub niestawienie się mogą nadal zostać obciążone pełną kwotą według uznania MT Travel.",
            ]),
            ("Wycieczki na Wyspy (Kos, Leros, Kalymnos)", [
                "Ponieważ te wycieczki obejmują wcześniej zakupione bilety promowe, anulowanie w ciągu 24 godzin przed odjazdem może zostać obciążone pełną kwotą, nawet jeśli płatność nie została jeszcze pobrana.",
            ]),
            ("Anulowanie z Powodu Pogody i Bezpieczeństwa", [
                "Jeśli MT Travel odwoła wycieczkę z powodu niebezpiecznych warunków pogodowych lub morskich, goście otrzymują możliwość zmiany terminu na inny bez dodatkowych kosztów - w obu przypadkach nie obowiązuje żadna opłata, ponieważ płatność jest pobierana dopiero w dniu wycieczki.",
            ]),
            ("Jak Anulować", [
                f"Aby anulować lub zmienić termin rezerwacji, jak najszybciej skontaktuj się z naszym zespołem telefonicznie, przez WhatsApp lub {EMAIL}, podając numer rezerwacji.",
            ]),
        ],
    }
    legal_page("cancellation-policy",
        {"tr": "İptal Politikası", "en": "Cancellation Policy", "de": "Stornierungsrichtlinie", "ru": "Политика Отмены", "pl": "Polityka Anulowania"},
        "MT Travel ile ayırtılan turlar için iptal ve iade koşulları.",
        cancellation_sections, title_key="footer.cancellation")

    # ------------------------------------------------------------------
    # DISTANCE SALES AGREEMENT
    # ------------------------------------------------------------------
    distance_sections = {
        "tr": [
            ("Taraflar", [
                f"Bu sözleşme {LEGAL_NAME} (\"Satıcı\") ile bu web sitesi üzerinden çevrimiçi rezervasyon yapan kişi (\"Alıcı\") arasındadır.",
            ]),
            ("Konu", [
                "Bu sözleşme, MT Travel web sitesinde listelenen ve web sitesinin çevrimiçi rezervasyon ve ödeme sistemi aracılığıyla uzaktan satın alınan tur ve transfer hizmetlerinin satışını kapsar.",
            ]),
            ("Cayma Hakkı", [
                "Tur ve transfer hizmetleri zamana ve tarihe bağlı boş zaman hizmetleri olduğundan, cayma hakkı, planlı boş zaman hizmetleri için geçerli mesafeli satış mevzuatına uygun olarak genel bir iade hakkı yerine İptal Politikamız aracılığıyla kullanılır.",
            ]),
            ("Fiyat ve Ödeme", [
                "Toplam fiyat, rezervasyon tamamlanmadan önce açıkça gösterilir. Çevrimiçi ödeme alınmaz - tam tutar tur günü şahsen ödenir ve ödeme sayfasında gösterilenin ötesinde herhangi bir ek ücret uygulanmaz.",
            ]),
            ("Hizmetin Sunumu", [
                "Hizmet, onaylanan tur veya transferin tarih ve saatinde, tur onayında belirtilen buluşma noktasında \"sunulmuş\" sayılır.",
            ]),
            ("Kabul", [
                "Ödeme sayfasında sözleşme kutusunu işaretleyip ödemeyi tamamlayarak, Alıcı bu Mesafeli Satış Sözleşmesi'ni tamamen okuduğunu ve kabul ettiğini onaylar.",
            ]),
        ],
        "en": [
            ("Parties", [
                f"This agreement is between {LEGAL_NAME} (\"Seller\") and the person making an online reservation through this website (\"Buyer\").",
            ]),
            ("Subject", [
                "This agreement covers the sale of tour and transfer services listed on the MT Travel website and purchased remotely through the website's online reservation and payment system.",
            ]),
            ("Right of Withdrawal", [
                "Because tour and transfer services are time- and date-bound leisure services, the right of withdrawal is exercised through our Cancellation Policy rather than a general right of refund, in line with distance selling legislation applicable to scheduled leisure services.",
            ]),
            ("Price and Payment", [
                "The total price is clearly shown before the reservation is completed. No online payment is taken - the full amount is paid in person on the day of the tour, and no additional charges apply beyond what is shown on the payment page.",
            ]),
            ("Provision of Service", [
                "The service is considered \"provided\" at the date and time of the confirmed tour or transfer, at the meeting point stated in the tour confirmation.",
            ]),
            ("Acceptance", [
                "By checking the agreement box on the payment page and completing the reservation, the Buyer confirms having fully read and accepted this Distance Sales Agreement.",
            ]),
        ],
        "de": [
            ("Vertragsparteien", [
                f"Diese Vereinbarung besteht zwischen {LEGAL_NAME} (\"Verkäufer\") und der Person, die über diese Website eine Online-Reservierung vornimmt (\"Käufer\").",
            ]),
            ("Gegenstand", [
                "Diese Vereinbarung umfasst den Verkauf von Tour- und Transferdienstleistungen, die auf der MT Travel Website aufgeführt und über das Online-Reservierungs- und Zahlungssystem der Website aus der Ferne erworben werden.",
            ]),
            ("Widerrufsrecht", [
                "Da Tour- und Transferdienstleistungen zeit- und datumsgebundene Freizeitdienstleistungen sind, wird das Widerrufsrecht gemäß den für geplante Freizeitdienstleistungen geltenden Fernabsatzvorschriften über unsere Stornierungsrichtlinie und nicht über ein allgemeines Rückerstattungsrecht ausgeübt.",
            ]),
            ("Preis und Zahlung", [
                "Der Gesamtpreis wird vor Abschluss der Reservierung deutlich angezeigt. Es wird keine Online-Zahlung erhoben - der volle Betrag wird persönlich am Tag der Tour bezahlt, und es fallen keine zusätzlichen Kosten über das auf der Zahlungsseite Angezeigte hinaus an.",
            ]),
            ("Erbringung der Dienstleistung", [
                "Die Dienstleistung gilt als \"erbracht\" zum Datum und zur Uhrzeit der bestätigten Tour oder des Transfers, am in der Tourbestätigung angegebenen Treffpunkt.",
            ]),
            ("Annahme", [
                "Durch Ankreuzen des Vereinbarungsfelds auf der Zahlungsseite und Abschluss der Reservierung bestätigt der Käufer, diese Fernabsatzvereinbarung vollständig gelesen und akzeptiert zu haben.",
            ]),
        ],
        "ru": [
            ("Стороны", [
                f"Настоящее соглашение заключено между {LEGAL_NAME} («Продавец») и лицом, осуществляющим онлайн-бронирование через данный веб-сайт («Покупатель»).",
            ]),
            ("Предмет Соглашения", [
                "Настоящее соглашение охватывает продажу туристических и трансферных услуг, указанных на веб-сайте MT Travel и приобретаемых удаленно через систему онлайн-бронирования и оплаты веб-сайта.",
            ]),
            ("Право на Отказ", [
                "Поскольку туристические и трансферные услуги являются привязанными ко времени и дате услугами досуга, право на отказ реализуется через нашу Политику отмены, а не через общее право на возврат средств, в соответствии с законодательством о дистанционных продажах, применимым к запланированным услугам досуга.",
            ]),
            ("Цена и Оплата", [
                "Общая цена четко указывается перед завершением бронирования. Онлайн-оплата не взимается - полная сумма оплачивается лично в день тура, и никакие дополнительные сборы сверх указанных на странице оплаты не применяются.",
            ]),
            ("Предоставление Услуги", [
                "Услуга считается «предоставленной» в дату и время подтвержденного тура или трансфера в месте встречи, указанном в подтверждении тура.",
            ]),
            ("Согласие", [
                "Отметив поле соглашения на странице оплаты и завершив бронирование, Покупатель подтверждает, что полностью прочитал и принял настоящее Соглашение о дистанционных продажах.",
            ]),
        ],
        "pl": [
            ("Strony", [
                f"Niniejsza umowa zostaje zawarta pomiędzy {LEGAL_NAME} („Sprzedawca\") a osobą dokonującą rezerwacji online za pośrednictwem tej witryny („Kupujący\").",
            ]),
            ("Przedmiot", [
                "Niniejsza umowa obejmuje sprzedaż usług wycieczkowych i transferowych wymienionych na stronie internetowej MT Travel, zakupionych zdalnie za pośrednictwem systemu rezerwacji i płatności online tej strony.",
            ]),
            ("Prawo Odstąpienia", [
                "Ponieważ usługi wycieczkowe i transferowe są usługami rekreacyjnymi związanymi z określonym czasem i datą, prawo odstąpienia jest realizowane za pośrednictwem naszej Polityki Anulowania, a nie ogólnego prawa do zwrotu, zgodnie z przepisami dotyczącymi sprzedaży na odległość mającymi zastosowanie do zaplanowanych usług rekreacyjnych.",
            ]),
            ("Cena i Płatność", [
                "Łączna cena jest wyraźnie widoczna przed zakończeniem rezerwacji. Nie jest pobierana żadna płatność online - pełna kwota jest płacona osobiście w dniu wycieczki, a poza kwotą widoczną na stronie płatności nie obowiązują żadne dodatkowe opłaty.",
            ]),
            ("Świadczenie Usługi", [
                "Usługę uznaje się za „wykonaną\" w dniu i o godzinie potwierdzonej wycieczki lub transferu, w miejscu spotkania podanym w potwierdzeniu wycieczki.",
            ]),
            ("Akceptacja", [
                "Zaznaczając pole zgody na stronie płatności i finalizując rezerwację, Kupujący potwierdza, że w pełni zapoznał się z niniejszą Umową Sprzedaży na Odległość i ją zaakceptował.",
            ]),
        ],
    }
    legal_page("distance-sales-agreement",
        {"tr": "Mesafeli Satış Sözleşmesi", "en": "Distance Sales Agreement", "de": "Fernabsatzvertrag", "ru": "Договор Дистанционной Продажи", "pl": "Umowa Sprzedaży na Odległość"},
        "Türk tüketici koruma mevzuatına uygun olarak, MT Travel üzerinden çevrimiçi ayırtılan turlara uygulanan mesafeli satış sözleşmesi.",
        distance_sections, title_key="legal.distance_sales_title")


if __name__ == "__main__":
    build()
