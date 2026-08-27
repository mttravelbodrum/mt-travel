import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "..", "data"))
import common_parts as cp
from icons import icon

OUT = os.path.join(os.path.dirname(__file__), "..", "site")


def error_page(code, title, message, filename):
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(title=f"{code} {title} | MT Travel", description=message, canonical_path=f"{filename}.html", noindex=True)}
</head>
<body>
  {cp.topbar()}
  {cp.header(active="")}
  <main>
    <div class="container error-page">
      <h1>{code}</h1>
      <h2>{title}</h2>
      <p style="max-width:440px; margin-inline:auto; margin-bottom:28px;">{message}</p>
      <div style="display:flex; gap:14px; justify-content:center; flex-wrap:wrap;">
        <a href="index.html" class="btn btn--primary">{icon('arrow-left',16)}Anasayfaya Dön</a>
        <a href="contact.html" class="btn btn--outline-dark">Destek ile İletişime Geç</a>
      </div>
    </div>
  </main>
  {cp.footer()}
  {cp.scripts()}
</body>
</html>'''
    with open(os.path.join(OUT, f"{filename}.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  {filename}.html written ({len(html)} chars)")


def build_maintenance():
    html = f'''<!DOCTYPE html>
<html lang="tr">
<head>
  {cp.head(title="Bakımda | MT Travel", description="Birkaç iyileştirme yapıyoruz - kısa süre içinde geri döneceğiz.", canonical_path="maintenance.html", noindex=True)}
</head>
<body>
  {cp.topbar()}
  {cp.header(active="")}
  <main>
    <div class="container error-page">
      <div class="confirm-check" style="background:var(--gold-100); color:var(--gold-600);">{icon('settings', 44)}</div>
      <h2 style="margin-top:24px;">Kısa Süre İçinde Geri Döneceğiz</h2>
      <p style="max-width:460px; margin-inline:auto; margin-bottom:28px;">MT Travel, her şeyi daha da iyi hale getirmek için şu anda planlı bakımdan geçiyor. Lütfen kısa süre sonra tekrar kontrol edin veya aşağıdan doğrudan bize ulaşın.</p>
      <div style="display:flex; gap:14px; justify-content:center; flex-wrap:wrap;">
        <a href="tel:{cp.COMPANY['phone_link']}" class="btn btn--primary">{icon('phone',16)}{cp.COMPANY['phone_display']}</a>
        <a href="https://wa.me/{cp.COMPANY['whatsapp_link']}" class="btn btn--whatsapp" target="_blank" rel="noopener">{icon('whatsapp',16)}WhatsApp</a>
      </div>
    </div>
  </main>
  {cp.footer()}
  {cp.scripts()}
</body>
</html>'''
    with open(os.path.join(OUT, "maintenance.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  maintenance.html written ({len(html)} chars)")


def build():
    error_page("403", "Erişim Yasaklandı", "Bu sayfayı görüntüleme izniniz yok. Bunun bir hata olduğunu düşünüyorsanız, lütfen destek ekibimizle iletişime geçin.", "403")
    error_page("500", "Bir Şeyler Ters Gitti", "Bizim tarafımızda beklenmeyen bir hata oluştu. Ekibimiz bilgilendirildi - lütfen birazdan tekrar deneyin.", "500")
    build_maintenance()


if __name__ == "__main__":
    build()
