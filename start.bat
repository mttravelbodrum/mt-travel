@echo off
REM ==========================================================================
REM MT TRAVEL - tek tikla baslatma (Windows)
REM
REM Bu dosyaya cift tiklayarak calistirin. Hem gercek arka ucu (backend)
REM hem de web sitesini baslatir ve tarayicinizda otomatik olarak acar.
REM
REM Neden gerekli: Bu proje statik bir HTML dosyasi degil, gercek bir
REM rezervasyon sistemi ve veritabanina sahip gercek bir web sitesidir.
REM Tarayicilar, dogrudan dosya olarak acilan sayfalarin bir sunucuya
REM erismesini guvenlik nedeniyle engeller - bu yuzden site her zaman
REM bu betik araciligiyla (ya da benzer bir yontemle) calistirilmalidir.
REM ==========================================================================

title MT TRAVEL
cd /d "%~dp0"

echo ======================================================
echo   MT TRAVEL - Baslatiliyor...
echo ======================================================
echo.

REM ---- Node.js kontrolu ----
where node >nul 2>nul
if errorlevel 1 (
  echo HATA: Node.js bulunamadi.
  echo Lutfen once https://nodejs.org adresinden Node.js'i kurun ^(18 veya uzeri^),
  echo ardindan bu dosyayi tekrar calistirin.
  pause
  exit /b 1
)

REM ---- Python kontrolu ----
set PYTHON_CMD=
where python >nul 2>nul
if not errorlevel 1 (
  set PYTHON_CMD=python
) else (
  where py >nul 2>nul
  if not errorlevel 1 (
    set PYTHON_CMD=py
  ) else (
    echo HATA: Python bulunamadi.
    echo Lutfen once https://www.python.org adresinden Python'i kurun,
    echo ardindan bu dosyayi tekrar calistirin.
    pause
    exit /b 1
  )
)

REM ---- Backend .env dosyasini hazirla ----
cd backend
if not exist .env (
  echo Ilk calistirma: backend\.env dosyasi olusturuluyor...
  copy .env.example .env >nul
)

REM ---- Veritabanini hazirla ----
if not exist data\db.json (
  echo Veritabani hazirlaniyor ^(ilk calistirma^)...
  call node seed.js
)

REM ---- 4000 ve 8000 portlarinin zaten kullanimda olup olmadigini kontrol et ----
REM Onceki bir calistirmadan kalan eski bir sunucu hala acikta kalmis
REM olabilir - bu durumda yeni sunucu hic baslamaz ve degisiklikler asla
REM gorunmez, cunku eski sunucu yaniti vermeye devam eder.
set PORT_CONFLICT=0
netstat -ano | findstr /R /C:":4000 .*LISTENING" >nul 2>nul
if not errorlevel 1 set PORT_CONFLICT=1
netstat -ano | findstr /R /C:":8000 .*LISTENING" >nul 2>nul
if not errorlevel 1 set PORT_CONFLICT=1

if "%PORT_CONFLICT%"=="1" (
  echo.
  echo ======================================================
  echo   UYARI: 4000 veya 8000 portu zaten kullanimda!
  echo ======================================================
  echo.
  echo   Bu genellikle daha once acilmis, hala calisan eski bir
  echo   pencereden kaynaklanir - bu durumda YENI degisiklikler
  echo   hicbir zaman gorunmez, cunku eski sunucu yanit vermeye
  echo   devam eder.
  echo.
  echo   COZUM: Daha once bu siteyi baslattiginiz TUM "MT Travel"
  echo   baslikli siyah pencereleri kapatin ^(veya Gorev Yoneticisi'nden
  echo   node.exe ve python.exe islemlerini sonlandirin^), sonra bu
  echo   dosyayi tekrar calistirin.
  echo.
  pause
  exit /b 1
)

REM ---- Backend'i ayri bir pencerede baslat ----
REM Not: Calisma dizinini spawn edilen pencereye miras birakmaya guvenmek
REM yerine, start komutunun kendi /D parametresiyle her pencereye dogru
REM klasoru acikca veriyoruz - boylece hangi Windows yapilandirmasinda
REM calistigi fark etmeksizin her zaman dogru dosyalari sunar.
echo Backend sunucusu baslatiliyor (port 4000)...
start "MT Travel - Backend" /D "%~dp0backend" cmd /k "node server.js"

timeout /t 2 /nobreak >nul

REM ---- Site sunucusunu ayri bir pencerede baslat ----
echo Web sitesi sunucusu baslatiliyor (port 8000)...
start "MT Travel - Website" /D "%~dp0site" cmd /k "%PYTHON_CMD% "%~dp0serve-no-cache.py" 8000"

timeout /t 2 /nobreak >nul

echo.
echo ======================================================
echo   Hazir! Site su adreste calisiyor: http://localhost:8000
echo   Admin paneli: http://localhost:8000/admin/login.html
echo ======================================================
echo.
echo Acilan iki pencereyi KAPATMAYIN - kapatirsaniz site durur.
echo Durdurmak icin o pencereleri kapatmaniz yeterlidir.
echo.

REM ---- Tarayiciyi otomatik ac ----
start http://localhost:8000

pause
