"""
Master build script - regenerates the entire MT TRAVEL site from the
data files. Run this after editing anything in /data/*.json to rebuild
every HTML page consistently.

Usage: cd scripts && python3 build_all.py
"""
import subprocess, sys, os

STEPS = [
    "gen_js_data.py",          # tours/countries/reviews/site JS data + i18n bundle (run first & last)
    "gen_home.py",
    "gen_tours_catalog.py",
    "gen_tour_detail.py",
    "gen_static_pages.py",     # about / contact
    "gen_booking.py",
    "gen_checkout.py",
    "gen_success.py",
    "gen_ticket.py",
    "gen_legal_pages.py",
    "gen_404.py",
    "gen_error_pages.py",      # 403 / 500 / maintenance
    "gen_admin_login.py",
    "gen_admin_dashboard.py",
    "gen_admin_reservations.py",
    "gen_admin_tours.py",
    "gen_admin_customers.py",
    "gen_admin_media.py",
    "gen_admin_reports.py",
    "gen_admin_settings.py",
    "gen_seo_files.py",        # sitemap/robots last, once every page exists
]

def main():
    here = os.path.dirname(__file__)
    for step in STEPS:
        print(f"\n=== {step} ===")
        result = subprocess.run([sys.executable, step], cwd=here)
        if result.returncode != 0:
            print(f"FAILED at {step} - stopping.")
            sys.exit(1)
    print("\nBuild complete - every page regenerated from /data.")

if __name__ == "__main__":
    main()
