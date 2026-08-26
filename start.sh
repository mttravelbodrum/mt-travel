#!/bin/bash
# ==========================================================================
# MT TRAVEL — tek tıkla başlatma (Mac / Linux)
#
# Bu dosya çift tıklanarak veya bir terminalde "./start.sh" yazılarak
# çalıştırılabilir. Hem gerçek arka ucu (backend) hem de web sitesini
# başlatır ve tarayıcınızda otomatik olarak açar.
#
# Neden gerekli: Bu proje statik bir HTML dosyası değil, gerçek bir
# rezervasyon sistemi ve veritabanına sahip gerçek bir web sitesidir.
# Tarayıcılar, doğrudan dosya olarak açılan sayfaların bir sunucuya
# erişmesini güvenlik nedeniyle engeller - bu yüzden site her zaman
# bu betik aracılığıyla (ya da benzer bir yöntemle) çalıştırılmalıdır.
# ==========================================================================

set -e
cd "$(dirname "$0")"
SCRIPT_DIR="$(pwd)"

echo "======================================================"
echo "  MT TRAVEL - Başlatılıyor..."
echo "======================================================"
echo ""

# ---- Node.js kontrolü ----
if ! command -v node >/dev/null 2>&1; then
  echo "HATA: Node.js bulunamadı."
  echo "Lütfen önce https://nodejs.org adresinden Node.js'i kurun (18 veya üzeri),"
  echo "ardından bu dosyayı tekrar çalıştırın."
  read -p "Kapatmak için Enter'a basın..."
  exit 1
fi

# ---- Python kontrolü (site sunucusu için) ----
PYTHON_CMD=""
if command -v python3 >/dev/null 2>&1; then
  PYTHON_CMD="python3"
elif command -v python >/dev/null 2>&1; then
  PYTHON_CMD="python"
else
  echo "HATA: Python bulunamadı."
  echo "Lütfen önce https://www.python.org adresinden Python'ı kurun,"
  echo "ardından bu dosyayı tekrar çalıştırın."
  read -p "Kapatmak için Enter'a basın..."
  exit 1
fi

# ---- Portların zaten kullanımda olup olmadığını kontrol et ----
port_in_use() {
  if command -v curl >/dev/null 2>&1; then
    curl -s -o /dev/null --max-time 1 "http://localhost:$1" 2>/dev/null
    return $?
  fi
  return 1
}

if port_in_use 4000; then
  echo ""
  echo "Site zaten çalışıyor gibi görünüyor (4000 portu kullanımda)."
  echo "Muhtemelen zaten açık bir pencerede çalışıyordur - tarayıcınızda"
  echo "http://localhost:8000 adresini açmanız yeterli olabilir."
  echo ""
  echo "Emin değilseniz, önce açık olan diğer başlatma pencerelerini kapatıp"
  echo "bu dosyayı tekrar çalıştırın."
  read -p "Yine de devam etmek için Enter'a basın, iptal için Ctrl+C..." || exit 0
fi

# ---- Backend .env dosyasını hazırla (yoksa örnekten oluştur) ----
cd backend
if [ ! -f .env ]; then
  echo "İlk çalıştırma: backend/.env dosyası oluşturuluyor..."
  cp .env.example .env
fi

# ---- Veritabanını hazırla (yoksa oluştur) ----
if [ ! -f data/db.json ]; then
  echo "Veritabanı hazırlanıyor (ilk çalıştırma)..."
  node seed.js
fi

# ---- Backend'i başlat ----
echo "Backend sunucusu başlatılıyor (port 4000)..."
node server.js &
BACKEND_PID=$!
cd ..

# Backend'in gerçekten ayağa kalktığını doğrula
sleep 1
if ! kill -0 $BACKEND_PID 2>/dev/null; then
  echo ""
  echo "HATA: Backend başlatılamadı. Olası nedenler:"
  echo "  - 4000 portu zaten kullanımda olabilir"
  echo "  - backend/.env dosyasında bir sorun olabilir"
  echo "Ayrıntılar için backend/README.md dosyasına bakın."
  read -p "Kapatmak için Enter'a basın..."
  exit 1
fi

# ---- Site sunucusunu başlat ----
echo "Web sitesi sunucusu başlatılıyor (port 8000)..."
cd site
$PYTHON_CMD "$SCRIPT_DIR/serve-no-cache.py" 8000 &
SITE_PID=$!
cd ..

sleep 1

echo ""
echo "======================================================"
echo "  Hazır! Site şu adreste çalışıyor: http://localhost:8000"
echo "  Admin paneli: http://localhost:8000/admin/login.html"
echo "======================================================"
echo ""
echo "Bu pencereyi KAPATMAYIN - kapatırsanız site durur."
echo "Durdurmak için bu pencerede Ctrl+C tuşlarına basın."
echo ""

# ---- Tarayıcıyı otomatik aç ----
if command -v open >/dev/null 2>&1; then
  open "http://localhost:8000"
elif command -v xdg-open >/dev/null 2>&1; then
  xdg-open "http://localhost:8000"
fi

# Kullanıcı Ctrl+C yapana kadar bekle, sonra her iki sunucuyu da düzgünce kapat
trap "echo ''; echo 'Sunucular durduruluyor...'; kill $BACKEND_PID $SITE_PID 2>/dev/null; exit 0" INT TERM
wait
