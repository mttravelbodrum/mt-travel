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
  {cp.head(title="Sayfa Bulunamadı | MT Travel", description="Aradığınız sayfa bulunamadı.", canonical_path="404.html", noindex=True)}
</head>
<body>
  {cp.topbar()}
  {cp.header(active="")}
  <main>
    <div class="container error-page">
      <h1>404</h1>
      <h2 data-i18n="error404.title">Sayfa Bulunamadı</h2>
      <p style="max-width:440px; margin-inline:auto; margin-bottom:28px;" data-i18n="error404.subtitle">Aradığınız sayfa taşınmış veya artık mevcut olmayabilir. Sizi doğru yere yönlendirelim.</p>
      <div style="display:flex; gap:14px; justify-content:center; flex-wrap:wrap;">
        <a href="index.html" class="btn btn--primary">{icon('arrow-left',16)}<span data-i18n="error404.back_home">Anasayfaya Dön</span></a>
        <a href="tours.html" class="btn btn--outline-dark" data-i18n="error404.browse_tours">Turlara Göz At</a>
      </div>
    </div>
  </main>
  {cp.footer()}
  {cp.scripts()}
</body>
</html>'''
    with open(os.path.join(OUT, "404.html"), "w", encoding="utf-8") as f:
        f.write(html)
    print(f"  404.html written ({len(html)} chars)")


if __name__ == "__main__":
    build()
