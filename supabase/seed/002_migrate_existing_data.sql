-- MT Travel - migrate existing data into Supabase
-- Auto-generated from backend/data/db.json (operational fields),
-- data/tours.json (i18n content), and data/helpers.py's FOLDER_PREFIX
-- (the existing assets/images/{prefix}_images/ convention).
-- Safe to re-run: every insert is ON CONFLICT keyed on the same
-- natural key the app already uses, so running this twice never
-- creates duplicates.

-- ============ tours (19) ============
insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('kos-island', 'island', true, 'best_seller',
   45, 45, 22.5, 0,
   'standard', 38.25, 72,
   10, '08:00', '18:00',
   4.9, 245, true, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"leros-island","kalymnos-island","boat-trip"}', 'sea')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('leros-island', 'island', true, 'none',
   48, 48, 24, 0,
   'standard', 40.8, 76.8,
   11, '08:00', '19:00',
   4.7, 96, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"kos-island","kalymnos-island","boat-trip"}', 'sea')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('kalymnos-island', 'island', true, 'none',
   50, 50, 25, 0,
   'standard', 42.5, 80,
   10, '08:00', '18:00',
   4.8, 112, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"kos-island","leros-island","boat-trip"}', 'sea')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('boat-trip', 'water', false, 'best_seller',
   35, 35, 17.5, 0,
   'standard', 29.75, 56,
   7, '08:00', '15:00',
   4.8, 320, true, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"jeep-safari","scuba-diving"}', 'sea')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('turkish-bath', 'wellness', false, 'none',
   25, 25, 12.5, 0,
   'standard', 21.25, 40,
   1.5, '08:00', '09:30',
   4.7, 168, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"aquapark","boat-trip","horse-riding"}', 'spa')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('jeep-safari', 'land', false, 'popular',
   40, 40, 20, 0,
   'standard', 34, 64,
   6, '08:00', '14:00',
   4.8, 180, true, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"atv-safari","horse-riding","rafting"}', 'adventure')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('atv-safari', 'land', false, 'none',
   38, 38, 19, 0,
   'single_double', 38, 64.6,
   3, '08:00', '11:00',
   4.7, 94, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"jeep-safari","horse-riding","scuba-diving"}', 'adventure')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('horse-riding', 'land', false, 'none',
   30, 30, 15, 0,
   'standard', 25.5, 48,
   2, '08:00', '10:00',
   4.8, 76, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"jeep-safari","atv-safari","turkish-bath"}', 'adventure')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('scuba-diving', 'water', false, 'popular',
   60, 60, 30, 0,
   'standard', 51, 96,
   4, '08:00', '12:00',
   4.9, 150, true, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"boat-trip","dolphin-park","rafting"}', 'sea')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('dolphin-park', 'land', false, 'none',
   42, 42, 21, 0,
   'standard', 35.7, 67.2,
   3, '08:00', '11:00',
   4.6, 88, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"aquapark","boat-trip"}', 'family')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('aquapark', 'land', false, 'none',
   28, 28, 14, 0,
   'standard', 23.8, 44.8,
   6, '08:00', '14:00',
   4.6, 140, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"dolphin-park","boat-trip","horse-riding"}', 'family')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('pamukkale', 'land', false, 'popular',
   55, 55, 27.5, 0,
   'standard', 46.75, 88,
   13, '08:00', '21:00',
   4.9, 210, true, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"ephesus","dalyan"}', 'ruins')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('ephesus', 'land', false, 'best_seller',
   50, 50, 25, 0,
   'standard', 42.5, 80,
   11, '08:00', '19:00',
   4.9, 268, true, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"pamukkale","dalyan"}', 'ruins')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('dalyan', 'land', false, 'none',
   45, 45, 22.5, 0,
   'standard', 38.25, 72,
   12, '08:00', '20:00',
   4.8, 132, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"pamukkale","ephesus","rafting"}', 'ruins')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('rafting', 'land', false, 'none',
   40, 40, 20, 0,
   'standard', 34, 64,
   12, '08:00', '20:00',
   4.7, 64, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"jeep-safari","atv-safari","scuba-diving"}', 'adventure')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('airport-transfer', 'transfer', false, 'none',
   18, 18, 9, 0,
   'standard', 15.3, 28.8,
   1, '08:00', '09:00',
   4.8, 302, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"vip-transfer","bodrum-transfer"}', 'transfer')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('vip-transfer', 'transfer', false, 'none',
   45, 45, 22.5, 0,
   'standard', 38.25, 72,
   1, '08:00', '09:00',
   4.9, 71, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"airport-transfer","bodrum-transfer"}', 'transfer')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('bodrum-transfer', 'transfer', false, 'none',
   20, 20, 10, 0,
   'standard', 17, 32,
   1, '08:00', '09:00',
   4.7, 54, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"airport-transfer","vip-transfer","jeep-safari"}', 'transfer')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

insert into public.tours
  (slug, category, is_island, badge, price, price_adult, price_child, price_infant,
   pricing_mode, price_single, price_double, duration_hours, departure_time, return_time,
   rating, review_count, featured, visible, available_days, related_slugs, theme)
values
  ('bodrum-city-tour', 'land', false, 'popular',
   35, 35, 17.5, 0,
   'standard', 29.75, 56,
   6, '08:00', '14:00',
   4.7, 88, false, true,
   '{"monday","tuesday","wednesday","thursday","friday","saturday","sunday"}', '{"boat-trip","turkish-bath","jeep-safari"}', 'ruins')
on conflict (slug) do update set
  category = excluded.category, is_island = excluded.is_island, badge = excluded.badge,
  price = excluded.price, price_adult = excluded.price_adult, price_child = excluded.price_child,
  price_infant = excluded.price_infant, pricing_mode = excluded.pricing_mode,
  price_single = excluded.price_single, price_double = excluded.price_double,
  duration_hours = excluded.duration_hours, departure_time = excluded.departure_time,
  return_time = excluded.return_time, rating = excluded.rating, review_count = excluded.review_count,
  featured = excluded.featured, visible = excluded.visible, available_days = excluded.available_days,
  related_slugs = excluded.related_slugs, theme = excluded.theme;

-- ============ tour_translations ============
insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kos-island'), 'tr',
   'Kos Adası Turu', 'Yunanistan''ın Kos Adası''nda dolu dolu bir gün - kaleler, antik kalıntılar ve Ege''nin en berrak suları.', 'Kos, Yunanistan (Bodrum''dan feribotla)',
   '10 Saat - Tam Gün', '08:00, Her Gün', '18:30',
   'Bodrum Uluslararası Feribot Terminali, Neyzen Tevfik Caddesi',
   '["Kos, Bodrum''a kısa bir feribot mesafesinde olsa da bambaşka bir dünya hissi verir - beyaz badanalı sokaklar, İtalyan dönemi mimarisi ve bir Yunan adası sabahının o eşsiz sakinliği. Gününüz, Kos Kasabası''nın tam kalbine varan manzaralı bir deniz yolculuğuyla başlar.", "Karaya çıktığınızda 15. yüzyıldan kalma Şövalyeler Kalesi''nin önünden geçecek, Hipokrat''ın ders verirken gölgelendiği söylenen antik çınar ağacının altında duracak ve liman kenarındaki kafeleri, butikleri gezeceksiniz. Kasaba plajında yüzmek, yerel Yunan mutfağını tatmak ya da eski kasabada kaybolmak için bolca vaktiniz olacak; ardından feribot sizi gün batımına doğru Bodrum''a geri getirecek."]'::jsonb, '["Gidiş-dönüş boyunca deniz manzaralı feribot yolculuğu", "Kos Kasabası''nı kendi hızınızda keşfetme özgürlüğü", "Şövalyeler Kalesi ve Hipokrat Çınarı", "Kasaba plajında isteğe bağlı yüzme molası", "Yunan tavernaları, fırınları ve butik alışveriş", "Limanda İngilizce konuşan rehber desteği"]'::jsonb,
   '["Bodrum - Kos gidiş-dönüş feribot bileti", "Otel alış ve bırakış hizmeti (Bodrum yarımadası)", "İngilizce konuşan tur rehberi", "Liman vergileri ve harçları", "Kos Kasabası''nda serbest zaman", "Geçiş süresince seyahat sigortası"]'::jsonb, '["Kos''ta öğle yemeği ve içecekler", "Kişisel harcamalar ve alışveriş", "Adada isteğe bağlı ekstra geziler", "Bahşişler"]'::jsonb,
   '[{"time": "07:00", "title": "Otelden Alış", "text": "Şoförümüz sizi Bodrum yarımadasındaki otelinizin lobisinden alır."}, {"time": "08:00", "title": "Feribotla Hareket", "text": "Kos''a geçiş için Bodrum Uluslararası Feribot Terminali''nden gemiye binilir."}, {"time": "09:15", "title": "Kos Kasabası''na Varış", "text": "Pasaport kontrolünün ardından rehberinizle kısa bir tanıtım yürüyüşü yapılır."}, {"time": "09:45", "title": "Serbest Keşif Zamanı", "text": "Kaleyi, eski kasabayı, plajı ve kafeleri kendi hızınızda gezersiniz."}, {"time": "17:00", "title": "Dönüş Yolculuğu", "text": "Bodrum''a dönüş feribotuna binilir, akşamüzeri varış yapılır."}]'::jsonb, '[{"q": "Kos Adası turu için pasaport gerekli mi?", "a": "Evet, çocuklar dahil her misafirin geçerli bir pasaportu olmalıdır. Rezervasyon yapmadan önce uyruğunuza ait giriş şartlarını kontrol etmenizi öneririz."}, {"q": "Kos Adası turuna öğle yemeği dahil mi?", "a": "Öğle yemeği dahil değildir; böylece Kos Kasabası''ndaki taverna ve kafeler arasında özgürce seçim yapabilirsiniz. Dilerseniz restoran önerisi de sunabiliriz."}, {"q": "Kos Kasabası''nda ne kadar serbest zamanımız oluyor?", "a": "Kaleyi, eski kasabayı, mağazaları ve plajı kendi hızınızda gezmeniz için yaklaşık yedi saat serbest zamanınız olacak."}, {"q": "Kos Adası turu çocuklar için uygun mu?", "a": "Evet, tur aile dostu olup yüzme molası da içerir; ancak çocukların da geçerli bir pasaportu olması gerekir."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kos-island'), 'en',
   'Kos Island Tour', 'A full day on the Greek island of Kos - castles, ancient ruins and the Aegean''s clearest water.', 'Kos, Greece (via ferry from Bodrum)',
   '10 Hours - Full Day', '08:00 AM, Daily', '18:30 PM',
   'Bodrum International Ferry Terminal, Neyzen Tevfik Street',
   '["Kos sits just a short ferry ride from Bodrum, yet it feels like a different world - whitewashed lanes, Italian-era architecture and the unmistakable calm of a Greek island morning. Your day begins with a scenic crossing across the strait, arriving directly in the heart of Kos Town.", "Once ashore, you''ll wander past the 15th-century Castle of the Knights, stand beneath the ancient plane tree said to have shaded Hippocrates as he taught medicine, and browse the harbour-front cafes and boutiques. There''s free time to swim at the town beach, try local Greek cuisine, or simply get lost in the old town before the ferry brings you back to Bodrum as the sun begins to set."]'::jsonb, '["Round-trip ferry crossing with sea views the whole way", "Free time to explore Kos Town at your own pace", "Castle of the Knights and the Hippocrates Plane Tree", "Optional swim at the town beach", "Greek tavernas, bakeries and boutique shopping", "English-speaking guide assistance at the port"]'::jsonb,
   '["Return ferry tickets Bodrum - Kos", "Hotel pick-up and drop-off (Bodrum peninsula)", "English-speaking tour guide", "Port taxes and harbour fees", "Free time in Kos Town", "Travel insurance during the crossing"]'::jsonb, '["Lunch and drinks in Kos", "Personal expenses and shopping", "Optional excursions on the island", "Gratuities"]'::jsonb,
   '[{"time": "07:00", "title": "Hotel Pick-up", "text": "Our driver collects you from your hotel lobby across the Bodrum peninsula."}, {"time": "08:00", "title": "Departure by Ferry", "text": "Board the ferry at Bodrum International Ferry Terminal for the crossing to Kos."}, {"time": "09:15", "title": "Arrival in Kos Town", "text": "Clear passport control and meet your guide for a short orientation walk."}, {"time": "09:45", "title": "Free Time to Explore", "text": "Visit the castle, old town, beach and cafes at your own pace."}, {"time": "17:00", "title": "Return Crossing", "text": "Board the return ferry to Bodrum, arriving in the early evening."}]'::jsonb, '[{"q": "Do I need a passport for the Kos Island tour?", "a": "Yes, a valid passport is required for every guest, including children. Please check your nationality''s entry requirements before booking, as some travellers may need to arrange a visa in advance."}, {"q": "Is lunch included in the Kos Island tour?", "a": "Lunch is not included so you can choose freely among the tavernas and cafes in Kos Town, but let us know if you''d like a restaurant recommendation."}, {"q": "How much free time do we get in Kos Town?", "a": "You''ll have approximately seven hours of free time to explore the castle, old town, shops and beach at your own pace."}, {"q": "Is the Kos Island tour suitable for children?", "a": "Yes, the tour is family-friendly and includes swimming time, though children must also carry a valid passport."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kos-island'), 'de',
   'Kos Insel Tour', 'Ein voller Tag auf der griechischen Insel Kos - Burgen, antike Ruinen und das klarste Wasser der Ägäis.', 'Kos, Griechenland (per Fähre ab Bodrum)',
   '10 Stunden - Ganztägig', '08:00 Uhr, täglich', '18:30 Uhr',
   'Internationales Fährterminal Bodrum, Neyzen Tevfik Straße',
   '["Kos liegt nur eine kurze Fährfahrt von Bodrum entfernt und fühlt sich dennoch wie eine andere Welt an - weiß getünchte Gassen, Architektur aus der italienischen Zeit und die unverwechselbare Ruhe eines griechischen Inselmorgens. Ihr Tag beginnt mit einer malerischen Überfahrt direkt ins Herz der Stadt Kos.", "An Land angekommen spazieren Sie an der Ritterburg aus dem 15. Jahrhundert vorbei, stehen unter der antiken Platane, unter der Hippokrates der Legende nach Medizin lehrte, und schlendern durch die Cafés und Boutiquen an der Hafenpromenade. Es bleibt Zeit zum Baden am Stadtstrand, für griechische Küche oder um sich einfach in der Altstadt treiben zu lassen, bevor die Fähre Sie bei Sonnenuntergang zurück nach Bodrum bringt."]'::jsonb, '["Fährüberfahrt mit Meerblick auf der gesamten Strecke", "Freie Zeit zur Erkundung der Stadt Kos in Ihrem Tempo", "Ritterburg und die Hippokrates-Platane", "Optionales Bad am Stadtstrand", "Griechische Tavernen, Bäckereien und Boutique-Shopping", "Unterstützung durch einen englischsprachigen Reiseleiter im Hafen"]'::jsonb,
   '["Fährtickets Bodrum - Kos (hin und zurück)", "Hotelabholung und -rückbringung (Bodrum-Halbinsel)", "Englischsprachiger Reiseleiter", "Hafengebühren und -abgaben", "Freizeit in der Stadt Kos", "Reiseversicherung während der Überfahrt"]'::jsonb, '["Mittagessen und Getränke auf Kos", "Persönliche Ausgaben und Einkäufe", "Optionale Ausflüge auf der Insel", "Trinkgelder"]'::jsonb,
   '[{"time": "07:00", "title": "Hotelabholung", "text": "Unser Fahrer holt Sie in der Lobby Ihres Hotels auf der Bodrum-Halbinsel ab."}, {"time": "08:00", "title": "Abfahrt mit der Fähre", "text": "Einschiffung am Internationalen Fährterminal Bodrum zur Überfahrt nach Kos."}, {"time": "09:15", "title": "Ankunft in der Stadt Kos", "text": "Passkontrolle und kurzer Orientierungsspaziergang mit Ihrem Reiseleiter."}, {"time": "09:45", "title": "Freie Erkundung", "text": "Besuchen Sie Burg, Altstadt, Strand und Cafés in Ihrem eigenen Tempo."}, {"time": "17:00", "title": "Rückfahrt", "text": "Einschiffung zur Rückfahrt nach Bodrum, Ankunft am frühen Abend."}]'::jsonb, '[{"q": "Brauche ich einen Reisepass für die Kos-Insel-Tour?", "a": "Ja, für jeden Gast, auch Kinder, ist ein gültiger Reisepass erforderlich. Bitte prüfen Sie vor der Buchung die Einreisebestimmungen für Ihre Staatsangehörigkeit."}, {"q": "Ist das Mittagessen bei der Kos-Insel-Tour inbegriffen?", "a": "Das Mittagessen ist nicht inbegriffen, damit Sie frei zwischen den Tavernen und Cafés in der Stadt Kos wählen können. Gerne empfehlen wir Ihnen ein Restaurant."}, {"q": "Wie viel Freizeit haben wir in der Stadt Kos?", "a": "Sie haben etwa sieben Stunden freie Zeit, um Burg, Altstadt, Geschäfte und Strand in Ihrem eigenen Tempo zu erkunden."}, {"q": "Ist die Kos-Insel-Tour für Kinder geeignet?", "a": "Ja, die Tour ist familienfreundlich und beinhaltet Badezeit, allerdings benötigen auch Kinder einen gültigen Reisepass."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kos-island'), 'ru',
   'Тур на остров Кос', 'Насыщенный день на греческом острове Кос - крепости, античные руины и самая прозрачная вода Эгейского моря.', 'Кос, Греция (на пароме из Бодрума)',
   '10 часов - весь день', '08:00, ежедневно', '18:30',
   'Международный паромный терминал Бодрума, улица Нейзен Тевфик',
   '["Кос находится всего в коротком переходе на пароме от Бодрума, но кажется совсем другим миром - белёные улочки, архитектура итальянской эпохи и неповторимое спокойствие греческого острова по утрам. Ваш день начинается с живописного морского перехода прямо в центр города Кос.", "Сойдя на берег, вы пройдёте мимо крепости Рыцарей XV века, постоите под древним платаном, под которым, по легенде, Гиппократ преподавал медицину, и прогуляетесь по кафе и бутикам набережной. Будет свободное время искупаться на городском пляже, попробовать греческую кухню или просто затеряться в старом городе, прежде чем паром на закате доставит вас обратно в Бодрум."]'::jsonb, '["Живописный переход на пароме с видом на море всю дорогу", "Свободное время для знакомства с городом Кос в своём темпе", "Крепость Рыцарей и платан Гиппократа", "Возможность искупаться на городском пляже", "Греческие таверны, пекарни и бутики", "Помощь англоговорящего гида в порту"]'::jsonb,
   '["Билеты на паром Бодрум - Кос туда и обратно", "Трансфер от отеля и обратно (полуостров Бодрум)", "Англоговорящий гид", "Портовые сборы и пошлины", "Свободное время в городе Кос", "Страховка на время переправы"]'::jsonb, '["Обед и напитки на Косе", "Личные расходы и покупки", "Дополнительные экскурсии на острове", "Чаевые"]'::jsonb,
   '[{"time": "07:00", "title": "Трансфер из отеля", "text": "Водитель заберёт вас из лобби отеля на полуострове Бодрум."}, {"time": "08:00", "title": "Отправление на пароме", "text": "Посадка на паром в порту Бодрума для переправы на Кос."}, {"time": "09:15", "title": "Прибытие в город Кос", "text": "Паспортный контроль и короткая ознакомительная прогулка с гидом."}, {"time": "09:45", "title": "Свободное время", "text": "Осмотрите крепость, старый город, пляж и кафе в своём темпе."}, {"time": "17:00", "title": "Обратный переход", "text": "Посадка на паром до Бодрума, прибытие ранним вечером."}]'::jsonb, '[{"q": "Нужен ли паспорт для тура на остров Кос?", "a": "Да, действующий паспорт необходим каждому гостю, включая детей. Перед бронированием уточните визовые требования для вашего гражданства."}, {"q": "Включён ли обед в тур на остров Кос?", "a": "Обед не включён, чтобы вы могли свободно выбрать таверну или кафе в городе Кос. Мы с радостью подскажем хороший вариант."}, {"q": "Сколько свободного времени у нас будет в городе Кос?", "a": "У вас будет около семи часов свободного времени, чтобы осмотреть крепость, старый город, магазины и пляж в своём темпе."}, {"q": "Подходит ли тур на остров Кос для детей?", "a": "Да, тур подходит для семей и включает время для купания, однако у детей также должен быть действующий паспорт."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kos-island'), 'pl',
   'Wycieczka na Wyspę Kos', 'Pełen wrażeń dzień na greckiej wyspie Kos - zamki, starożytne ruiny i najczystsza woda Morza Egejskiego.', 'Kos, Grecja (promem z Bodrum)',
   '10 godzin - Cały dzień', '08:00, codziennie', '18:30',
   'Międzynarodowy Terminal Promowy w Bodrum, ulica Neyzen Tevfik',
   '["Kos leży zaledwie krótki rejs promem od Bodrum, a mimo to wydaje się zupełnie innym światem - białe uliczki, architektura z okresu włoskiego i wyjątkowy spokój greckiego wyspiarskiego poranka. Dzień zaczyna się od malowniczego rejsu prosto do centrum miasta Kos.", "Po zejściu na ląd miniecie XV-wieczny Zamek Rycerzy, staniecie pod starożytnym platanem, pod którym podobno Hipokrates nauczał medycyny, i przejdziecie się wzdłuż nadmorskich kawiarni i butików. Będzie czas na kąpiel na miejskiej plaży, degustację greckiej kuchni lub po prostu błądzenie po starówce, zanim prom o zachodzie słońca zabierze was z powrotem do Bodrum."]'::jsonb, '["Malowniczy rejs promem z widokiem na morze przez całą drogę", "Czas wolny na zwiedzanie miasta Kos we własnym tempie", "Zamek Rycerzy i Platan Hipokratesa", "Opcjonalna kąpiel na miejskiej plaży", "Greckie tawerny, piekarnie i butikowe zakupy", "Wsparcie anglojęzycznego przewodnika w porcie"]'::jsonb,
   '["Bilety promowe Bodrum - Kos w obie strony", "Odbiór i powrót z hotelu (półwysep Bodrum)", "Anglojęzyczny przewodnik", "Opłaty i podatki portowe", "Czas wolny w mieście Kos", "Ubezpieczenie podróżne na czas rejsu"]'::jsonb, '["Obiad i napoje na Kos", "Wydatki osobiste i zakupy", "Opcjonalne wycieczki na wyspie", "Napiwki"]'::jsonb,
   '[{"time": "07:00", "title": "Odbiór z hotelu", "text": "Kierowca odbierze Państwa z lobby hotelu na półwyspie Bodrum."}, {"time": "08:00", "title": "Wyjazd promem", "text": "Wejście na prom w Międzynarodowym Terminalu Promowym w Bodrum w celu przeprawy na Kos."}, {"time": "09:15", "title": "Przybycie do miasta Kos", "text": "Kontrola paszportowa i krótki spacer orientacyjny z przewodnikiem."}, {"time": "09:45", "title": "Czas wolny na zwiedzanie", "text": "Zwiedźcie zamek, starówkę, plażę i kawiarnie we własnym tempie."}, {"time": "17:00", "title": "Podróż powrotna", "text": "Wejście na prom powrotny do Bodrum, przybycie wczesnym wieczorem."}]'::jsonb, '[{"q": "Czy potrzebuję paszportu na wycieczkę na wyspę Kos?", "a": "Tak, każdy gość, w tym dzieci, musi posiadać ważny paszport. Przed rezerwacją sprawdź wymagania wizowe dla swojego obywatelstwa."}, {"q": "Czy obiad jest wliczony w wycieczkę na Kos?", "a": "Obiad nie jest wliczony, dzięki czemu mogą Państwo swobodnie wybrać tawernę lub kawiarnię w mieście Kos. Chętnie polecimy dobrą restaurację."}, {"q": "Ile czasu wolnego mamy w mieście Kos?", "a": "Będą Państwo mieli około siedmiu godzin czasu wolnego na zwiedzenie zamku, starówki, sklepów i plaży we własnym tempie."}, {"q": "Czy wycieczka na Kos jest odpowiednia dla dzieci?", "a": "Tak, wycieczka jest przyjazna rodzinom i obejmuje czas na kąpiel, jednak dzieci również muszą posiadać ważny paszport."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'leros-island'), 'tr',
   'Leros Adası Turu', 'Daha sakin bir Yunan adası kaçamağı - Art Deco limanlar, saklı koylar ve yavaşlayan bir ada temposu.', 'Leros, Yunanistan (Bodrum''dan feribotla)',
   '11 Saat - Tam Gün', '07:30, Belirli Günler', '18:30',
   'Bodrum Uluslararası Feribot Terminali, Neyzen Tevfik Caddesi',
   '["Leros, çoğu ziyaretçinin planlamayı akıl bile edemediği ama gördükten sonra en uzun süre hatırladığı Oniki Ada üyesidir. Kalabalık turist gruplarından uzak limanları, adanın 20. yüzyıldaki alışılmadık geçmişinden - bir İtalyan deniz üssü olarak kullanıldığı dönemden - kalma çarpıcı 1930''lar İtalyan Rasyonalist binalarıyla çevrilidir.", "Gününüz yavaş ve keyifli akar: Lakki''nin atmosferik limanında bir yürüyüş, koya tepeden bakan Panteli Kalesi''ne çıkış ve yoğun sezonda bile sakinliğini koruyan koylarda serbest yüzme zamanı. ''Gerçek'' Ege''yi koy koy görmek isteyenler için tam bir seçim."]'::jsonb, '["Nadiren ziyaret edilen bir Yunan adasına manzaralı feribot geçişi", "Lakki limanındaki İtalyan Rasyonalist dönem mimarisi", "Koya bakan Panteli Kalesi manzara noktası", "Kalabalıktan uzak, sakin yüzme koyları", "Alinda ve Pandeli''nin geleneksel köyleri", "İngilizce konuşan rehberle küçük grup temposu"]'::jsonb,
   '["Bodrum - Leros gidiş-dönüş feribot bileti", "Otel alış ve bırakış hizmeti (Bodrum yarımadası)", "İngilizce konuşan tur rehberi", "Liman vergileri ve harçları", "Lakki ve Panteli''de rehberli yürüyüş", "Geçiş süresince seyahat sigortası"]'::jsonb, '["Adada öğle yemeği ve içecekler", "Kişisel harcamalar ve alışveriş", "Müze giriş ücretleri", "Bahşişler"]'::jsonb,
   '[{"time": "06:30", "title": "Otelden Alış", "text": "Feribot terminaline zamanında ulaşmak için erken saatte otelinizden alınırsınız."}, {"time": "07:30", "title": "Feribotla Hareket", "text": "Leros''a geçiş için Bodrum''dan gemiye binilir."}, {"time": "09:00", "title": "Lakki''ye Varış", "text": "Art Deco liman kasabasında rehberli yürüyüş, ardından Panteli''ye geçiş."}, {"time": "10:30", "title": "Serbest Zaman ve Yüzme", "text": "Alinda plajını, kaleyi keşfedin ya da deniz kenarında dinlenin."}, {"time": "17:00", "title": "Dönüş Yolculuğu", "text": "Dönüş feribotuna binilir, akşamüzeri Bodrum''a varılır."}]'::jsonb, '[{"q": "Leros neden Kos''a göre daha az kalabalık?", "a": "Leros çok daha az günübirlik ziyaretçi ağırlar; bu yüzden plajları, kafeleri ve eski kasabası belirgin şekilde daha sakindir - hareketli bir tatil beldesi havasından çok, dingin bir tempo tercih edenler için idealdir."}, {"q": "Leros için pasaport gerekli mi?", "a": "Evet, tüm misafirler için geçerli bir pasaport gereklidir. Rezervasyon öncesinde uyruğunuza ait vize şartlarını kontrol etmenizi öneririz."}, {"q": "Bu turda yüzme için zaman var mı?", "a": "Evet, programda adanın sakin koylarından birinde yüzmeye ayrılmış serbest zaman bulunmaktadır."}, {"q": "Leros turu hangi günler yapılıyor?", "a": "Bu tur, feribot programına bağlı olarak haftanın belirli günlerinde düzenlenir; müsaitlik durumunu rezervasyon sırasında ekibimiz teyit eder."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'leros-island'), 'en',
   'Leros Island Tour', 'A quieter Greek island escape - Art Deco harbours, hidden bays and a slower pace of island life.', 'Leros, Greece (via ferry from Bodrum)',
   '11 Hours - Full Day', '07:30 AM, Selected Days', '18:30 PM',
   'Bodrum International Ferry Terminal, Neyzen Tevfik Street',
   '["Leros is the Dodecanese island most visitors never plan for - and the one they remember longest. Away from the cruise-ship crowds, its harbours are lined with striking Italian Rationalist buildings from the 1930s, a reminder of the island''s unusual 20th-century history as an Italian naval base.", "Your day unfolds gently: a walk through the atmospheric port of Lakki, a visit to the hilltop Kastro of Panteli for sweeping views over the bay, and free time to swim in coves that stay quiet even in peak season. It''s the trip for travellers who want to see the ''real'' Aegean, one bay at a time."]'::jsonb, '["Scenic ferry crossing to a rarely-visited Greek island", "Italian Rationalist-era architecture in Lakki harbour", "Panteli Castle viewpoint over the bay", "Quiet coves for swimming away from the crowds", "Traditional villages of Alinda and Pandeli", "Small-group pace with an English-speaking guide"]'::jsonb,
   '["Return ferry tickets Bodrum - Leros", "Hotel pick-up and drop-off (Bodrum peninsula)", "English-speaking tour guide", "Port taxes and harbour fees", "Guided walk through Lakki and Panteli", "Travel insurance during the crossing"]'::jsonb, '["Lunch and drinks on the island", "Personal expenses and shopping", "Museum entrance fees", "Gratuities"]'::jsonb,
   '[{"time": "06:30", "title": "Hotel Pick-up", "text": "Early collection from your hotel to reach the ferry terminal in good time."}, {"time": "07:30", "title": "Departure by Ferry", "text": "Board the ferry at Bodrum for the crossing to Leros."}, {"time": "09:00", "title": "Arrival in Lakki", "text": "Guided walk through the Art Deco port town, then onward to Panteli."}, {"time": "10:30", "title": "Free Time & Swimming", "text": "Explore Alinda beach, the castle, or simply relax by the water."}, {"time": "17:00", "title": "Return Crossing", "text": "Board the return ferry, arriving back in Bodrum by early evening."}]'::jsonb, '[{"q": "Why is Leros less crowded than Kos?", "a": "Leros sees far fewer day-trip visitors, so its beaches, cafes and old town stay noticeably quieter - ideal if you prefer a relaxed pace over a busy resort feel."}, {"q": "Do I need a passport for Leros?", "a": "Yes, a valid passport is required for all guests. Please confirm any visa requirements for your nationality before booking."}, {"q": "Is there time to swim on this tour?", "a": "Yes, there is free time built into the itinerary specifically for swimming at one of the island''s quiet coves."}, {"q": "Which days does the Leros tour run?", "a": "This tour runs on selected days of the week depending on the ferry schedule - our team will confirm availability when you book."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'leros-island'), 'de',
   'Leros Insel Tour', 'Ein ruhigerer griechischer Inselausflug - Art-Deco-Häfen, versteckte Buchten und ein entspanntes Inseltempo.', 'Leros, Griechenland (per Fähre ab Bodrum)',
   '11 Stunden - Ganztägig', '07:30 Uhr, ausgewählte Tage', '18:30 Uhr',
   'Internationales Fährterminal Bodrum, Neyzen Tevfik Straße',
   '["Leros ist die Dodekanes-Insel, die die meisten Besucher nie einplanen - und an die sie sich am längsten erinnern. Fernab der Kreuzfahrtmassen säumen ihre Häfen markante italienische Rationalismus-Bauten aus den 1930er Jahren, ein Zeugnis der ungewöhnlichen Geschichte der Insel als italienischer Marinestützpunkt.", "Ihr Tag verläuft entspannt: ein Spaziergang durch den stimmungsvollen Hafen von Lakki, ein Besuch der Burg von Panteli mit weitem Blick über die Bucht und Freizeit zum Baden in Buchten, die selbst zur Hochsaison ruhig bleiben. Die richtige Reise für alle, die die ''echte'' Ägäis Bucht für Bucht erleben möchten."]'::jsonb, '["Malerische Fährüberfahrt zu einer selten besuchten griechischen Insel", "Architektur des italienischen Rationalismus im Hafen von Lakki", "Aussichtspunkt an der Burg von Panteli über die Bucht", "Ruhige Buchten zum Baden abseits der Menschenmassen", "Traditionelle Dörfer Alinda und Pandeli", "Kleingruppentempo mit englischsprachigem Reiseleiter"]'::jsonb,
   '["Fährtickets Bodrum - Leros (hin und zurück)", "Hotelabholung und -rückbringung (Bodrum-Halbinsel)", "Englischsprachiger Reiseleiter", "Hafengebühren und -abgaben", "Geführter Spaziergang durch Lakki und Panteli", "Reiseversicherung während der Überfahrt"]'::jsonb, '["Mittagessen und Getränke auf der Insel", "Persönliche Ausgaben und Einkäufe", "Museumseintritte", "Trinkgelder"]'::jsonb,
   '[{"time": "06:30", "title": "Hotelabholung", "text": "Frühe Abholung von Ihrem Hotel, um rechtzeitig das Fährterminal zu erreichen."}, {"time": "07:30", "title": "Abfahrt mit der Fähre", "text": "Einschiffung in Bodrum zur Überfahrt nach Leros."}, {"time": "09:00", "title": "Ankunft in Lakki", "text": "Geführter Spaziergang durch die Art-Deco-Hafenstadt, weiter nach Panteli."}, {"time": "10:30", "title": "Freizeit und Baden", "text": "Erkunden Sie den Strand von Alinda, die Burg oder entspannen Sie am Wasser."}, {"time": "17:00", "title": "Rückfahrt", "text": "Einschiffung zur Rückfahrt, Ankunft in Bodrum am frühen Abend."}]'::jsonb, '[{"q": "Warum ist Leros weniger überlaufen als Kos?", "a": "Leros hat deutlich weniger Tagesbesucher, sodass Strände, Cafés und die Altstadt spürbar ruhiger bleiben - ideal, wenn Sie ein entspanntes Tempo bevorzugen."}, {"q": "Brauche ich einen Reisepass für Leros?", "a": "Ja, für alle Gäste ist ein gültiger Reisepass erforderlich. Bitte prüfen Sie vor der Buchung die Visabestimmungen für Ihre Staatsangehörigkeit."}, {"q": "Gibt es bei dieser Tour Zeit zum Baden?", "a": "Ja, im Programm ist gezielt Freizeit zum Baden in einer der ruhigen Buchten der Insel eingeplant."}, {"q": "An welchen Tagen findet die Leros-Tour statt?", "a": "Diese Tour findet je nach Fährplan an ausgewählten Wochentagen statt - unser Team bestätigt die Verfügbarkeit bei der Buchung."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'leros-island'), 'ru',
   'Тур на остров Лерос', 'Более спокойный греческий остров - гавани в стиле ар-деко, укромные бухты и неспешный островной ритм.', 'Лерос, Греция (на пароме из Бодрума)',
   '11 часов - весь день', '07:30, в отдельные дни', '18:30',
   'Международный паромный терминал Бодрума, улица Нейзен Тевфик',
   '["Лерос - остров Додеканеса, который большинство туристов даже не планируют посетить, но запоминают дольше всего. Вдали от круизных толп его гавани окружены впечатляющими зданиями итальянского рационализма 1930-х годов - память о необычной истории острова как итальянской военно-морской базы.", "Ваш день проходит неспешно: прогулка по атмосферному порту Лакки, подъём к крепости Пантели с видом на залив и свободное время для купания в бухтах, которые остаются тихими даже в высокий сезон. Эта поездка для тех, кто хочет увидеть ''настоящую'' Эгейскую бухту за бухтой."]'::jsonb, '["Живописный переход на пароме на редко посещаемый греческий остров", "Архитектура итальянского рационализма в порту Лакки", "Смотровая площадка у крепости Пантели с видом на залив", "Тихие бухты для купания вдали от толп", "Традиционные деревни Алинда и Пандели", "Небольшая группа и англоговорящий гид"]'::jsonb,
   '["Билеты на паром Бодрум - Лерос туда и обратно", "Трансфер от отеля и обратно (полуостров Бодрум)", "Англоговорящий гид", "Портовые сборы и пошлины", "Прогулка с гидом по Лакки и Пантели", "Страховка на время переправы"]'::jsonb, '["Обед и напитки на острове", "Личные расходы и покупки", "Входные билеты в музеи", "Чаевые"]'::jsonb,
   '[{"time": "06:30", "title": "Трансфер из отеля", "text": "Ранний выезд из отеля, чтобы вовремя успеть в паромный терминал."}, {"time": "07:30", "title": "Отправление на пароме", "text": "Посадка на паром в Бодруме для переправы на Лерос."}, {"time": "09:00", "title": "Прибытие в Лакки", "text": "Прогулка с гидом по портовому городу в стиле ар-деко, затем в Пантели."}, {"time": "10:30", "title": "Свободное время и купание", "text": "Осмотрите пляж Алинда, крепость или просто отдохните у воды."}, {"time": "17:00", "title": "Обратный переход", "text": "Посадка на обратный паром, прибытие в Бодрум ранним вечером."}]'::jsonb, '[{"q": "Почему на Леросе меньше туристов, чем на Косе?", "a": "На Лерос приезжает гораздо меньше однодневных туристов, поэтому пляжи, кафе и старый город остаются заметно тише - идеально для спокойного отдыха."}, {"q": "Нужен ли паспорт для поездки на Лерос?", "a": "Да, действующий паспорт нужен всем гостям. Перед бронированием уточните визовые требования для вашего гражданства."}, {"q": "Есть ли в этом туре время для купания?", "a": "Да, в программе предусмотрено свободное время специально для купания в одной из тихих бухт острова."}, {"q": "В какие дни проходит тур на Лерос?", "a": "Этот тур проходит в определённые дни недели в зависимости от расписания парома - наша команда подтвердит доступность при бронировании."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'leros-island'), 'pl',
   'Wycieczka na Wyspę Leros', 'Spokojniejsza grecka wyspa - porty w stylu art déco, ukryte zatoki i wolniejsze tempo wyspiarskiego życia.', 'Leros, Grecja (promem z Bodrum)',
   '11 godzin - Cały dzień', '07:30, wybrane dni', '18:30',
   'Międzynarodowy Terminal Promowy w Bodrum, ulica Neyzen Tevfik',
   '["Leros to wyspa Dodekanezu, której większość turystów nigdy nie planuje odwiedzić - a która zapada w pamięć najdłużej. Z dala od tłumów wycieczkowców jej porty otaczają uderzające budynki włoskiego racjonalizmu z lat 30. XX wieku, świadectwo niezwykłej historii wyspy jako włoskiej bazy marynarki wojennej.", "Dzień płynie spokojnie: spacer po klimatycznym porcie Lakki, wejście na wzgórze do zamku Panteli z rozległym widokiem na zatokę oraz czas wolny na kąpiel w zatoczkach, które pozostają ciche nawet w szczycie sezonu. To wycieczka dla tych, którzy chcą poznać ''prawdziwe'' Morze Egejskie zatoka po zatoce."]'::jsonb, '["Malowniczy rejs promem na rzadko odwiedzaną grecką wyspę", "Architektura włoskiego racjonalizmu w porcie Lakki", "Punkt widokowy przy zamku Panteli nad zatoką", "Ciche zatoczki do kąpieli z dala od tłumów", "Tradycyjne wioski Alinda i Pandeli", "Kameralne tempo z anglojęzycznym przewodnikiem"]'::jsonb,
   '["Bilety promowe Bodrum - Leros w obie strony", "Odbiór i powrót z hotelu (półwysep Bodrum)", "Anglojęzyczny przewodnik", "Opłaty i podatki portowe", "Spacer z przewodnikiem po Lakki i Panteli", "Ubezpieczenie podróżne na czas rejsu"]'::jsonb, '["Obiad i napoje na wyspie", "Wydatki osobiste i zakupy", "Bilety wstępu do muzeów", "Napiwki"]'::jsonb,
   '[{"time": "06:30", "title": "Odbiór z hotelu", "text": "Wczesny odbiór z hotelu, aby zdążyć na czas do terminalu promowego."}, {"time": "07:30", "title": "Wyjazd promem", "text": "Wejście na prom w Bodrum w celu przeprawy na Leros."}, {"time": "09:00", "title": "Przybycie do Lakki", "text": "Spacer z przewodnikiem po portowym mieście w stylu art déco, następnie do Panteli."}, {"time": "10:30", "title": "Czas wolny i kąpiel", "text": "Zwiedźcie plażę Alinda, zamek lub po prostu odpocznijcie nad wodą."}, {"time": "17:00", "title": "Podróż powrotna", "text": "Wejście na prom powrotny, przybycie do Bodrum wczesnym wieczorem."}]'::jsonb, '[{"q": "Dlaczego Leros jest mniej zatłoczony niż Kos?", "a": "Leros odwiedza znacznie mniej turystów jednodniowych, dzięki czemu plaże, kawiarnie i stare miasto są zauważalnie spokojniejsze - idealne dla tych, którzy wolą wolniejsze tempo."}, {"q": "Czy na Leros potrzebny jest paszport?", "a": "Tak, ważny paszport jest wymagany od wszystkich gości. Przed rezerwacją sprawdź wymagania wizowe dla swojego obywatelstwa."}, {"q": "Czy w tej wycieczce jest czas na kąpiel?", "a": "Tak, w programie przewidziano czas wolny specjalnie na kąpiel w jednej z cichych zatoczek wyspy."}, {"q": "W jakie dni odbywa się wycieczka na Leros?", "a": "Ta wycieczka odbywa się w wybrane dni tygodnia w zależności od rozkładu promów - nasz zespół potwierdzi dostępność podczas rezerwacji."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kalymnos-island'), 'tr',
   'Kalymnos Adası Turu', 'Sünger Dalgıçları Adası - etkileyici kireçtaşı kayalıklar, turkuaz koylar ve otantik bir Yunan liman kasabası.', 'Kalymnos, Yunanistan (Bodrum''dan feribotla)',
   '10 Saat - Tam Gün', '08:00, Her Gün', '18:00',
   'Bodrum Uluslararası Feribot Terminali, Neyzen Tevfik Caddesi',
   '["Bir asırdan uzun süredir ''Sünger Dalgıçları Adası'' olarak bilinen Kalymnos, servetini ve kimliğini Ege sünger ticareti üzerine kurmuştur - Pothia limanının çevresindeki atölyelerde süngerlerin hâlâ nasıl temizlenip satıldığını görebilirsiniz. Kasabanın üzerinde yükselen, Akdeniz''in en yüksek kireçtaşı kayalıklarından bazıları, adayı dünyaca ünlü bir kaya tırmanışı destinasyonu haline getirmiştir.", "Kalymnos''un tadını çıkarmak için tırmanmanıza gerek yok elbette: bu tur size Pothia''nın neoklasik sahilinde dolaşmak, sünger ve takı dükkanlarını gezmek ve boğazın karşısındaki minik Telendos adacığına bakmak için serbest zaman tanır. Berrak, sakin koylarda yüzme molaları, büyük ada geçişlerinden gerçekten farklı hissettiren bir günü tamamlar."]'::jsonb, '["Kalymnos''un ünlü kireçtaşı kayalıklarının altından feribot geçişi", "Pothia''da sünger atölyeleri ve gösterimleri", "Telendos adacığına bakan manzaralar", "Berrak kıyı koylarında serbest yüzme zamanı", "Neoklasik liman mimarisi", "Geçiş boyunca İngilizce konuşan rehber"]'::jsonb,
   '["Bodrum - Kalymnos gidiş-dönüş feribot bileti", "Otel alış ve bırakış hizmeti (Bodrum yarımadası)", "İngilizce konuşan tur rehberi", "Liman vergileri ve harçları", "Pothia''da tanıtım yürüyüşü", "Geçiş süresince seyahat sigortası"]'::jsonb, '["Adada öğle yemeği ve içecekler", "Kişisel harcamalar ve alışveriş", "Telendos adacığına tekne turu (isteğe bağlı, yerinde ödemeli)", "Bahşişler"]'::jsonb,
   '[{"time": "07:00", "title": "Otelden Alış", "text": "Bodrum yarımadasındaki otelinizden alınırsınız."}, {"time": "08:00", "title": "Feribotla Hareket", "text": "Kalymnos''a geçiş için Bodrum''dan gemiye binilir."}, {"time": "09:15", "title": "Pothia''ya Varış", "text": "Liman boyunca ve sünger atölyelerinde rehberli tanıtım yürüyüşü."}, {"time": "10:00", "title": "Serbest Zaman ve Yüzme", "text": "Kasabayı gezin, sünger alışverişi yapın ya da yakındaki bir koyda dinlenin."}, {"time": "16:30", "title": "Dönüş Yolculuğu", "text": "Dönüş feribotuna binilir, akşam saatlerinde Bodrum''a varılır."}]'::jsonb, '[{"q": "Kalymnos, tırmanış yapmayanlar için de uygun mu?", "a": "Kesinlikle - tırmanış sahnesi bir zorunluluk değil, sadece bir arka plandır. Çoğu misafir günü Pothia limanını gezerek, doğal sünger alışverişi yaparak ve yüzerek geçirir."}, {"q": "Kalymnos neyle ünlüdür?", "a": "Kalymnos nesillerdir Ege doğal sünger ticaretinin merkezi olmuştur; son yıllarda ise kireçtaşı kayalıkları sayesinde Avrupa''nın önde gelen kaya tırmanışı destinasyonlarından biri haline gelmiştir."}, {"q": "Telendos adacığını ziyaret edebilir miyiz?", "a": "Minik Telendos adacığı boğazın hemen karşısından görülebilir ve serbest zamanınızda bağımsız olarak ayarlanabilecek kısa bir yerel teknesi ile ulaşılabilir."}, {"q": "Pasaport gerekli mi?", "a": "Evet, çocuklar dahil her misafir için geçerli bir pasaport gereklidir."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kalymnos-island'), 'en',
   'Kalymnos Island Tour', 'The Sponge Divers'' Island - dramatic limestone cliffs, turquoise coves and an authentic Greek harbour town.', 'Kalymnos, Greece (via ferry from Bodrum)',
   '10 Hours - Full Day', '08:00 AM, Daily', '18:00 PM',
   'Bodrum International Ferry Terminal, Neyzen Tevfik Street',
   '["Known for over a century as the ''Sponge Divers'' Island'', Kalymnos built its wealth and identity on the Aegean sponge trade - and you can still watch sponges being cleaned and sold in workshops around the harbour of Pothia. Above the town, some of the tallest limestone cliffs in the Mediterranean have made this a world-famous destination for rock climbers.", "You don''t need to climb to enjoy Kalymnos, though: this tour gives you free time to wander Pothia''s neoclassical waterfront, browse sponge and jewellery shops, and look across the strait to the tiny islet of Telendos. Swim stops at clear, calm coves round out a day that feels genuinely different from the bigger island crossings."]'::jsonb, '["Ferry crossing beneath Kalymnos'' famous limestone cliffs", "Sponge workshops and demonstrations in Pothia", "Views across to the islet of Telendos", "Free time to swim in clear coastal coves", "Neoclassical harbour architecture", "English-speaking guide throughout the crossing"]'::jsonb,
   '["Return ferry tickets Bodrum - Kalymnos", "Hotel pick-up and drop-off (Bodrum peninsula)", "English-speaking tour guide", "Port taxes and harbour fees", "Orientation walk through Pothia", "Travel insurance during the crossing"]'::jsonb, '["Lunch and drinks on the island", "Personal expenses and shopping", "Boat trip to Telendos islet (optional, paid locally)", "Gratuities"]'::jsonb,
   '[{"time": "07:00", "title": "Hotel Pick-up", "text": "Collection from your hotel across the Bodrum peninsula."}, {"time": "08:00", "title": "Departure by Ferry", "text": "Board the ferry at Bodrum for the crossing to Kalymnos."}, {"time": "09:15", "title": "Arrival in Pothia", "text": "Guided orientation walk along the harbour and sponge workshops."}, {"time": "10:00", "title": "Free Time & Swimming", "text": "Explore the town, shop for sponges, or relax at a nearby cove."}, {"time": "16:30", "title": "Return Crossing", "text": "Board the return ferry, arriving back in Bodrum in the evening."}]'::jsonb, '[{"q": "Is Kalymnos good for non-climbers?", "a": "Absolutely - the climbing scene is a backdrop, not a requirement. Most guests spend the day exploring Pothia''s harbour, shopping for natural sponges and swimming."}, {"q": "What is Kalymnos famous for?", "a": "Kalymnos has been the centre of the Aegean natural sponge trade for generations, and more recently has become one of Europe''s top rock-climbing destinations thanks to its limestone cliffs."}, {"q": "Can we visit Telendos islet?", "a": "The tiny islet of Telendos is visible just across the strait and reachable by a short local boat, which can be arranged independently during your free time."}, {"q": "Do I need a passport?", "a": "Yes, a valid passport is required for every guest, including children."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kalymnos-island'), 'de',
   'Kalymnos Insel Tour', 'Die Insel der Schwammtaucher - eindrucksvolle Kalksteinklippen, türkisfarbene Buchten und eine authentische griechische Hafenstadt.', 'Kalymnos, Griechenland (per Fähre ab Bodrum)',
   '10 Stunden - Ganztägig', '08:00 Uhr, täglich', '18:00 Uhr',
   'Internationales Fährterminal Bodrum, Neyzen Tevfik Straße',
   '["Seit über einem Jahrhundert als ''Insel der Schwammtaucher'' bekannt, baute Kalymnos seinen Wohlstand und seine Identität auf dem ägäischen Schwammhandel auf - noch heute können Sie in Werkstätten rund um den Hafen von Pothia beim Reinigen und Verkaufen von Schwämmen zusehen. Über der Stadt machen einige der höchsten Kalksteinklippen des Mittelmeers die Insel zu einem weltberühmten Ziel für Kletterer.", "Zum Genießen von Kalymnos muss man aber nicht klettern: Diese Tour gibt Ihnen Zeit, die neoklassizistische Uferpromenade von Pothia zu erkunden, Schwamm- und Schmuckläden zu durchstöbern und über die Meerenge zum winzigen Eiland Telendos zu blicken. Badestopps in klaren, ruhigen Buchten runden einen Tag ab, der sich spürbar von den größeren Inselüberfahrten unterscheidet."]'::jsonb, '["Fährüberfahrt unterhalb der berühmten Kalksteinklippen von Kalymnos", "Schwammwerkstätten und Vorführungen in Pothia", "Ausblicke auf das Eiland Telendos", "Freizeit zum Baden in klaren Küstenbuchten", "Neoklassizistische Hafenarchitektur", "Englischsprachiger Reiseleiter während der gesamten Überfahrt"]'::jsonb,
   '["Fährtickets Bodrum - Kalymnos (hin und zurück)", "Hotelabholung und -rückbringung (Bodrum-Halbinsel)", "Englischsprachiger Reiseleiter", "Hafengebühren und -abgaben", "Orientierungsspaziergang durch Pothia", "Reiseversicherung während der Überfahrt"]'::jsonb, '["Mittagessen und Getränke auf der Insel", "Persönliche Ausgaben und Einkäufe", "Bootsfahrt zum Eiland Telendos (optional, vor Ort zu zahlen)", "Trinkgelder"]'::jsonb,
   '[{"time": "07:00", "title": "Hotelabholung", "text": "Abholung von Ihrem Hotel auf der Bodrum-Halbinsel."}, {"time": "08:00", "title": "Abfahrt mit der Fähre", "text": "Einschiffung in Bodrum zur Überfahrt nach Kalymnos."}, {"time": "09:15", "title": "Ankunft in Pothia", "text": "Geführter Orientierungsspaziergang am Hafen und den Schwammwerkstätten."}, {"time": "10:00", "title": "Freizeit und Baden", "text": "Erkunden Sie die Stadt, kaufen Sie Schwämme oder entspannen Sie in einer nahen Bucht."}, {"time": "16:30", "title": "Rückfahrt", "text": "Einschiffung zur Rückfahrt, Ankunft in Bodrum am Abend."}]'::jsonb, '[{"q": "Ist Kalymnos auch für Nicht-Kletterer geeignet?", "a": "Auf jeden Fall - die Kletterszene ist eine Kulisse, keine Voraussetzung. Die meisten Gäste verbringen den Tag im Hafen von Pothia, beim Schwammkauf und beim Baden."}, {"q": "Wofür ist Kalymnos bekannt?", "a": "Kalymnos ist seit Generationen das Zentrum des ägäischen Naturschwammhandels und hat sich dank seiner Kalksteinklippen zu einem der führenden Kletterziele Europas entwickelt."}, {"q": "Können wir das Eiland Telendos besuchen?", "a": "Das winzige Eiland Telendos ist direkt auf der anderen Seite der Meerenge sichtbar und mit einem kurzen lokalen Boot erreichbar, das Sie in Ihrer Freizeit unabhängig organisieren können."}, {"q": "Brauche ich einen Reisepass?", "a": "Ja, für jeden Gast, auch Kinder, ist ein gültiger Reisepass erforderlich."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kalymnos-island'), 'ru',
   'Тур на остров Калимнос', 'Остров ныряльщиков за губками - впечатляющие известняковые скалы, бирюзовые бухты и настоящий греческий портовый городок.', 'Калимнос, Греция (на пароме из Бодрума)',
   '10 часов - весь день', '08:00, ежедневно', '18:00',
   'Международный паромный терминал Бодрума, улица Нейзен Тевфик',
   '["Более века известный как ''остров ныряльщиков за губками'', Калимнос построил своё благосостояние и самобытность на эгейской торговле губками - в мастерских у порта Потия до сих пор можно увидеть, как губки очищают и продают. Над городом возвышаются одни из самых высоких известняковых скал Средиземноморья, сделавшие остров всемирно известным местом для скалолазания.", "Впрочем, чтобы насладиться Калимносом, лазать вовсе не обязательно: этот тур даёт свободное время, чтобы прогуляться по неоклассической набережной Потии, заглянуть в лавки с губками и украшениями и полюбоваться через пролив на крошечный островок Тэлендос. Остановки для купания в чистых спокойных бухтах дополняют день, который ощущается совсем иначе, чем поездки на более крупные острова."]'::jsonb, '["Переход на пароме под знаменитыми известняковыми скалами Калимноса", "Мастерские по обработке губок и демонстрации в Потии", "Виды на островок Тэлендос", "Свободное время для купания в прозрачных прибрежных бухтах", "Неоклассическая архитектура порта", "Англоговорящий гид на протяжении всего перехода"]'::jsonb,
   '["Билеты на паром Бодрум - Калимнос туда и обратно", "Трансфер от отеля и обратно (полуостров Бодрум)", "Англоговорящий гид", "Портовые сборы и пошлины", "Ознакомительная прогулка по Потии", "Страховка на время переправы"]'::jsonb, '["Обед и напитки на острове", "Личные расходы и покупки", "Поездка на лодке до островка Тэлендос (по желанию, оплата на месте)", "Чаевые"]'::jsonb,
   '[{"time": "07:00", "title": "Трансфер из отеля", "text": "Забираем вас из отеля на полуострове Бодрум."}, {"time": "08:00", "title": "Отправление на пароме", "text": "Посадка на паром в Бодруме для переправы на Калимнос."}, {"time": "09:15", "title": "Прибытие в Потию", "text": "Ознакомительная прогулка с гидом вдоль порта и мастерских по обработке губок."}, {"time": "10:00", "title": "Свободное время и купание", "text": "Осмотрите город, купите губки на память или отдохните в соседней бухте."}, {"time": "16:30", "title": "Обратный переход", "text": "Посадка на обратный паром, прибытие в Бодрум вечером."}]'::jsonb, '[{"q": "Подходит ли Калимнос для тех, кто не занимается скалолазанием?", "a": "Безусловно - скалолазание здесь лишь антураж, а не обязательное условие. Большинство гостей проводят день, гуляя по порту Потия, покупая натуральные губки и купаясь."}, {"q": "Чем знаменит Калимнос?", "a": "Калимнос уже несколько поколений остаётся центром эгейской торговли натуральными губками, а в последние годы стал одним из ведущих направлений скалолазания в Европе благодаря известняковым скалам."}, {"q": "Можем ли мы посетить островок Тэлендос?", "a": "Крошечный островок Тэлендос виден прямо через пролив, и до него можно добраться на короткой местной лодке, которую можно организовать самостоятельно в свободное время."}, {"q": "Нужен ли паспорт?", "a": "Да, действующий паспорт необходим каждому гостю, включая детей."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'kalymnos-island'), 'pl',
   'Wycieczka na Wyspę Kalymnos', 'Wyspa nurków poławiających gąbki - imponujące wapienne klify, turkusowe zatoczki i autentyczne greckie miasteczko portowe.', 'Kalymnos, Grecja (promem z Bodrum)',
   '10 godzin - Cały dzień', '08:00, codziennie', '18:00',
   'Międzynarodowy Terminal Promowy w Bodrum, ulica Neyzen Tevfik',
   '["Znany od ponad wieku jako ''Wyspa Nurków Poławiających Gąbki'', Kalymnos zbudował swoje bogactwo i tożsamość na egejskim handlu gąbkami - w warsztatach wokół portu Pothia wciąż można zobaczyć, jak gąbki są czyszczone i sprzedawane. Nad miastem wznoszą się jedne z najwyższych wapiennych klifów w basenie Morza Śródziemnego, które uczyniły wyspę światowej sławy destynacją dla wspinaczy.", "Nie trzeba jednak się wspinać, by cieszyć się Kalymnos: ta wycieczka daje czas wolny na spacer po neoklasycystycznej promenadzie Pothii, przejrzenie sklepów z gąbkami i biżuterią oraz spojrzenie przez cieśninę na maleńką wysepkę Telendos. Postoje na kąpiel w czystych, spokojnych zatoczkach dopełniają dzień, który wyraźnie różni się od większych rejsów międzywyspowych."]'::jsonb, '["Rejs promem pod słynnymi wapiennymi klifami Kalymnos", "Warsztaty i pokazy obróbki gąbek w Pothii", "Widoki na wysepkę Telendos", "Czas wolny na kąpiel w przejrzystych przybrzeżnych zatoczkach", "Neoklasycystyczna architektura portu", "Anglojęzyczny przewodnik przez cały rejs"]'::jsonb,
   '["Bilety promowe Bodrum - Kalymnos w obie strony", "Odbiór i powrót z hotelu (półwysep Bodrum)", "Anglojęzyczny przewodnik", "Opłaty i podatki portowe", "Spacer orientacyjny po Pothii", "Ubezpieczenie podróżne na czas rejsu"]'::jsonb, '["Obiad i napoje na wyspie", "Wydatki osobiste i zakupy", "Rejs łodzią na wysepkę Telendos (opcjonalnie, płatne na miejscu)", "Napiwki"]'::jsonb,
   '[{"time": "07:00", "title": "Odbiór z hotelu", "text": "Odbiór z hotelu na półwyspie Bodrum."}, {"time": "08:00", "title": "Wyjazd promem", "text": "Wejście na prom w Bodrum w celu przeprawy na Kalymnos."}, {"time": "09:15", "title": "Przybycie do Pothii", "text": "Spacer orientacyjny z przewodnikiem wzdłuż portu i warsztatów gąbkowych."}, {"time": "10:00", "title": "Czas wolny i kąpiel", "text": "Zwiedźcie miasto, kupcie gąbki na pamiątkę lub odpocznijcie w pobliskiej zatoczce."}, {"time": "16:30", "title": "Podróż powrotna", "text": "Wejście na prom powrotny, przybycie do Bodrum wieczorem."}]'::jsonb, '[{"q": "Czy Kalymnos jest odpowiedni dla osób, które się nie wspinają?", "a": "Zdecydowanie - wspinaczka jest tu tłem, a nie wymogiem. Większość gości spędza dzień, zwiedzając port Pothia, kupując naturalne gąbki i pływając."}, {"q": "Z czego słynie Kalymnos?", "a": "Kalymnos od pokoleń jest centrum egejskiego handlu naturalnymi gąbkami, a ostatnio stał się jednym z czołowych miejsc wspinaczkowych w Europie dzięki wapiennym klifom."}, {"q": "Czy możemy odwiedzić wysepkę Telendos?", "a": "Maleńka wysepka Telendos jest widoczna tuż za cieśniną i można do niej dotrzeć krótką lokalną łodzią, którą można zorganizować samodzielnie w czasie wolnym."}, {"q": "Czy potrzebny jest paszport?", "a": "Tak, ważny paszport jest wymagany od każdego gościa, w tym dzieci."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'boat-trip'), 'tr',
   'Bodrum Tekne Turu', 'Bodrum''un koylarını ve Kara Ada''nın çamur mağarasını gezen klasik bir gulet turu.', 'Bodrum Yarımadası, Türkiye',
   '7 Saat - Günlük Tur', '10:00, Her Gün (Hava Durumuna Bağlı)', '17:00',
   'Bodrum Marina, 4. İskele (veya otel alış noktası)',
   '["Bodrum tekne turunun en çok rezerve edilen gezimiz olmasının bir nedeni var: yarımadayı görmenin en iyi yolu bu. Geleneksel ahşap bir guletle art arda sıralanan korunaklı koyları dolaşacak, suyun cazibesine karşı koyamadığınız her yerde demir atacaksınız.", "Öne çıkanlar arasında Akvaryum Koyu''nun inanılmaz berraklıktaki sığ suları, Kara Ada''da bir mağara kaynağından mineral açısından zengin çamura bulanıp denizde durulanabileceğiniz bir mola ve güvertede müzik eşliğinde bolca yüzme zamanı var. Yol boyunca sade bir gemi yemeği servis edilir."]'::jsonb, '["Geleneksel ahşap gulet ile tekne turu", "Akvaryum Koyu''nun berrak sığ sularında yüzme molası", "Kara Ada mineral çamur mağarası deneyimi", "Birden fazla yüzme ve güneşlenme molası", "Gemide öğle yemeği ve müzik", "Bodrum yarımadası genelinde ücretsiz otel alışı"]'::jsonb,
   '["Tam gün gulet turu", "Otel alış ve bırakış hizmeti", "Gemide öğle yemeği", "Gemide meşrubat ve çay", "Şnorkel ekipmanı (sınırlı sayıda)", "Can yeleği ve güvenlik brifingi"]'::jsonb, '["Alkollü içecekler", "Kara Ada çamur banyosu girişi (küçük yerel ücret)", "Kişisel harcamalar", "Mürettebat için bahşiş"]'::jsonb,
   '[{"time": "09:15", "title": "Otelden Alış", "text": "Otelinizden alınıp marinaya transfer edilirsiniz."}, {"time": "10:00", "title": "Hareket", "text": "Gulet, Bodrum Marina''dan ilk koya doğru yola çıkar."}, {"time": "11:00", "title": "Akvaryum Koyu", "text": "Sığ, kristal berraklığındaki suda demirlenip yüzülür."}, {"time": "13:00", "title": "Gemide Öğle Yemeği", "text": "Sakin bir koyda demirliyken rahat bir öğle yemeği servis edilir."}, {"time": "14:30", "title": "Kara Ada", "text": "İsteğe bağlı mineral çamur mağarası ziyareti, ardından tekrar yüzme."}, {"time": "16:30", "title": "Marinaya Dönüş", "text": "Bodrum Marina''ya dönülür ve otelinize transfer sağlanır."}]'::jsonb, '[{"q": "Bodrum tekne turuna ne getirmeliyim?", "a": "Mayo, havlu, güneş kremi ve yedek kıyafet önerilir. Şnorkel ekipmanı ve can yeleği gemide sağlanmaktadır."}, {"q": "Bodrum tekne turu yüzme bilmeyenler için uygun mu?", "a": "Evet, kendine güvenmeyen herkes için can yeleği mevcuttur ve hiç kimse suya girmeye zorlanmaz."}, {"q": "Hava koşulları kötü olursa ne olur?", "a": "Rota deniz koşullarına göre ayarlanabilir; nadir güvensiz hava durumlarında ise tur yeniden planlanır veya ücret iadesi yapılır."}, {"q": "Öğle yemeği gerçekten dahil mi?", "a": "Evet, tam bir gemi öğle yemeği ve meşrubatlar fiyata dahildir - yalnızca alkollü içecekler ekstradır."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'boat-trip'), 'en',
   'Bodrum Boat Trip', 'A classic gulet cruise around Bodrum''s bays, coves and Black Island''s mineral mud caves.', 'Bodrum Peninsula, Türkiye',
   '7 Hours - Daily Tour', '10:00 AM, Daily (Weather Permitting)', '17:00 PM',
   'Bodrum Marina, Dock 4 (or hotel pick-up point)',
   '["There''s a reason the Bodrum boat trip is our most booked excursion: it''s simply the best way to see the peninsula. You''ll cruise aboard a traditional wooden gulet to a string of sheltered bays, dropping anchor wherever the water looks too inviting to pass up.", "Highlights include Aquarium Bay''s impossibly clear shallows, a stop at Black Island (Karaada) where a cave spring lets you cover yourself in mineral-rich mud before rinsing off in the sea, and plenty of open swimming time with music playing on deck. A simple onboard lunch is served along the way."]'::jsonb, '["Cruise aboard a traditional wooden gulet", "Swim stop at Aquarium Bay''s clear shallow water", "Black Island mineral mud cave experience", "Multiple swimming and sunbathing stops", "Onboard lunch and music", "Free hotel pick-up across the Bodrum peninsula"]'::jsonb,
   '["Full-day gulet cruise", "Hotel pick-up and drop-off", "Onboard lunch", "Soft drinks and tea on board", "Snorkelling gear (limited sets)", "Life jackets and safety briefing"]'::jsonb, '["Alcoholic beverages", "Black Island mud bath entrance (small local fee)", "Personal expenses", "Gratuities for the crew"]'::jsonb,
   '[{"time": "09:15", "title": "Hotel Pick-up", "text": "Collection from your hotel and transfer to the marina."}, {"time": "10:00", "title": "Departure", "text": "The gulet sets sail from Bodrum Marina toward the first bay."}, {"time": "11:00", "title": "Aquarium Bay", "text": "Anchor and swim in shallow, crystal-clear water."}, {"time": "13:00", "title": "Lunch on Board", "text": "A relaxed onboard lunch is served while anchored in a quiet cove."}, {"time": "14:30", "title": "Black Island", "text": "Optional visit to the mineral mud cave, then more swimming."}, {"time": "16:30", "title": "Return to Marina", "text": "Cruise back to Bodrum Marina and transfer to your hotel."}]'::jsonb, '[{"q": "What should I bring on the Bodrum boat trip?", "a": "A swimsuit, towel, sunscreen and a change of clothes are recommended. Snorkelling gear and life jackets are provided on board."}, {"q": "Is the Bodrum boat trip suitable for non-swimmers?", "a": "Yes, life jackets are available for anyone who isn''t a confident swimmer, and you''re never required to get in the water."}, {"q": "What happens if the weather is bad?", "a": "The route may be adjusted for sea conditions, or in rare cases of unsafe weather, the tour is rescheduled or refunded."}, {"q": "Is lunch really included?", "a": "Yes, a full onboard lunch and soft drinks are included in the price - only alcoholic drinks are extra."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'boat-trip'), 'de',
   'Bodrum Bootstour', 'Eine klassische Gulet-Kreuzfahrt zu Bodrums Buchten, Küsten und den Mineralschlamm-Höhlen der Schwarzen Insel.', 'Bodrum-Halbinsel, Türkei',
   '7 Stunden - Tagestour', '10:00 Uhr, täglich (wetterabhängig)', '17:00 Uhr',
   'Bodrum Marina, Anlegestelle 4 (oder Hotelabholpunkt)',
   '["Es gibt einen Grund, warum die Bodrum-Bootstour unser meistgebuchter Ausflug ist: Sie ist schlicht der beste Weg, die Halbinsel zu erleben. An Bord eines traditionellen Holz-Guletts fahren Sie eine Reihe geschützter Buchten an und ankern überall dort, wo das Wasser zu verlockend aussieht, um weiterzufahren.", "Zu den Höhepunkten zählen die unglaublich klaren Untiefen der Aquarium-Bucht, ein Halt an der Schwarzen Insel (Karaada), wo eine Höhlenquelle Ihnen erlaubt, sich mit mineralstoffreichem Schlamm einzureiben und im Meer abzuspülen, sowie reichlich Zeit zum Schwimmen bei Musik an Deck. Unterwegs wird ein einfaches Mittagessen an Bord serviert."]'::jsonb, '["Kreuzfahrt an Bord eines traditionellen Holz-Guletts", "Badestopp im klaren, seichten Wasser der Aquarium-Bucht", "Mineralschlamm-Höhlenerlebnis auf der Schwarzen Insel", "Mehrere Schwimm- und Sonnenstopps", "Mittagessen und Musik an Bord", "Kostenlose Hotelabholung auf der gesamten Bodrum-Halbinsel"]'::jsonb,
   '["Ganztägige Gulet-Kreuzfahrt", "Hotelabholung und -rückbringung", "Mittagessen an Bord", "Softdrinks und Tee an Bord", "Schnorchelausrüstung (begrenzte Anzahl)", "Schwimmwesten und Sicherheitseinweisung"]'::jsonb, '["Alkoholische Getränke", "Eintritt zum Schlammbad auf der Schwarzen Insel (geringe lokale Gebühr)", "Persönliche Ausgaben", "Trinkgeld für die Crew"]'::jsonb,
   '[{"time": "09:15", "title": "Hotelabholung", "text": "Abholung von Ihrem Hotel und Transfer zur Marina."}, {"time": "10:00", "title": "Abfahrt", "text": "Das Gulet legt in der Bodrum Marina ab und fährt zur ersten Bucht."}, {"time": "11:00", "title": "Aquarium-Bucht", "text": "Ankern und Schwimmen im seichten, kristallklaren Wasser."}, {"time": "13:00", "title": "Mittagessen an Bord", "text": "Ein entspanntes Mittagessen wird vor Anker in einer ruhigen Bucht serviert."}, {"time": "14:30", "title": "Schwarze Insel", "text": "Optionaler Besuch der Mineralschlamm-Höhle, danach weiteres Schwimmen."}, {"time": "16:30", "title": "Rückfahrt zur Marina", "text": "Rückfahrt zur Bodrum Marina und Transfer zu Ihrem Hotel."}]'::jsonb, '[{"q": "Was sollte ich zur Bodrum-Bootstour mitbringen?", "a": "Empfohlen werden Badebekleidung, Handtuch, Sonnencreme und Wechselkleidung. Schnorchelausrüstung und Schwimmwesten werden an Bord gestellt."}, {"q": "Ist die Bodrum-Bootstour für Nichtschwimmer geeignet?", "a": "Ja, für alle, die sich im Wasser nicht ganz sicher fühlen, sind Schwimmwesten vorhanden, und niemand muss ins Wasser gehen."}, {"q": "Was passiert bei schlechtem Wetter?", "a": "Die Route kann an die Seebedingungen angepasst werden; in seltenen Fällen unsicheren Wetters wird die Tour verschoben oder erstattet."}, {"q": "Ist das Mittagessen wirklich inbegriffen?", "a": "Ja, ein vollständiges Mittagessen an Bord sowie Softdrinks sind im Preis inbegriffen - nur alkoholische Getränke kosten extra."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'boat-trip'), 'ru',
   'Морская прогулка на яхте по Бодруму', 'Классический круиз на гулете по бухтам Бодрума и пещере с минеральной грязью на Чёрном острове.', 'Полуостров Бодрум, Турция',
   '7 часов - однодневный тур', '10:00, ежедневно (по погоде)', '17:00',
   'Марина Бодрума, причал 4 (или точка трансфера из отеля)',
   '["Морская прогулка по Бодруму - наша самая популярная экскурсия не случайно: это просто лучший способ увидеть полуостров. Вы отправитесь в плавание на традиционном деревянном гулете вдоль череды укрытых бухт, бросая якорь везде, где вода выглядит слишком заманчиво, чтобы проплыть мимо.", "Среди главных моментов - невероятно прозрачные мелководья Акварной бухты, остановка у Чёрного острова (Караада), где в пещерном источнике можно обмазаться минеральной грязью и смыть её в море, а также много времени для купания под музыку на палубе. По пути подаётся простой обед на борту."]'::jsonb, '["Круиз на традиционном деревянном гулете", "Остановка для купания в прозрачном мелководье Акварной бухты", "Пещера с минеральной грязью на Чёрном острове", "Несколько остановок для купания и загара", "Обед и музыка на борту", "Бесплатный трансфер из отеля по всему полуострову Бодрум"]'::jsonb,
   '["Круиз на гулете на весь день", "Трансфер от отеля и обратно", "Обед на борту", "Безалкогольные напитки и чай на борту", "Снаряжение для снорклинга (ограниченное количество)", "Спасательные жилеты и инструктаж по безопасности"]'::jsonb, '["Алкогольные напитки", "Вход в грязевую ванну на Чёрном острове (небольшая местная плата)", "Личные расходы", "Чаевые экипажу"]'::jsonb,
   '[{"time": "09:15", "title": "Трансфер из отеля", "text": "Забираем вас из отеля и везём в марину."}, {"time": "10:00", "title": "Отправление", "text": "Гулет отходит от марины Бодрума к первой бухте."}, {"time": "11:00", "title": "Акварная бухта", "text": "Стоянка на якоре и купание в мелкой кристально чистой воде."}, {"time": "13:00", "title": "Обед на борту", "text": "Неспешный обед подаётся на якорной стоянке в тихой бухте."}, {"time": "14:30", "title": "Чёрный остров", "text": "Посещение пещеры с минеральной грязью по желанию, затем снова купание."}, {"time": "16:30", "title": "Возвращение в марину", "text": "Возвращение в марину Бодрума и трансфер в отель."}]'::jsonb, '[{"q": "Что взять с собой на морскую прогулку по Бодруму?", "a": "Рекомендуем купальник, полотенце, солнцезащитный крем и сменную одежду. Снаряжение для снорклинга и спасательные жилеты предоставляются на борту."}, {"q": "Подходит ли прогулка тем, кто плохо плавает?", "a": "Да, для всех, кто не уверен в своих силах, есть спасательные жилеты, и заходить в воду никого не заставляют."}, {"q": "Что будет, если погода испортится?", "a": "Маршрут может быть скорректирован в зависимости от состояния моря; в редких случаях действительно небезопасной погоды тур переносится или деньги возвращаются."}, {"q": "Обед правда включён?", "a": "Да, полноценный обед на борту и безалкогольные напитки включены в стоимость - доплата нужна только за алкоголь."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'boat-trip'), 'pl',
   'Rejs Łodzią po Bodrum', 'Klasyczny rejs guletą po zatokach Bodrum i jaskini z mineralnym błotem na Czarnej Wyspie.', 'Półwysep Bodrum, Turcja',
   '7 godzin - Wycieczka jednodniowa', '10:00, codziennie (zależnie od pogody)', '17:00',
   'Marina Bodrum, Molo 4 (lub punkt odbioru z hotelu)',
   '["Jest powód, dla którego rejs łodzią po Bodrum to nasza najczęściej rezerwowana wycieczka: to po prostu najlepszy sposób na poznanie półwyspu. Popłyniecie tradycyjną drewnianą guletą do szeregu osłoniętych zatok, rzucając kotwicę wszędzie tam, gdzie woda wygląda zbyt kusząco, by przepłynąć obok.", "Do najważniejszych punktów należą niewiarygodnie czyste płycizny Zatoki Akwarium, postój przy Czarnej Wyspie (Karaada), gdzie jaskinne źródło pozwala pokryć się bogatym w minerały błotem i spłukać je w morzu, oraz mnóstwo czasu na pływanie przy muzyce na pokładzie. Po drodze podawany jest prosty obiad na pokładzie."]'::jsonb, '["Rejs na pokładzie tradycyjnej drewnianej gulety", "Postój na kąpiel w czystej, płytkiej wodzie Zatoki Akwarium", "Jaskinia z mineralnym błotem na Czarnej Wyspie", "Wiele postojów na pływanie i opalanie", "Obiad i muzyka na pokładzie", "Bezpłatny odbiór z hotelu na całym półwyspie Bodrum"]'::jsonb,
   '["Całodniowy rejs guletą", "Odbiór i powrót z hotelu", "Obiad na pokładzie", "Napoje bezalkoholowe i herbata na pokładzie", "Sprzęt do snorkelingu (ograniczona liczba zestawów)", "Kamizelki ratunkowe i instruktaż bezpieczeństwa"]'::jsonb, '["Napoje alkoholowe", "Wstęp do kąpieli błotnej na Czarnej Wyspie (niewielka opłata lokalna)", "Wydatki osobiste", "Napiwki dla załogi"]'::jsonb,
   '[{"time": "09:15", "title": "Odbiór z hotelu", "text": "Odbiór z hotelu i transfer do mariny."}, {"time": "10:00", "title": "Wyjazd", "text": "Guleta wypływa z Mariny Bodrum w kierunku pierwszej zatoki."}, {"time": "11:00", "title": "Zatoka Akwarium", "text": "Kotwiczenie i kąpiel w płytkiej, krystalicznie czystej wodzie."}, {"time": "13:00", "title": "Obiad na pokładzie", "text": "Spokojny obiad podawany podczas kotwiczenia w cichej zatoce."}, {"time": "14:30", "title": "Czarna Wyspa", "text": "Opcjonalna wizyta w jaskini z mineralnym błotem, a następnie dalsze pływanie."}, {"time": "16:30", "title": "Powrót do mariny", "text": "Rejs powrotny do Mariny Bodrum i transfer do hotelu."}]'::jsonb, '[{"q": "Co zabrać na rejs łodzią po Bodrum?", "a": "Zalecamy strój kąpielowy, ręcznik, krem z filtrem i zmianę ubrania. Sprzęt do snorkelingu i kamizelki ratunkowe są zapewnione na pokładzie."}, {"q": "Czy rejs jest odpowiedni dla osób słabo pływających?", "a": "Tak, dla każdego, kto nie czuje się pewnie w wodzie, dostępne są kamizelki ratunkowe, a nikt nie jest zmuszany do wchodzenia do wody."}, {"q": "Co się stanie w przypadku złej pogody?", "a": "Trasa może zostać dostosowana do warunków morskich; w rzadkich przypadkach naprawdę niebezpiecznej pogody wycieczka jest przekładana lub zwracane są pieniądze."}, {"q": "Czy obiad naprawdę jest wliczony?", "a": "Tak, pełny obiad na pokładzie i napoje bezalkoholowe są wliczone w cenę - dodatkowo płatne są tylko napoje alkoholowe."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'turkish-bath'), 'tr',
   'Türk Hamamı Deneyimi', 'Geleneksel Osmanlı usulü bir hamam ritüeli - sıcak mermer, buhar, köpük yıkama ve tam vücut kese.', 'Bodrum Şehir Merkezi, Türkiye',
   '1,5 Saat', 'Her Gün, Birden Fazla Seans Saati', 'Aynı gün, seans sonunda',
   'Tarihi Hamam, Bodrum Şehir Merkezi',
   '["Türk hamamı yüzyıllardır süregelen bir gelenektir ve bu deneyim, ritüeli baştan sona geleneksel haliyle takip eder. Isıtılmış mermer platformda (göbek taşı) gözeneklerinizi nazik bir buharla açarak dinlenmeyle başlar, ardından bir görevli cildi fark edilir derecede pürüzsüzleştiren tam vücut kese uygulaması yapar.", "Bunu, geleneksel usulde bir bezden bolca dökülen ılık köpük yıkama takip eder ve ziyaret isteğe bağlı bir yağ masajıyla sona erer. Kadınlar ve erkekler için ayrı seanslar mevcuttur; tüm deneyim, otantik olduğu kadar rahatlatıcı olacak şekilde tasarlanmıştır."]'::jsonb, '["Bodrum''un eski kasabasında tarihi bir hamam", "Geleneksel sıcak mermer platform (göbek taşı)", "Tam vücut kese pürüzsüzleştirme", "Sıcak, geleneksel köpük yıkama", "İsteğe bağlı yağ masajı yükseltmesi", "Kadın ve erkekler için ayrı seanslar"]'::jsonb,
   '["Hamam girişi ve tam ritüel", "Kese ve köpük yıkama", "Havlu, peştemal ve terlik", "Seans sonrası bitki çayı", "Eşyalarınız için dolap", "Talep üzerine otel alış hizmeti"]'::jsonb, '["Yağ masajı yükseltmesi (isteğe bağlı ek)", "Önceden talep edilmemişse ulaşım", "Kişisel tuvalet malzemeleri", "Görevli için bahşiş"]'::jsonb,
   '[{"time": "00:00", "title": "Varış ve Giriş", "text": "Peştemalinizi giyip eşyalarınızı dolaba yerleştirin."}, {"time": "00:15", "title": "Mermerde Isınma", "text": "Buhar gözenekleri açarken sıcak göbek taşında dinlenin."}, {"time": "00:45", "title": "Kese Uygulaması", "text": "Geleneksel tam vücut kese ölü derileri arındırır."}, {"time": "01:05", "title": "Köpük Yıkama", "text": "Geleneksel usulde sıcak, bol köpüklü yıkama."}, {"time": "01:20", "title": "Dinlenme ve Çay", "text": "Dinlenme alanında bitki çayı ile tamamlanır."}]'::jsonb, '[{"q": "Türk hamamı kadın-erkek karma mı, ayrı mı?", "a": "Geleneksel hamam adetine uygun olarak kadınlar ve erkekler için ayrı seanslar düzenlenir."}, {"q": "Hamama ne getirmeliyim?", "a": "Ekstra bir şey gerekmez - peştemal, havlu ve terlik sağlanır. Geleneksel peştemal yerine kendi mayonuzu kullanmak isterseniz getirebilirsiniz."}, {"q": "Yağ masajı dahil mi?", "a": "Temel ritüel (mermerde ısınma, kese ve köpük yıkama) dahildir; yağ masajı rezervasyon sırasında ekleyebileceğiniz isteğe bağlı, ücretli bir yükseltmedir."}, {"q": "Çocuklar Türk hamamına katılabilir mi?", "a": "Evet, bir ebeveyn eşliğinde çocuklar da katılabilir; ancak kese uygulaması genellikle küçük misafirler için daha hafif yapılır."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'turkish-bath'), 'en',
   'Turkish Bath (Hammam) Experience', 'A traditional Ottoman-style hammam ritual - hot marble, steam, foam wash and a full-body scrub.', 'Bodrum Town Centre, Türkiye',
   '1.5 Hours', 'Multiple Time Slots, Daily', 'Same day, on completion',
   'Historic Hammam, Bodrum Town Centre',
   '["The Turkish hammam is centuries old, and this experience follows the traditional ritual from start to finish. You''ll begin by relaxing on the heated marble platform (the gobek tasi, or ''belly stone'') to open the pores in gentle steam, before an attendant works through a full-body kese scrub that leaves skin remarkably smooth.", "A warm foam wash follows, poured generously from a cloth in the traditional style, and the visit finishes with an optional oil massage. Separate sessions are available for men and women, and the whole experience is designed to be as relaxing as it is authentic."]'::jsonb, '["Historic hammam in Bodrum''s old town", "Traditional hot marble platform (gobek tasi)", "Full-body kese exfoliating scrub", "Warm traditional foam wash", "Optional oil massage upgrade", "Separate sessions for men and women"]'::jsonb,
   '["Hammam entrance and full ritual", "Kese scrub and foam wash", "Towels, peshtemal wrap and slippers", "Herbal tea after the session", "Locker for your belongings", "Hotel pick-up available on request"]'::jsonb, '["Oil massage upgrade (optional add-on)", "Transport if not requested in advance", "Personal toiletries", "Gratuities for the attendant"]'::jsonb,
   '[{"time": "00:00", "title": "Arrival & Check-in", "text": "Change into your peshtemal and store your belongings in a locker."}, {"time": "00:15", "title": "Warm-up on the Marble", "text": "Relax on the heated gobek tasi as steam opens the pores."}, {"time": "00:45", "title": "Kese Scrub", "text": "A traditional full-body exfoliation removes dead skin."}, {"time": "01:05", "title": "Foam Wash", "text": "A warm, generous foam wash in the traditional style."}, {"time": "01:20", "title": "Relax & Tea", "text": "Finish with herbal tea in the lounge area."}]'::jsonb, '[{"q": "Is the Turkish bath mixed or separate for men and women?", "a": "Sessions are held separately for men and women, following traditional hammam custom."}, {"q": "What should I bring to the hammam?", "a": "Nothing extra is required - a peshtemal wrap, towels and slippers are provided. You may wish to bring your own swimwear if you prefer not to use the traditional wrap."}, {"q": "Is the oil massage included?", "a": "The core ritual (marble warm-up, scrub and foam wash) is included; the oil massage is an optional paid upgrade you can add when booking."}, {"q": "Can children join the Turkish bath?", "a": "Yes, children are welcome accompanied by a parent, though the scrub is typically gentler for younger guests."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'turkish-bath'), 'de',
   'Türkisches Hamam-Erlebnis', 'Ein traditionelles osmanisches Hamam-Ritual - heißer Marmor, Dampf, Schaumwäsche und ein Ganzkörper-Peeling.', 'Bodrum Stadtzentrum, Türkei',
   '1,5 Stunden', 'Mehrere Zeitfenster, täglich', 'Am selben Tag, nach Abschluss',
   'Historisches Hamam, Bodrum Stadtzentrum',
   '["Das türkische Hamam ist jahrhundertealt, und dieses Erlebnis folgt dem traditionellen Ritual von Anfang bis Ende. Sie beginnen mit Entspannung auf der beheizten Marmorplatte (dem Göbek Tasi, dem ''Bauchstein''), während sanfter Dampf die Poren öffnet, bevor eine Betreuerin oder ein Betreuer ein Ganzkörper-Kese-Peeling durchführt, das die Haut bemerkenswert weich zurücklässt.", "Es folgt eine warme Schaumwäsche, großzügig aus einem Tuch nach traditioneller Art gegossen, und der Besuch endet mit einer optionalen Ölmassage. Für Männer und Frauen gibt es getrennte Sitzungen, und das gesamte Erlebnis ist ebenso entspannend wie authentisch gestaltet."]'::jsonb, '["Historisches Hamam in Bodrums Altstadt", "Traditionelle heiße Marmorplatte (Göbek Tasi)", "Ganzkörper-Kese-Peeling", "Warme, traditionelle Schaumwäsche", "Optionales Ölmassage-Upgrade", "Getrennte Sitzungen für Männer und Frauen"]'::jsonb,
   '["Hamam-Eintritt und vollständiges Ritual", "Kese-Peeling und Schaumwäsche", "Handtücher, Peshtemal-Tuch und Pantoffeln", "Kräutertee nach der Sitzung", "Schließfach für Ihre Wertsachen", "Hotelabholung auf Anfrage verfügbar"]'::jsonb, '["Ölmassage-Upgrade (optionaler Zusatz)", "Transport, sofern nicht im Voraus angefragt", "Persönliche Pflegeartikel", "Trinkgeld für das Personal"]'::jsonb,
   '[{"time": "00:00", "title": "Ankunft und Empfang", "text": "Umziehen in Ihr Peshtemal-Tuch und Verstauen Ihrer Sachen im Schließfach."}, {"time": "00:15", "title": "Aufwärmen auf dem Marmor", "text": "Entspannen Sie auf dem beheizten Göbek Tasi, während Dampf die Poren öffnet."}, {"time": "00:45", "title": "Kese-Peeling", "text": "Ein traditionelles Ganzkörper-Peeling entfernt abgestorbene Hautschüppchen."}, {"time": "01:05", "title": "Schaumwäsche", "text": "Eine warme, großzügige Schaumwäsche nach traditioneller Art."}, {"time": "01:20", "title": "Entspannen und Tee", "text": "Abschluss mit Kräutertee im Ruhebereich."}]'::jsonb, '[{"q": "Ist das türkische Bad gemischt oder getrennt für Männer und Frauen?", "a": "Nach traditionellem Hamam-Brauch finden die Sitzungen getrennt für Männer und Frauen statt."}, {"q": "Was sollte ich zum Hamam mitbringen?", "a": "Es ist nichts Zusätzliches nötig - Peshtemal-Tuch, Handtücher und Pantoffeln werden gestellt. Wer das traditionelle Tuch nicht nutzen möchte, kann eigene Badebekleidung mitbringen."}, {"q": "Ist die Ölmassage inbegriffen?", "a": "Das Kernritual (Aufwärmen auf Marmor, Peeling und Schaumwäsche) ist inbegriffen; die Ölmassage ist ein optionales, kostenpflichtiges Upgrade, das Sie bei der Buchung hinzufügen können."}, {"q": "Können Kinder am türkischen Bad teilnehmen?", "a": "Ja, Kinder sind in Begleitung eines Elternteils willkommen, wobei das Peeling bei jüngeren Gästen in der Regel sanfter ausgeführt wird."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'turkish-bath'), 'ru',
   'Турецкая баня (хаммам)', 'Традиционный османский ритуал хаммама - горячий мрамор, пар, пенное омовение и пилинг всего тела.', 'Центр города Бодрум, Турция',
   '1,5 часа', 'Несколько сеансов ежедневно', 'В тот же день, по завершении',
   'Историческая баня, центр города Бодрум',
   '["Турецкому хаммаму уже много веков, и это впечатление следует традиционному ритуалу от начала до конца. Вы начнёте с отдыха на подогреваемой мраморной плите (гёбек таши, «камень живота»), где мягкий пар раскрывает поры, а затем сотрудник проведёт пилинг всего тела кесе, после которого кожа становится удивительно гладкой.", "Далее следует тёплое пенное омовение, щедро льющееся из ткани по традиционному методу, а визит завершается опциональным массажем с маслом. Для мужчин и женщин предусмотрены раздельные сеансы, и весь опыт задуман таким же расслабляющим, каким и подлинным."]'::jsonb, '["Историческая баня в старом городе Бодрума", "Традиционная горячая мраморная плита (гёбек таши)", "Пилинг кесе для всего тела", "Тёплое традиционное пенное омовение", "Опциональный апгрейд - массаж с маслом", "Раздельные сеансы для мужчин и женщин"]'::jsonb,
   '["Вход в баню и полный ритуал", "Пилинг кесе и пенное омовение", "Полотенца, палантин пештемаль и тапочки", "Травяной чай после сеанса", "Шкафчик для личных вещей", "Трансфер от отеля по запросу"]'::jsonb, '["Апгрейд - массаж с маслом (по желанию)", "Транспорт, если не запрошен заранее", "Личные туалетные принадлежности", "Чаевые персоналу"]'::jsonb,
   '[{"time": "00:00", "title": "Прибытие и регистрация", "text": "Переоденьтесь в пештемаль и оставьте вещи в шкафчике."}, {"time": "00:15", "title": "Прогрев на мраморе", "text": "Отдых на горячем гёбек таши, пока пар раскрывает поры."}, {"time": "00:45", "title": "Пилинг кесе", "text": "Традиционный пилинг всего тела удаляет отмершие частицы кожи."}, {"time": "01:05", "title": "Пенное омовение", "text": "Тёплое, щедрое пенное омовение по традиционному методу."}, {"time": "01:20", "title": "Отдых и чай", "text": "Завершение травяным чаем в зоне отдыха."}]'::jsonb, '[{"q": "Турецкая баня смешанная или раздельная для мужчин и женщин?", "a": "Согласно традиционному обычаю хаммама сеансы проводятся раздельно для мужчин и женщин."}, {"q": "Что взять с собой в хаммам?", "a": "Ничего дополнительного не требуется - пештемаль, полотенца и тапочки предоставляются. Если вы предпочитаете не использовать традиционную ткань, можно взять свой купальник."}, {"q": "Массаж с маслом включён?", "a": "Основной ритуал (прогрев на мраморе, пилинг и пенное омовение) включён; массаж с маслом - это опциональный платный апгрейд, который можно добавить при бронировании."}, {"q": "Могут ли дети посещать турецкую баню?", "a": "Да, дети допускаются в сопровождении родителя, при этом пилинг для юных гостей обычно выполняется мягче."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'turkish-bath'), 'pl',
   'Turecka Łaźnia (Hammam)', 'Tradycyjny osmański rytuał hammamu - gorący marmur, para, pienista kąpiel i peeling całego ciała.', 'Centrum Bodrum, Turcja',
   '1,5 godziny', 'Wiele godzin sesji, codziennie', 'Tego samego dnia, po zakończeniu',
   'Zabytkowy hammam, centrum Bodrum',
   '["Turecki hammam ma wielowiekową tradycję, a to doświadczenie podąża za tradycyjnym rytuałem od początku do końca. Zaczniecie od relaksu na podgrzewanej marmurowej płycie (goebek tasi, czyli ''kamieniu brzucha''), gdzie delikatna para otwiera pory, po czym obsługa wykona peeling całego ciała kese, dzięki któremu skóra staje się niezwykle gładka.", "Następnie następuje ciepła kąpiel pianowa, hojnie polewana z tkaniny w tradycyjny sposób, a wizyta kończy się opcjonalnym masażem olejkowym. Dostępne są osobne sesje dla mężczyzn i kobiet, a całe doświadczenie ma być równie relaksujące, co autentyczne."]'::jsonb, '["Zabytkowy hammam w starej części Bodrum", "Tradycyjna gorąca płyta marmurowa (goebek tasi)", "Peeling kese całego ciała", "Ciepła, tradycyjna kąpiel pianowa", "Opcjonalny masaż olejkowy", "Osobne sesje dla mężczyzn i kobiet"]'::jsonb,
   '["Wstęp do hammamu i pełny rytuał", "Peeling kese i kąpiel pianowa", "Ręczniki, chusta peshtemal i klapki", "Herbata ziołowa po sesji", "Szafka na rzeczy osobiste", "Odbiór z hotelu na życzenie"]'::jsonb, '["Masaż olejkowy (opcjonalny dodatek)", "Transport, jeśli nie zamówiony wcześniej", "Osobiste kosmetyki", "Napiwki dla obsługi"]'::jsonb,
   '[{"time": "00:00", "title": "Przybycie i zameldowanie", "text": "Przebranie się w peshtemal i zostawienie rzeczy w szafce."}, {"time": "00:15", "title": "Rozgrzewka na marmurze", "text": "Relaks na podgrzanej płycie goebek tasi, gdy para otwiera pory."}, {"time": "00:45", "title": "Peeling kese", "text": "Tradycyjny peeling całego ciała usuwa martwy naskórek."}, {"time": "01:05", "title": "Kąpiel pianowa", "text": "Ciepła, obfita kąpiel pianowa w tradycyjnym stylu."}, {"time": "01:20", "title": "Relaks i herbata", "text": "Zakończenie herbatą ziołową w strefie relaksu."}]'::jsonb, '[{"q": "Czy turecka łaźnia jest koedukacyjna, czy osobna dla mężczyzn i kobiet?", "a": "Zgodnie z tradycyjnym zwyczajem hammamu sesje odbywają się osobno dla mężczyzn i kobiet."}, {"q": "Co zabrać do hammamu?", "a": "Nic dodatkowego nie jest potrzebne - chusta peshtemal, ręczniki i klapki są zapewnione. Jeśli wolicie nie używać tradycyjnej chusty, możecie zabrać własny strój kąpielowy."}, {"q": "Czy masaż olejkowy jest wliczony?", "a": "Podstawowy rytuał (rozgrzewka na marmurze, peeling i kąpiel pianowa) jest wliczony; masaż olejkowy to opcjonalny, płatny dodatek, który można dodać przy rezerwacji."}, {"q": "Czy dzieci mogą korzystać z tureckiej łaźni?", "a": "Tak, dzieci są mile widziane pod opieką rodzica, choć peeling dla młodszych gości jest zazwyczaj wykonywany łagodniej."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'jeep-safari'), 'tr',
   'Jeep Safari Macerası', 'Bodrum''un tepelerinde, mandalina bahçelerinde ve dağ köylerinde üstü açık bir konvoy turu.', 'Bodrum Yarımadası İç Kesimi, Türkiye',
   '6 Saat - Yarım Gün', '09:00, Her Gün', '15:00',
   'Bodrum yarımadası genelinde otelden alış',
   '["Bu üstü açık jeep konvoyunda kıyı şeridini tepelerle değiştirin ve Bodrum yarımadasının daha vahşi tarafını keşfedin. Şoförünüz, çam ormanları, mandalina ve zeytin bahçeleri boyunca toprak yollardan geçerek küçük bir 4x4 grubunu çoğu ziyaretçinin hiç görmediği sakin dağ köylerine götürür.", "Ege''ye tepeden bakan panoramik manzara noktalarında düzenli fotoğraf molaları, herkesi güldüren bir su-çamur bölümü ve taze yerel ürünler ya da soğuk bir içecek alabileceğiniz bir köy molası sizi bekliyor. Bir plaj gününe tozlu, enerjik ve keyifli bir alternatif."]'::jsonb, '["Yarımadanın iç kesimlerinde üstü açık 4x4 konvoyu", "Ege kıyı şeridine bakan dağ manzara noktaları", "Mandalina ve zeytin bahçeleriyle çevrili kırsal", "Eğlenceli su-çamur parkur bölümü", "Geleneksel bir dağ köyünde mola", "Kişisel bir tempo için küçük konvoy büyüklüğü"]'::jsonb,
   '["Paylaşımlı 4x4 konvoyunda jeep koltuğu", "Otel alış ve bırakış hizmeti", "İngilizce konuşan şoför-rehber", "Araçta şişe suyu", "Serbest zamanlı köy molası", "Gezi süresince sigorta"]'::jsonb, '["Öğle yemeği ve atıştırmalıklar (köyde satın alınabilir)", "Kişisel harcamalar ve hediyelik eşyalar", "Çamur bölümüne katılırsanız yedek kıyafet", "Şoför için bahşiş"]'::jsonb,
   '[{"time": "09:00", "title": "Otelden Alış", "text": "Otelinizden alınıp konvoyun başlangıç noktasına transfer edilirsiniz."}, {"time": "09:45", "title": "Tepelere Doğru", "text": "Jeep konvoyu orman ve bahçe yollarında tırmanmaya başlar."}, {"time": "11:00", "title": "Manzara Noktası Molası", "text": "Ege kıyı şeridine bakan fotoğraf molası."}, {"time": "12:00", "title": "Su-Çamur Bölümü", "text": "Su ve çamur geçişleriyle eğlenceli bir off-road bölümü."}, {"time": "13:00", "title": "Köy Molası", "text": "Bir dağ köyünde içecek veya yerel atıştırmalık için serbest zaman."}, {"time": "14:30", "title": "Dönüş", "text": "Konvoy geri döner ve otelinize bırakılırsınız."}]'::jsonb, '[{"q": "Off-road sürüş deneyimim olması gerekir mi?", "a": "Hayır, konvoya deneyimli bir şoför-rehber liderlik eder ve paylaşımlı bir jeepte yer alırsınız - siz sadece yolculuğun keyfini çıkarırsınız."}, {"q": "Islanır ya da kirlenir miyim?", "a": "Su-çamur bölümüne tam katılım isteğe bağlıdır, ancak parkurda biraz su veya toz eğlencenin bir parçasıdır - kirlenmesini önemsemeyeceğiniz kıyafetler önerilir."}, {"q": "Jeep Safari çocuklar için uygun mu?", "a": "Evet, çocuklar katılabilir; ancak sarsıntılı arazi 5 yaş ve üzeri çocuklar için daha uygundur."}, {"q": "Öğle yemeği dahil mi?", "a": "Öğle yemeği dahil değildir, ancak köy molasında atıştırmalık veya içecek satın alma seçenekleri vardır; öğle yemeği dahil bir tur tercih ederseniz bize bildirin."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'jeep-safari'), 'en',
   'Jeep Safari Adventure', 'An open-top convoy through Bodrum''s hills, mandarin groves and mountain villages.', 'Bodrum Peninsula Hinterland, Türkiye',
   '6 Hours - Half Day', '09:00 AM, Daily', '15:00 PM',
   'Hotel pick-up across the Bodrum peninsula',
   '["Swap the coastline for the hills on this open-top jeep convoy through the wilder side of the Bodrum peninsula. Your driver leads a small group of 4x4s along dirt tracks through pine forest, mandarin and olive groves, and sleepy mountain villages most visitors never see.", "There are regular stops for photos at panoramic viewpoints over the Aegean, a splash-and-mud section that always gets a laugh, and a village break where you can pick up fresh local produce or a cold drink. It''s a dusty, energetic contrast to a beach day - and a good one."]'::jsonb, '["Open-top 4x4 convoy through the peninsula''s hinterland", "Mountain viewpoints over the Aegean coastline", "Mandarin and olive grove countryside", "Playful splash-and-mud track section", "Stop in a traditional mountain village", "Small convoy size for a personal pace"]'::jsonb,
   '["Jeep seat in a shared 4x4 convoy", "Hotel pick-up and drop-off", "English-speaking driver-guide", "Bottled water on board", "Village stop with free time", "Insurance during the excursion"]'::jsonb, '["Lunch and snacks (available for purchase in the village)", "Personal expenses and souvenirs", "Change of clothes if you join the mud section", "Gratuities for the driver"]'::jsonb,
   '[{"time": "09:00", "title": "Hotel Pick-up", "text": "Collection from your hotel and transfer to the convoy start point."}, {"time": "09:45", "title": "Into the Hills", "text": "The jeep convoy begins climbing through forest and grove tracks."}, {"time": "11:00", "title": "Viewpoint Stop", "text": "Photo stop overlooking the Aegean coastline."}, {"time": "12:00", "title": "Splash & Mud Section", "text": "A playful off-road section with water and mud crossings."}, {"time": "13:00", "title": "Village Break", "text": "Free time in a mountain village for a drink or local snack."}, {"time": "14:30", "title": "Return", "text": "The convoy heads back and you''re dropped at your hotel."}]'::jsonb, '[{"q": "Do I need off-road driving experience?", "a": "No, an experienced driver-guide leads the convoy in a shared jeep - you simply enjoy the ride."}, {"q": "Will I get wet or muddy?", "a": "The splash-and-mud section is optional to fully engage with, but a little water or dust on the track is part of the fun - we recommend clothes you don''t mind getting dirty."}, {"q": "Is the Jeep Safari suitable for children?", "a": "Yes, children are welcome, though the bumpy terrain is best suited to kids aged 5 and up."}, {"q": "Is lunch included?", "a": "Lunch isn''t included, but the village stop has options to buy a snack or drink; let us know if you''d prefer a tour with lunch included."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'jeep-safari'), 'de',
   'Jeep-Safari-Abenteuer', 'Ein Konvoi offener Jeeps durch Bodrums Hügel, Mandarinenhaine und Bergdörfer.', 'Hinterland der Bodrum-Halbinsel, Türkei',
   '6 Stunden - Halbtägig', '09:00 Uhr, täglich', '15:00 Uhr',
   'Hotelabholung auf der gesamten Bodrum-Halbinsel',
   '["Tauschen Sie die Küste gegen die Hügel bei diesem Konvoi offener Jeeps durch die wildere Seite der Bodrum-Halbinsel. Ihr Fahrer führt eine kleine Gruppe von Geländewagen über Feldwege durch Pinienwälder, Mandarinen- und Olivenhaine sowie verschlafene Bergdörfer, die die meisten Besucher nie zu Gesicht bekommen.", "Es gibt regelmäßige Fotostopps an Panoramaaussichtspunkten über der Ägäis, einen Wasser- und Schlammabschnitt, der immer für Gelächter sorgt, sowie eine Dorfpause, bei der Sie frische lokale Produkte oder ein kaltes Getränk erwerben können. Ein staubiger, energiegeladener Kontrast zu einem Strandtag - und ein guter dazu."]'::jsonb, '["Konvoi offener Geländewagen durch das Hinterland der Halbinsel", "Bergaussichtspunkte über die ägäische Küste", "Landschaft mit Mandarinen- und Olivenhainen", "Verspielter Wasser- und Schlammabschnitt", "Halt in einem traditionellen Bergdorf", "Kleine Konvoigröße für ein persönliches Tempo"]'::jsonb,
   '["Jeepsitz in einem gemeinsam genutzten Geländewagen-Konvoi", "Hotelabholung und -rückbringung", "Englischsprachiger Fahrer-Guide", "Flaschenwasser an Bord", "Dorfhalt mit Freizeit", "Versicherung während des Ausflugs"]'::jsonb, '["Mittagessen und Snacks (im Dorf käuflich)", "Persönliche Ausgaben und Souvenirs", "Wechselkleidung, falls Sie am Schlammabschnitt teilnehmen", "Trinkgeld für den Fahrer"]'::jsonb,
   '[{"time": "09:00", "title": "Hotelabholung", "text": "Abholung von Ihrem Hotel und Transfer zum Startpunkt des Konvois."}, {"time": "09:45", "title": "Aufstieg in die Hügel", "text": "Der Jeep-Konvoi beginnt den Aufstieg über Wald- und Hainwege."}, {"time": "11:00", "title": "Aussichtspunkt-Halt", "text": "Fotostopp mit Blick über die ägäische Küste."}, {"time": "12:00", "title": "Wasser- und Schlammabschnitt", "text": "Ein verspielter Geländeabschnitt mit Wasser- und Schlammdurchquerungen."}, {"time": "13:00", "title": "Dorfpause", "text": "Freizeit in einem Bergdorf für ein Getränk oder lokalen Snack."}, {"time": "14:30", "title": "Rückfahrt", "text": "Der Konvoi kehrt zurück und Sie werden an Ihrem Hotel abgesetzt."}]'::jsonb, '[{"q": "Brauche ich Geländefahrerfahrung?", "a": "Nein, ein erfahrener Fahrer-Guide führt den Konvoi in einem gemeinsam genutzten Jeep - Sie genießen einfach die Fahrt."}, {"q": "Werde ich nass oder schmutzig?", "a": "Die aktive Teilnahme am Wasser- und Schlammabschnitt ist optional, aber etwas Wasser oder Staub auf der Strecke gehört zum Spaß - wir empfehlen Kleidung, deren Verschmutzung Ihnen nichts ausmacht."}, {"q": "Ist die Jeep-Safari für Kinder geeignet?", "a": "Ja, Kinder sind willkommen, das holprige Gelände eignet sich jedoch am besten für Kinder ab 5 Jahren."}, {"q": "Ist das Mittagessen inbegriffen?", "a": "Das Mittagessen ist nicht inbegriffen, aber im Dorf gibt es die Möglichkeit, einen Snack oder ein Getränk zu kaufen; teilen Sie uns mit, wenn Sie eine Tour mit Mittagessen bevorzugen."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'jeep-safari'), 'ru',
   'Джип-сафари приключение', 'Конвой открытых джипов по холмам Бодрума, мандариновым рощам и горным деревням.', 'Внутренние районы полуострова Бодрум, Турция',
   '6 часов - полдня', '09:00, ежедневно', '15:00',
   'Трансфер от отеля по всему полуострову Бодрум',
   '["Смените побережье на холмы в этом конвое открытых джипов по более дикой стороне полуострова Бодрум. Ваш водитель ведёт небольшую группу внедорожников по грунтовым дорогам через сосновые леса, мандариновые и оливковые рощи и сонные горные деревни, которые большинство туристов никогда не видят.", "Вас ждут регулярные остановки для фото на панорамных смотровых площадках над Эгейским морем, весело-грязевой участок трассы, который всегда вызывает смех, и остановка в деревне, где можно купить свежие местные продукты или холодный напиток. Пыльный, энергичный контраст пляжному дню - и хороший контраст."]'::jsonb, '["Конвой открытых внедорожников по внутренним районам полуострова", "Горные смотровые площадки над побережьем Эгейского моря", "Сельская местность с мандариновыми и оливковыми рощами", "Весёлый водно-грязевой участок трассы", "Остановка в традиционной горной деревне", "Небольшой размер конвоя для комфортного темпа"]'::jsonb,
   '["Место в джипе в составе общего конвоя внедорожников", "Трансфер от отеля и обратно", "Англоговорящий водитель-гид", "Питьевая вода в машине", "Остановка в деревне со свободным временем", "Страховка на время экскурсии"]'::jsonb, '["Обед и закуски (можно купить в деревне)", "Личные расходы и сувениры", "Сменная одежда, если вы участвуете в грязевом участке", "Чаевые водителю"]'::jsonb,
   '[{"time": "09:00", "title": "Трансфер из отеля", "text": "Забираем вас из отеля и везём к стартовой точке конвоя."}, {"time": "09:45", "title": "Подъём в холмы", "text": "Конвой джипов начинает подъём по лесным и рощевым тропам."}, {"time": "11:00", "title": "Остановка на смотровой площадке", "text": "Остановка для фото с видом на побережье Эгейского моря."}, {"time": "12:00", "title": "Водно-грязевой участок", "text": "Весёлый внедорожный участок с преодолением воды и грязи."}, {"time": "13:00", "title": "Остановка в деревне", "text": "Свободное время в горной деревне для напитка или местной закуски."}, {"time": "14:30", "title": "Возвращение", "text": "Конвой возвращается, и вас высаживают у отеля."}]'::jsonb, '[{"q": "Нужен ли мне опыт внедорожного вождения?", "a": "Нет, конвой ведёт опытный водитель-гид на общем джипе - вам остаётся только наслаждаться поездкой."}, {"q": "Я намокну или испачкаюсь?", "a": "Активное участие в водно-грязевом участке необязательно, но немного воды или пыли на трассе - часть веселья; рекомендуем одежду, которую не жалко испачкать."}, {"q": "Подходит ли джип-сафари для детей?", "a": "Да, дети допускаются, но неровная местность лучше всего подходит для детей от 5 лет."}, {"q": "Обед включён?", "a": "Обед не включён, но в деревне можно купить закуску или напиток; сообщите нам, если предпочитаете тур с обедом."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'jeep-safari'), 'pl',
   'Przygoda Jeep Safari', 'Konwój odkrytych jeepów przez wzgórza Bodrum, gaje mandarynkowe i górskie wioski.', 'Zaplecze Półwyspu Bodrum, Turcja',
   '6 godzin - Pół dnia', '09:00, codziennie', '15:00',
   'Odbiór z hotelu na całym półwyspie Bodrum',
   '["Zamieńcie wybrzeże na wzgórza podczas tego konwoju odkrytych jeepów przez dzikszą stronę półwyspu Bodrum. Kierowca prowadzi niewielką grupę terenówek po polnych drogach przez lasy sosnowe, gaje mandarynkowe i oliwne oraz senne górskie wioski, których większość turystów nigdy nie widzi.", "Podczas trasy odbywają się regularne postoje na zdjęcia w punktach widokowych nad Morzem Egejskim, zabawny odcinek z wodą i błotem, który zawsze wywołuje śmiech, oraz postój we wsi, gdzie można kupić świeże lokalne produkty lub zimny napój. Zakurzony, pełen energii kontrast dla dnia na plaży - i to dobry kontrast."]'::jsonb, '["Konwój odkrytych terenówek przez zaplecze półwyspu", "Górskie punkty widokowe nad wybrzeżem Morza Egejskiego", "Wiejski krajobraz z gajami mandarynkowymi i oliwnymi", "Zabawny odcinek trasy z wodą i błotem", "Postój w tradycyjnej górskiej wiosce", "Niewielki konwój dla osobistego tempa"]'::jsonb,
   '["Miejsce w jeepie we wspólnym konwoju terenówek", "Odbiór i powrót z hotelu", "Anglojęzyczny kierowca-przewodnik", "Woda butelkowana w trasie", "Postój we wsi z czasem wolnym", "Ubezpieczenie na czas wycieczki"]'::jsonb, '["Obiad i przekąski (do kupienia we wsi)", "Wydatki osobiste i pamiątki", "Zmiana ubrania w razie udziału w odcinku błotnym", "Napiwek dla kierowcy"]'::jsonb,
   '[{"time": "09:00", "title": "Odbiór z hotelu", "text": "Odbiór z hotelu i transfer do punktu startowego konwoju."}, {"time": "09:45", "title": "Wjazd na wzgórza", "text": "Konwój jeepów zaczyna wjazd przez leśne i sadownicze drogi."}, {"time": "11:00", "title": "Postój przy punkcie widokowym", "text": "Postój na zdjęcia z widokiem na wybrzeże Morza Egejskiego."}, {"time": "12:00", "title": "Odcinek z wodą i błotem", "text": "Zabawny odcinek terenowy z przeprawami przez wodę i błoto."}, {"time": "13:00", "title": "Postój we wsi", "text": "Czas wolny w górskiej wiosce na napój lub lokalną przekąskę."}, {"time": "14:30", "title": "Powrót", "text": "Konwój wraca, a Państwo zostają wysadzeni przy hotelu."}]'::jsonb, '[{"q": "Czy potrzebne jest doświadczenie w jeździe terenowej?", "a": "Nie, konwojem kieruje doświadczony kierowca-przewodnik we wspólnym jeepie - wystarczy cieszyć się jazdą."}, {"q": "Czy się zmoczę lub pobrudzę?", "a": "Aktywny udział w odcinku z wodą i błotem jest opcjonalny, ale odrobina wody czy kurzu na trasie to część zabawy - polecamy ubranie, którego nie szkoda pobrudzić."}, {"q": "Czy Jeep Safari jest odpowiednie dla dzieci?", "a": "Tak, dzieci są mile widziane, choć wyboisty teren najlepiej sprawdza się dla dzieci od 5 roku życia."}, {"q": "Czy obiad jest wliczony?", "a": "Obiad nie jest wliczony, ale we wsi można kupić przekąskę lub napój; dajcie nam znać, jeśli wolicie wycieczkę z obiadem."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'atv-safari'), 'tr',
   'ATV Safari', 'Yarımadanın toprak parkurlarında kendi kullandığınız bir quad macerası için direksiyona geçin.', 'Bodrum Yarımadası İç Kesimi, Türkiye',
   '3 Saat - Yarım Gün', '10:00 ve 14:00, Her Gün', '13:00 / 17:00',
   'ATV Üs Kampı (otel alış hizmeti mevcuttur)',
   '["Jeep Safari manzarayla ilgiliyse, ATV Safari sürüşle ilgilidir. Kısa bir güvenlik brifinginin ardından kendi quad''ınızın direksiyonuna geçer, rehberinizi yarımadanın kenarındaki tozlu parkurlar, orman yolları ve açık kırsal alanlar boyunca takip edersiniz.", "Aktif ve uygulamalı birkaç saat sizi bekliyor - tekli veya çiftli koltuklu quad''lar mevcut olduğundan hem tek başına maceraperestler hem de çiftler için uygundur. Rota ortasındaki kısa bir mola nefeslenip fotoğraf çekmenize olanak tanır."]'::jsonb, '["Ehliyet gerektirmeyen, kendi kullandığınız quad", "Orman ve toprak parkurlarda rehberli konvoy", "Tekli ve çiftli koltuklu quad seçenekleri", "Güvenlik brifingi ve kask sağlanır", "Rota ortasında manzaralı mola", "Kompakt yarım gün formatı"]'::jsonb,
   '["Rota için quad kiralama", "Kask ve güvenlik ekipmanı", "Güvenlik brifingi ve deneme turu", "İngilizce konuşan rehber", "Otel alış ve bırakış hizmeti", "Şişe suyu"]'::jsonb, '["Daha uzun rotalarda yakıt ek ücreti (nadir, önceden bildirilir)", "Kişisel harcamalar", "Fotoğraf/video paketi (satın alınabilir)", "Rehber için bahşiş"]'::jsonb,
   '[{"time": "09:30", "title": "Otelden Alış", "text": "Otelinizden alınıp üs kampına transfer edilirsiniz."}, {"time": "10:00", "title": "Güvenlik Brifingi", "text": "Quad kontrolleri ve güvenlik kuralları anlatılır, kısa bir deneme turu yapılır."}, {"time": "10:20", "title": "Rehberli Sürüş", "text": "Rehberinizi orman ve kırsal parkurlar boyunca takip edersiniz."}, {"time": "11:15", "title": "Dinlenme Molası", "text": "Manzaralı bir noktada su ve fotoğraf için kısa bir mola."}, {"time": "12:40", "title": "Üs Kampına Dönüş", "text": "Konvoy üs kampına döner ve otelinize transfer edilirsiniz."}]'::jsonb, '[{"q": "ATV Safari için ehliyet gerekli mi?", "a": "Bu turda kullanılan quad''lar için ehliyet gerekmez, ancak sürmek için en az 16 yaşında olmalısınız (daha küçük misafirler bir yetişkinle yolcu olarak binebilir)."}, {"q": "Bir quad''ı iki kişi paylaşabilir mi?", "a": "Evet, çiftler veya bir ebeveyn-çocuk için çiftli koltuklu quad''lar mevcuttur - rezervasyon sırasında tercihinizi belirtin."}, {"q": "Ne giymeliyim?", "a": "Kapalı ayakkabılar, güneş gözlüğü ve tozlanmasını önemsemeyeceğiniz kıyafetler önerilir. Kasklar tarafımızca sağlanır."}, {"q": "ATV Safari fiziksel olarak zorlayıcı mı?", "a": "Orta düzeyde aktiftir - direksiyon ve gaz kontrolünü kendiniz yaparsınız - ancak önceden deneyim gerekmez."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'atv-safari'), 'en',
   'ATV Safari', 'Get behind the handlebars for a self-driven quad adventure on the peninsula''s dirt trails.', 'Bodrum Peninsula Hinterland, Türkiye',
   '3 Hours - Half Day', '10:00 AM & 14:00 PM, Daily', '13:00 PM / 17:00 PM',
   'ATV Base Camp (hotel pick-up available)',
   '["If the Jeep Safari is about the view, the ATV Safari is about the driving. After a short safety briefing, you''ll take the handlebars of your own quad bike and follow your guide along dusty trails, forest tracks and open countryside on the edge of the peninsula.", "It''s an active, hands-on couple of hours - single or double-seat quads are available, so it works well for solo adventurers and couples alike. A short rest stop lets you catch your breath and take photos before the final stretch back to base."]'::jsonb, '["Self-driven quad bike, no licence required", "Guided convoy along forest and dirt trails", "Single and double-seat quads available", "Safety briefing and helmet provided", "Scenic rest stop mid-route", "Compact half-day format"]'::jsonb,
   '["Quad bike rental for the route", "Helmet and safety equipment", "Safety briefing and practice lap", "English-speaking guide", "Hotel pick-up and drop-off", "Bottled water"]'::jsonb, '["Fuel surcharge on longer routes (rare, advised in advance)", "Personal expenses", "Photos/video package (available to purchase)", "Gratuities for the guide"]'::jsonb,
   '[{"time": "09:30", "title": "Hotel Pick-up", "text": "Collection from your hotel and transfer to base camp."}, {"time": "10:00", "title": "Safety Briefing", "text": "Quad controls and safety rules explained, plus a short practice lap."}, {"time": "10:20", "title": "Guided Ride", "text": "Follow your guide along forest and countryside trails."}, {"time": "11:15", "title": "Rest Stop", "text": "A short break for water and photos at a scenic point."}, {"time": "12:40", "title": "Return to Base", "text": "The convoy returns to base camp and you''re transferred to your hotel."}]'::jsonb, '[{"q": "Do I need a driving licence for the ATV Safari?", "a": "No licence is required for the quad bikes used on this tour, but you must be at least 16 to drive (younger guests can ride as a passenger with an adult)."}, {"q": "Can two people share one quad?", "a": "Yes, double-seat quads are available for couples or a parent and child - let us know your preference when booking."}, {"q": "What should I wear?", "a": "Closed-toe shoes, sunglasses and clothes you don''t mind getting dusty are recommended. Helmets are provided."}, {"q": "Is the ATV Safari physically demanding?", "a": "It''s moderately active - you''ll be steering and controlling the throttle yourself - but no prior experience is needed."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'atv-safari'), 'de',
   'ATV-Safari', 'Übernehmen Sie das Lenkrad für ein selbstgefahrenes Quad-Abenteuer auf den Feldwegen der Halbinsel.', 'Hinterland der Bodrum-Halbinsel, Türkei',
   '3 Stunden - Halbtägig', '10:00 und 14:00 Uhr, täglich', '13:00 / 17:00 Uhr',
   'ATV-Basislager (Hotelabholung verfügbar)',
   '["Geht es bei der Jeep-Safari um die Aussicht, so geht es bei der ATV-Safari ums Fahren. Nach einer kurzen Sicherheitseinweisung übernehmen Sie das Lenkrad Ihres eigenen Quads und folgen Ihrem Guide über staubige Pfade, Waldwege und offenes Gelände am Rand der Halbinsel.", "Es sind ein paar aktive, praxisnahe Stunden - Ein- und Zweisitzer-Quads sind verfügbar, sodass sich das Angebot sowohl für Alleinreisende als auch für Paare eignet. Ein kurzer Rastplatz lässt Sie verschnaufen und Fotos machen, bevor es zurück zur Basis geht."]'::jsonb, '["Selbstgefahrenes Quad, kein Führerschein erforderlich", "Geführter Konvoi über Wald- und Feldwege", "Ein- und Zweisitzer-Quads verfügbar", "Sicherheitseinweisung und Helm inbegriffen", "Malerischer Rastplatz auf halber Strecke", "Kompaktes Halbtagesformat"]'::jsonb,
   '["Quad-Vermietung für die Strecke", "Helm und Sicherheitsausrüstung", "Sicherheitseinweisung und Proberunde", "Englischsprachiger Guide", "Hotelabholung und -rückbringung", "Flaschenwasser"]'::jsonb, '["Treibstoffzuschlag bei längeren Strecken (selten, wird vorab mitgeteilt)", "Persönliche Ausgaben", "Foto-/Videopaket (käuflich)", "Trinkgeld für den Guide"]'::jsonb,
   '[{"time": "09:30", "title": "Hotelabholung", "text": "Abholung von Ihrem Hotel und Transfer zum Basislager."}, {"time": "10:00", "title": "Sicherheitseinweisung", "text": "Erklärung der Quad-Steuerung und Sicherheitsregeln sowie eine kurze Proberunde."}, {"time": "10:20", "title": "Geführte Fahrt", "text": "Folgen Sie Ihrem Guide über Wald- und Landschaftswege."}, {"time": "11:15", "title": "Rastplatz", "text": "Kurze Pause für Wasser und Fotos an einem malerischen Punkt."}, {"time": "12:40", "title": "Rückkehr zur Basis", "text": "Der Konvoi kehrt zum Basislager zurück, Transfer zu Ihrem Hotel."}]'::jsonb, '[{"q": "Brauche ich einen Führerschein für die ATV-Safari?", "a": "Für die bei dieser Tour genutzten Quads ist kein Führerschein erforderlich, das Mindestalter zum Fahren liegt jedoch bei 16 Jahren (jüngere Gäste können als Beifahrer mit einem Erwachsenen mitfahren)."}, {"q": "Können sich zwei Personen ein Quad teilen?", "a": "Ja, Zweisitzer-Quads sind für Paare oder Elternteil und Kind verfügbar - teilen Sie uns Ihre Präferenz bei der Buchung mit."}, {"q": "Was sollte ich anziehen?", "a": "Geschlossene Schuhe, eine Sonnenbrille und Kleidung, deren Verschmutzung Ihnen nichts ausmacht, werden empfohlen. Helme werden gestellt."}, {"q": "Ist die ATV-Safari körperlich anstrengend?", "a": "Sie ist mäßig aktiv - Sie lenken und geben selbst Gas - aber Vorerfahrung ist nicht nötig."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'atv-safari'), 'ru',
   'АТВ-сафари', 'Возьмитесь за руль для самостоятельного приключения на квадроцикле по грунтовым тропам полуострова.', 'Внутренние районы полуострова Бодрум, Турция',
   '3 часа - полдня', '10:00 и 14:00, ежедневно', '13:00 / 17:00',
   'Базовый лагерь АТВ (трансфер от отеля доступен)',
   '["Если джип-сафари - это про виды, то АТВ-сафари - про саму езду. После короткого инструктажа по безопасности вы сядете за руль собственного квадроцикла и последуете за гидом по пыльным тропам, лесным дорогам и открытой местности на краю полуострова.", "Вас ждут пара активных, насыщенных часов - доступны одно- и двухместные квадроциклы, поэтому вариант подходит как для одиночных путешественников, так и для пар. Короткая остановка для отдыха позволит перевести дух и сделать фото перед последним отрезком пути обратно на базу."]'::jsonb, '["Самостоятельное вождение квадроцикла, права не требуются", "Конвой с гидом по лесным и грунтовым тропам", "Доступны одно- и двухместные квадроциклы", "Инструктаж по безопасности и шлем включены", "Живописная остановка на середине маршрута", "Компактный формат на полдня"]'::jsonb,
   '["Аренда квадроцикла на маршрут", "Шлем и защитное снаряжение", "Инструктаж по безопасности и пробный круг", "Англоговорящий гид", "Трансфер от отеля и обратно", "Питьевая вода"]'::jsonb, '["Доплата за топливо на более длинных маршрутах (редко, сообщается заранее)", "Личные расходы", "Фото/видео пакет (можно приобрести)", "Чаевые гиду"]'::jsonb,
   '[{"time": "09:30", "title": "Трансфер из отеля", "text": "Забираем вас из отеля и везём в базовый лагерь."}, {"time": "10:00", "title": "Инструктаж по безопасности", "text": "Объяснение управления квадроциклом и правил безопасности, короткий пробный круг."}, {"time": "10:20", "title": "Поездка с гидом", "text": "Следуйте за гидом по лесным и природным тропам."}, {"time": "11:15", "title": "Остановка для отдыха", "text": "Короткий перерыв на воду и фото в живописном месте."}, {"time": "12:40", "title": "Возвращение на базу", "text": "Конвой возвращается в базовый лагерь, трансфер в отель."}]'::jsonb, '[{"q": "Нужны ли водительские права для АТВ-сафари?", "a": "Для квадроциклов, используемых в этом туре, права не нужны, но для управления необходимо быть не младше 16 лет (более юные гости могут ехать пассажирами со взрослым)."}, {"q": "Могут ли два человека разделить один квадроцикл?", "a": "Да, для пар или родителя с ребёнком доступны двухместные квадроциклы - сообщите о своих предпочтениях при бронировании."}, {"q": "Что надеть?", "a": "Рекомендуется закрытая обувь, солнцезащитные очки и одежда, которую не жалко испачкать. Шлемы предоставляются."}, {"q": "АТВ-сафари физически тяжёлое?", "a": "Оно умеренно активное - вы сами управляете рулём и газом - но предварительный опыт не требуется."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'atv-safari'), 'pl',
   'ATV Safari', 'Chwyćcie za kierownicę podczas samodzielnej przygody quadem na polnych szlakach półwyspu.', 'Zaplecze Półwyspu Bodrum, Turcja',
   '3 godziny - Pół dnia', '10:00 i 14:00, codziennie', '13:00 / 17:00',
   'Obóz bazowy ATV (odbiór z hotelu dostępny)',
   '["Jeśli Jeep Safari to widoki, to ATV Safari to jazda. Po krótkim instruktażu bezpieczeństwa chwycicie za kierownicę własnego quada i podążycie za przewodnikiem po zakurzonych szlakach, leśnych drogach i otwartym terenie na skraju półwyspu.", "Czekają Was aktywne, praktyczne godziny - dostępne są quady jedno- i dwuosobowe, więc opcja sprawdzi się zarówno dla samotnych podróżników, jak i par. Krótki postój pozwoli złapać oddech i zrobić zdjęcia przed ostatnim odcinkiem powrotu do bazy."]'::jsonb, '["Samodzielna jazda quadem, prawo jazdy niewymagane", "Konwój z przewodnikiem po leśnych i polnych szlakach", "Dostępne quady jedno- i dwuosobowe", "Instruktaż bezpieczeństwa i kask w cenie", "Malowniczy postój w połowie trasy", "Kompaktowy format na pół dnia"]'::jsonb,
   '["Wynajem quada na trasę", "Kask i sprzęt ochronny", "Instruktaż bezpieczeństwa i okrążenie próbne", "Anglojęzyczny przewodnik", "Odbiór i powrót z hotelu", "Woda butelkowana"]'::jsonb, '["Dopłata paliwowa przy dłuższych trasach (rzadko, zgłaszana wcześniej)", "Wydatki osobiste", "Pakiet foto/wideo (do kupienia)", "Napiwek dla przewodnika"]'::jsonb,
   '[{"time": "09:30", "title": "Odbiór z hotelu", "text": "Odbiór z hotelu i transfer do obozu bazowego."}, {"time": "10:00", "title": "Instruktaż bezpieczeństwa", "text": "Wyjaśnienie sterowania quadem i zasad bezpieczeństwa oraz krótkie okrążenie próbne."}, {"time": "10:20", "title": "Przejazd z przewodnikiem", "text": "Podążajcie za przewodnikiem po leśnych i wiejskich szlakach."}, {"time": "11:15", "title": "Postój na odpoczynek", "text": "Krótka przerwa na wodę i zdjęcia w malowniczym miejscu."}, {"time": "12:40", "title": "Powrót do bazy", "text": "Konwój wraca do obozu bazowego, transfer do hotelu."}]'::jsonb, '[{"q": "Czy do ATV Safari potrzebne jest prawo jazdy?", "a": "Do quadów używanych w tej wycieczce prawo jazdy nie jest wymagane, ale aby prowadzić, trzeba mieć ukończone 16 lat (młodsi goście mogą jechać jako pasażerowie z dorosłym)."}, {"q": "Czy dwie osoby mogą jechać jednym quadem?", "a": "Tak, dla par lub rodzica z dzieckiem dostępne są quady dwuosobowe - proszę zaznaczyć preferencję przy rezerwacji."}, {"q": "Co powinienem/powinnam założyć?", "a": "Zalecane jest zamknięte obuwie, okulary przeciwsłoneczne i ubranie, którego nie szkoda zakurzyć. Kaski są zapewnione."}, {"q": "Czy ATV Safari jest wymagające fizycznie?", "a": "Jest umiarkowanie aktywne - sami sterujecie i obsługujecie gaz - ale wcześniejsze doświadczenie nie jest wymagane."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'horse-riding'), 'tr',
   'Atlı Doğa Turu', 'Bodrum yakınlarındaki kırsalda ve kıyı boyunca, yeni başlayanlara uygun rehberli bir binicilik turu.', 'Bodrum Kırsalı, Türkiye',
   '2 Saat', '09:00 ve 17:00, Her Gün', '11:00 / 19:00',
   'Binicilik ahırı, otel alış hizmeti mevcuttur',
   '["Bu rehberli doğa turu, tamamen yeni başlayanlar dahil her seviyeden binici için tasarlanmıştır. Atınızla kısa bir tanışma ve temel kontrol bilgisinin ardından rehberiniz grubu zeytin bahçeleri ve açık kırsal alan boyunca sakin bir tempoda yönlendirir; yol boyunca sık sık Ege manzarası eşlik eder.", "Akşam seansı, yumuşak ışığı ve serin sıcaklığıyla özellikle popülerdir; her iki rota da attan inip esneme ve fotoğraf çekme molası içerir. Atlar, konfor ve güven için binicilerin deneyim seviyesine göre eşleştirilir."]'::jsonb, '["Tamamen yeni başlayanlar için uygun", "Kırsal ve kıyı boyunca parkur manzaraları", "Sabah veya altın saat akşam seçenekleri", "Deneyim seviyenize göre eşleştirilen atlar", "Kişisel rehberle küçük grup boyutu", "Rota boyunca fotoğraf molası"]'::jsonb,
   '["At ve rehberli doğa turu", "Binicilik kaskı", "Hareketten önce temel binicilik eğitimi", "İngilizce konuşan rehber", "Otel alış ve bırakış hizmeti", "Şişe suyu"]'::jsonb, '["Profesyonel fotoğraf paketi", "Kişisel harcamalar", "Binicilik botları (kapalı ayakkabı gerekli, kendiniz getirin)", "Rehber için bahşiş"]'::jsonb,
   '[{"time": "08:30", "title": "Otelden Alış", "text": "Otelinizden alınıp ahıra transfer edilirsiniz."}, {"time": "09:00", "title": "Atınızla Tanışma", "text": "Kısa bir güvenlik brifingi ve at kontrolüne giriş."}, {"time": "09:20", "title": "Rehberli Doğa Turu", "text": "Zeytin bahçeleri ve açık kırsal alan boyunca binersiniz."}, {"time": "10:15", "title": "Fotoğraf Molası", "text": "Attan inip kısa bir mola, esneme ve fotoğraf zamanı."}, {"time": "10:45", "title": "Ahıra Dönüş", "text": "Ahıra geri dönülür ve otelinize transfer edilirsiniz."}]'::jsonb, '[{"q": "Binicilik deneyimim olması gerekir mi?", "a": "Hayır, bu tur hem tamamen yeni başlayanları hem de deneyimli binicileri ağırlar - atlar ve tempo buna göre ayarlanır."}, {"q": "Kilo veya yaş sınırı var mı?", "a": "Biniciler genellikle en az 8 yaşında olmalıdır; sizi doğru atla eşleştirebilmemiz için özel kilo veya sağlık sorularınızı önceden bize iletin."}, {"q": "Ne giymeliyim?", "a": "Kapalı ayakkabı ve rahat pantolon önerilir. Binicilik kaskı tarafımızca sağlanır."}, {"q": "Sabah mı akşam mı seansı daha iyi?", "a": "İkisi de güzeldir - sabahlar daha serin ve sakindir, akşam seansı ise özellikle fotoğraflar için hoş, yumuşak bir altın ışık sunar."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'horse-riding'), 'en',
   'Horse Riding Tour', 'A guided trail ride through countryside and along the coastline near Bodrum, suited to beginners.', 'Bodrum Countryside, Türkiye',
   '2 Hours', '09:00 AM & 17:00 PM, Daily', '11:00 AM / 19:00 PM',
   'Riding stable, hotel pick-up available',
   '["This guided trail ride is designed for riders of every level, including complete beginners. After a short introduction to your horse and basic handling, your guide leads the group at a gentle pace through olive groves and open countryside, with the Aegean often in view along the way.", "The evening slot is especially popular for its softer light and cooler temperatures, and both routes include a stop to dismount, stretch and take photos before heading back. Horses are matched to riders'' experience level for comfort and confidence."]'::jsonb, '["Suitable for complete beginners", "Countryside and coastal trail views", "Morning or golden-hour evening time slots", "Horses matched to your experience level", "Small group sizes with a personal guide", "Photo stop along the route"]'::jsonb,
   '["Horse and guided trail ride", "Riding helmet", "Basic riding instruction before departure", "English-speaking guide", "Hotel pick-up and drop-off", "Bottled water"]'::jsonb, '["Professional photography package", "Personal expenses", "Riding boots (closed shoes required, bring your own)", "Gratuities for the guide"]'::jsonb,
   '[{"time": "08:30", "title": "Hotel Pick-up", "text": "Collection from your hotel and transfer to the stable."}, {"time": "09:00", "title": "Meet Your Horse", "text": "A short safety briefing and introduction to handling your horse."}, {"time": "09:20", "title": "Guided Trail Ride", "text": "Ride out through olive groves and open countryside."}, {"time": "10:15", "title": "Photo Stop", "text": "Dismount for a short break, stretch and photos."}, {"time": "10:45", "title": "Return to Stable", "text": "Ride back to the stable and transfer to your hotel."}]'::jsonb, '[{"q": "Do I need riding experience?", "a": "No, this tour welcomes complete beginners as well as experienced riders - horses and pacing are adjusted accordingly."}, {"q": "What is the weight or age limit?", "a": "Riders should generally be at least 8 years old; please contact us in advance with specific weight or health questions so we can match you with the right horse."}, {"q": "What should I wear?", "a": "Closed-toe shoes and comfortable trousers are recommended. A riding helmet is provided."}, {"q": "Which time slot is better, morning or evening?", "a": "Both are lovely - mornings are cooler and quieter, while the evening slot offers softer golden light, especially nice for photos."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'horse-riding'), 'de',
   'Reittour', 'Ein geführter Ausritt durch die Landschaft und die Küste bei Bodrum, geeignet für Anfänger.', 'Bodrum-Umland, Türkei',
   '2 Stunden', '09:00 und 17:00 Uhr, täglich', '11:00 / 19:00 Uhr',
   'Reitstall (Hotelabholung verfügbar)',
   '["Dieser geführte Ausritt ist für Reiter jeden Niveaus konzipiert, auch für absolute Anfänger. Nach einer kurzen Einführung in Ihr Pferd und den grundlegenden Umgang führt Ihr Guide die Gruppe in gemächlichem Tempo durch Olivenhaine und offene Landschaft, häufig mit Blick auf die Ägäis.", "Der Abendtermin ist besonders beliebt wegen seines weichen Lichts und der kühleren Temperaturen, und beide Routen beinhalten einen Halt zum Absteigen, Dehnen und Fotografieren, bevor es zurückgeht. Die Pferde werden dem Erfahrungsniveau der Reiter entsprechend zugeteilt, um Komfort und Sicherheit zu gewährleisten."]'::jsonb, '["Geeignet für absolute Anfänger", "Landschafts- und Küstenausblicke entlang der Route", "Vormittags- oder goldene Abendstunden-Termine", "Pferde passend zu Ihrem Erfahrungsniveau", "Kleine Gruppengröße mit persönlichem Guide", "Fotostopp entlang der Route"]'::jsonb,
   '["Pferd und geführter Ausritt", "Reithelm", "Grundlegende Reitanleitung vor dem Start", "Englischsprachiger Guide", "Hotelabholung und -rückbringung", "Flaschenwasser"]'::jsonb, '["Professionelles Fotopaket", "Persönliche Ausgaben", "Reitstiefel (geschlossene Schuhe erforderlich, bitte mitbringen)", "Trinkgeld für den Guide"]'::jsonb,
   '[{"time": "08:30", "title": "Hotelabholung", "text": "Abholung von Ihrem Hotel und Transfer zum Stall."}, {"time": "09:00", "title": "Treffen mit Ihrem Pferd", "text": "Kurze Sicherheitseinweisung und Einführung in die Handhabung Ihres Pferdes."}, {"time": "09:20", "title": "Geführter Ausritt", "text": "Reiten Sie durch Olivenhaine und offene Landschaft."}, {"time": "10:15", "title": "Fotostopp", "text": "Absteigen für eine kurze Pause, Dehnen und Fotos."}, {"time": "10:45", "title": "Rückkehr zum Stall", "text": "Rückritt zum Stall und Transfer zu Ihrem Hotel."}]'::jsonb, '[{"q": "Brauche ich Reiterfahrung?", "a": "Nein, diese Tour heißt sowohl absolute Anfänger als auch erfahrene Reiter willkommen - Pferde und Tempo werden entsprechend angepasst."}, {"q": "Gibt es eine Gewichts- oder Altersgrenze?", "a": "Reiter sollten im Allgemeinen mindestens 8 Jahre alt sein; bitte kontaktieren Sie uns vorab bei speziellen Fragen zu Gewicht oder Gesundheit, damit wir das passende Pferd zuteilen können."}, {"q": "Was sollte ich anziehen?", "a": "Geschlossene Schuhe und bequeme Hosen werden empfohlen. Ein Reithelm wird gestellt."}, {"q": "Welcher Termin ist besser, morgens oder abends?", "a": "Beide sind schön - Morgende sind kühler und ruhiger, während der Abendtermin weicheres, goldenes Licht bietet, besonders schön für Fotos."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'horse-riding'), 'ru',
   'Конная прогулка', 'Конная прогулка с гидом по сельской местности и побережью недалеко от Бодрума, подходит для новичков.', 'Окрестности Бодрума, Турция',
   '2 часа', '09:00 и 17:00, ежедневно', '11:00 / 19:00',
   'Конюшня (трансфер от отеля доступен)',
   '["Эта конная прогулка с гидом рассчитана на всадников любого уровня, включая полных новичков. После короткого знакомства с лошадью и базовыми навыками управления гид ведёт группу спокойным темпом через оливковые рощи и открытую местность, часто с видом на Эгейское море.", "Вечерний сеанс особенно популярен благодаря мягкому свету и более прохладной температуре, оба маршрута включают остановку, чтобы спешиться, размяться и сделать фото перед возвращением. Лошади подбираются в соответствии с опытом всадников для комфорта и уверенности."]'::jsonb, '["Подходит для полных новичков", "Виды на сельскую местность и побережье вдоль маршрута", "Утренние или вечерние сеансы в золотой час", "Лошади подобраны по вашему уровню опыта", "Небольшая группа с персональным гидом", "Остановка для фото по маршруту"]'::jsonb,
   '["Лошадь и конная прогулка с гидом", "Шлем для верховой езды", "Базовый инструктаж перед выездом", "Англоговорящий гид", "Трансфер от отеля и обратно", "Питьевая вода"]'::jsonb, '["Профессиональный фотопакет", "Личные расходы", "Сапоги для верховой езды (нужна закрытая обувь, возьмите свою)", "Чаевые гиду"]'::jsonb,
   '[{"time": "08:30", "title": "Трансфер из отеля", "text": "Забираем вас из отеля и везём на конюшню."}, {"time": "09:00", "title": "Знакомство с лошадью", "text": "Короткий инструктаж по безопасности и знакомство с управлением лошадью."}, {"time": "09:20", "title": "Конная прогулка с гидом", "text": "Прогулка верхом через оливковые рощи и открытую местность."}, {"time": "10:15", "title": "Остановка для фото", "text": "Спешивание для короткого отдыха, разминки и фото."}, {"time": "10:45", "title": "Возвращение на конюшню", "text": "Возвращение на конюшню и трансфер в отель."}]'::jsonb, '[{"q": "Нужен ли мне опыт верховой езды?", "a": "Нет, этот тур подходит как полным новичкам, так и опытным всадникам - лошади и темп подбираются соответственно."}, {"q": "Есть ли ограничения по весу или возрасту?", "a": "Всадникам обычно должно быть не менее 8 лет; пожалуйста, свяжитесь с нами заранее по вопросам веса или здоровья, чтобы мы могли подобрать подходящую лошадь."}, {"q": "Что надеть?", "a": "Рекомендуется закрытая обувь и удобные брюки. Шлем для верховой езды предоставляется."}, {"q": "Какой сеанс лучше - утренний или вечерний?", "a": "Оба хороши - утром прохладнее и спокойнее, а вечерний сеанс дарит более мягкий золотистый свет, особенно приятный для фото."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'horse-riding'), 'pl',
   'Przejażdżka Konna', 'Przejażdżka konna z przewodnikiem przez wiejskie tereny i wybrzeże w pobliżu Bodrum, odpowiednia dla początkujących.', 'Okolice Bodrum, Turcja',
   '2 godziny', '09:00 i 17:00, codziennie', '11:00 / 19:00',
   'Stajnia (odbiór z hotelu dostępny)',
   '["Ta przejażdżka konna z przewodnikiem jest zaprojektowana dla jeźdźców każdego poziomu, w tym całkowitych początkujących. Po krótkim wprowadzeniu do obsługi konia przewodnik prowadzi grupę spokojnym tempem przez gaje oliwne i otwarty teren, często z widokiem na Morze Egejskie.", "Sesja wieczorna jest szczególnie popularna ze względu na miękkie światło i chłodniejszą temperaturę, a obie trasy obejmują postój na zsiadanie z konia, rozciąganie i zdjęcia przed powrotem. Konie są dobierane do poziomu doświadczenia jeźdźców dla komfortu i pewności siebie."]'::jsonb, '["Odpowiednie dla całkowitych początkujących", "Widoki na wiejskie tereny i wybrzeże wzdłuż trasy", "Sesje poranne lub o złotej godzinie wieczorem", "Konie dobrane do Państwa poziomu doświadczenia", "Niewielka grupa z osobistym przewodnikiem", "Postój na zdjęcia wzdłuż trasy"]'::jsonb,
   '["Koń i przejażdżka z przewodnikiem", "Kask jeździecki", "Podstawowy instruktaż jazdy przed wyjazdem", "Anglojęzyczny przewodnik", "Odbiór i powrót z hotelu", "Woda butelkowana"]'::jsonb, '["Profesjonalny pakiet fotograficzny", "Wydatki osobiste", "Buty jeździeckie (wymagane zamknięte obuwie, proszę zabrać własne)", "Napiwek dla przewodnika"]'::jsonb,
   '[{"time": "08:30", "title": "Odbiór z hotelu", "text": "Odbiór z hotelu i transfer do stajni."}, {"time": "09:00", "title": "Poznanie konia", "text": "Krótki instruktaż bezpieczeństwa i wprowadzenie do obsługi konia."}, {"time": "09:20", "title": "Przejażdżka z przewodnikiem", "text": "Jazda przez gaje oliwne i otwarty teren."}, {"time": "10:15", "title": "Postój na zdjęcia", "text": "Zsiadanie z konia na krótką przerwę, rozciąganie i zdjęcia."}, {"time": "10:45", "title": "Powrót do stajni", "text": "Powrót do stajni i transfer do hotelu."}]'::jsonb, '[{"q": "Czy potrzebne jest doświadczenie jeździeckie?", "a": "Nie, ta wycieczka jest odpowiednia zarówno dla całkowitych początkujących, jak i doświadczonych jeźdźców - konie i tempo są odpowiednio dostosowywane."}, {"q": "Czy istnieje limit wagowy lub wiekowy?", "a": "Jeźdźcy powinni mieć zazwyczaj co najmniej 8 lat; prosimy o wcześniejszy kontakt w sprawie wagi lub zdrowia, abyśmy mogli dobrać odpowiedniego konia."}, {"q": "Co powinienem/powinnam założyć?", "a": "Zalecane jest zamknięte obuwie i wygodne spodnie. Kask jeździecki jest zapewniony."}, {"q": "Która sesja jest lepsza - poranna czy wieczorna?", "a": "Obie są piękne - poranki są chłodniejsze i spokojniejsze, natomiast sesja wieczorna oferuje miękkie, złote światło, szczególnie efektowne na zdjęciach."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'scuba-diving'), 'tr',
   'Tüplü Dalış Deneyimi', 'Ege''yi su altında keşfedin - yeni başlayanlara uygun deneme dalışı veya sertifikalı dalıcılar için rehberli dalış.', 'Bodrum Yarımadası Dalış Noktaları, Türkiye',
   '4 Saat - Yarım Gün', '09:30, Her Gün (Hava Durumuna Bağlı)', '13:30',
   'Bodrum Marina''daki dalış merkezi',
   '["Bodrum''un berrak suları ve yumuşak su altı arazisi, onu Türkiye''de ilk kez dalış denemek için en popüler yerlerden biri yapar - sertifikalı dalıcılar için de ödüllendirici bir noktadır. İlk kez dalanlar ''deneme dalışı'' tarzı bir seansa katılır: karada kısa bir brifing, ardından bir eğitmenin sürekli yanınızda olduğu, tamamen gözetim altında sığ bir dalış.", "Sertifikalı dalıcılar, resif canlılarının bulunduğu daha derin noktalara rehberli dalışa katılabilir; koşullara bağlı olarak ahtapot, deniz yılanı balığı ve mercan balığı sürüleri görme şansı da vardır. Tüm ekipman sağlanır ve her dalışa lisanslı bir eğitmen eşlik eder."]'::jsonb, '["Deneyim gerektirmeyen, yeni başlayanlara uygun deneme dalışı", "Sertifikalı dalıcılar için rehberli dalış seçeneği", "Lisanslı eğitmenle küçük gruplar", "Tam ekipman sağlanır", "Berrak Ege görüş mesafesi", "Su altı fotoğraf fırsatları"]'::jsonb,
   '["Tam dalış ekipmanı (dalış elbisesi, tüp, regülatör, maske, palet)", "Lisanslı eğitmen ve güvenlik brifingi", "Dalış noktasına tekne transferi", "Bir dalış (sertifikanıza göre deneme veya rehberli)", "Otel alış ve bırakış hizmeti", "Şişe suyu ve havlu"]'::jsonb, '["PADI veya SSI sertifika kursu (ayrı olarak sunulur)", "Su altı fotoğraf/video paketi (satın alınabilir)", "İkinci dalış eklentisi", "Eğitmen için bahşiş"]'::jsonb,
   '[{"time": "09:00", "title": "Otelden Alış", "text": "Otelinizden alınıp dalış merkezine transfer edilirsiniz."}, {"time": "09:30", "title": "Brifing ve Ekipman", "text": "Eğitmeninizle güvenlik brifingi ve ekipman ayarlama."}, {"time": "10:15", "title": "Tekne Transferi", "text": "Dalış noktasına kısa bir tekne yolculuğu."}, {"time": "10:45", "title": "Dalış", "text": "Baştan sona tam gözetim altında sığ deneme veya rehberli dalış."}, {"time": "12:30", "title": "Dönüş", "text": "Marinaya tekneyle dönüş ve otelinize transfer."}]'::jsonb, '[{"q": "Katılmak için dalış deneyimim olması gerekir mi?", "a": "Hayır, deneme dalışı tamamen yeni başlayanlar için tasarlanmıştır ve sığ derinlikte lisanslı bir eğitmenin tam gözetimini içerir."}, {"q": "Zaten sertifikalı bir dalıcıysam ne olur?", "a": "Sertifikalı dalıcılar daha derin bir noktaya rehberli dalışa katılabilir - rezervasyon yaparken sertifika kartınızı getirmeniz yeterlidir."}, {"q": "İyi yüzemeyenler için güvenli mi?", "a": "Temel su konforu faydalıdır, ancak deneme dalışı yakından gözetim altındadır ve tam yüzdürme ekipmanı kullanır, bu yüzden güçlü yüzme becerisi gerekmez."}, {"q": "Tüplü dalış için minimum yaş nedir?", "a": "Deneme dalışı genellikle 10 yaş ve üzeri için mevcuttur; rezervasyon yaparken genç dalıcıların yaşını belirtmenizi rica ederiz."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'scuba-diving'), 'en',
   'Scuba Diving Experience', 'Discover the Aegean underwater on a beginner-friendly trial dive or a guided dive for certified divers.', 'Bodrum Peninsula Dive Sites, Türkiye',
   '4 Hours - Half Day', '09:30 AM, Daily (Weather Permitting)', '13:30 PM',
   'Dive centre at Bodrum Marina',
   '["Bodrum''s clear water and gentle underwater terrain make it one of Turkey''s most popular places to try diving for the first time - and a rewarding spot for certified divers too. First-timers join a ''discover scuba'' style session: a short briefing on land, then a shallow, fully supervised dive with an instructor by your side the whole time.", "Certified divers can join a guided dive to deeper sites with reef life and, depending on conditions, the chance to spot octopus, moray eels and schools of bream. All equipment is provided and every dive is led by a licensed instructor."]'::jsonb, '["Beginner-friendly trial dive, no experience required", "Guided dives available for certified divers", "Small groups with a licensed instructor", "Full equipment provided", "Clear Aegean visibility", "Underwater photo opportunities"]'::jsonb,
   '["Full scuba equipment (wetsuit, tank, regulator, mask, fins)", "Licensed instructor and safety briefing", "Boat transfer to the dive site", "One dive (trial or guided, depending on certification)", "Hotel pick-up and drop-off", "Bottled water and towel"]'::jsonb, '["PADI or SSI certification course (available separately)", "Underwater photo/video package (available to purchase)", "Second dive add-on", "Gratuities for the instructor"]'::jsonb,
   '[{"time": "09:00", "title": "Hotel Pick-up", "text": "Collection from your hotel and transfer to the dive centre."}, {"time": "09:30", "title": "Briefing & Kitting Up", "text": "Safety briefing and equipment fitting with your instructor."}, {"time": "10:15", "title": "Boat Transfer", "text": "Short boat ride out to the dive site."}, {"time": "10:45", "title": "The Dive", "text": "A shallow trial dive or guided dive, fully supervised throughout."}, {"time": "12:30", "title": "Return", "text": "Boat back to the marina and transfer to your hotel."}]'::jsonb, '[{"q": "Do I need diving experience to join?", "a": "No, the trial dive is designed for complete beginners and includes full supervision from a licensed instructor at shallow depth."}, {"q": "What if I''m already a certified diver?", "a": "Certified divers can join a guided dive to a deeper site - just bring your certification card when booking."}, {"q": "Is it safe for people who can''t swim well?", "a": "Basic water comfort is helpful, but the trial dive is closely supervised and uses full buoyancy equipment, so strong swimming ability isn''t required."}, {"q": "What''s the minimum age for scuba diving?", "a": "The trial dive is generally available from age 10 and up; please mention the age of any young divers when booking."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'scuba-diving'), 'de',
   'Tauch-Erlebnis', 'Entdecken Sie die Ägäis unter Wasser bei einem anfängerfreundlichen Schnuppertauchgang oder einem geführten Tauchgang für zertifizierte Taucher.', 'Tauchplätze der Bodrum-Halbinsel, Türkei',
   '4 Stunden - Halbtägig', '09:30 Uhr, täglich (wetterabhängig)', '13:30 Uhr',
   'Tauchzentrum an der Bodrum Marina',
   '["Bodrums klares Wasser und sanftes Unterwasserterrain machen es zu einem der beliebtesten Orte der Türkei, um das Tauchen zum ersten Mal auszuprobieren - und auch für zertifizierte Taucher ein lohnender Ort. Einsteiger nehmen an einer ''Schnuppertauch''-Sitzung teil: eine kurze Einweisung an Land, dann ein flacher, vollständig betreuter Tauchgang mit einem Instruktor stets an Ihrer Seite.", "Zertifizierte Taucher können an einem geführten Tauchgang zu tieferen Riffgebieten teilnehmen und je nach Bedingungen die Chance haben, Oktopusse, Muränen und Brassenschwärme zu entdecken. Die gesamte Ausrüstung wird gestellt, und jeder Tauchgang wird von einem lizenzierten Instruktor geleitet."]'::jsonb, '["Anfängerfreundlicher Schnuppertauchgang, keine Erfahrung nötig", "Geführte Tauchgänge für zertifizierte Taucher verfügbar", "Kleine Gruppen mit lizenziertem Instruktor", "Vollständige Ausrüstung inbegriffen", "Klare Sichtweiten der Ägäis", "Unterwasser-Fotomöglichkeiten"]'::jsonb,
   '["Vollständige Tauchausrüstung (Anzug, Flasche, Regler, Maske, Flossen)", "Lizenzierter Instruktor und Sicherheitseinweisung", "Bootstransfer zum Tauchplatz", "Ein Tauchgang (Schnupper- oder geführter Tauchgang je nach Zertifizierung)", "Hotelabholung und -rückbringung", "Flaschenwasser und Handtuch"]'::jsonb, '["PADI- oder SSI-Zertifizierungskurs (separat erhältlich)", "Unterwasser-Foto-/Videopaket (käuflich)", "Zweiter Tauchgang als Zusatz", "Trinkgeld für den Instruktor"]'::jsonb,
   '[{"time": "09:00", "title": "Hotelabholung", "text": "Abholung von Ihrem Hotel und Transfer zum Tauchzentrum."}, {"time": "09:30", "title": "Einweisung und Ausrüstung", "text": "Sicherheitseinweisung und Anpassung der Ausrüstung mit Ihrem Instruktor."}, {"time": "10:15", "title": "Bootstransfer", "text": "Kurze Bootsfahrt zum Tauchplatz."}, {"time": "10:45", "title": "Der Tauchgang", "text": "Ein flacher Schnupper- oder geführter Tauchgang, durchgehend vollständig betreut."}, {"time": "12:30", "title": "Rückfahrt", "text": "Bootsfahrt zurück zur Marina und Transfer zu Ihrem Hotel."}]'::jsonb, '[{"q": "Brauche ich Taucherfahrung, um teilzunehmen?", "a": "Nein, der Schnuppertauchgang ist für absolute Anfänger konzipiert und beinhaltet vollständige Betreuung durch einen lizenzierten Instruktor in geringer Tiefe."}, {"q": "Was, wenn ich bereits zertifizierter Taucher bin?", "a": "Zertifizierte Taucher können an einem geführten Tauchgang zu einem tieferen Platz teilnehmen - bringen Sie einfach Ihre Zertifizierungskarte zur Buchung mit."}, {"q": "Ist es sicher für Personen, die nicht gut schwimmen können?", "a": "Grundlegende Wassersicherheit ist hilfreich, aber der Schnuppertauchgang wird eng betreut und nutzt vollständige Auftriebsausrüstung, sodass starke Schwimmfähigkeiten nicht erforderlich sind."}, {"q": "Was ist das Mindestalter für Tauchen?", "a": "Der Schnuppertauchgang ist in der Regel ab 10 Jahren möglich; bitte geben Sie bei der Buchung das Alter junger Taucher an."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'scuba-diving'), 'ru',
   'Дайвинг-приключение', 'Откройте для себя подводный мир Эгейского моря - пробный дайвинг для новичков или дайвинг с гидом для сертифицированных дайверов.', 'Места для дайвинга на полуострове Бодрум, Турция',
   '4 часа - полдня', '09:30, ежедневно (по погоде)', '13:30',
   'Дайвинг-центр в марине Бодрума',
   '["Прозрачная вода и мягкий подводный рельеф делают Бодрум одним из самых популярных мест Турции для первого знакомства с дайвингом - и вознаграждающим местом для сертифицированных дайверов. Новички участвуют в сеансе в стиле ''ознакомительного дайвинга'': короткий инструктаж на суше, затем неглубокое погружение под полным контролем инструктора, который постоянно находится рядом с вами.", "Сертифицированные дайверы могут отправиться на дайвинг с гидом к более глубоким рифовым участкам и, в зависимости от условий, увидеть осьминогов, мурен и косяки морских карасей. Всё снаряжение предоставляется, и каждое погружение проводится лицензированным инструктором."]'::jsonb, '["Пробный дайвинг для новичков, опыт не требуется", "Дайвинг с гидом доступен для сертифицированных дайверов", "Небольшие группы с лицензированным инструктором", "Полное снаряжение предоставляется", "Прозрачная видимость Эгейского моря", "Возможности для подводной фотосъёмки"]'::jsonb,
   '["Полное снаряжение для дайвинга (гидрокостюм, баллон, регулятор, маска, ласты)", "Лицензированный инструктор и инструктаж по безопасности", "Трансфер на лодке к месту погружения", "Одно погружение (пробное или с гидом, в зависимости от сертификации)", "Трансфер от отеля и обратно", "Питьевая вода и полотенце"]'::jsonb, '["Курс сертификации PADI или SSI (предлагается отдельно)", "Пакет подводной фото/видеосъёмки (можно приобрести)", "Дополнительное второе погружение", "Чаевые инструктору"]'::jsonb,
   '[{"time": "09:00", "title": "Трансфер из отеля", "text": "Забираем вас из отеля и везём в дайвинг-центр."}, {"time": "09:30", "title": "Инструктаж и снаряжение", "text": "Инструктаж по безопасности и подгонка снаряжения с инструктором."}, {"time": "10:15", "title": "Трансфер на лодке", "text": "Короткая поездка на лодке к месту погружения."}, {"time": "10:45", "title": "Погружение", "text": "Неглубокое пробное или сопровождаемое погружение под полным контролем инструктора."}, {"time": "12:30", "title": "Возвращение", "text": "Возвращение на лодке в марину и трансфер в отель."}]'::jsonb, '[{"q": "Нужен ли опыт дайвинга для участия?", "a": "Нет, пробный дайвинг рассчитан на полных новичков и включает полное сопровождение лицензированного инструктора на небольшой глубине."}, {"q": "Что, если я уже сертифицированный дайвер?", "a": "Сертифицированные дайверы могут отправиться на погружение с гидом в более глубоком месте - просто возьмите с собой сертификационную карту при бронировании."}, {"q": "Безопасно ли это для тех, кто плохо плавает?", "a": "Базовая уверенность в воде полезна, но пробное погружение проходит под пристальным наблюдением и с полным комплектом плавучести, поэтому отличные навыки плавания не требуются."}, {"q": "Какой минимальный возраст для дайвинга?", "a": "Пробное погружение обычно доступно с 10 лет; пожалуйста, укажите возраст юных дайверов при бронировании."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'scuba-diving'), 'pl',
   'Doświadczenie Nurkowania', 'Odkryjcie Morze Egejskie pod wodą podczas próbnego nurkowania dla początkujących lub nurkowania z przewodnikiem dla certyfikowanych nurków.', 'Miejsca do nurkowania na Półwyspie Bodrum, Turcja',
   '4 godziny - Pół dnia', '09:30, codziennie (zależnie od pogody)', '13:30',
   'Centrum nurkowe w Marinie Bodrum',
   '["Czysta woda i łagodny teren podwodny sprawiają, że Bodrum jest jednym z najpopularniejszych miejsc w Turcji do pierwszej próby nurkowania - a także satysfakcjonującym miejscem dla certyfikowanych nurków. Osoby początkujące biorą udział w sesji typu ''odkryj nurkowanie'': krótki instruktaż na lądzie, a następnie płytkie, w pełni nadzorowane nurkowanie z instruktorem stale u Państwa boku.", "Certyfikowani nurkowie mogą wziąć udział w nurkowaniu z przewodnikiem w głębszych miejscach z rafami i, w zależności od warunków, mieć szansę zobaczyć ośmiornice, murenowate i ławice sarg. Cały sprzęt jest zapewniony, a każdemu nurkowaniu przewodzi licencjonowany instruktor."]'::jsonb, '["Próbne nurkowanie dla początkujących, doświadczenie niewymagane", "Nurkowanie z przewodnikiem dostępne dla certyfikowanych nurków", "Małe grupy z licencjonowanym instruktorem", "Pełny sprzęt w cenie", "Krystalicznie czysta widoczność Morza Egejskiego", "Możliwości fotografii podwodnej"]'::jsonb,
   '["Pełny sprzęt do nurkowania (pianka, butla, automat, maska, płetwy)", "Licencjonowany instruktor i instruktaż bezpieczeństwa", "Transfer łodzią na miejsce nurkowania", "Jedno nurkowanie (próbne lub z przewodnikiem, zależnie od certyfikacji)", "Odbiór i powrót z hotelu", "Woda butelkowana i ręcznik"]'::jsonb, '["Kurs certyfikacji PADI lub SSI (dostępny osobno)", "Pakiet zdjęć/wideo podwodnego (do kupienia)", "Dodatkowe drugie nurkowanie", "Napiwek dla instruktora"]'::jsonb,
   '[{"time": "09:00", "title": "Odbiór z hotelu", "text": "Odbiór z hotelu i transfer do centrum nurkowego."}, {"time": "09:30", "title": "Instruktaż i przygotowanie sprzętu", "text": "Instruktaż bezpieczeństwa i dopasowanie sprzętu z instruktorem."}, {"time": "10:15", "title": "Transfer łodzią", "text": "Krótki rejs łodzią do miejsca nurkowania."}, {"time": "10:45", "title": "Nurkowanie", "text": "Płytkie próbne lub prowadzone nurkowanie, przez cały czas w pełni nadzorowane."}, {"time": "12:30", "title": "Powrót", "text": "Powrót łodzią do mariny i transfer do hotelu."}]'::jsonb, '[{"q": "Czy potrzebne jest doświadczenie w nurkowaniu, aby wziąć udział?", "a": "Nie, próbne nurkowanie jest przeznaczone dla całkowitych początkujących i obejmuje pełny nadzór licencjonowanego instruktora na niewielkiej głębokości."}, {"q": "Co jeśli jestem już certyfikowanym nurkiem?", "a": "Certyfikowani nurkowie mogą wziąć udział w nurkowaniu z przewodnikiem w głębszym miejscu - wystarczy zabrać kartę certyfikacyjną na rezerwację."}, {"q": "Czy to bezpieczne dla osób słabo pływających?", "a": "Podstawowa pewność w wodzie jest pomocna, ale próbne nurkowanie jest ściśle nadzorowane i wykorzystuje pełny sprzęt wypornościowy, więc doskonałe umiejętności pływackie nie są wymagane."}, {"q": "Jaki jest minimalny wiek do nurkowania?", "a": "Próbne nurkowanie jest zazwyczaj dostępne od 10 roku życia; prosimy o podanie wieku młodych nurków przy rezerwacji."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dolphin-park'), 'tr',
   'Yunus Parkı Ziyareti', 'Yunus ve deniz aslanı gösterileriyle aile dostu yarım gün, isteğe bağlı suya girme deneyimiyle.', 'Bodrum Yarımadası, Türkiye',
   '3 Saat', '10:00 ve 14:00, Her Gün', '13:00 / 17:00',
   'Bodrum yarımadası genelinde otelden alış',
   '["Yunus Parkı''nda geçirilen bir sabah ya da öğleden sonra, eğlenceli bir gösteriyi daha yakın bir deneyim için suya girme seçeneğiyle birleştiren en popüler aile aktivitelerimizden biridir. Eğitimli yunuslar ve deniz aslanları, bu amaçla inşa edilmiş bir gösteri havuzunda eğiticileriyle birlikte performans sergiler.", "İsteğe bağlı eklentiler, misafirlerin (genellikle 6 yaş civarından itibaren, küçük çocuklar için bazı kısıtlamalarla) personel gözetiminde yunuslarla yüzmesine, dokunmasına veya fotoğraf çekilmesine olanak tanır. Su eklentisi olmadan bile gösterinin kendisi, çocuklar ve yetişkinler için unutulmaz birkaç saat sunar."]'::jsonb, '["Canlı yunus ve deniz aslanı gösterisi", "İsteğe bağlı yakın temas veya yüzme eklentisi", "Bu amaçla inşa edilmiş gösteri havuzu ve oturma alanı", "Çocuklu aileler için harika", "Boyunca fotoğraf fırsatları", "Kompakt yarım gün formatı"]'::jsonb,
   '["Giriş ve rezerve gösteri koltuğu", "Otel alış ve bırakış hizmeti", "İngilizce konuşan tur desteği", "Standart gösteri izleme paketi", "Şişe suyu", "Seyahat sigortası"]'::jsonb, '["Suya girme veya yakın temas paketi (isteğe bağlı, yerinde ödemeli)", "Profesyonel fotoğraf paketi", "Tesiste yiyecek ve içecek", "Bahşişler"]'::jsonb,
   '[{"time": "09:15", "title": "Otelden Alış", "text": "Sabah seansı için otelinizden alınırsınız."}, {"time": "10:00", "title": "Varış ve Yerleşme", "text": "Parka varış ve rezerve koltuklarınıza yerleşme."}, {"time": "10:30", "title": "Yunus ve Deniz Aslanı Gösterisi", "text": "Canlı performansın keyfini çıkarın."}, {"time": "11:15", "title": "İsteğe Bağlı Yakın Temas", "text": "Yüzme eklentisi rezervasyonu yapan misafirler suda yunuslarla buluşur."}, {"time": "12:45", "title": "Dönüş", "text": "Otelinize transfer sağlanır."}]'::jsonb, '[{"q": "Yunuslarla yüzme dahil mi?", "a": "Park girişi ve gösteri dahildir; suya girme veya dokunma deneyimi, önceden bizimle rezerve edebileceğiniz isteğe bağlı, ücretli bir eklentidir."}, {"q": "Su deneyimine hangi yaştan itibaren katılınabilir?", "a": "Bu programa göre değişir ancak genellikle 6 yaş civarından itibaren, küçük çocuklar için bir yetişkin eşliğinde mevcuttur - eklentiyi rezerve ederken kesin yaş kurallarını teyit edebiliriz."}, {"q": "Gösteri her yaş için uygun mu?", "a": "Evet, gösterinin kendisi her yaş için keyiflidir ve suya girmeyi gerektirmez."}, {"q": "Gösteri ne kadar sürüyor?", "a": "Ana gösteri yaklaşık 30-40 dakika sürer; transferler dahil tüm ziyaret yaklaşık üç saat sürmektedir."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dolphin-park'), 'en',
   'Dolphin Park Visit', 'A family-friendly half day of dolphin and sea lion shows, with optional in-water encounters.', 'Bodrum Peninsula, Türkiye',
   '3 Hours', '10:00 AM & 14:00 PM, Daily', '13:00 PM / 17:00 PM',
   'Hotel pick-up across the Bodrum peninsula',
   '["A morning or afternoon at the Dolphin Park is one of our most popular family outings, combining an entertaining show with the option to get in the water for a closer encounter. Trained dolphins and sea lions perform alongside their handlers in a purpose-built show pool.", "Optional add-ons let guests (usually from around age 6, with some restrictions for younger children) swim, touch or pose for photos with the dolphins under close staff supervision. Even without the water add-on, the show alone makes for a memorable couple of hours for kids and adults alike."]'::jsonb, '["Live dolphin and sea lion show", "Optional close encounter or swim add-on", "Purpose-built show pool and seating", "Great for families with children", "Photo opportunities throughout", "Compact half-day format"]'::jsonb,
   '["Entrance and reserved show seating", "Hotel pick-up and drop-off", "English-speaking tour assistance", "Standard show viewing package", "Bottled water", "Travel insurance"]'::jsonb, '["In-water swim or encounter package (optional, paid locally)", "Professional photo package", "Food and drinks at the venue", "Gratuities"]'::jsonb,
   '[{"time": "09:15", "title": "Hotel Pick-up", "text": "Collection from your hotel for the morning session."}, {"time": "10:00", "title": "Arrival & Seating", "text": "Arrive at the park and take your reserved seats."}, {"time": "10:30", "title": "Dolphin & Sea Lion Show", "text": "Enjoy the live performance."}, {"time": "11:15", "title": "Optional Encounter", "text": "Guests who booked the swim add-on meet the dolphins in the water."}, {"time": "12:45", "title": "Return", "text": "Transfer back to your hotel."}]'::jsonb, '[{"q": "Is the swim with dolphins included?", "a": "The park entrance and show are included; the in-water swim or touch encounter is an optional paid add-on you can book with us in advance."}, {"q": "What age can join the water encounter?", "a": "This varies by programme but is generally available from around age 6, with an accompanying adult for younger children - we can confirm exact age rules when you book the add-on."}, {"q": "Is the show suitable for all ages?", "a": "Yes, the show itself is enjoyable for all ages and doesn''t require getting in the water."}, {"q": "How long is the show?", "a": "The main show runs for approximately 30-40 minutes, with the full visit lasting around three hours including transfers."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dolphin-park'), 'de',
   'Delfinpark-Besuch', 'Ein familienfreundlicher halber Tag mit Delfin- und Seelöwenshows, mit optionalen Begegnungen im Wasser.', 'Bodrum-Halbinsel, Türkei',
   '3 Stunden', '10:00 und 14:00 Uhr, täglich', '13:00 / 17:00 Uhr',
   'Hotelabholung auf der gesamten Bodrum-Halbinsel',
   '["Ein Vormittag oder Nachmittag im Delfinpark ist einer unserer beliebtesten Familienausflüge und verbindet eine unterhaltsame Show mit der Möglichkeit, für eine nähere Begegnung ins Wasser zu gehen. Trainierte Delfine und Seelöwen treten mit ihren Trainern in einem eigens dafür gebauten Showbecken auf.", "Optionale Zusatzangebote erlauben es Gästen (in der Regel ab etwa 6 Jahren, mit gewissen Einschränkungen für jüngere Kinder), unter engmaschiger Personalbetreuung mit den Delfinen zu schwimmen, sie zu berühren oder sich mit ihnen fotografieren zu lassen. Auch ohne das Wasser-Upgrade sorgt allein die Show für ein paar unvergessliche Stunden für Kinder und Erwachsene gleichermaßen."]'::jsonb, '["Live-Delfin- und Seelöwenshow", "Optionale Nahbegegnung oder Schwimm-Upgrade", "Eigens gebautes Showbecken mit Sitzplätzen", "Ideal für Familien mit Kindern", "Durchgehend Fotomöglichkeiten", "Kompaktes Halbtagesformat"]'::jsonb,
   '["Eintritt und reservierter Show-Sitzplatz", "Hotelabholung und -rückbringung", "Englischsprachige Reisebegleitung", "Standard-Show-Betrachtungspaket", "Flaschenwasser", "Reiseversicherung"]'::jsonb, '["Schwimm- oder Begegnungspaket im Wasser (optional, vor Ort zu zahlen)", "Professionelles Fotopaket", "Essen und Getränke vor Ort", "Trinkgelder"]'::jsonb,
   '[{"time": "09:15", "title": "Hotelabholung", "text": "Abholung von Ihrem Hotel für die Vormittagssitzung."}, {"time": "10:00", "title": "Ankunft und Einlass", "text": "Ankunft im Park und Einnehmen Ihrer reservierten Plätze."}, {"time": "10:30", "title": "Delfin- und Seelöwenshow", "text": "Genießen Sie die Live-Vorführung."}, {"time": "11:15", "title": "Optionale Begegnung", "text": "Gäste mit gebuchtem Schwimm-Upgrade treffen die Delfine im Wasser."}, {"time": "12:45", "title": "Rückfahrt", "text": "Transfer zurück zu Ihrem Hotel."}]'::jsonb, '[{"q": "Ist das Schwimmen mit Delfinen inbegriffen?", "a": "Der Parkeintritt und die Show sind inbegriffen; die Schwimm- oder Berührungsbegegnung im Wasser ist ein optionales, kostenpflichtiges Upgrade, das Sie im Voraus bei uns buchen können."}, {"q": "Ab welchem Alter kann man an der Wasserbegegnung teilnehmen?", "a": "Dies variiert je nach Programm, ist aber im Allgemeinen ab etwa 6 Jahren möglich, mit Begleitung eines Erwachsenen für jüngere Kinder - wir bestätigen die genauen Altersregeln bei Buchung des Zusatzangebots."}, {"q": "Ist die Show für alle Altersgruppen geeignet?", "a": "Ja, die Show selbst ist für alle Altersgruppen unterhaltsam und erfordert kein Betreten des Wassers."}, {"q": "Wie lange dauert die Show?", "a": "Die Hauptshow dauert etwa 30-40 Minuten, der gesamte Besuch inklusive Transfers etwa drei Stunden."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dolphin-park'), 'ru',
   'Посещение дельфинария', 'Семейная поездка на полдня с шоу дельфинов и морских львов, с возможностью общения в воде по желанию.', 'Полуостров Бодрум, Турция',
   '3 часа', '10:00 и 14:00, ежедневно', '13:00 / 17:00',
   'Трансфер от отеля по всему полуострову Бодрум',
   '["Утро или день в дельфинарии - одна из наших самых популярных семейных поездок, сочетающая увлекательное шоу с возможностью зайти в воду для более близкого знакомства. Дрессированные дельфины и морские львы выступают вместе с тренерами в специально построенном бассейне для шоу.", "Дополнительные опции позволяют гостям (обычно примерно от 6 лет, с некоторыми ограничениями для детей младшего возраста) поплавать, потрогать дельфинов или сфотографироваться с ними под пристальным наблюдением персонала. Даже без дополнительной опции в воде само шоу подарит запоминающиеся часы и детям, и взрослым."]'::jsonb, '["Живое шоу дельфинов и морских львов", "Опциональное близкое общение или плавание", "Специально построенный бассейн для шоу с местами", "Отлично подходит для семей с детьми", "Возможности для фото на протяжении всего визита", "Компактный формат на полдня"]'::jsonb,
   '["Вход и зарезервированные места на шоу", "Трансфер от отеля и обратно", "Помощь англоговорящего сопровождающего", "Стандартный пакет просмотра шоу", "Питьевая вода", "Страховка"]'::jsonb, '["Пакет плавания или общения в воде (по желанию, оплата на месте)", "Профессиональный фотопакет", "Еда и напитки на месте", "Чаевые"]'::jsonb,
   '[{"time": "09:15", "title": "Трансфер из отеля", "text": "Забираем вас из отеля для утреннего сеанса."}, {"time": "10:00", "title": "Прибытие и рассадка", "text": "Прибытие в парк и занятие зарезервированных мест."}, {"time": "10:30", "title": "Шоу дельфинов и морских львов", "text": "Наслаждайтесь живым представлением."}, {"time": "11:15", "title": "Опциональное общение", "text": "Гости с забронированным плаванием встречаются с дельфинами в воде."}, {"time": "12:45", "title": "Возвращение", "text": "Трансфер обратно в отель."}]'::jsonb, '[{"q": "Включено ли плавание с дельфинами?", "a": "Вход в парк и шоу включены; плавание или контакт с дельфинами в воде - это опциональное платное дополнение, которое можно забронировать у нас заранее."}, {"q": "С какого возраста можно участвовать в общении в воде?", "a": "Это зависит от программы, но обычно доступно примерно с 6 лет, с сопровождением взрослого для детей младшего возраста - мы подтвердим точные возрастные правила при бронировании допопции."}, {"q": "Подходит ли шоу для всех возрастов?", "a": "Да, само шоу интересно для всех возрастов и не требует захода в воду."}, {"q": "Сколько длится шоу?", "a": "Основное шоу длится примерно 30-40 минут, а весь визит с учётом трансферов - около трёх часов."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dolphin-park'), 'pl',
   'Wizyta w Parku Delfinów', 'Przyjazna rodzinom półdniowa wycieczka z pokazami delfinów i lwów morskich, z opcjonalnym kontaktem w wodzie.', 'Półwysep Bodrum, Turcja',
   '3 godziny', '10:00 i 14:00, codziennie', '13:00 / 17:00',
   'Odbiór z hotelu na całym półwyspie Bodrum',
   '["Poranek lub popołudnie w Parku Delfinów to jedna z naszych najpopularniejszych wycieczek rodzinnych, łącząca efektowny pokaz z możliwością wejścia do wody dla bliższego kontaktu. Wytresowane delfiny i lwy morskie występują wraz z trenerami w specjalnie zbudowanym basenie pokazowym.", "Opcjonalne dodatki pozwalają gościom (zazwyczaj od około 6 roku życia, z pewnymi ograniczeniami dla młodszych dzieci) popływać, dotknąć lub sfotografować się z delfinami pod ścisłym nadzorem personelu. Nawet bez dodatku wodnego sam pokaz zapewnia niezapomniane godziny zarówno dzieciom, jak i dorosłym."]'::jsonb, '["Pokaz delfinów i lwów morskich na żywo", "Opcjonalny bliski kontakt lub pływanie", "Specjalnie zbudowany basen pokazowy z miejscami siedzącymi", "Świetne dla rodzin z dziećmi", "Możliwości zdjęć przez cały czas trwania wizyty", "Kompaktowy format na pół dnia"]'::jsonb,
   '["Wstęp i zarezerwowane miejsca na pokaz", "Odbiór i powrót z hotelu", "Anglojęzyczna pomoc podczas wycieczki", "Standardowy pakiet oglądania pokazu", "Woda butelkowana", "Ubezpieczenie podróżne"]'::jsonb, '["Pakiet pływania lub kontaktu w wodzie (opcjonalnie, płatne na miejscu)", "Profesjonalny pakiet fotograficzny", "Jedzenie i napoje na miejscu", "Napiwki"]'::jsonb,
   '[{"time": "09:15", "title": "Odbiór z hotelu", "text": "Odbiór z hotelu na sesję poranną."}, {"time": "10:00", "title": "Przybycie i zajęcie miejsc", "text": "Przybycie do parku i zajęcie zarezerwowanych miejsc."}, {"time": "10:30", "title": "Pokaz delfinów i lwów morskich", "text": "Cieszcie się pokazem na żywo."}, {"time": "11:15", "title": "Opcjonalny kontakt", "text": "Goście z zarezerwowanym dodatkiem pływania spotykają delfiny w wodzie."}, {"time": "12:45", "title": "Powrót", "text": "Transfer z powrotem do hotelu."}]'::jsonb, '[{"q": "Czy pływanie z delfinami jest wliczone?", "a": "Wstęp do parku i pokaz są wliczone; pływanie lub kontakt dotykowy w wodzie to opcjonalny, płatny dodatek, który można zarezerwować u nas z wyprzedzeniem."}, {"q": "Od jakiego wieku można uczestniczyć w kontakcie w wodzie?", "a": "Zależy to od programu, ale zazwyczaj dostępne jest od około 6 roku życia, z towarzyszącym dorosłym dla młodszych dzieci - potwierdzimy dokładne zasady wiekowe przy rezerwacji dodatku."}, {"q": "Czy pokaz jest odpowiedni dla każdego wieku?", "a": "Tak, sam pokaz jest atrakcyjny dla każdego wieku i nie wymaga wchodzenia do wody."}, {"q": "Ile trwa pokaz?", "a": "Główny pokaz trwa około 30-40 minut, a cała wizyta wraz z transferami zajmuje około trzech godzin."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'aquapark'), 'tr',
   'Aquapark Günlük Giriş', 'Bölgenin en büyük su parklarından birinde kaydıraklar, dalga havuzları ve tam gün aile eğlencesi.', 'Bodrum Yarımadası, Türkiye',
   '6 Saat - Tam Gün Giriş', '09:30, Her Gün', '16:00',
   'Bodrum yarımadası genelinde otelden alış',
   '["Gezmek değil eğlenmek odaklı bir gün için Aquapark paketi, gidiş-dönüş transfer ve bölgenin en büyük su parklarından birine tam gün giriş içerir. Kaydıraklar, yumuşak aile kaydıraklarından dik ve yüksek hızlı düşüşlere kadar çeşitlilik gösterir; dalga havuzları, tembel nehirler ve özel çocuk alanları da mevcuttur.", "Park çevresinde güneşlenme sandalyeleri bulunur ve gününüzü tam olarak değerlendirmek isterseniz tesiste yiyecek-içecek büfeleri vardır. Aileler veya tur gezmekten bir mola vermek isteyenler için kolay, zahmetsiz bir seçim."]'::jsonb, '["Bölgenin büyük bir su parkına tam gün giriş", "Her heyecan seviyesi için kaydıraklar, artı dalga havuzu", "Özel çocuk ve aile bölgeleri", "Gidiş-dönüş otel transferi dahil", "Tesiste güneşlenme sandalyeleri mevcut", "Parkta yiyecek-içecek büfeleri"]'::jsonb,
   '["Tam gün park giriş bileti", "Gidiş-dönüş otel transferi", "İngilizce konuşan transfer desteği", "Dalga havuzu ve çocuk bölgelerine erişim", "Seyahat sigortası", "Dolap kiralama (tesiste depozito gerekir)"]'::jsonb, '["Park içinde yiyecek ve içecek", "Özel kabana veya premium şezlong kiralama", "Havlu (tesiste kiralanabilir)", "Bahşişler"]'::jsonb,
   '[{"time": "08:45", "title": "Otelden Alış", "text": "Parka transfer için otelinizden alınırsınız."}, {"time": "09:30", "title": "Parka Giriş", "text": "Parka girip yerleşirsiniz - havuzların yakınında şezlonglar mevcuttur."}, {"time": "Tüm gün", "title": "Serbest Zaman", "text": "Kaydırakların, dalga havuzunun ve aile alanlarının keyfini kendi hızınızda çıkarın."}, {"time": "15:30", "title": "Buluşma Noktası", "text": "Dönüş transferi için anlaşılan buluşma noktasında toplanılır."}, {"time": "16:00", "title": "Otele Dönüş", "text": "Otelinize transfer sağlanır."}]'::jsonb, '[{"q": "Aquapark küçük çocuklar için uygun mu?", "a": "Evet, büyük kaydırakların yanı sıra özel çocuk havuzları ve daha yumuşak kaydıraklar da bulunur; bu yüzden park karışık yaş gruplu aileler için uygundur."}, {"q": "Havlu sağlanıyor mu?", "a": "Havlu dahil değildir ancak tesiste kiralanabilir; zaman ve maliyet tasarrufu için kendi havlunuzu getirmenizi öneririz."}, {"q": "Tüm gün kalabilir miyiz?", "a": "Evet, biletiniz tam gün girişi kapsar ve transfer programı parkta tam bir gün geçirmeye göre planlanmıştır."}, {"q": "Parkın içinde yiyecek var mı?", "a": "Evet, park genelinde yiyecek-içecek büfeleri bulunur, ancak bunlar tur fiyatına dahil değildir."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'aquapark'), 'en',
   'Aquapark Day Pass', 'A full day of slides, wave pools and family fun at one of the region''s biggest water parks.', 'Bodrum Peninsula, Türkiye',
   '6 Hours - Full Day Entry', '09:30 AM, Daily', '16:00 PM',
   'Hotel pick-up across the Bodrum peninsula',
   '["For a day that''s all about fun rather than sightseeing, the Aquapark package includes return transfer and full-day entry to one of the region''s largest water parks. Slides range from gentle family rides to steep, high-speed drops, alongside wave pools, lazy rivers and dedicated toddler areas.", "Sun loungers are available around the park, and there are food and drink stalls on site if you''d like to make a full day of it. It''s an easy, low-effort choice for families or anyone wanting a break from touring."]'::jsonb, '["Full-day entry to a major regional water park", "Slides for all thrill levels, plus wave pool", "Dedicated toddler and family zones", "Return hotel transfer included", "Sun loungers available on site", "Food and drink stalls at the park"]'::jsonb,
   '["Full-day park entrance ticket", "Return hotel transfer", "English-speaking transfer assistance", "Access to wave pool and toddler zones", "Travel insurance", "Locker rental (deposit required on site)"]'::jsonb, '["Food and drinks inside the park", "Private cabana or premium lounger rental", "Towels (available to rent on site)", "Gratuities"]'::jsonb,
   '[{"time": "08:45", "title": "Hotel Pick-up", "text": "Collection from your hotel for the transfer to the park."}, {"time": "09:30", "title": "Park Entry", "text": "Enter the park and settle in - loungers available near the pools."}, {"time": "All day", "title": "Free Time", "text": "Enjoy the slides, wave pool and family areas at your own pace."}, {"time": "15:30", "title": "Meeting Point", "text": "Regroup at the agreed meeting point for the return transfer."}, {"time": "16:00", "title": "Return to Hotel", "text": "Transfer back to your hotel."}]'::jsonb, '[{"q": "Is the Aquapark suitable for young children?", "a": "Yes, there are dedicated toddler pools and gentler slides alongside the bigger rides, so the park works well for mixed-age families."}, {"q": "Are towels provided?", "a": "Towels aren''t included but can be rented on site; we recommend bringing your own to save time and cost."}, {"q": "Can we stay for the full day?", "a": "Yes, your ticket covers full-day entry, and the transfer schedule is built around a full day at the park."}, {"q": "Is food available inside the park?", "a": "Yes, there are food and drink stalls throughout the park, though these aren''t included in the tour price."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'aquapark'), 'de',
   'Aquapark Tagesticket', 'Ein ganzer Tag mit Rutschen, Wellenbecken und Familienspaß in einem der größten Wasserparks der Region.', 'Bodrum-Halbinsel, Türkei',
   '6 Stunden - Ganztägiger Eintritt', '09:30 Uhr, täglich', '16:00 Uhr',
   'Hotelabholung auf der gesamten Bodrum-Halbinsel',
   '["Für einen Tag, bei dem es nur um Spaß statt Sightseeing geht, beinhaltet das Aquapark-Paket Rücktransfer und ganztägigen Eintritt in einen der größten Wasserparks der Region. Die Rutschen reichen von sanften Familienrutschen bis zu steilen Hochgeschwindigkeitsabfahrten, dazu kommen Wellenbecken, Lazy Rivers und eigene Kleinkindbereiche.", "Rund um den Park stehen Sonnenliegen zur Verfügung, und es gibt Essens- und Getränkestände vor Ort, falls Sie den Tag voll auskosten möchten. Eine einfache, mühelose Wahl für Familien oder alle, die eine Pause vom Sightseeing möchten."]'::jsonb, '["Ganztägiger Eintritt in einen großen regionalen Wasserpark", "Rutschen für jedes Nervenkitzel-Level, plus Wellenbecken", "Eigene Kleinkind- und Familienzonen", "Rücktransfer vom Hotel inbegriffen", "Sonnenliegen vor Ort verfügbar", "Essens- und Getränkestände im Park"]'::jsonb,
   '["Ganztägiges Parkeintrittsticket", "Rücktransfer zum Hotel", "Englischsprachige Transferbegleitung", "Zugang zu Wellenbecken und Kleinkindzonen", "Reiseversicherung", "Schließfachvermietung (Kaution vor Ort erforderlich)"]'::jsonb, '["Essen und Getränke im Park", "Vermietung einer privaten Cabana oder Premium-Liege", "Handtücher (vor Ort mietbar)", "Trinkgelder"]'::jsonb,
   '[{"time": "08:45", "title": "Hotelabholung", "text": "Abholung von Ihrem Hotel für den Transfer zum Park."}, {"time": "09:30", "title": "Parkeinlass", "text": "Betreten Sie den Park und richten Sie sich ein - Liegen sind in der Nähe der Becken verfügbar."}, {"time": "Ganztägig", "title": "Freizeit", "text": "Genießen Sie Rutschen, Wellenbecken und Familienbereiche in Ihrem eigenen Tempo."}, {"time": "15:30", "title": "Treffpunkt", "text": "Sammeln am vereinbarten Treffpunkt für den Rücktransfer."}, {"time": "16:00", "title": "Rückfahrt zum Hotel", "text": "Transfer zurück zu Ihrem Hotel."}]'::jsonb, '[{"q": "Ist der Aquapark für kleine Kinder geeignet?", "a": "Ja, es gibt eigene Kleinkindbecken und sanftere Rutschen neben den größeren Attraktionen, sodass der Park für Familien mit gemischten Altersgruppen gut geeignet ist."}, {"q": "Werden Handtücher gestellt?", "a": "Handtücher sind nicht inbegriffen, können aber vor Ort gemietet werden; wir empfehlen, ein eigenes mitzubringen, um Zeit und Kosten zu sparen."}, {"q": "Können wir den ganzen Tag bleiben?", "a": "Ja, Ihr Ticket deckt den ganztägigen Eintritt ab, und der Transferzeitplan ist auf einen vollen Tag im Park ausgelegt."}, {"q": "Gibt es Essen im Park?", "a": "Ja, im gesamten Park gibt es Essens- und Getränkestände, diese sind jedoch nicht im Tourpreis inbegriffen."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'aquapark'), 'ru',
   'Дневной билет в аквапарк', 'Целый день горок, волновых бассейнов и семейного веселья в одном из крупнейших аквапарков региона.', 'Полуостров Бодрум, Турция',
   '6 часов - вход на весь день', '09:30, ежедневно', '16:00',
   'Трансфер от отеля по всему полуострову Бодрум',
   '["Для дня, посвящённого исключительно веселью, а не экскурсиям, пакет в аквапарк включает трансфер туда и обратно и вход на весь день в один из крупнейших аквапарков региона. Горки варьируются от спокойных семейных до крутых скоростных спусков, а также есть волновые бассейны, ленивые реки и отдельные зоны для малышей.", "По территории парка расставлены шезлонги, а на месте есть киоски с едой и напитками, если вы хотите провести здесь целый день. Простой, необременительный вариант для семей или всех, кто хочет отдохнуть от экскурсий."]'::jsonb, '["Вход на весь день в крупный региональный аквапарк", "Горки для любого уровня азарта, плюс волновой бассейн", "Отдельные зоны для малышей и семей", "Трансфер от отеля и обратно включён", "Шезлонги доступны на месте", "Киоски с едой и напитками в парке"]'::jsonb,
   '["Билет на вход в парк на весь день", "Трансфер от отеля и обратно", "Помощь англоговорящего сопровождающего", "Доступ к волновому бассейну и зонам для малышей", "Страховка", "Аренда шкафчика (депозит на месте)"]'::jsonb, '["Еда и напитки в парке", "Аренда частной кабаны или премиального шезлонга", "Полотенца (можно арендовать на месте)", "Чаевые"]'::jsonb,
   '[{"time": "08:45", "title": "Трансфер из отеля", "text": "Забираем вас из отеля для трансфера в парк."}, {"time": "09:30", "title": "Вход в парк", "text": "Вход в парк и размещение - шезлонги доступны рядом с бассейнами."}, {"time": "Весь день", "title": "Свободное время", "text": "Наслаждайтесь горками, волновым бассейном и семейными зонами в своём темпе."}, {"time": "15:30", "title": "Точка сбора", "text": "Сбор в согласованной точке для обратного трансфера."}, {"time": "16:00", "title": "Возвращение в отель", "text": "Трансфер обратно в отель."}]'::jsonb, '[{"q": "Подходит ли аквапарк для маленьких детей?", "a": "Да, помимо крупных аттракционов есть отдельные бассейны для малышей и более спокойные горки, поэтому парк хорошо подходит для семей с детьми разного возраста."}, {"q": "Полотенца предоставляются?", "a": "Полотенца не включены, но их можно арендовать на месте; рекомендуем взять своё, чтобы сэкономить время и деньги."}, {"q": "Можем ли мы остаться на весь день?", "a": "Да, ваш билет покрывает вход на весь день, и расписание трансфера рассчитано на полный день в парке."}, {"q": "Есть ли еда в парке?", "a": "Да, по всему парку есть киоски с едой и напитками, но они не включены в стоимость тура."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'aquapark'), 'pl',
   'Bilet Dzienny do Aquaparku', 'Cały dzień zjeżdżalni, basenów z falami i rodzinnej zabawy w jednym z największych parków wodnych regionu.', 'Półwysep Bodrum, Turcja',
   '6 godzin - Wstęp całodniowy', '09:30, codziennie', '16:00',
   'Odbiór z hotelu na całym półwyspie Bodrum',
   '["Na dzień poświęcony wyłącznie zabawie, a nie zwiedzaniu, pakiet Aquapark obejmuje transfer w obie strony i całodniowy wstęp do jednego z największych parków wodnych regionu. Zjeżdżalnie obejmują zarówno łagodne trasy rodzinne, jak i strome, szybkie zjazdy, a do tego baseny z falami, leniwe rzeki i dedykowane strefy dla najmłodszych.", "Wokół parku dostępne są leżaki, a na miejscu znajdują się stoiska z jedzeniem i napojami, jeśli chcecie spędzić tu cały dzień. Łatwy, bezwysiłkowy wybór dla rodzin lub każdego, kto chce zrobić sobie przerwę od zwiedzania."]'::jsonb, '["Całodniowy wstęp do dużego regionalnego parku wodnego", "Zjeżdżalnie dla każdego poziomu emocji, plus basen z falami", "Dedykowane strefy dla najmłodszych i rodzin", "Transfer z hotelu w obie strony wliczony", "Leżaki dostępne na miejscu", "Stoiska z jedzeniem i napojami w parku"]'::jsonb,
   '["Całodniowy bilet wstępu do parku", "Transfer z hotelu w obie strony", "Anglojęzyczna pomoc podczas transferu", "Dostęp do basenu z falami i stref dla najmłodszych", "Ubezpieczenie podróżne", "Wynajem szafki (depozyt wymagany na miejscu)"]'::jsonb, '["Jedzenie i napoje w parku", "Wynajem prywatnej kabany lub leżaka premium", "Ręczniki (do wynajęcia na miejscu)", "Napiwki"]'::jsonb,
   '[{"time": "08:45", "title": "Odbiór z hotelu", "text": "Odbiór z hotelu w celu transferu do parku."}, {"time": "09:30", "title": "Wejście do parku", "text": "Wejście do parku i zadomowienie się - leżaki dostępne w pobliżu basenów."}, {"time": "Cały dzień", "title": "Czas wolny", "text": "Cieszcie się zjeżdżalniami, basenem z falami i strefami rodzinnymi we własnym tempie."}, {"time": "15:30", "title": "Punkt zbiórki", "text": "Zbiórka w uzgodnionym punkcie na transfer powrotny."}, {"time": "16:00", "title": "Powrót do hotelu", "text": "Transfer z powrotem do hotelu."}]'::jsonb, '[{"q": "Czy Aquapark jest odpowiedni dla małych dzieci?", "a": "Tak, oprócz większych atrakcji są dedykowane baseny dla najmłodszych i łagodniejsze zjeżdżalnie, więc park dobrze sprawdza się dla rodzin z dziećmi w różnym wieku."}, {"q": "Czy ręczniki są zapewnione?", "a": "Ręczniki nie są wliczone, ale można je wynająć na miejscu; polecamy zabranie własnego, aby zaoszczędzić czas i koszty."}, {"q": "Czy możemy zostać na cały dzień?", "a": "Tak, bilet obejmuje wstęp na cały dzień, a harmonogram transferu jest dostosowany do pełnego dnia w parku."}, {"q": "Czy w parku jest jedzenie?", "a": "Tak, na terenie całego parku znajdują się stoiska z jedzeniem i napojami, jednak nie są one wliczone w cenę wycieczki."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'pamukkale'), 'tr',
   'Pamukkale Günübirlik Turu', 'Pamukkale''nin beyaz travertenleri ve Hierapolis antik kenti, uzun ama unutulmaz tek bir günde.', 'Denizli, Türkiye',
   '13 Saat - Tam Gün (Uzun Mesafe)', '04:30, Her Gün', '20:30',
   'Bodrum yarımadası genelinde otelden alış',
   '["Kelime anlamıyla ''Pamuk Kale'' olan Pamukkale, Türkiye''nin en çok fotoğraflanan yerlerinden biridir: binlerce yıl boyunca kalsiyum bakımından zengin termal suyla oluşmuş, parlak beyaz traverten teraslarla kaplı bir yamaç. Bodrum''dan gerçekten erken bir başlangıç gerektirir, ancak her misafirimiz buna değdiğini söylüyor.", "Terasların ötesinde, bir zamanlar önemli bir Roma ve Helenistik spa kenti olan antik Hierapolis''in kalıntılarını - iyi korunmuş tiyatrosu ve geniş nekropolüyle - keşfedeceksiniz. Misafirler isteğe bağlı olarak, batık antik sütunlar arasında ılık mineralli suda yüzebileceğiniz Kleopatra Antik Havuzu''nda da yüzebilir."]'::jsonb, '["Pamukkale''nin beyaz traverten terasları", "Antik Hierapolis kalıntıları ve Roma tiyatrosu", "Vadiye tepeden bakan geniş manzaralar", "Kleopatra Antik Havuzu''nda isteğe bağlı yüzme", "UNESCO Dünya Mirası Alanı", "Öğle yemeği molalı tam gün rehberli deneyim"]'::jsonb,
   '["Klimalı araçla gidiş-dönüş ulaşım", "Otel alış ve bırakış hizmeti", "İngilizce konuşan tur rehberi", "Pamukkale ve Hierapolis giriş ücretleri", "Yerel bir restoranda öğle yemeği", "Seyahat sigortası"]'::jsonb, '["Kleopatra Antik Havuzu girişi (isteğe bağlı, yerinde ödemeli)", "Öğle yemeğiyle içecekler", "Kişisel harcamalar ve hediyelik eşyalar", "Rehber ve şoför için bahşiş"]'::jsonb,
   '[{"time": "04:30", "title": "Otelden Alış", "text": "Alanda geçirilecek zamanı en üst düzeye çıkarmak için çok erken hareket."}, {"time": "08:30", "title": "Pamukkale''ye Varış", "text": "Traverten teraslarda rehberli yürüyüş başlar."}, {"time": "10:00", "title": "Hierapolis Kalıntıları", "text": "Antik tiyatro, nekropol ve kent kalıntıları keşfedilir."}, {"time": "11:30", "title": "İsteğe Bağlı Kleopatra Havuzu", "text": "Antik sütunlar arasında isteğe bağlı yüzme için serbest zaman."}, {"time": "13:00", "title": "Öğle Yemeği", "text": "Dönüş yolculuğundan önce yerel bir restoranda mola."}, {"time": "14:00", "title": "Dönüş Yolculuğu", "text": "Bodrum''a doğru yola çıkılır, akşam saatlerinde varılır."}]'::jsonb, '[{"q": "Pamukkale turu neden bu kadar erken başlıyor?", "a": "Pamukkale, Bodrum''a yaklaşık 3,5-4 saat mesafededir; bu yüzden erken bir başlangıç, günün yolda değil alanın kendisinde geçirilmesini sağlar."}, {"q": "Özel bir şey getirmem gerekir mi?", "a": "Kleopatra Havuzu''nu ziyaret etmeyi planlıyorsanız mayo ve havlu, teraslar için de rahat yürüyüş ayakkabıları önerilir."}, {"q": "Teraslarda yalınayak yürümek zorunlu mu?", "a": "Evet, oluşumları korumak için ziyaretçilerden genellikle ana traverten teraslarında yalınayak yürümeleri istenir; bu yüzden kolay çıkarılabilen sandaletler işinize yarar."}, {"q": "Bu tur yaşlı gezginler için uygun mu?", "a": "Teraslarda düzensiz, ıslak kireçtaşı üzerinde biraz yürüyüş gerekir, ancak tempo çoğu fitness seviyesi için idare edilebilir - hareket kabiliyetiyle ilgili endişelerinizi önceden bize bildirin."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'pamukkale'), 'en',
   'Pamukkale Day Trip', 'The white travertine terraces of Pamukkale and the ancient ruins of Hierapolis, in one long, unforgettable day.', 'Denizli Province, Türkiye',
   '13 Hours - Full Day (Long Distance)', '04:30 AM, Daily', '20:30 PM',
   'Hotel pick-up across the Bodrum peninsula',
   '["Pamukkale - literally ''Cotton Castle'' - is one of Turkey''s most photographed sites: a hillside of brilliant white travertine terraces formed over thousands of years by calcium-rich thermal water. It''s a genuinely early start from Bodrum, but every guest tells us it was worth it.", "Beyond the terraces themselves, you''ll explore the ruins of ancient Hierapolis, a once-important Roman and Hellenistic spa city with a well-preserved theatre and vast necropolis. Guests can also take an optional swim in Cleopatra''s Antique Pool, where you float among sunken ancient columns in warm mineral water."]'::jsonb, '["The white travertine terraces of Pamukkale", "Ancient Hierapolis ruins and Roman theatre", "Sweeping views across the valley", "Optional swim in Cleopatra''s Antique Pool", "UNESCO World Heritage Site", "Full-day guided experience with lunch stop"]'::jsonb,
   '["Round-trip transport in air-conditioned vehicle", "Hotel pick-up and drop-off", "English-speaking tour guide", "Pamukkale and Hierapolis entrance fees", "Lunch at a local restaurant", "Travel insurance"]'::jsonb, '["Cleopatra''s Antique Pool entrance (optional, paid locally)", "Drinks with lunch", "Personal expenses and souvenirs", "Gratuities for the guide and driver"]'::jsonb,
   '[{"time": "04:30", "title": "Hotel Pick-up", "text": "Very early departure to make the most of the day at the site."}, {"time": "08:30", "title": "Arrival at Pamukkale", "text": "Begin the guided walk across the travertine terraces."}, {"time": "10:00", "title": "Hierapolis Ruins", "text": "Explore the ancient theatre, necropolis and city ruins."}, {"time": "11:30", "title": "Optional Cleopatra''s Pool", "text": "Free time for an optional swim among ancient columns."}, {"time": "13:00", "title": "Lunch", "text": "A stop at a local restaurant before the journey back."}, {"time": "14:00", "title": "Return Journey", "text": "Drive back toward Bodrum, arriving in the evening."}]'::jsonb, '[{"q": "Why does the Pamukkale tour start so early?", "a": "Pamukkale is roughly 3.5-4 hours from Bodrum, so an early start ensures you have plenty of time at the site itself rather than losing the day to travel."}, {"q": "Do I need to bring anything special?", "a": "A swimsuit and towel are recommended if you plan to visit Cleopatra''s Pool, along with comfortable walking shoes for the terraces."}, {"q": "Is walking on the terraces barefoot required?", "a": "Yes, visitors are generally asked to walk barefoot on the main travertine terraces to protect the formations, so sandals that are easy to remove are helpful."}, {"q": "Is this tour suitable for elderly travellers?", "a": "The terraces involve some walking on uneven, wet limestone, but the pace is manageable for most fitness levels - let us know of any mobility concerns in advance."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'pamukkale'), 'de',
   'Pamukkale Tagesausflug', 'Die weißen Kalksinterterrassen von Pamukkale und die antiken Ruinen von Hierapolis, an einem einzigen, unvergesslichen langen Tag.', 'Provinz Denizli, Türkei',
   '13 Stunden - Ganztägig (Langstrecke)', '04:30 Uhr, täglich', '20:30 Uhr',
   'Hotelabholung auf der gesamten Bodrum-Halbinsel',
   '["Pamukkale - wörtlich ''Baumwollschloss'' - ist eines der meistfotografierten Ziele der Türkei: ein Hang mit strahlend weißen Kalksinterterrassen, geformt über Jahrtausende durch kalziumreiches Thermalwasser. Es ist ein wirklich früher Start ab Bodrum, aber jeder Gast sagt uns, dass es sich gelohnt hat.", "Über die Terrassen hinaus erkunden Sie die Ruinen des antiken Hierapolis, einst eine bedeutende römisch-hellenistische Kurstadt mit einem gut erhaltenen Theater und einer weitläufigen Nekropole. Gäste können zudem optional im Antiken Pool der Kleopatra schwimmen, wo Sie zwischen versunkenen antiken Säulen in warmem Mineralwasser treiben."]'::jsonb, '["Die weißen Kalksinterterrassen von Pamukkale", "Antike Ruinen von Hierapolis und römisches Theater", "Weite Ausblicke über das Tal", "Optionales Schwimmen im Antiken Pool der Kleopatra", "UNESCO-Weltkulturerbe", "Ganztägiges geführtes Erlebnis mit Mittagspause"]'::jsonb,
   '["Hin- und Rücktransport im klimatisierten Fahrzeug", "Hotelabholung und -rückbringung", "Englischsprachiger Reiseleiter", "Eintritt Pamukkale und Hierapolis", "Mittagessen in einem lokalen Restaurant", "Reiseversicherung"]'::jsonb, '["Eintritt zum Antiken Pool der Kleopatra (optional, vor Ort zu zahlen)", "Getränke zum Mittagessen", "Persönliche Ausgaben und Souvenirs", "Trinkgeld für Reiseleiter und Fahrer"]'::jsonb,
   '[{"time": "04:30", "title": "Hotelabholung", "text": "Sehr früher Start, um die Zeit vor Ort optimal zu nutzen."}, {"time": "08:30", "title": "Ankunft in Pamukkale", "text": "Beginn des geführten Spaziergangs über die Kalksinterterrassen."}, {"time": "10:00", "title": "Ruinen von Hierapolis", "text": "Erkundung des antiken Theaters, der Nekropole und der Stadtruinen."}, {"time": "11:30", "title": "Optionaler Kleopatra-Pool", "text": "Freizeit für ein optionales Bad zwischen antiken Säulen."}, {"time": "13:00", "title": "Mittagessen", "text": "Halt in einem lokalen Restaurant vor der Rückfahrt."}, {"time": "14:00", "title": "Rückfahrt", "text": "Fahrt zurück Richtung Bodrum, Ankunft am Abend."}]'::jsonb, '[{"q": "Warum beginnt die Pamukkale-Tour so früh?", "a": "Pamukkale liegt etwa 3,5-4 Stunden von Bodrum entfernt, daher stellt ein früher Start sicher, dass Sie viel Zeit vor Ort haben, statt den Tag mit Fahren zu verlieren."}, {"q": "Muss ich etwas Besonderes mitbringen?", "a": "Badebekleidung und Handtuch werden empfohlen, falls Sie den Kleopatra-Pool besuchen möchten, ebenso bequeme Wanderschuhe für die Terrassen."}, {"q": "Muss man barfuß über die Terrassen laufen?", "a": "Ja, Besucher werden in der Regel gebeten, auf den Haupt-Kalksinterterrassen barfuß zu gehen, um die Formationen zu schützen, daher sind leicht auszuziehende Sandalen hilfreich."}, {"q": "Ist diese Tour für ältere Reisende geeignet?", "a": "Die Terrassen erfordern etwas Gehen auf unebenem, nassem Kalkstein, aber das Tempo ist für die meisten Fitnesslevel machbar - teilen Sie uns eventuelle Mobilitätsbedenken im Voraus mit."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'pamukkale'), 'ru',
   'Однодневная поездка в Памуккале', 'Белые травертиновые террасы Памуккале и античные руины Иераполиса за один долгий, но незабываемый день.', 'Денизли, Турция',
   '13 часов - весь день (дальняя поездка)', '04:30, ежедневно', '20:30',
   'Трансфер от отеля по всему полуострову Бодрум',
   '["Памуккале - дословно ''Хлопковый замок'' - одно из самых фотографируемых мест Турции: склон холма, покрытый ослепительно белыми травертиновыми террасами, сформированными за тысячи лет богатой кальцием термальной водой. Выезд из Бодрума действительно очень ранний, но каждый наш гость говорит, что оно того стоило.", "Помимо самих террас, вы исследуете руины античного Иераполиса - некогда важного римско-эллинистического курортного города с хорошо сохранившимся театром и обширным некрополем. Гости также могут по желанию искупаться в Античном бассейне Клеопатры, где можно плавать среди затонувших древних колонн в тёплой минеральной воде."]'::jsonb, '["Белые травертиновые террасы Памуккале", "Античные руины Иераполиса и римский театр", "Панорамные виды на долину", "Купание в Античном бассейне Клеопатры по желанию", "Объект Всемирного наследия ЮНЕСКО", "Целый день с гидом и остановкой на обед"]'::jsonb,
   '["Трансфер туда и обратно на кондиционированном транспорте", "Трансфер от отеля и обратно", "Англоговорящий гид", "Входные билеты в Памуккале и Иераполис", "Обед в местном ресторане", "Страховка"]'::jsonb, '["Вход в Античный бассейн Клеопатры (по желанию, оплата на месте)", "Напитки к обеду", "Личные расходы и сувениры", "Чаевые гиду и водителю"]'::jsonb,
   '[{"time": "04:30", "title": "Трансфер из отеля", "text": "Очень ранний выезд, чтобы максимально использовать время на месте."}, {"time": "08:30", "title": "Прибытие в Памуккале", "text": "Начало прогулки с гидом по травертиновым террасам."}, {"time": "10:00", "title": "Руины Иераполиса", "text": "Осмотр античного театра, некрополя и городских руин."}, {"time": "11:30", "title": "Бассейн Клеопатры (по желанию)", "text": "Свободное время для купания среди античных колонн."}, {"time": "13:00", "title": "Обед", "text": "Остановка в местном ресторане перед обратной дорогой."}, {"time": "14:00", "title": "Обратный путь", "text": "Дорога обратно в сторону Бодрума, прибытие вечером."}]'::jsonb, '[{"q": "Почему тур в Памуккале начинается так рано?", "a": "Памуккале находится примерно в 3,5-4 часах от Бодрума, поэтому ранний выезд обеспечивает достаточно времени на месте, а не в дороге."}, {"q": "Нужно ли взять с собой что-то особенное?", "a": "Рекомендуем купальник и полотенце, если планируете посетить бассейн Клеопатры, а также удобную обувь для ходьбы по террасам."}, {"q": "Нужно ли ходить по террасам босиком?", "a": "Да, посетителей обычно просят ходить босиком по основным травертиновым террасам, чтобы защитить формации, поэтому пригодятся сандалии, которые легко снять."}, {"q": "Подходит ли этот тур пожилым путешественникам?", "a": "Терраса предполагает ходьбу по неровному влажному известняку, но темп посилен для большинства уровней физической подготовки - сообщите нам заранее о любых проблемах с передвижением."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'pamukkale'), 'pl',
   'Jednodniowa Wycieczka do Pamukkale', 'Białe tarasy trawertynowe Pamukkale i starożytne ruiny Hierapolis w jeden długi, niezapomniany dzień.', 'Prowincja Denizli, Turcja',
   '13 godzin - Cały dzień (Duża odległość)', '04:30, codziennie', '20:30',
   'Odbiór z hotelu na całym półwyspie Bodrum',
   '["Pamukkale - dosłownie ''Bawełniany Zamek'' - to jedno z najczęściej fotografowanych miejsc w Turcji: zbocze pokryte olśniewająco białymi tarasami trawertynowymi, uformowanymi przez tysiące lat przez bogatą w wapń wodę termalną. To naprawdę bardzo wczesny wyjazd z Bodrum, ale każdy nasz gość mówi, że było warto.", "Poza samymi tarasami zwiedzicie ruiny starożytnego Hierapolis, niegdyś ważnego rzymsko-hellenistycznego miasta uzdrowiskowego z dobrze zachowanym teatrem i rozległą nekropolią. Goście mogą także skorzystać z opcjonalnej kąpieli w Antycznym Basenie Kleopatry, gdzie unosicie się w ciepłej wodzie mineralnej wśród zatopionych starożytnych kolumn."]'::jsonb, '["Białe tarasy trawertynowe Pamukkale", "Starożytne ruiny Hierapolis i rzymski teatr", "Rozległe widoki na dolinę", "Opcjonalna kąpiel w Antycznym Basenie Kleopatry", "Obiekt Światowego Dziedzictwa UNESCO", "Całodniowa wycieczka z przewodnikiem i postojem na obiad"]'::jsonb,
   '["Transport w obie strony klimatyzowanym pojazdem", "Odbiór i powrót z hotelu", "Anglojęzyczny przewodnik", "Bilety wstępu do Pamukkale i Hierapolis", "Obiad w lokalnej restauracji", "Ubezpieczenie podróżne"]'::jsonb, '["Wstęp do Antycznego Basenu Kleopatry (opcjonalnie, płatne na miejscu)", "Napoje do obiadu", "Wydatki osobiste i pamiątki", "Napiwki dla przewodnika i kierowcy"]'::jsonb,
   '[{"time": "04:30", "title": "Odbiór z hotelu", "text": "Bardzo wczesny wyjazd, aby maksymalnie wykorzystać czas na miejscu."}, {"time": "08:30", "title": "Przybycie do Pamukkale", "text": "Rozpoczęcie spaceru z przewodnikiem po tarasach trawertynowych."}, {"time": "10:00", "title": "Ruiny Hierapolis", "text": "Zwiedzanie starożytnego teatru, nekropolii i ruin miasta."}, {"time": "11:30", "title": "Opcjonalny Basen Kleopatry", "text": "Czas wolny na opcjonalną kąpiel wśród starożytnych kolumn."}, {"time": "13:00", "title": "Obiad", "text": "Postój w lokalnej restauracji przed podróżą powrotną."}, {"time": "14:00", "title": "Podróż powrotna", "text": "Jazda z powrotem w kierunku Bodrum, przybycie wieczorem."}]'::jsonb, '[{"q": "Dlaczego wycieczka do Pamukkale zaczyna się tak wcześnie?", "a": "Pamukkale znajduje się około 3,5-4 godziny od Bodrum, więc wczesny wyjazd zapewnia dużo czasu na miejscu zamiast tracenia dnia na dojazd."}, {"q": "Czy muszę zabrać coś specjalnego?", "a": "Zalecamy strój kąpielowy i ręcznik, jeśli planujecie odwiedzić Basen Kleopatry, a także wygodne buty do chodzenia po tarasach."}, {"q": "Czy trzeba chodzić po tarasach boso?", "a": "Tak, odwiedzający są zazwyczaj proszeni o chodzenie boso po głównych tarasach trawertynowych, aby chronić formacje, więc przydadzą się sandały łatwe do zdjęcia."}, {"q": "Czy ta wycieczka jest odpowiednia dla starszych podróżnych?", "a": "Tarasy wymagają chodzenia po nierównym, mokrym wapieniu, ale tempo jest możliwe do zniesienia dla większości poziomów sprawności - prosimy o wcześniejsze zgłoszenie ewentualnych problemów z poruszaniem się."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'ephesus'), 'tr',
   'Efes Antik Kenti Turu', 'Akdeniz''in en iyi korunmuş antik kentlerinden birinin mermer sokaklarında yürüyün.', 'Selçuk, İzmir, Türkiye',
   '11 Saat - Tam Gün (Uzun Mesafe)', '06:30, Her Gün', '19:30',
   'Bodrum yarımadası genelinde otelden alış',
   '["Çok az antik alan tarihi Efes kadar canlandırır. Bir zamanlar yaklaşık 250.000 kişilik büyük bir Roma liman kenti olan Efes''in mermer döşeli sokakları, görkemli cepheleri ve kamu binaları dikkat çekici derecede sağlam kalmıştır; bu da onu Akdeniz''deki en eksiksiz klasik kentlerden biri yapar.", "Rehberiniz sizi Efes''in ikonik cephesi Celsus Kütüphanesi''nden, bir zamanlar 24.000 seyirci ağırlayan Büyük Tiyatro''dan ve varlıklı Efeslilerin yaşadığı Teras Evleri''nden geçirir. Birçok misafirimiz ziyareti, kendi zengin tarihine sahip yakındaki Meryem Ana Evi ve Selçuk''taki Aziz Yuhanna Bazilikası ile birleştirmeyi tercih eder."]'::jsonb, '["Efes''in ikonik cephesi Celsus Kütüphanesi", "Bir zamanlar 24.000 kişilik Büyük Tiyatro", "Mermer döşeli Kuretler Caddesi", "İsteğe bağlı Meryem Ana Evi ziyareti", "UNESCO Dünya Mirası Alanı", "Öğle yemeği molalı tam gün rehberli tur"]'::jsonb,
   '["Klimalı araçla gidiş-dönüş ulaşım", "Otel alış ve bırakış hizmeti", "İngilizce konuşan lisanslı rehber", "Efes ören yeri girişi", "Yerel bir restoranda öğle yemeği", "Seyahat sigortası"]'::jsonb, '["Teras Evleri girişi (isteğe bağlı, yerinde ödemeli)", "Meryem Ana Evi girişi (isteğe bağlı)", "Öğle yemeğiyle içecekler", "Rehber ve şoför için bahşiş"]'::jsonb,
   '[{"time": "06:30", "title": "Otelden Alış", "text": "Selçuk''a doğru kuzeye yolculuk için erken hareket."}, {"time": "09:30", "title": "Efes''e Varış", "text": "Antik kent boyunca rehberli yürüyüş turu."}, {"time": "11:30", "title": "Celsus Kütüphanesi ve Tiyatro", "text": "Alanın en ünlü simgeleri ziyaret edilir."}, {"time": "13:00", "title": "Öğle Yemeği", "text": "Selçuk yakınlarında yerel bir restoranda mola."}, {"time": "14:30", "title": "İsteğe Bağlı Ek Alanlar", "text": "Meryem Ana Evi veya Teras Evleri için zaman."}, {"time": "15:30", "title": "Dönüş Yolculuğu", "text": "Bodrum''a doğru yola çıkılır, akşam saatlerinde varılır."}]'::jsonb, '[{"q": "Efes''te ne kadar yürüyüş var?", "a": "Antik kent boyunca ana güzergah mermer ve taş yollarda yaklaşık 1,5-2 km sürer; bu yüzden rahat yürüyüş ayakkabıları önerilir."}, {"q": "Alanda gölgelik var mı?", "a": "Bazı bölgelerde gölge bulunur ancak alanın büyük kısmı açıktır - özellikle yazın güneş koruması, şapka ve su şiddetle tavsiye edilir."}, {"q": "Teras Evleri ekstra giriş ücretine değer mi?", "a": "Birçok misafirimiz, orijinal mozaik ve freskleri kapalı alanda koruduğu için burayı bir öne çıkan nokta olarak görüyor - rehberiniz ilgi alanlarınıza göre öneride bulunabilir."}, {"q": "Bu tur Pamukkale ile birleştirilebilir mi?", "a": "Efes ve Pamukkale, aralarındaki mesafe nedeniyle ayrı günübirlik turlar olarak sunulmaktadır; çok günlü kombinasyon seçenekleri için bize danışabilirsiniz."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'ephesus'), 'en',
   'Ephesus Ancient City Tour', 'Walk the marble streets of one of the best-preserved ancient cities in the Mediterranean.', 'Selcuk, Izmir Province, Türkiye',
   '11 Hours - Full Day (Long Distance)', '06:30 AM, Daily', '19:30 PM',
   'Hotel pick-up across the Bodrum peninsula',
   '["Few ancient sites bring history to life like Ephesus. Once a major Roman port city of some 250,000 people, its marble-paved streets, grand facades and public buildings remain remarkably intact, making it one of the most complete classical cities anywhere in the Mediterranean.", "Your guide leads you past the Library of Celsus, the Great Theatre that once seated 24,000 spectators, and the Terrace Houses where wealthy Ephesians lived. Many guests choose to combine the visit with the nearby House of the Virgin Mary and the Basilica of St. John in Selcuk, both rich with their own history."]'::jsonb, '["The Library of Celsus, Ephesus'' iconic facade", "The Great Theatre, once seating 24,000", "Marble-paved Curetes Street", "Optional visit to the House of the Virgin Mary", "UNESCO World Heritage Site", "Full-day guided tour with lunch stop"]'::jsonb,
   '["Round-trip transport in air-conditioned vehicle", "Hotel pick-up and drop-off", "English-speaking licensed guide", "Ephesus archaeological site entrance", "Lunch at a local restaurant", "Travel insurance"]'::jsonb, '["Terrace Houses entrance (optional, paid locally)", "House of the Virgin Mary entrance (optional)", "Drinks with lunch", "Gratuities for the guide and driver"]'::jsonb,
   '[{"time": "06:30", "title": "Hotel Pick-up", "text": "Early departure for the journey north to Selcuk."}, {"time": "09:30", "title": "Arrival at Ephesus", "text": "Guided walking tour through the ancient city."}, {"time": "11:30", "title": "Library of Celsus & Theatre", "text": "Visit the site''s most famous landmarks."}, {"time": "13:00", "title": "Lunch", "text": "A stop at a local restaurant near Selcuk."}, {"time": "14:30", "title": "Optional Extra Sites", "text": "Time for the House of the Virgin Mary or Terrace Houses."}, {"time": "15:30", "title": "Return Journey", "text": "Drive back toward Bodrum, arriving in the evening."}]'::jsonb, '[{"q": "How much walking is involved at Ephesus?", "a": "The main route through the ancient city covers roughly 1.5-2km on marble and stone paths, so comfortable walking shoes are recommended."}, {"q": "Is there shade at the site?", "a": "Some areas have shade but much of the site is open - sun protection, a hat and water are strongly recommended, especially in summer."}, {"q": "Are the Terrace Houses worth the extra entrance fee?", "a": "Many guests find them a highlight, as they preserve original mosaics and frescoes under cover - your guide can advise based on your interests."}, {"q": "Can this be combined with Pamukkale?", "a": "Ephesus and Pamukkale are offered as separate day tours due to the travel distance between them, but ask us about multi-day combination options."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'ephesus'), 'de',
   'Efes Antike Stadt Tour', 'Wandeln Sie auf den Marmorstraßen einer der am besten erhaltenen antiken Städte im Mittelmeerraum.', 'Selcuk, Provinz Izmir, Türkei',
   '11 Stunden - Ganztägig (Langstrecke)', '06:30 Uhr, täglich', '19:30 Uhr',
   'Hotelabholung auf der gesamten Bodrum-Halbinsel',
   '["Nur wenige antike Stätten lassen Geschichte so lebendig werden wie Ephesus. Einst eine bedeutende römische Hafenstadt mit rund 250.000 Einwohnern, sind ihre marmorgepflasterten Straßen, prachtvollen Fassaden und öffentlichen Gebäude bemerkenswert intakt geblieben - eine der vollständigsten klassischen Städte im gesamten Mittelmeerraum.", "Ihr Reiseleiter führt Sie an der Celsus-Bibliothek vorbei, dem einst 24.000 Zuschauer fassenden Großen Theater und den Terrassenhäusern, in denen wohlhabende Epheser lebten. Viele Gäste verbinden den Besuch gern mit dem nahegelegenen Haus der Jungfrau Maria und der Basilika des Heiligen Johannes in Selcuk, beide reich an eigener Geschichte."]'::jsonb, '["Die Celsus-Bibliothek, Ephesus'' ikonische Fassade", "Das Große Theater, einst für 24.000 Zuschauer", "Die marmorgepflasterte Kuretenstraße", "Optionaler Besuch des Hauses der Jungfrau Maria", "UNESCO-Weltkulturerbe", "Ganztägige geführte Tour mit Mittagspause"]'::jsonb,
   '["Hin- und Rücktransport im klimatisierten Fahrzeug", "Hotelabholung und -rückbringung", "Englischsprachiger lizenzierter Reiseleiter", "Eintritt zur archäologischen Stätte Ephesus", "Mittagessen in einem lokalen Restaurant", "Reiseversicherung"]'::jsonb, '["Eintritt zu den Terrassenhäusern (optional, vor Ort zu zahlen)", "Eintritt zum Haus der Jungfrau Maria (optional)", "Getränke zum Mittagessen", "Trinkgeld für Reiseleiter und Fahrer"]'::jsonb,
   '[{"time": "06:30", "title": "Hotelabholung", "text": "Früher Start für die Fahrt Richtung Norden nach Selcuk."}, {"time": "09:30", "title": "Ankunft in Ephesus", "text": "Geführte Wandertour durch die antike Stadt."}, {"time": "11:30", "title": "Celsus-Bibliothek und Theater", "text": "Besuch der berühmtesten Sehenswürdigkeiten der Stätte."}, {"time": "13:00", "title": "Mittagessen", "text": "Halt in einem lokalen Restaurant bei Selcuk."}, {"time": "14:30", "title": "Optionale weitere Stätten", "text": "Zeit für das Haus der Jungfrau Maria oder die Terrassenhäuser."}, {"time": "15:30", "title": "Rückfahrt", "text": "Fahrt zurück Richtung Bodrum, Ankunft am Abend."}]'::jsonb, '[{"q": "Wie viel Gehen ist in Ephesus erforderlich?", "a": "Die Hauptroute durch die antike Stadt umfasst etwa 1,5-2 km auf Marmor- und Steinwegen, daher werden bequeme Wanderschuhe empfohlen."}, {"q": "Gibt es Schatten an der Stätte?", "a": "Einige Bereiche bieten Schatten, aber ein Großteil der Stätte liegt im Freien - Sonnenschutz, ein Hut und Wasser werden dringend empfohlen, besonders im Sommer."}, {"q": "Lohnen sich die Terrassenhäuser den zusätzlichen Eintritt?", "a": "Viele Gäste empfinden sie als Highlight, da sie originale Mosaiken und Fresken überdacht bewahren - Ihr Reiseleiter berät Sie gern je nach Ihren Interessen."}, {"q": "Kann man dies mit Pamukkale kombinieren?", "a": "Ephesus und Pamukkale werden aufgrund der Entfernung zueinander als separate Tagestouren angeboten, aber fragen Sie uns gern nach mehrtägigen Kombinationsmöglichkeiten."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'ephesus'), 'ru',
   'Тур в античный город Эфес', 'Прогуляйтесь по мраморным улицам одного из наиболее хорошо сохранившихся античных городов Средиземноморья.', 'Сельчук, Измир, Турция',
   '11 часов - весь день (дальняя поездка)', '06:30, ежедневно', '19:30',
   'Трансфер от отеля по всему полуострову Бодрум',
   '["Немногие античные памятники оживляют историю так, как Эфес. Некогда крупный римский портовый город с населением около 250 000 человек, его мощёные мрамором улицы, величественные фасады и общественные здания сохранились удивительно хорошо, что делает его одним из самых полных классических городов во всём Средиземноморье.", "Ваш гид проведёт вас мимо библиотеки Цельса, Большого театра, некогда вмещавшего 24 000 зрителей, и Террасных домов, где жили состоятельные эфесяне. Многие гости предпочитают объединить визит с посещением расположенных неподалёку Дома Девы Марии и Базилики Святого Иоанна в Сельчуке, оба места богаты собственной историей."]'::jsonb, '["Библиотека Цельса - знаковый фасад Эфеса", "Большой театр, некогда вмещавший 24 000 зрителей", "Мощёная мрамором улица Куретов", "Посещение Дома Девы Марии по желанию", "Объект Всемирного наследия ЮНЕСКО", "Целый день с гидом и остановкой на обед"]'::jsonb,
   '["Трансфер туда и обратно на кондиционированном транспорте", "Трансфер от отеля и обратно", "Англоговорящий лицензированный гид", "Вход на археологический объект Эфес", "Обед в местном ресторане", "Страховка"]'::jsonb, '["Вход в Террасные дома (по желанию, оплата на месте)", "Вход в Дом Девы Марии (по желанию)", "Напитки к обеду", "Чаевые гиду и водителю"]'::jsonb,
   '[{"time": "06:30", "title": "Трансфер из отеля", "text": "Ранний выезд для поездки на север, в Сельчук."}, {"time": "09:30", "title": "Прибытие в Эфес", "text": "Пешая экскурсия с гидом по античному городу."}, {"time": "11:30", "title": "Библиотека Цельса и театр", "text": "Посещение самых знаменитых памятников объекта."}, {"time": "13:00", "title": "Обед", "text": "Остановка в местном ресторане неподалёку от Сельчука."}, {"time": "14:30", "title": "Дополнительные объекты по желанию", "text": "Время для Дома Девы Марии или Террасных домов."}, {"time": "15:30", "title": "Обратный путь", "text": "Дорога обратно в сторону Бодрума, прибытие вечером."}]'::jsonb, '[{"q": "Сколько нужно ходить пешком в Эфесе?", "a": "Основной маршрут по античному городу составляет примерно 1,5-2 км по мраморным и каменным дорожкам, поэтому рекомендуется удобная обувь для ходьбы."}, {"q": "Есть ли на объекте тень?", "a": "В некоторых зонах есть тень, но большая часть объекта открыта - настоятельно рекомендуем защиту от солнца, головной убор и воду, особенно летом."}, {"q": "Стоят ли Террасные дома дополнительной платы за вход?", "a": "Многие гости считают их одним из главных моментов поездки, так как там сохранены оригинальные мозаики и фрески под навесом - ваш гид подскажет с учётом ваших интересов."}, {"q": "Можно ли совместить это с Памуккале?", "a": "Эфес и Памуккале предлагаются как отдельные однодневные туры из-за расстояния между ними, но вы можете спросить нас о вариантах многодневных комбинаций."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'ephesus'), 'pl',
   'Wycieczka do Starożytnego Miasta Efez', 'Przejdźcie się marmurowymi ulicami jednego z najlepiej zachowanych starożytnych miast w basenie Morza Śródziemnego.', 'Selczuk, prowincja Izmir, Turcja',
   '11 godzin - Cały dzień (Duża odległość)', '06:30, codziennie', '19:30',
   'Odbiór z hotelu na całym półwyspie Bodrum',
   '["Niewiele starożytnych miejsc ożywia historię tak jak Efez. Niegdyś ważne rzymskie miasto portowe liczące około 250 000 mieszkańców, jego wybrukowane marmurem ulice, okazałe fasady i budynki publiczne pozostały niezwykle dobrze zachowane, co czyni je jednym z najbardziej kompletnych klasycznych miast w całym basenie Morza Śródziemnego.", "Przewodnik oprowadzi Was obok Biblioteki Celsusa, Wielkiego Teatru, niegdyś mieszczącego 24 000 widzów, oraz Domów Tarasowych, w których mieszkali zamożni mieszkańcy Efezu. Wielu gości decyduje się połączyć wizytę z pobliskim Domem Matki Boskiej i Bazyliką św. Jana w Selczuku - oba miejsca mają bogatą własną historię."]'::jsonb, '["Biblioteka Celsusa - ikoniczna fasada Efezu", "Wielki Teatr, niegdyś mieszczący 24 000 widzów", "Wybrukowana marmurem Ulica Kuretów", "Opcjonalna wizyta w Domu Matki Boskiej", "Obiekt Światowego Dziedzictwa UNESCO", "Całodniowa wycieczka z przewodnikiem i postojem na obiad"]'::jsonb,
   '["Transport w obie strony klimatyzowanym pojazdem", "Odbiór i powrót z hotelu", "Anglojęzyczny licencjonowany przewodnik", "Wstęp na teren wykopalisk w Efezie", "Obiad w lokalnej restauracji", "Ubezpieczenie podróżne"]'::jsonb, '["Wstęp do Domów Tarasowych (opcjonalnie, płatne na miejscu)", "Wstęp do Domu Matki Boskiej (opcjonalnie)", "Napoje do obiadu", "Napiwki dla przewodnika i kierowcy"]'::jsonb,
   '[{"time": "06:30", "title": "Odbiór z hotelu", "text": "Wczesny wyjazd w podróż na północ, do Selczuka."}, {"time": "09:30", "title": "Przybycie do Efezu", "text": "Piesza wycieczka z przewodnikiem po starożytnym mieście."}, {"time": "11:30", "title": "Biblioteka Celsusa i Teatr", "text": "Zwiedzanie najsłynniejszych zabytków tego miejsca."}, {"time": "13:00", "title": "Obiad", "text": "Postój w lokalnej restauracji w pobliżu Selczuka."}, {"time": "14:30", "title": "Opcjonalne dodatkowe miejsca", "text": "Czas na Dom Matki Boskiej lub Domy Tarasowe."}, {"time": "15:30", "title": "Podróż powrotna", "text": "Jazda z powrotem w kierunku Bodrum, przybycie wieczorem."}]'::jsonb, '[{"q": "Ile trzeba chodzić w Efezie?", "a": "Główna trasa przez starożytne miasto obejmuje około 1,5-2 km po marmurowych i kamiennych ścieżkach, dlatego zalecane są wygodne buty do chodzenia."}, {"q": "Czy na miejscu jest cień?", "a": "Niektóre obszary oferują cień, ale większa część terenu jest odkryta - zdecydowanie zalecamy ochronę przeciwsłoneczną, nakrycie głowy i wodę, zwłaszcza latem."}, {"q": "Czy Domy Tarasowe są warte dodatkowej opłaty za wstęp?", "a": "Wielu gości uważa je za jeden z najważniejszych punktów, ponieważ zachowały oryginalne mozaiki i freski pod zadaszeniem - przewodnik doradzi w oparciu o Państwa zainteresowania."}, {"q": "Czy można to połączyć z Pamukkale?", "a": "Efez i Pamukkale są oferowane jako osobne wycieczki jednodniowe ze względu na odległość między nimi, ale zapytajcie nas o opcje wielodniowych kombinacji."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dalyan'), 'tr',
   'Dalyan Turu', 'Nehir tekneleri, antik kaya mezarları, şifalı çamur banyoları ve Kaplumbağa Plajı, tek bir dolu dolu günde.', 'Dalyan, Muğla, Türkiye',
   '12 Saat - Tam Gün', '07:00, Her Gün', '19:00',
   'Bodrum yarımadası genelinde otelden alış',
   '["Dalyan, tek bir güne olağanüstü bir çeşitlilik sığdırıyor. Sazlıklarla çevrili Dalyan Nehri''nde tekneyle gezecek, üzerinde yükselen yamaca doğrudan oyulmuş etkileyici Likya kaya mezarlarının altından geçeceksiniz - çarpıcı ve fotoğrafik bir gün başlangıcı.", "Oradan tekne, antik Kaunos kalıntılarına, şifalı bir çamur banyosu ve kaplıca molasına, son olarak da kumsalında yuva yapan iri başlı deniz kaplumbağalarıyla tanınan Kaplumbağa Plajı olarak da bilinen İztuzu Plajı''na devam eder. Tarih, doğa ve dinlenmeyi harmanlayan dolu dolu, akılda kalıcı bir gün."]'::jsonb, '["Likya kaya mezarlarının önünden tekne turu", "Antik Kaunos kalıntıları", "Şifalı çamur banyosu ve kaplıca molası", "İztuzu ''Kaplumbağa Plajı''nda serbest zaman", "Kaplumbağalar ve kuş türlerini içeren nehir yaşamı", "Öğle yemeği molalı tam gün rehberli deneyim"]'::jsonb,
   '["Klimalı araçla gidiş-dönüş ulaşım", "Nehir tekne turu", "Otel alış ve bırakış hizmeti", "İngilizce konuşan tur rehberi", "Çamur banyosu ve kaplıca girişi", "Yerel bir restoranda öğle yemeği"]'::jsonb, '["Öğle yemeğiyle içecekler", "Kişisel harcamalar ve hediyelik eşyalar", "Kaunos kalıntıları giriş ücreti (küçük, yerinde ödemeli)", "Rehber ve şoför için bahşiş"]'::jsonb,
   '[{"time": "07:00", "title": "Otelden Alış", "text": "Dalyan nehir deltasına doğru hareket."}, {"time": "10:00", "title": "Nehir Tekne Turu", "text": "Likya kaya mezarları ve sazlıkların önünden geçilir."}, {"time": "11:00", "title": "Kaunos Kalıntıları", "text": "Nehir kıyısındaki antik kalıntılar ziyaret edilir."}, {"time": "12:00", "title": "Çamur Banyosu ve Kaplıca", "text": "Şifalı çamur ve mineralli havuzların keyfini çıkarma zamanı."}, {"time": "13:30", "title": "Öğle Yemeği", "text": "Yerel bir restoranda mola."}, {"time": "14:30", "title": "İztuzu Kaplumbağa Plajı", "text": "Ünlü plajda dinlenme ve yüzme için serbest zaman."}]'::jsonb, '[{"q": "Kaplumbağa Plajı''nda gerçekten kaplumbağa görebilir miyiz?", "a": "İri başlı deniz kaplumbağaları mevsimsel olarak İztuzu Plajı boyunca yuva yapar; suda görülme ihtimali vardır ama garanti edilemez - plajın kendisi her halükarda çok güzeldir."}, {"q": "Çamur banyosu fiyata dahil mi?", "a": "Evet, çamur banyosu ve kaplıca havuzlarına giriş tur paketinize dahildir."}, {"q": "Dalyan turu için ne getirmeliyim?", "a": "Gün hem çamur banyosunu hem de plajı içerdiğinden mayo, havlu, güneş kremi ve yedek kıyafet önerilir."}, {"q": "Bu sakin bir tur mu yoksa aktif bir tur mu?", "a": "İyi bir karışımdır - tekne turu ve plaj zamanı sakindir, Kaunos kalıntılarında ise sadece biraz yürüyüş vardır."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dalyan'), 'en',
   'Dalyan Tour', 'River boats, ancient rock tombs, therapeutic mud baths and Turtle Beach in one varied day.', 'Dalyan, Mugla Province, Türkiye',
   '12 Hours - Full Day', '07:00 AM, Daily', '19:00 PM',
   'Hotel pick-up across the Bodrum peninsula',
   '["Dalyan packs an unusual amount of variety into a single day. You''ll cruise the reed-lined Dalyan River by boat, passing beneath the dramatic Lycian rock tombs carved directly into the cliffside above - a striking, photogenic start to the day.", "From there, the boat continues to the ruins of ancient Kaunos, a therapeutic mud bath and hot spring stop, and finally Iztuzu Beach - also known as Turtle Beach for the loggerhead sea turtles that nest along its sands. It''s a full, memorable day that mixes history, nature and relaxation."]'::jsonb, '["Boat cruise past the Lycian rock tombs", "Ancient ruins of Kaunos", "Therapeutic mud bath and hot spring stop", "Iztuzu ''Turtle Beach'' free time", "River wildlife including turtles and birdlife", "Full-day guided experience with lunch stop"]'::jsonb,
   '["Round-trip transport in air-conditioned vehicle", "River boat cruise", "Hotel pick-up and drop-off", "English-speaking tour guide", "Mud bath and hot spring entrance", "Lunch at a local restaurant"]'::jsonb, '["Drinks with lunch", "Personal expenses and souvenirs", "Kaunos ruins entrance fee (small, paid locally)", "Gratuities for the guide and driver"]'::jsonb,
   '[{"time": "07:00", "title": "Hotel Pick-up", "text": "Departure toward the Dalyan river delta."}, {"time": "10:00", "title": "River Boat Cruise", "text": "Cruise past the Lycian rock tombs and reed beds."}, {"time": "11:00", "title": "Kaunos Ruins", "text": "Visit the ancient ruins on the riverbank."}, {"time": "12:00", "title": "Mud Bath & Hot Springs", "text": "Time to enjoy the therapeutic mud and mineral pools."}, {"time": "13:30", "title": "Lunch", "text": "A stop at a local restaurant."}, {"time": "14:30", "title": "Iztuzu Turtle Beach", "text": "Free time to relax and swim at the famous beach."}]'::jsonb, '[{"q": "Will we actually see turtles at Turtle Beach?", "a": "Loggerhead turtles nest along Iztuzu Beach seasonally and sightings in the water are possible but not guaranteed - the beach itself is beautiful either way."}, {"q": "Is the mud bath included in the price?", "a": "Yes, entrance to the mud bath and hot spring pools is included in your tour package."}, {"q": "What should I bring for the Dalyan tour?", "a": "A swimsuit, towel, sunscreen and a change of clothes are recommended, since the day includes both the mud bath and the beach."}, {"q": "Is this a relaxed or active tour?", "a": "It''s a good mix - boat cruising and beach time are relaxed, with just a little walking at the Kaunos ruins."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dalyan'), 'de',
   'Dalyan Tour', 'Flussboote, antike Felsengräber, Heilschlammbäder und Turtle Beach an einem abwechslungsreichen Tag.', 'Dalyan, Provinz Mugla, Türkei',
   '12 Stunden - Ganztägig', '07:00 Uhr, täglich', '19:00 Uhr',
   'Hotelabholung auf der gesamten Bodrum-Halbinsel',
   '["Dalyan vereint ein ungewöhnliches Maß an Abwechslung in einem einzigen Tag. Sie fahren mit dem Boot den schilfgesäumten Fluss Dalyan entlang und passieren dabei die eindrucksvollen lykischen Felsengräber, die direkt in die darüberliegende Klippe gehauen sind - ein markanter, fotogener Start in den Tag.", "Von dort führt die Bootsfahrt weiter zu den Ruinen des antiken Kaunos, einem Halt an einem Heilschlammbad mit heißer Quelle und schließlich zum Iztuzu-Strand - auch bekannt als ''Turtle Beach'' wegen der Karettschildkröten, die dort an den Stränden nisten. Ein voller, unvergesslicher Tag, der Geschichte, Natur und Entspannung verbindet."]'::jsonb, '["Bootsfahrt vorbei an den lykischen Felsengräbern", "Antike Ruinen von Kaunos", "Halt an Heilschlammbad und heißer Quelle", "Freizeit am Iztuzu ''Turtle Beach''", "Tierwelt am Fluss, einschließlich Schildkröten und Vögel", "Ganztägiges geführtes Erlebnis mit Mittagspause"]'::jsonb,
   '["Hin- und Rücktransport im klimatisierten Fahrzeug", "Flussbootfahrt", "Hotelabholung und -rückbringung", "Englischsprachiger Reiseleiter", "Eintritt zu Schlammbad und heißer Quelle", "Mittagessen in einem lokalen Restaurant"]'::jsonb, '["Getränke zum Mittagessen", "Persönliche Ausgaben und Souvenirs", "Eintrittsgebühr zu den Kaunos-Ruinen (gering, vor Ort zu zahlen)", "Trinkgeld für Reiseleiter und Fahrer"]'::jsonb,
   '[{"time": "07:00", "title": "Hotelabholung", "text": "Abfahrt in Richtung des Dalyan-Flussdeltas."}, {"time": "10:00", "title": "Flussbootfahrt", "text": "Fahrt vorbei an den lykischen Felsengräbern und Schilfgebieten."}, {"time": "11:00", "title": "Ruinen von Kaunos", "text": "Besuch der antiken Ruinen am Flussufer."}, {"time": "12:00", "title": "Schlammbad und heiße Quelle", "text": "Zeit, das Heilschlamm- und Mineralbad zu genießen."}, {"time": "13:30", "title": "Mittagessen", "text": "Halt in einem lokalen Restaurant."}, {"time": "14:30", "title": "Iztuzu Turtle Beach", "text": "Freizeit zum Entspannen und Baden am berühmten Strand."}]'::jsonb, '[{"q": "Sehen wir am Turtle Beach wirklich Schildkröten?", "a": "Karettschildkröten nisten saisonal am Iztuzu-Strand, und Sichtungen im Wasser sind möglich, aber nicht garantiert - der Strand selbst ist so oder so wunderschön."}, {"q": "Ist das Schlammbad im Preis inbegriffen?", "a": "Ja, der Eintritt zum Schlammbad und den heißen Quellen ist in Ihrem Tourpaket enthalten."}, {"q": "Was sollte ich für die Dalyan-Tour mitbringen?", "a": "Badebekleidung, Handtuch, Sonnencreme und Wechselkleidung werden empfohlen, da der Tag sowohl das Schlammbad als auch den Strand umfasst."}, {"q": "Ist dies eine entspannte oder aktive Tour?", "a": "Es ist eine gute Mischung - Bootsfahrt und Strandzeit sind entspannt, mit nur etwas Gehen bei den Kaunos-Ruinen."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dalyan'), 'ru',
   'Тур в Даламан (Дальян)', 'Речные лодки, античные скальные гробницы, лечебные грязевые ванны и пляж черепах за один насыщенный день.', 'Дальян, Мугла, Турция',
   '12 часов - весь день', '07:00, ежедневно', '19:00',
   'Трансфер от отеля по всему полуострову Бодрум',
   '["Дальян вмещает в один день необычайное разнообразие впечатлений. Вы отправитесь на лодке по реке Дальян, окружённой тростником, минуя впечатляющие ликийские скальные гробницы, вырубленные прямо в скале над водой - яркое, фотогеничное начало дня.", "Далее лодка проследует к руинам античного Кавноса, остановке у лечебной грязевой ванны с горячим источником и, наконец, к пляжу Изтузу, также известному как ''пляж черепах'' благодаря головастым морским черепахам, гнездящимся на его песке. Насыщенный, незабываемый день, объединяющий историю, природу и отдых."]'::jsonb, '["Прогулка на лодке мимо ликийских скальных гробниц", "Античные руины Кавноса", "Остановка у лечебной грязевой ванны и горячего источника", "Свободное время на пляже Изтузу (''пляж черепах'')", "Речная фауна, включая черепах и птиц", "Целый день с гидом и остановкой на обед"]'::jsonb,
   '["Трансфер туда и обратно на кондиционированном транспорте", "Прогулка на речной лодке", "Трансфер от отеля и обратно", "Англоговорящий гид", "Вход в грязевую ванну и горячий источник", "Обед в местном ресторане"]'::jsonb, '["Напитки к обеду", "Личные расходы и сувениры", "Входная плата в руины Кавноса (небольшая, на месте)", "Чаевые гиду и водителю"]'::jsonb,
   '[{"time": "07:00", "title": "Трансфер из отеля", "text": "Выезд в сторону дельты реки Дальян."}, {"time": "10:00", "title": "Прогулка на речной лодке", "text": "Проезд мимо ликийских скальных гробниц и тростниковых зарослей."}, {"time": "11:00", "title": "Руины Кавноса", "text": "Посещение античных руин на берегу реки."}, {"time": "12:00", "title": "Грязевая ванна и горячий источник", "text": "Время насладиться лечебной грязью и минеральными бассейнами."}, {"time": "13:30", "title": "Обед", "text": "Остановка в местном ресторане."}, {"time": "14:30", "title": "Пляж черепах Изтузу", "text": "Свободное время для отдыха и купания на знаменитом пляже."}]'::jsonb, '[{"q": "Действительно ли мы увидим черепах на пляже черепах?", "a": "Головастые морские черепахи сезонно гнездятся на пляже Изтузу, и встреча с ними в воде возможна, но не гарантирована - сам пляж прекрасен в любом случае."}, {"q": "Включена ли грязевая ванна в стоимость?", "a": "Да, вход в грязевую ванну и минеральные бассейны включён в ваш тур-пакет."}, {"q": "Что взять с собой на тур в Дальян?", "a": "Рекомендуем купальник, полотенце, солнцезащитный крем и сменную одежду, так как день включает и грязевую ванну, и пляж."}, {"q": "Это спокойный или активный тур?", "a": "Хорошее сочетание - прогулка на лодке и время на пляже спокойные, лишь немного ходьбы у руин Кавноса."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'dalyan'), 'pl',
   'Wycieczka do Dalyan', 'Łodzie rzeczne, starożytne grobowce skalne, lecznicze kąpiele błotne i Plaża Żółwi w jeden urozmaicony dzień.', 'Dalyan, prowincja Mugla, Turcja',
   '12 godzin - Cały dzień', '07:00, codziennie', '19:00',
   'Odbiór z hotelu na całym półwyspie Bodrum',
   '["Dalyan mieści w jednym dniu niezwykłą różnorodność atrakcji. Popłyniecie łodzią porośniętą trzciną rzeką Dalyan, mijając imponujące likijskie grobowce skalne, wykute bezpośrednio w klifie nad wodą - efektowny, fotogeniczny początek dnia.", "Stamtąd łódź płynie dalej do ruin starożytnego Kaunos, na postój przy leczniczej kąpieli błotnej z gorącym źródłem, a na koniec na plażę Iztuzu - znaną również jako ''Plaża Żółwi'' ze względu na żółwie karetta karetta gniazdujące na jej piaskach. Pełen, niezapomniany dzień łączący historię, naturę i relaks."]'::jsonb, '["Rejs łodzią obok likijskich grobowców skalnych", "Starożytne ruiny Kaunos", "Postój przy leczniczej kąpieli błotnej i gorącym źródle", "Czas wolny na plaży Iztuzu (''Plaża Żółwi'')", "Fauna rzeczna, w tym żółwie i ptaki", "Całodniowa wycieczka z przewodnikiem i postojem na obiad"]'::jsonb,
   '["Transport w obie strony klimatyzowanym pojazdem", "Rejs łodzią rzeczną", "Odbiór i powrót z hotelu", "Anglojęzyczny przewodnik", "Wstęp do kąpieli błotnej i gorącego źródła", "Obiad w lokalnej restauracji"]'::jsonb, '["Napoje do obiadu", "Wydatki osobiste i pamiątki", "Opłata wstępu do ruin Kaunos (niewielka, na miejscu)", "Napiwki dla przewodnika i kierowcy"]'::jsonb,
   '[{"time": "07:00", "title": "Odbiór z hotelu", "text": "Wyjazd w kierunku delty rzeki Dalyan."}, {"time": "10:00", "title": "Rejs łodzią rzeczną", "text": "Przepłynięcie obok likijskich grobowców skalnych i trzcinowisk."}, {"time": "11:00", "title": "Ruiny Kaunos", "text": "Zwiedzanie starożytnych ruin nad brzegiem rzeki."}, {"time": "12:00", "title": "Kąpiel błotna i gorące źródło", "text": "Czas na cieszenie się leczniczym błotem i basenami mineralnymi."}, {"time": "13:30", "title": "Obiad", "text": "Postój w lokalnej restauracji."}, {"time": "14:30", "title": "Plaża Żółwi Iztuzu", "text": "Czas wolny na relaks i kąpiel na słynnej plaży."}]'::jsonb, '[{"q": "Czy naprawdę zobaczymy żółwie na Plaży Żółwi?", "a": "Żółwie karetta karetta sezonowo gniazdują wzdłuż plaży Iztuzu, a ich obserwacja w wodzie jest możliwa, ale nie gwarantowana - sama plaża jest piękna niezależnie od tego."}, {"q": "Czy kąpiel błotna jest wliczona w cenę?", "a": "Tak, wstęp do kąpieli błotnej i basenów mineralnych jest wliczony w Państwa pakiet wycieczkowy."}, {"q": "Co zabrać na wycieczkę do Dalyan?", "a": "Zalecamy strój kąpielowy, ręcznik, krem z filtrem i zmianę ubrania, ponieważ dzień obejmuje zarówno kąpiel błotną, jak i plażę."}, {"q": "Czy to spokojna czy aktywna wycieczka?", "a": "To dobra mieszanka - rejs łodzią i czas na plaży są spokojne, z niewielką ilością chodzenia przy ruinach Kaunos."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'rafting'), 'tr',
   'Rafting Macerası', 'Bölgenin akarsuyunda, manzaralı bir kanyon boyunca rehberli bir rafting turu için günübirlik gezi.', 'Dalaman Nehri Kanyonu, Türkiye',
   '12 Saat - Tam Gün (Uzun Mesafe)', '07:00, Her Gün', '19:00',
   'Bodrum yarımadası genelinde otelden alış',
   '["Bodrum yarımadasının kendisinde akarsu bulunmadığından, bu tur sizi bölgenin rafting nehrine, çam kaplı kayalıklardan oluşan bir kanyona götürür; burada serin ve hızlı akan sular, plaj gününe gerçek anlamda heyecan verici bir kontrast sunar.", "Bir güvenlik brifingi ve sakin suda kısa bir deneme kürek çekmenin ardından rehberiniz, küçük bir rafting ekibini yeni başlayanlara uygun bir dizi akıntı boyunca yönlendirir; aralarında kanyon manzarasının tadını çıkarabileceğiniz daha sakin bölümler de bulunur. Deneyim gerekmez ve tüm güvenlik ekipmanı sağlanır."]'::jsonb, '["Yeni başlayanlara uygun rehberli rafting", "Çam kaplı kayalıklardan oluşan manzaralı kanyon", "Deneyimli rehberle küçük rafting ekipleri", "Güvenlik brifingi ve deneme kürek çekme dahil", "Nehir kenarında öğle yemeği molası", "Manzaralı transferli tam gün gezi"]'::jsonb,
   '["Rafting ekipmanı (bot, kürek, kask, can yeleği)", "Deneyimli rafting rehberi", "Klimalı araçla gidiş-dönüş ulaşım", "Otel alış ve bırakış hizmeti", "Nehir kenarında öğle yemeği", "Seyahat sigortası"]'::jsonb, '["Yedek kıyafet (ıslanacaksınız)", "Su geçirmez kamera/fotoğraf paketi (satın alınabilir)", "Kişisel harcamalar", "Rehber için bahşiş"]'::jsonb,
   '[{"time": "07:00", "title": "Otelden Alış", "text": "Rafting bölgesine doğru hareket."}, {"time": "10:30", "title": "Güvenlik Brifingi", "text": "Ekipman ayarlama ve sakin suda deneme kürek çekme."}, {"time": "11:00", "title": "Rafting Parkuru", "text": "Rehberiniz ve rafting ekibinizle akıntılarda ilerleme."}, {"time": "13:00", "title": "Nehir Kenarında Öğle Yemeği", "text": "Kanyonda rahat bir öğle yemeği molası."}, {"time": "14:30", "title": "Serbest Zaman", "text": "Hareketten önce isteğe bağlı sakin sürüklenme veya nehir kenarında zaman."}, {"time": "15:30", "title": "Dönüş Yolculuğu", "text": "Bodrum''a doğru yola çıkılır, akşam saatlerinde varılır."}]'::jsonb, '[{"q": "Rafting deneyimim olması gerekir mi?", "a": "Hayır, bu turda kullanılan parkur ilk kez katılanlara uygundur ve rehberiniz önceden tam bir güvenlik brifingi ile ekibi yönlendirir."}, {"q": "Tamamen ıslanır mıyım?", "a": "Evet, boyunca ıslanmayı bekleyin - eve dönüş yolculuğu için tam bir yedek kıyafet getirin."}, {"q": "Rafting için minimum yaş nedir?", "a": "Genellikle 7 yaş civarından itibaren, ancak bu o günkü nehir koşullarına göre değişebilir - rezervasyon yaparken grubunuzdaki yaşları bize bildirin."}, {"q": "İyi yüzemiyorsam güvenli mi?", "a": "Can yelekleri her zaman giyilir ve rehber nehir güvenliği konusunda eğitimlidir; ancak grubunuzda kendine güvenmeyen bir yüzücü varsa lütfen önceden bize bildirin."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'rafting'), 'en',
   'Rafting Adventure', 'A day trip to the region''s whitewater river for a guided rafting run through a scenic canyon.', 'Dalaman River Canyon, Türkiye',
   '12 Hours - Full Day (Long Distance)', '07:00 AM, Daily', '19:00 PM',
   'Hotel pick-up across the Bodrum peninsula',
   '["There''s no whitewater on the Bodrum peninsula itself, so this tour takes you inland to the region''s rafting river, where a canyon of pine-covered cliffs and cool, fast-moving water make for a genuinely thrilling contrast to a day at the beach.", "After a safety briefing and short practice paddle in calm water, your guide leads a small raft crew down a series of rapids suited to beginners, with plenty of calmer stretches to relax and take in the canyon scenery in between. No experience is necessary and all safety equipment is provided."]'::jsonb, '["Guided whitewater rafting suited to beginners", "Scenic canyon of pine-covered cliffs", "Small raft crews with an experienced guide", "Safety briefing and practice paddle included", "Lunch stop by the river", "Full-day excursion with scenic transfer"]'::jsonb,
   '["Rafting equipment (raft, paddle, helmet, life jacket)", "Experienced rafting guide", "Round-trip transport in air-conditioned vehicle", "Hotel pick-up and drop-off", "Lunch by the river", "Travel insurance"]'::jsonb, '["Change of clothes (you will get wet)", "Waterproof camera/photo package (available to purchase)", "Personal expenses", "Gratuities for the guide"]'::jsonb,
   '[{"time": "07:00", "title": "Hotel Pick-up", "text": "Departure toward the rafting region."}, {"time": "10:30", "title": "Safety Briefing", "text": "Equipment fitting and a practice paddle in calm water."}, {"time": "11:00", "title": "Rafting Run", "text": "Navigate the rapids with your guide and raft crew."}, {"time": "13:00", "title": "Lunch by the River", "text": "A relaxed lunch stop in the canyon."}, {"time": "14:30", "title": "Free Time", "text": "Optional relaxing float or riverside time before departure."}, {"time": "15:30", "title": "Return Journey", "text": "Drive back toward Bodrum, arriving in the evening."}]'::jsonb, '[{"q": "Do I need rafting experience?", "a": "No, the route used on this tour is suited to first-timers, and your guide steers the raft crew through a full safety briefing beforehand."}, {"q": "Will I get completely wet?", "a": "Yes, expect to get wet throughout - bring a full change of clothes for the journey home."}, {"q": "What is the minimum age for rafting?", "a": "Generally from around age 7, though this can vary with river conditions on the day - let us know the ages in your group when booking."}, {"q": "Is it safe if I can''t swim well?", "a": "Life jackets are worn at all times and the guide is trained in river safety, but please let us know in advance if anyone in your group is not a confident swimmer."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'rafting'), 'de',
   'Rafting-Abenteuer', 'Ein Tagesausflug zum Wildwasserfluss der Region für eine geführte Raftingfahrt durch eine malerische Schlucht.', 'Dalaman-Fluss-Schlucht, Türkei',
   '12 Stunden - Ganztägig (Langstrecke)', '07:00 Uhr, täglich', '19:00 Uhr',
   'Hotelabholung auf der gesamten Bodrum-Halbinsel',
   '["Da es auf der Bodrum-Halbinsel selbst kein Wildwasser gibt, führt diese Tour Sie ins Landesinnere zum Raftingfluss der Region, wo eine Schlucht mit pinienbewachsenen Klippen und kühlem, schnell fließendem Wasser für einen wirklich spannenden Kontrast zu einem Strandtag sorgt.", "Nach einer Sicherheitseinweisung und einem kurzen Übungspaddeln in ruhigem Wasser führt Ihr Guide eine kleine Rafting-Crew durch eine Reihe von für Anfänger geeigneten Stromschnellen, mit reichlich ruhigeren Abschnitten dazwischen, um die Schluchtlandschaft zu genießen. Erfahrung ist nicht erforderlich, und die gesamte Sicherheitsausrüstung wird gestellt."]'::jsonb, '["Geführtes Wildwasser-Rafting für Anfänger geeignet", "Malerische Schlucht mit pinienbewachsenen Klippen", "Kleine Rafting-Crews mit erfahrenem Guide", "Sicherheitseinweisung und Übungspaddeln inbegriffen", "Mittagspause am Fluss", "Ganztägiger Ausflug mit malerischem Transfer"]'::jsonb,
   '["Rafting-Ausrüstung (Boot, Paddel, Helm, Schwimmweste)", "Erfahrener Rafting-Guide", "Hin- und Rücktransport im klimatisierten Fahrzeug", "Hotelabholung und -rückbringung", "Mittagessen am Fluss", "Reiseversicherung"]'::jsonb, '["Wechselkleidung (Sie werden nass)", "Wasserdichtes Kamera-/Fotopaket (käuflich)", "Persönliche Ausgaben", "Trinkgeld für den Guide"]'::jsonb,
   '[{"time": "07:00", "title": "Hotelabholung", "text": "Abfahrt in Richtung der Rafting-Region."}, {"time": "10:30", "title": "Sicherheitseinweisung", "text": "Anpassung der Ausrüstung und Übungspaddeln in ruhigem Wasser."}, {"time": "11:00", "title": "Rafting-Strecke", "text": "Bewältigung der Stromschnellen mit Ihrem Guide und Ihrer Rafting-Crew."}, {"time": "13:00", "title": "Mittagessen am Fluss", "text": "Entspannte Mittagspause in der Schlucht."}, {"time": "14:30", "title": "Freizeit", "text": "Optionales entspanntes Treiben oder Zeit am Flussufer vor der Abfahrt."}, {"time": "15:30", "title": "Rückfahrt", "text": "Fahrt zurück Richtung Bodrum, Ankunft am Abend."}]'::jsonb, '[{"q": "Brauche ich Rafting-Erfahrung?", "a": "Nein, die bei dieser Tour genutzte Strecke ist für Einsteiger geeignet, und Ihr Guide leitet die Rafting-Crew zuvor durch eine vollständige Sicherheitseinweisung."}, {"q": "Werde ich komplett nass?", "a": "Ja, rechnen Sie damit, durchgehend nass zu werden - bringen Sie für die Heimfahrt komplette Wechselkleidung mit."}, {"q": "Was ist das Mindestalter fürs Rafting?", "a": "In der Regel ab etwa 7 Jahren, kann jedoch je nach Flussbedingungen am jeweiligen Tag variieren - teilen Sie uns bei der Buchung das Alter Ihrer Gruppe mit."}, {"q": "Ist es sicher, wenn ich nicht gut schwimmen kann?", "a": "Schwimmwesten werden durchgehend getragen und der Guide ist in Flusssicherheit geschult, teilen Sie uns aber bitte im Voraus mit, falls jemand in Ihrer Gruppe kein sicherer Schwimmer ist."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'rafting'), 'ru',
   'Рафтинг-приключение', 'Однодневная поездка на реку региона для рафтинга с гидом через живописный каньон.', 'Каньон реки Даламан, Турция',
   '12 часов - весь день (дальняя поездка)', '07:00, ежедневно', '19:00',
   'Трансфер от отеля по всему полуострову Бодрум',
   '["Поскольку на самом полуострове Бодрум нет порожистых рек, этот тур везёт вас вглубь материка к реке региона для рафтинга, где каньон с покрытыми соснами скалами и прохладной быстрой водой создаёт по-настоящему захватывающий контраст пляжному дню.", "После инструктажа по безопасности и короткой тренировки на спокойной воде ваш гид ведёт небольшой экипаж по серии порогов, подходящих для новичков, с достаточным количеством спокойных участков между ними для наслаждения пейзажем каньона. Опыт не требуется, всё защитное снаряжение предоставляется."]'::jsonb, '["Рафтинг с гидом, подходящий для новичков", "Живописный каньон с покрытыми соснами скалами", "Небольшие экипажи с опытным гидом", "Инструктаж по безопасности и тренировочное гребля включены", "Обеденный перерыв у реки", "Целый день с живописным трансфером"]'::jsonb,
   '["Снаряжение для рафтинга (плот, весло, шлем, спасательный жилет)", "Опытный гид по рафтингу", "Трансфер туда и обратно на кондиционированном транспорте", "Трансфер от отеля и обратно", "Обед у реки", "Страховка"]'::jsonb, '["Сменная одежда (вы промокнете)", "Водонепроницаемый фото/видео пакет (можно приобрести)", "Личные расходы", "Чаевые гиду"]'::jsonb,
   '[{"time": "07:00", "title": "Трансфер из отеля", "text": "Выезд в сторону региона рафтинга."}, {"time": "10:30", "title": "Инструктаж по безопасности", "text": "Подгонка снаряжения и тренировочная гребля на спокойной воде."}, {"time": "11:00", "title": "Маршрут рафтинга", "text": "Прохождение порогов вместе с гидом и экипажем."}, {"time": "13:00", "title": "Обед у реки", "text": "Спокойный обеденный перерыв в каньоне."}, {"time": "14:30", "title": "Свободное время", "text": "Опциональный спокойный сплав или время у берега перед отъездом."}, {"time": "15:30", "title": "Обратный путь", "text": "Дорога обратно в сторону Бодрума, прибытие вечером."}]'::jsonb, '[{"q": "Нужен ли мне опыт рафтинга?", "a": "Нет, маршрут, используемый в этом туре, подходит для новичков, и ваш гид проведёт полный инструктаж по безопасности перед стартом."}, {"q": "Я полностью промокну?", "a": "Да, будьте готовы промокнуть на всём протяжении - возьмите с собой полный комплект сменной одежды для обратной дороги."}, {"q": "Какой минимальный возраст для рафтинга?", "a": "Обычно от 7 лет, но это может меняться в зависимости от состояния реки в конкретный день - сообщите нам возраст участников вашей группы при бронировании."}, {"q": "Безопасно ли это, если я плохо плаваю?", "a": "Спасательные жилеты надеваются постоянно, а гид обучен речной безопасности, но, пожалуйста, сообщите нам заранее, если кто-то в вашей группе не уверенно плавает."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'rafting'), 'pl',
   'Przygoda z Raftingiem', 'Jednodniowa wycieczka na rzekę górską regionu na spływ raftingowy z przewodnikiem przez malowniczy kanion.', 'Kanion Rzeki Dalaman, Turcja',
   '12 godzin - Cały dzień (Duża odległość)', '07:00, codziennie', '19:00',
   'Odbiór z hotelu na całym półwyspie Bodrum',
   '["Ponieważ na samym półwyspie Bodrum nie ma rzek górskich, ta wycieczka zabiera Was w głąb lądu, na rzekę raftingową regionu, gdzie kanion z porośniętymi sosnami klifami i chłodną, wartko płynącą wodą tworzy naprawdę ekscytujący kontrast dla dnia na plaży.", "Po instruktażu bezpieczeństwa i krótkim treningu wiosłowania na spokojnej wodzie przewodnik prowadzi niewielką załogę przez serię progów odpowiednich dla początkujących, z wieloma spokojniejszymi odcinkami pomiędzy nimi na podziwianie krajobrazu kanionu. Doświadczenie nie jest wymagane, a cały sprzęt ochronny jest zapewniony."]'::jsonb, '["Rafting z przewodnikiem odpowiedni dla początkujących", "Malowniczy kanion z porośniętymi sosnami klifami", "Niewielkie załogi z doświadczonym przewodnikiem", "Instruktaż bezpieczeństwa i trening wiosłowania w cenie", "Przerwa na obiad nad rzeką", "Całodniowa wycieczka z malowniczym transferem"]'::jsonb,
   '["Sprzęt raftingowy (tratwa, wiosło, kask, kamizelka ratunkowa)", "Doświadczony przewodnik raftingowy", "Transport w obie strony klimatyzowanym pojazdem", "Odbiór i powrót z hotelu", "Obiad nad rzeką", "Ubezpieczenie podróżne"]'::jsonb, '["Zmiana ubrania (zmoczą się Państwo)", "Wodoodporny pakiet foto/wideo (do kupienia)", "Wydatki osobiste", "Napiwek dla przewodnika"]'::jsonb,
   '[{"time": "07:00", "title": "Odbiór z hotelu", "text": "Wyjazd w kierunku regionu raftingowego."}, {"time": "10:30", "title": "Instruktaż bezpieczeństwa", "text": "Dopasowanie sprzętu i trening wiosłowania na spokojnej wodzie."}, {"time": "11:00", "title": "Trasa raftingowa", "text": "Pokonywanie progów wraz z przewodnikiem i załogą."}, {"time": "13:00", "title": "Obiad nad rzeką", "text": "Spokojna przerwa obiadowa w kanionie."}, {"time": "14:30", "title": "Czas wolny", "text": "Opcjonalny spokojny spływ lub czas nad brzegiem rzeki przed wyjazdem."}, {"time": "15:30", "title": "Podróż powrotna", "text": "Jazda z powrotem w kierunku Bodrum, przybycie wieczorem."}]'::jsonb, '[{"q": "Czy potrzebne jest doświadczenie w raftingu?", "a": "Nie, trasa używana w tej wycieczce jest odpowiednia dla początkujących, a przewodnik przeprowadzi pełny instruktaż bezpieczeństwa przed startem."}, {"q": "Czy całkowicie się zmoczę?", "a": "Tak, należy spodziewać się zmoczenia przez cały czas - proszę zabrać na drogę powrotną pełną zmianę ubrania."}, {"q": "Jaki jest minimalny wiek do raftingu?", "a": "Zazwyczaj od około 7 roku życia, choć może się to różnić w zależności od stanu rzeki danego dnia - proszę podać wiek uczestników grupy przy rezerwacji."}, {"q": "Czy to bezpieczne, jeśli słabo pływam?", "a": "Kamizelki ratunkowe są noszone przez cały czas, a przewodnik jest przeszkolony w zakresie bezpieczeństwa rzecznego, ale prosimy o wcześniejsze zgłoszenie, jeśli ktoś w grupie słabo pływa."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'airport-transfer'), 'tr',
   'Havalimanı Transferi', 'Milas-Bodrum Havalimanı ile oteliniz arasında doğrudan, güvenilir transfer; uçuş takibi dahil.', 'Milas-Bodrum Havalimanı (BJV) - Bodrum Yarımadası Otelleri',
   '45-70 Dakika (varış noktasına göre)', 'Talep Üzerine, 7/24', 'Uçuş saatinize göre ayarlanır',
   'Havalimanı geliş salonu / otel lobiniz',
   '["Uzun bir uçuşun ardından iniş yapmak, taksi ücreti pazarlığı yapılacak bir an değildir. Havalimanı Transferi hizmetimizde, geliş salonunda isminizle bekleyen bir şoför, sizi Bodrum yarımadasında herhangi bir yerdeki otelinize doğrudan götürmeye hazırdır.", "Uçuşunuzu gerçek zamanlı olarak takip ediyoruz; bu yüzden gecikse bile şoförünüz siz indiğinizde orada olacaktır. Aynı hizmet, check-in''e bolca vaktiniz kalacak şekilde ayarlanmış olarak dönüş yolculuğunuz için de tersine işler."]'::jsonb, '["Geliş salonunda isim tabelasıyla bekleyen şoför", "Gecikme ne olursa olsun gerçek zamanlı uçuş takibi", "Yarımada genelindeki otellere doğrudan güzergah", "Konforlu, klimalı araçlar", "7/24 hizmet", "Sabit fiyat, sürpriz yok"]'::jsonb,
   '["Özel transfer aracı", "Geliş salonunda isim tabelasıyla karşılama", "Uçuş takibi ve bekleme süresi", "Araçta şişe suyu", "Tüm geçiş ücretleri ve havalimanı harçları", "7/24 hizmet"]'::jsonb, '["Doğrudan güzergahın dışındaki ek duraklar", "Çocuk koltuğu (talep üzerine mevcuttur, rezervasyonda belirtin)", "Şoför için bahşiş", "İnişten bir saat sonrasına uzayan bekleme süresi"]'::jsonb,
   '[{"time": "İniş anında", "title": "Karşılama", "text": "Şoförünüz sizi geliş salonunda isim tabelasıyla karşılar."}, {"time": "+10 dk", "title": "Doğrudan Transfer", "text": "Otelinize kadar konforlu, klimalı bir yolculuk."}, {"time": "Varışta", "title": "Otele Bırakma", "text": "Başka durak olmadan doğrudan otel girişine bırakılırsınız."}]'::jsonb, '[{"q": "Uçuşum gecikirse ne olur?", "a": "Tüm uçuşları gerçek zamanlı takip ediyoruz; bu yüzden şoförünüz otomatik olarak ayarlanır ve siz indiğinizde ek ücret olmadan orada bekliyor olur."}, {"q": "Dönüş transferimi nasıl rezerve ederim?", "a": "İki yönü birden rezerve edebilir ya da dönüş transferinizi sonradan ekleyebilirsiniz - sadece uçuş numaranızı ve alış saatinizi bize verin."}, {"q": "Transfer özel mi yoksa paylaşımlı mı?", "a": "Bu hizmet, yalnızca sizin grubunuz için özel, doğrudan bir transferdir - başka yolcu veya ek durak yoktur."}, {"q": "Çocuk koltuğu talep edebilir miyim?", "a": "Evet, çocuğunuzun yaşına uygun koltuğu ayarlayabilmemiz için lütfen rezervasyon sırasında belirtin."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'airport-transfer'), 'en',
   'Airport Transfer', 'Direct, reliable transfer between Milas-Bodrum Airport and your hotel, with flight tracking included.', 'Milas-Bodrum Airport (BJV) to Bodrum Peninsula Hotels',
   '45-70 Minutes (depending on destination)', 'On Request, 24/7', 'Matched to your flight time',
   'Airport arrivals hall / your hotel lobby',
   '["Landing after a long flight is not the time to be negotiating a taxi fare. Our Airport Transfer service has a driver waiting in the arrivals hall with your name, ready to take you directly to your hotel anywhere on the Bodrum peninsula.", "We track your flight in real time, so even if it''s delayed your driver will be there when you land. The same service runs in reverse for your departure, timed to get you to check-in with plenty to spare."]'::jsonb, '["Driver waiting in arrivals with a name board", "Real-time flight tracking, no matter the delay", "Direct route to hotels across the peninsula", "Comfortable, air-conditioned vehicles", "Available around the clock", "Fixed price, no surprises"]'::jsonb,
   '["Private transfer vehicle", "Meet & greet at arrivals with name board", "Flight tracking and wait time", "Bottled water on board", "All tolls and airport fees", "24/7 availability"]'::jsonb, '["Extra stops beyond the direct route", "Child seat (available on request, mention when booking)", "Gratuities for the driver", "Waiting time beyond one hour after landing"]'::jsonb,
   '[{"time": "On landing", "title": "Meet & Greet", "text": "Your driver meets you in the arrivals hall with a name board."}, {"time": "+10 min", "title": "Direct Transfer", "text": "A comfortable, air-conditioned ride straight to your hotel."}, {"time": "On arrival", "title": "Hotel Drop-off", "text": "Dropped directly at your hotel entrance, no further stops."}]'::jsonb, '[{"q": "What happens if my flight is delayed?", "a": "We track all flights in real time, so your driver will adjust automatically and be waiting when you land, at no extra charge."}, {"q": "How do I book my return transfer?", "a": "You can book both directions at once, or add your departure transfer later - just give us your flight number and pick-up time."}, {"q": "Is the transfer private or shared?", "a": "This service is a private, direct transfer just for your party - no other passengers or extra stops."}, {"q": "Can I request a child seat?", "a": "Yes, please mention this when booking so we can arrange the right seat for your child''s age."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'airport-transfer'), 'de',
   'Flughafentransfer', 'Direkter, zuverlässiger Transfer zwischen dem Flughafen Milas-Bodrum und Ihrem Hotel, inklusive Flugverfolgung.', 'Flughafen Milas-Bodrum (BJV) zu Hotels auf der Bodrum-Halbinsel',
   '45-70 Minuten (je nach Ziel)', 'Auf Anfrage, rund um die Uhr', 'Abgestimmt auf Ihre Flugzeit',
   'Ankunftshalle des Flughafens / Ihre Hotellobby',
   '["Nach einem langen Flug zu landen, ist nicht der Moment, um über einen Taxipreis zu verhandeln. Bei unserem Flughafentransfer-Service wartet ein Fahrer mit Ihrem Namen in der Ankunftshalle und bringt Sie direkt zu Ihrem Hotel, egal wo auf der Bodrum-Halbinsel.", "Wir verfolgen Ihren Flug in Echtzeit, sodass Ihr Fahrer selbst bei Verspätung da ist, wenn Sie landen. Derselbe Service läuft für Ihre Abreise in umgekehrter Richtung, zeitlich so geplant, dass Sie mit ausreichend Puffer zum Check-in gelangen."]'::jsonb, '["Fahrer wartet in der Ankunftshalle mit Namensschild", "Echtzeit-Flugverfolgung, unabhängig von Verspätungen", "Direkte Route zu Hotels auf der gesamten Halbinsel", "Komfortable, klimatisierte Fahrzeuge", "Rund um die Uhr verfügbar", "Festpreis, keine Überraschungen"]'::jsonb,
   '["Privates Transferfahrzeug", "Empfang bei Ankunft mit Namensschild", "Flugverfolgung und Wartezeit", "Flaschenwasser an Bord", "Alle Mautgebühren und Flughafenabgaben", "24/7 Verfügbarkeit"]'::jsonb, '["Zusätzliche Stopps über die direkte Route hinaus", "Kindersitz (auf Anfrage verfügbar, bitte bei Buchung angeben)", "Trinkgeld für den Fahrer", "Wartezeit über eine Stunde nach Landung hinaus"]'::jsonb,
   '[{"time": "Bei Landung", "title": "Empfang", "text": "Ihr Fahrer empfängt Sie in der Ankunftshalle mit einem Namensschild."}, {"time": "+10 Min", "title": "Direkter Transfer", "text": "Eine komfortable, klimatisierte Fahrt direkt zu Ihrem Hotel."}, {"time": "Bei Ankunft", "title": "Absetzen am Hotel", "text": "Direktes Absetzen am Hoteleingang, ohne weitere Stopps."}]'::jsonb, '[{"q": "Was passiert, wenn sich mein Flug verspätet?", "a": "Wir verfolgen alle Flüge in Echtzeit, sodass sich Ihr Fahrer automatisch anpasst und ohne Zusatzkosten wartet, wenn Sie landen."}, {"q": "Wie buche ich meinen Rücktransfer?", "a": "Sie können beide Richtungen gleichzeitig buchen oder Ihren Abreisetransfer später hinzufügen - teilen Sie uns einfach Ihre Flugnummer und Abholzeit mit."}, {"q": "Ist der Transfer privat oder geteilt?", "a": "Dieser Service ist ein privater, direkter Transfer nur für Ihre Gruppe - keine weiteren Fahrgäste oder zusätzlichen Stopps."}, {"q": "Kann ich einen Kindersitz anfragen?", "a": "Ja, bitte geben Sie dies bei der Buchung an, damit wir den passenden Sitz für das Alter Ihres Kindes bereitstellen können."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'airport-transfer'), 'ru',
   'Трансфер из аэропорта', 'Прямой, надёжный трансфер между аэропортом Милас-Бодрум и вашим отелем, с отслеживанием рейса.', 'Аэропорт Милас-Бодрум (BJV) - отели полуострова Бодрум',
   '45-70 минут (в зависимости от места назначения)', 'По запросу, круглосуточно', 'Согласовано с временем вашего рейса',
   'Зал прилёта аэропорта / лобби вашего отеля',
   '["Приземление после долгого перелёта - не время торговаться о цене такси. В нашей службе трансфера из аэропорта водитель ждёт в зале прилёта с табличкой с вашим именем, готовый отвезти вас прямо в отель в любой точке полуострова Бодрум.", "Мы отслеживаем ваш рейс в реальном времени, поэтому даже при задержке водитель будет на месте к моменту вашей посадки. Та же услуга работает и в обратном направлении при отъезде, рассчитанная так, чтобы у вас было достаточно времени до регистрации."]'::jsonb, '["Водитель ждёт в зале прилёта с табличкой с именем", "Отслеживание рейса в реальном времени, независимо от задержки", "Прямой маршрут до отелей по всему полуострову", "Комфортные кондиционированные автомобили", "Доступно круглосуточно", "Фиксированная цена, без сюрпризов"]'::jsonb,
   '["Частный автомобиль трансфера", "Встреча в зале прилёта с табличкой с именем", "Отслеживание рейса и время ожидания", "Питьевая вода в машине", "Все дорожные сборы и аэропортовые пошлины", "Доступность 24/7"]'::jsonb, '["Дополнительные остановки сверх прямого маршрута", "Детское автокресло (доступно по запросу, укажите при бронировании)", "Чаевые водителю", "Время ожидания свыше часа после посадки"]'::jsonb,
   '[{"time": "При посадке", "title": "Встреча", "text": "Водитель встречает вас в зале прилёта с табличкой с именем."}, {"time": "+10 мин", "title": "Прямой трансфер", "text": "Комфортная поездка на кондиционированном автомобиле прямо до отеля."}, {"time": "По прибытии", "title": "Высадка у отеля", "text": "Высадка прямо у входа в отель, без дополнительных остановок."}]'::jsonb, '[{"q": "Что будет, если мой рейс задержится?", "a": "Мы отслеживаем все рейсы в реальном времени, поэтому водитель автоматически скорректирует время и будет ждать вас без дополнительной платы."}, {"q": "Как забронировать обратный трансфер?", "a": "Вы можете забронировать оба направления сразу или добавить трансфер на вылет позже - просто сообщите нам номер рейса и время встречи."}, {"q": "Трансфер частный или групповой?", "a": "Эта услуга - частный, прямой трансфер только для вашей группы, без других пассажиров и дополнительных остановок."}, {"q": "Могу ли я запросить детское кресло?", "a": "Да, пожалуйста, укажите это при бронировании, чтобы мы подготовили подходящее кресло по возрасту вашего ребёнка."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'airport-transfer'), 'pl',
   'Transfer z Lotniska', 'Bezpośredni, niezawodny transfer między Lotniskiem Milas-Bodrum a Państwa hotelem, ze śledzeniem lotu.', 'Lotnisko Milas-Bodrum (BJV) do hoteli na Półwyspie Bodrum',
   '45-70 minut (zależnie od miejsca docelowego)', 'Na życzenie, 24/7', 'Dopasowany do godziny Państwa lotu',
   'Hala przylotów na lotnisku / lobby hotelowe',
   '["Lądowanie po długim locie to nie moment na targowanie się o cenę taksówki. W naszej usłudze Transferu z Lotniska kierowca czeka w hali przylotów z tabliczką z Państwa nazwiskiem, gotowy zawieźć Państwa prosto do hotelu w dowolnym miejscu na półwyspie Bodrum.", "Śledzimy Państwa lot w czasie rzeczywistym, więc nawet w przypadku opóźnienia kierowca będzie czekał po lądowaniu. Ta sama usługa działa w drugą stronę przy wylocie, zaplanowana tak, by mieli Państwo mnóstwo czasu na odprawę."]'::jsonb, '["Kierowca czekający w hali przylotów z tabliczką z nazwiskiem", "Śledzenie lotu w czasie rzeczywistym, niezależnie od opóźnienia", "Bezpośrednia trasa do hoteli na całym półwyspie", "Komfortowe, klimatyzowane pojazdy", "Dostępność całodobowa", "Stała cena, bez niespodzianek"]'::jsonb,
   '["Prywatny pojazd transferowy", "Powitanie w hali przylotów z tabliczką z nazwiskiem", "Śledzenie lotu i czas oczekiwania", "Woda butelkowana w pojeździe", "Wszystkie opłaty drogowe i lotniskowe", "Dostępność 24/7"]'::jsonb, '["Dodatkowe postoje poza trasą bezpośrednią", "Fotelik dziecięcy (dostępny na życzenie, proszę zaznaczyć przy rezerwacji)", "Napiwek dla kierowcy", "Czas oczekiwania powyżej godziny po lądowaniu"]'::jsonb,
   '[{"time": "Po lądowaniu", "title": "Powitanie", "text": "Kierowca spotyka Państwa w hali przylotów z tabliczką z nazwiskiem."}, {"time": "+10 min", "title": "Transfer bezpośredni", "text": "Komfortowa, klimatyzowana jazda prosto do hotelu."}, {"time": "Po przybyciu", "title": "Wysadzenie przy hotelu", "text": "Wysadzenie bezpośrednio przy wejściu do hotelu, bez dodatkowych postojów."}]'::jsonb, '[{"q": "Co się stanie, jeśli mój lot się opóźni?", "a": "Śledzimy wszystkie loty w czasie rzeczywistym, więc kierowca automatycznie dostosuje się i będzie czekał po Państwa lądowaniu bez dodatkowych opłat."}, {"q": "Jak zarezerwować transfer powrotny?", "a": "Mogą Państwo zarezerwować obie trasy naraz lub dodać transfer na wylot później - wystarczy podać nam numer lotu i godzinę odbioru."}, {"q": "Czy transfer jest prywatny czy współdzielony?", "a": "Ta usługa to prywatny, bezpośredni transfer wyłącznie dla Państwa grupy - bez innych pasażerów i dodatkowych postojów."}, {"q": "Czy mogę poprosić o fotelik dziecięcy?", "a": "Tak, proszę zaznaczyć to przy rezerwacji, abyśmy mogli przygotować odpowiedni fotelik dopasowany do wieku Państwa dziecka."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'vip-transfer'), 'tr',
   'VIP Transfer', 'Yolda ekstra konfor isteyen misafirler için premium bir araç ve özel şoför.', 'Bodrum Yarımadası ve Çevresi, Türkiye',
   '45-70 Dakika (güzergaha göre)', 'Talep Üzerine, 7/24', 'Anlaşmalı',
   'Havalimanı geliş salonu / otel lobiniz',
   '["VIP Transfer, standart havalimanı veya noktadan noktaya transferi alır ve her bölümünü yükseltir: premium bir araç, resmi kıyafetli profesyonel bir şoför, araçta şişe suyu ve Wi-Fi, ve gözle görülür derecede daha konforlu bir yolculuk.", "İş seyahati yapanlar, balayı çiftleri ve tatillerinin ilk ve son izleniminin tatilin kendisi kadar özenli hissetmesini isteyen herkes için popüler bir tercihtir. Aynı premium standart, ister havalimanına, ister yarımadadaki başka bir kasabaya, ister daha uzağa gidiyor olun geçerlidir."]'::jsonb, '["Premium araç sınıfı (ör. Mercedes Vito veya dengi)", "Profesyonel, resmi kıyafetli şoför", "Araçta şişe suyu ve Wi-Fi", "İsim tabelasıyla karşılama", "Havalimanı veya şehirlerarası güzergahlar için uygun", "7/24 hizmet"]'::jsonb,
   '["Premium özel araç ve şoför", "İsim tabelasıyla karşılama", "Uçuş takibi (havalimanı güzergahları için)", "Araçta şişe suyu ve Wi-Fi", "Tüm geçiş ücretleri ve harçlar", "7/24 hizmet"]'::jsonb, '["Anlaşılan güzergahın dışındaki ek duraklar", "Çocuk koltuğu (talep üzerine mevcuttur)", "Şoför için bahşiş", "İnişten bir saat sonrasına uzayan bekleme süresi"]'::jsonb,
   '[{"time": "Talep üzerine", "title": "Rezervasyon Onayı", "text": "Alış noktanızı ve saatinizi önceden teyit ederiz."}, {"time": "Varışta", "title": "Karşılama", "text": "Şoförünüz sizi isim tabelasıyla karşılar."}, {"time": "Yolda", "title": "Premium Yolculuk", "text": "Varış noktanıza giderken su ve Wi-Fi eşliğinde rahatlayın."}]'::jsonb, '[{"q": "VIP Transfer, standart Havalimanı Transferi''nden nasıl farklı?", "a": "VIP Transfer daha üst bir araç sınıfı, resmi kıyafetli bir şoför kullanır ve Wi-Fi gibi ek olanaklar sunar - konfor da en az varış kadar önemliyse idealdir."}, {"q": "VIP Transfer havalimanı dışındaki güzergahlar için kullanılabilir mi?", "a": "Evet, şehirlerarası seyahat dahil bölgedeki herhangi bir noktadan noktaya güzergah için mevcuttur - rezervasyon sırasında güzergahınızı bildirmeniz yeterli."}, {"q": "İş seyahati için uygun mu?", "a": "Evet, dakik ve profesyonel bir transfer deneyimi isteyen iş misafirleri arasında popüler bir seçenektir."}, {"q": "Dönüş VIP Transferi rezerve edebilir miyim?", "a": "Evet, her iki yön birlikte veya ayrı ayrı rezerve edilebilir - rezervasyon sırasında seyahat detaylarınızı belirtmeniz yeterli."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'vip-transfer'), 'en',
   'VIP Transfer', 'A premium vehicle and private chauffeur for guests who want extra comfort on the road.', 'Bodrum Peninsula and Surrounding Region, Türkiye',
   '45-70 Minutes (route dependent)', 'On Request, 24/7', 'By arrangement',
   'Airport arrivals / your hotel lobby',
   '["The VIP Transfer takes the standard airport or point-to-point transfer and upgrades every part of it: a premium vehicle, a professional chauffeur in formal dress, bottled water and Wi-Fi on board, and a noticeably smoother ride.", "It''s a popular choice for business travellers, honeymooners, and anyone who wants their first and last impression of the trip to feel as polished as the holiday itself. The same premium standard applies whether you''re headed to the airport, another town on the peninsula, or further afield."]'::jsonb, '["Premium vehicle class (e.g. Mercedes Vito or equivalent)", "Professional, formally dressed chauffeur", "Bottled water and on-board Wi-Fi", "Meet & greet with name board", "Available for airport or intercity routes", "24/7 availability"]'::jsonb,
   '["Premium private vehicle and chauffeur", "Meet & greet with name board", "Flight tracking (for airport routes)", "Bottled water and Wi-Fi on board", "All tolls and fees", "24/7 availability"]'::jsonb, '["Extra stops beyond the agreed route", "Child seat (available on request)", "Gratuities for the chauffeur", "Waiting time beyond one hour after landing"]'::jsonb,
   '[{"time": "On request", "title": "Booking Confirmed", "text": "We confirm your pick-up point and time in advance."}, {"time": "On arrival", "title": "Meet & Greet", "text": "Your chauffeur meets you with a name board."}, {"time": "En route", "title": "Premium Ride", "text": "Relax with water and Wi-Fi on the way to your destination."}]'::jsonb, '[{"q": "How is VIP Transfer different from the standard Airport Transfer?", "a": "VIP Transfer uses a higher vehicle class, a chauffeur in formal dress, and adds amenities like Wi-Fi - ideal if comfort matters as much as getting there."}, {"q": "Can VIP Transfer be used for routes other than the airport?", "a": "Yes, it''s available for any point-to-point route in the region, including intercity travel - just let us know your route when booking."}, {"q": "Is this suitable for business travel?", "a": "Yes, it''s a popular option for business guests who want a punctual, professional transfer experience."}, {"q": "Can I book a return VIP Transfer?", "a": "Yes, both directions can be booked together or separately - just provide your travel details when booking."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'vip-transfer'), 'de',
   'VIP-Transfer', 'Ein Premiumfahrzeug und privater Chauffeur für Gäste, die zusätzlichen Komfort unterwegs wünschen.', 'Bodrum-Halbinsel und Umgebung, Türkei',
   '45-70 Minuten (routenabhängig)', 'Auf Anfrage, rund um die Uhr', 'Nach Vereinbarung',
   'Ankunftshalle des Flughafens / Ihre Hotellobby',
   '["Der VIP-Transfer nimmt den Standard-Flughafen- oder Punkt-zu-Punkt-Transfer und wertet jeden Teil davon auf: ein Premiumfahrzeug, ein professioneller Chauffeur in formeller Kleidung, Flaschenwasser und WLAN an Bord sowie eine spürbar ruhigere Fahrt.", "Eine beliebte Wahl für Geschäftsreisende, Flitterwöchner und alle, die möchten, dass der erste und letzte Eindruck ihrer Reise ebenso stilvoll wirkt wie der Urlaub selbst. Derselbe Premiumstandard gilt, egal ob es zum Flughafen, in eine andere Stadt auf der Halbinsel oder weiter geht."]'::jsonb, '["Premium-Fahrzeugklasse (z. B. Mercedes Vito oder gleichwertig)", "Professioneller, formell gekleideter Chauffeur", "Flaschenwasser und WLAN an Bord", "Empfang mit Namensschild", "Verfügbar für Flughafen- oder Überlandrouten", "Rund um die Uhr verfügbar"]'::jsonb,
   '["Premium-Privatfahrzeug und Chauffeur", "Empfang mit Namensschild", "Flugverfolgung (bei Flughafenrouten)", "Flaschenwasser und WLAN an Bord", "Alle Mautgebühren und Abgaben", "24/7 Verfügbarkeit"]'::jsonb, '["Zusätzliche Stopps über die vereinbarte Route hinaus", "Kindersitz (auf Anfrage verfügbar)", "Trinkgeld für den Chauffeur", "Wartezeit über eine Stunde nach Landung hinaus"]'::jsonb,
   '[{"time": "Auf Anfrage", "title": "Buchung bestätigt", "text": "Wir bestätigen Ihren Abholpunkt und -zeit im Voraus."}, {"time": "Bei Ankunft", "title": "Empfang", "text": "Ihr Chauffeur empfängt Sie mit einem Namensschild."}, {"time": "Unterwegs", "title": "Premium-Fahrt", "text": "Entspannen Sie mit Wasser und WLAN auf dem Weg zu Ihrem Ziel."}]'::jsonb, '[{"q": "Wie unterscheidet sich der VIP-Transfer vom Standard-Flughafentransfer?", "a": "Der VIP-Transfer nutzt eine höhere Fahrzeugklasse, einen formell gekleideten Chauffeur und bietet zusätzliche Annehmlichkeiten wie WLAN - ideal, wenn Komfort ebenso wichtig ist wie das Ankommen."}, {"q": "Kann der VIP-Transfer für andere Strecken als den Flughafen genutzt werden?", "a": "Ja, er ist für jede Punkt-zu-Punkt-Strecke in der Region verfügbar, einschließlich Überlandfahrten - teilen Sie uns bei der Buchung einfach Ihre Route mit."}, {"q": "Eignet sich das für Geschäftsreisen?", "a": "Ja, es ist eine beliebte Option für Geschäftsgäste, die einen pünktlichen, professionellen Transfer wünschen."}, {"q": "Kann ich einen Rück-VIP-Transfer buchen?", "a": "Ja, beide Richtungen können gemeinsam oder separat gebucht werden - teilen Sie uns einfach Ihre Reisedaten bei der Buchung mit."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'vip-transfer'), 'ru',
   'VIP-трансфер', 'Премиальный автомобиль и личный шофёр для гостей, желающих дополнительного комфорта в пути.', 'Полуостров Бодрум и окрестности, Турция',
   '45-70 минут (в зависимости от маршрута)', 'По запросу, круглосуточно', 'По договорённости',
   'Зал прилёта аэропорта / лобби вашего отеля',
   '["VIP-трансфер берёт стандартный трансфер из аэропорта или между точками и улучшает каждую его деталь: премиальный автомобиль, профессиональный шофёр в официальной форме, питьевую воду и Wi-Fi в салоне, а также заметно более плавную поездку.", "Популярный выбор среди бизнес-путешественников, молодожёнов и всех, кто хочет, чтобы первое и последнее впечатление от поездки было таким же изысканным, как и сам отдых. Тот же премиальный стандарт применяется независимо от того, едете ли вы в аэропорт, в другой город полуострова или дальше."]'::jsonb, '["Автомобиль премиум-класса (например, Mercedes Vito или аналог)", "Профессиональный шофёр в официальной форме", "Питьевая вода и Wi-Fi в салоне", "Встреча с табличкой с именем", "Доступен для маршрутов в аэропорт или между городами", "Доступность 24/7"]'::jsonb,
   '["Премиальный частный автомобиль и шофёр", "Встреча с табличкой с именем", "Отслеживание рейса (для маршрутов в аэропорт)", "Питьевая вода и Wi-Fi в салоне", "Все дорожные сборы и пошлины", "Доступность 24/7"]'::jsonb, '["Дополнительные остановки сверх согласованного маршрута", "Детское автокресло (доступно по запросу)", "Чаевые шофёру", "Время ожидания свыше часа после посадки"]'::jsonb,
   '[{"time": "По запросу", "title": "Подтверждение брони", "text": "Мы заранее согласуем точку и время вашего трансфера."}, {"time": "По прибытии", "title": "Встреча", "text": "Ваш шофёр встречает вас с табличкой с именем."}, {"time": "В пути", "title": "Премиальная поездка", "text": "Отдыхайте с водой и Wi-Fi по пути к месту назначения."}]'::jsonb, '[{"q": "Чем VIP-трансфер отличается от стандартного трансфера из аэропорта?", "a": "VIP-трансфер использует автомобиль более высокого класса, шофёра в официальной форме и дополнительные удобства, такие как Wi-Fi - идеально, если комфорт важен так же, как и сама поездка."}, {"q": "Можно ли использовать VIP-трансфер для маршрутов, отличных от аэропорта?", "a": "Да, он доступен для любых маршрутов между точками в регионе, включая поездки между городами - просто сообщите нам маршрут при бронировании."}, {"q": "Подходит ли это для деловых поездок?", "a": "Да, это популярный вариант среди деловых гостей, которые хотят пунктуального, профессионального трансфера."}, {"q": "Могу ли я забронировать обратный VIP-трансфер?", "a": "Да, оба направления можно забронировать вместе или отдельно - просто сообщите нам детали поездки при бронировании."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'vip-transfer'), 'pl',
   'Transfer VIP', 'Pojazd klasy premium i prywatny szofer dla gości pragnących dodatkowego komfortu w podróży.', 'Półwysep Bodrum i okolice, Turcja',
   '45-70 minut (zależnie od trasy)', 'Na życzenie, 24/7', 'Do uzgodnienia',
   'Hala przylotów na lotnisku / lobby hotelowe',
   '["Transfer VIP bierze standardowy transfer z lotniska lub między punktami i podnosi jakość każdego jego elementu: pojazd klasy premium, profesjonalnego szofera w oficjalnym stroju, wodę butelkowaną i Wi-Fi na pokładzie oraz zauważalnie płynniejszą jazdę.", "To popularny wybór wśród podróżujących służbowo, nowożeńców i każdego, kto chce, by pierwsze i ostatnie wrażenie z podróży było równie eleganckie, co sam wyjazd. Ten sam standard premium obowiązuje niezależnie od tego, czy jadą Państwo na lotnisko, do innego miasta na półwyspie, czy dalej."]'::jsonb, '["Pojazd klasy premium (np. Mercedes Vito lub podobny)", "Profesjonalny, oficjalnie ubrany szofer", "Woda butelkowana i Wi-Fi na pokładzie", "Powitanie z tabliczką z nazwiskiem", "Dostępny dla tras lotniskowych i międzymiastowych", "Dostępność 24/7"]'::jsonb,
   '["Prywatny pojazd klasy premium i szofer", "Powitanie z tabliczką z nazwiskiem", "Śledzenie lotu (dla tras lotniskowych)", "Woda butelkowana i Wi-Fi na pokładzie", "Wszystkie opłaty drogowe i inne", "Dostępność 24/7"]'::jsonb, '["Dodatkowe postoje poza uzgodnioną trasą", "Fotelik dziecięcy (dostępny na życzenie)", "Napiwek dla szofera", "Czas oczekiwania powyżej godziny po lądowaniu"]'::jsonb,
   '[{"time": "Na życzenie", "title": "Potwierdzenie rezerwacji", "text": "Potwierdzamy z wyprzedzeniem miejsce i godzinę odbioru."}, {"time": "Po przybyciu", "title": "Powitanie", "text": "Szofer spotyka Państwa z tabliczką z nazwiskiem."}, {"time": "W trasie", "title": "Jazda klasy premium", "text": "Odpoczywajcie z wodą i Wi-Fi w drodze do celu."}]'::jsonb, '[{"q": "Czym Transfer VIP różni się od standardowego Transferu z Lotniska?", "a": "Transfer VIP wykorzystuje pojazd wyższej klasy, oficjalnie ubranego szofera i dodatkowe udogodnienia, takie jak Wi-Fi - idealny, gdy komfort liczy się tak samo jak dotarcie na miejsce."}, {"q": "Czy Transfer VIP można wykorzystać do tras innych niż lotnisko?", "a": "Tak, jest dostępny dla dowolnej trasy między punktami w regionie, w tym podróży międzymiastowych - wystarczy podać nam trasę przy rezerwacji."}, {"q": "Czy to dobra opcja na podróż służbową?", "a": "Tak, to popularna opcja wśród gości biznesowych, którzy chcą punktualnego, profesjonalnego transferu."}, {"q": "Czy mogę zarezerwować powrotny Transfer VIP?", "a": "Tak, obie trasy można zarezerwować razem lub osobno - wystarczy podać nam szczegóły podróży przy rezerwacji."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-transfer'), 'tr',
   'Bodrum İçi Transfer', 'Bodrum yarımadası genelindeki kasabalar ve oteller arasında konforlu, noktadan noktaya transferler.', 'Bodrum, Gümbet, Bitez, Turgutreis, Yalıkavak, Gündoğan, Torba ve ötesi',
   '20-60 Dakika (güzergaha göre)', 'Talep Üzerine', 'Anlaşmalı',
   'Oteliniz, marina veya talep ettiğiniz alış noktası',
   '["Bodrum yarımadası haritada göründüğünden daha geniş bir alanı kaplar; Gümbet, Bitez, Turgutreis, Yalıkavak ve Gündoğan gibi tatil beldeleri kıyı boyunca yayılmıştır. Bu yerel transfer hizmeti, toplu taşıma programlarına veya taksi duraklarına bağlı kalmadan sizi herhangi iki nokta arasında hızlı ve konforlu bir şekilde taşır.", "İster tatilinizin ortasında otel değiştiriyor, ister Bodrum kasabasında akşam yemeğine gidiyor, ister yarımadanın başka bir yerinde kalan arkadaşlarınızla buluşuyor olun; anlaşılan saatte alınır ve doğrudan varış noktanıza götürülürsünüz."]'::jsonb, '["Yarımadadaki herhangi iki nokta arasında doğrudan transfer", "Bodrum, Gümbet, Bitez, Turgutreis, Yalıkavak ve daha fazlasını kapsar", "Konforlu, klimalı araçlar", "Rezervasyonda anlaşılan sabit fiyat", "Planlarınıza uygun esnek zamanlama", "Güler yüzlü, İngilizce konuşan şoförler"]'::jsonb,
   '["Özel transfer aracı", "Seçtiğiniz konumdan alış", "Varış noktanıza doğrudan bırakma", "Araçta şişe suyu", "Tüm geçiş ücretleri ve harçlar", "Esnek zamanlama"]'::jsonb, '["Anlaşılan güzergahın dışındaki ek duraklar", "15 dakikayı aşan bekleme süresi", "Şoför için bahşiş", "Çok büyük gruplar için standart bagaj limitini aşan yük"]'::jsonb,
   '[{"time": "Talep üzerine", "title": "Rezervasyon Onayı", "text": "Alış noktanızı, varış yerinizi ve saatinizi teyit ederiz."}, {"time": "Zamanında", "title": "Alış", "text": "Şoförünüz anlaşılan konuma gelir."}, {"time": "Doğrudan", "title": "Transfer", "text": "Varış noktanıza doğrudan, konforlu bir yolculuk."}]'::jsonb, '[{"q": "Aynı gün yerel transfer rezerve edebilir miyim?", "a": "Evet, şoför müsaitliğine bağlı olarak yerel transferler genellikle kısa süre önceden ayarlanabilir - acil talepler için doğrudan bizimle iletişime geçin."}, {"q": "Yarımadadaki tüm kasabaları kapsıyor musunuz?", "a": "Evet, Bodrum kasabası ve Gümbet, Bitez, Turgutreis, Yalıkavak, Gündoğan ve Torba dahil tüm çevre tatil bölgelerine hizmet veriyoruz."}, {"q": "Bu paylaşımlı mı yoksa özel bir araç mı?", "a": "Bu, yalnızca sizin grubunuz için özel, doğrudan bir transferdir."}, {"q": "Gidiş-dönüş rezerve edebilir miyim?", "a": "Evet, rezervasyon sırasında hem gidiş hem dönüş saatlerinizi belirtmeniz yeterlidir."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-transfer'), 'en',
   'Bodrum Local Transfer', 'Comfortable point-to-point transfers between towns and hotels across the Bodrum peninsula.', 'Bodrum, Gumbet, Bitez, Turgutreis, Yalikavak, Gundogan, Torba and beyond',
   '20-60 Minutes (route dependent)', 'On Request', 'By arrangement',
   'Your hotel, marina or requested pick-up point',
   '["The Bodrum peninsula covers more ground than it looks like on a map, with resort towns like Gumbet, Bitez, Turgutreis, Yalikavak and Gundogan spread along the coast. This local transfer service gets you between any two points quickly and comfortably, without relying on public transport schedules or taxi ranks.", "Whether you''re moving hotels mid-stay, heading to dinner in Bodrum town, or meeting friends staying elsewhere on the peninsula, you''ll be picked up at an agreed time and taken directly to your destination."]'::jsonb, '["Direct transfers between any two peninsula points", "Covers Bodrum, Gumbet, Bitez, Turgutreis, Yalikavak and more", "Comfortable, air-conditioned vehicles", "Fixed price agreed at booking", "Flexible timing to suit your plans", "Friendly, English-speaking drivers"]'::jsonb,
   '["Private transfer vehicle", "Pick-up at your chosen location", "Direct drop-off at your destination", "Bottled water on board", "All tolls and fees", "Flexible scheduling"]'::jsonb, '["Extra stops beyond the agreed route", "Waiting time beyond 15 minutes", "Gratuities for the driver", "Luggage beyond standard allowance for very large groups"]'::jsonb,
   '[{"time": "On request", "title": "Booking Confirmed", "text": "We confirm your pick-up point, destination and time."}, {"time": "On time", "title": "Pick-up", "text": "Your driver arrives at the agreed location."}, {"time": "Direct", "title": "Transfer", "text": "A direct, comfortable ride to your destination."}]'::jsonb, '[{"q": "Can I book a same-day local transfer?", "a": "Yes, local transfers can usually be arranged on short notice, subject to driver availability - contact us directly for urgent requests."}, {"q": "Do you cover all towns on the peninsula?", "a": "Yes, we serve Bodrum town and all the surrounding resort areas, including Gumbet, Bitez, Turgutreis, Yalikavak, Gundogan and Torba."}, {"q": "Is this a shared or private vehicle?", "a": "This is a private, direct transfer for your party only."}, {"q": "Can I book a round trip?", "a": "Yes, simply let us know both your outbound and return times when booking."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-transfer'), 'de',
   'Bodrum Lokaltransfer', 'Komfortable Punkt-zu-Punkt-Transfers zwischen Städten und Hotels auf der gesamten Bodrum-Halbinsel.', 'Bodrum, Gumbet, Bitez, Turgutreis, Yalikavak, Gundogan, Torba und weitere',
   '20-60 Minuten (routenabhängig)', 'Auf Anfrage', 'Nach Vereinbarung',
   'Ihr Hotel, die Marina oder gewünschter Abholpunkt',
   '["Die Bodrum-Halbinsel erstreckt sich über mehr Fläche, als es auf der Karte erscheint, mit Ferienorten wie Gumbet, Bitez, Turgutreis, Yalikavak und Gundogan entlang der Küste. Dieser lokale Transferservice bringt Sie schnell und komfortabel zwischen zwei beliebigen Punkten, ohne auf öffentliche Verkehrsfahrpläne oder Taxistände angewiesen zu sein.", "Ob Sie mitten im Aufenthalt das Hotel wechseln, zum Abendessen in die Stadt Bodrum fahren oder Freunde treffen, die anderswo auf der Halbinsel wohnen - Sie werden zur vereinbarten Zeit abgeholt und direkt an Ihr Ziel gebracht."]'::jsonb, '["Direkte Transfers zwischen zwei beliebigen Punkten der Halbinsel", "Deckt Bodrum, Gumbet, Bitez, Turgutreis, Yalikavak und mehr ab", "Komfortable, klimatisierte Fahrzeuge", "Bei Buchung vereinbarter Festpreis", "Flexible Zeitplanung passend zu Ihren Plänen", "Freundliche, englischsprachige Fahrer"]'::jsonb,
   '["Privates Transferfahrzeug", "Abholung am gewünschten Ort", "Direktes Absetzen an Ihrem Ziel", "Flaschenwasser an Bord", "Alle Mautgebühren und Abgaben", "Flexible Terminplanung"]'::jsonb, '["Zusätzliche Stopps über die vereinbarte Route hinaus", "Wartezeit über 15 Minuten hinaus", "Trinkgeld für den Fahrer", "Gepäck über das Standardlimit hinaus bei sehr großen Gruppen"]'::jsonb,
   '[{"time": "Auf Anfrage", "title": "Buchung bestätigt", "text": "Wir bestätigen Ihren Abholpunkt, Zielort und die Uhrzeit."}, {"time": "Pünktlich", "title": "Abholung", "text": "Ihr Fahrer trifft am vereinbarten Ort ein."}, {"time": "Direkt", "title": "Transfer", "text": "Eine direkte, komfortable Fahrt zu Ihrem Ziel."}]'::jsonb, '[{"q": "Kann ich einen Lokaltransfer für denselben Tag buchen?", "a": "Ja, lokale Transfers lassen sich in der Regel kurzfristig arrangieren, abhängig von der Fahrerverfügbarkeit - kontaktieren Sie uns direkt für dringende Anfragen."}, {"q": "Decken Sie alle Orte auf der Halbinsel ab?", "a": "Ja, wir bedienen die Stadt Bodrum und alle umliegenden Ferienorte, einschließlich Gumbet, Bitez, Turgutreis, Yalikavak, Gundogan und Torba."}, {"q": "Ist dies ein geteiltes oder privates Fahrzeug?", "a": "Dies ist ein privater, direkter Transfer nur für Ihre Gruppe."}, {"q": "Kann ich eine Hin- und Rückfahrt buchen?", "a": "Ja, teilen Sie uns bei der Buchung einfach Ihre Hin- und Rückfahrtzeiten mit."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-transfer'), 'ru',
   'Местный трансфер по Бодруму', 'Комфортные трансферы между городами и отелями по всему полуострову Бодрум.', 'Бодрум, Гюмбет, Битез, Тургутреис, Ялыкавак, Гюндоган, Торба и другие',
   '20-60 минут (в зависимости от маршрута)', 'По запросу', 'По договорённости',
   'Ваш отель, марина или запрошенная точка встречи',
   '["Полуостров Бодрум занимает большую территорию, чем кажется на карте, а курортные городки, такие как Гюмбет, Битез, Тургутреис, Ялыкавак и Гюндоган, растянуты вдоль побережья. Эта услуга местного трансфера быстро и комфортно доставит вас между любыми двумя точками, без привязки к расписанию общественного транспорта или стоянкам такси.", "Переезжаете ли вы в другой отель в середине отдыха, направляетесь на ужин в город Бодрум или встречаетесь с друзьями, остановившимися в другой части полуострова - вас заберут в согласованное время и отвезут прямо к месту назначения."]'::jsonb, '["Прямые трансферы между любыми двумя точками полуострова", "Охватывает Бодрум, Гюмбет, Битез, Тургутреис, Ялыкавак и другие", "Комфортные кондиционированные автомобили", "Фиксированная цена, согласованная при бронировании", "Гибкое время в соответствии с вашими планами", "Дружелюбные англоговорящие водители"]'::jsonb,
   '["Частный автомобиль трансфера", "Забор из выбранного места", "Прямая высадка в пункте назначения", "Питьевая вода в машине", "Все дорожные сборы и пошлины", "Гибкое планирование"]'::jsonb, '["Дополнительные остановки сверх согласованного маршрута", "Время ожидания свыше 15 минут", "Чаевые водителю", "Багаж сверх стандартной нормы для очень больших групп"]'::jsonb,
   '[{"time": "По запросу", "title": "Подтверждение брони", "text": "Мы согласуем точку отправления, назначения и время."}, {"time": "Вовремя", "title": "Встреча", "text": "Ваш водитель прибывает в согласованное место."}, {"time": "Напрямую", "title": "Трансфер", "text": "Прямая, комфортная поездка до места назначения."}]'::jsonb, '[{"q": "Можно ли забронировать местный трансфер в тот же день?", "a": "Да, местные трансферы обычно можно организовать с небольшим уведомлением, в зависимости от наличия водителей - для срочных запросов свяжитесь с нами напрямую."}, {"q": "Вы обслуживаете все города на полуострове?", "a": "Да, мы обслуживаем город Бодрум и все окрестные курортные зоны, включая Гюмбет, Битез, Тургутреис, Ялыкавак, Гюндоган и Торба."}, {"q": "Это общий или частный автомобиль?", "a": "Это частный, прямой трансфер только для вашей группы."}, {"q": "Могу ли я забронировать поездку туда и обратно?", "a": "Да, просто сообщите нам время отправления и возвращения при бронировании."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-transfer'), 'pl',
   'Transfer Lokalny w Bodrum', 'Komfortowe transfery między miastami a hotelami na całym półwyspie Bodrum.', 'Bodrum, Gumbet, Bitez, Turgutreis, Yalikavak, Gundogan, Torba i dalej',
   '20-60 minut (zależnie od trasy)', 'Na życzenie', 'Do uzgodnienia',
   'Państwa hotel, marina lub żądany punkt odbioru',
   '["Półwysep Bodrum zajmuje większy obszar, niż wydaje się na mapie, a miejscowości wypoczynkowe takie jak Gumbet, Bitez, Turgutreis, Yalikavak i Gundogan rozciągają się wzdłuż wybrzeża. Ta lokalna usługa transferowa szybko i komfortowo przewiezie Państwa między dowolnymi dwoma punktami, bez polegania na rozkładach transportu publicznego czy postojach taksówek.", "Niezależnie od tego, czy zmieniają Państwo hotel w trakcie pobytu, jadą na kolację do miasta Bodrum, czy spotykają się z przyjaciółmi zatrzymanymi gdzie indziej na półwyspie - zostaną Państwo odebrani o uzgodnionej porze i zawiezieni bezpośrednio do celu."]'::jsonb, '["Bezpośrednie transfery między dowolnymi dwoma punktami półwyspu", "Obejmuje Bodrum, Gumbet, Bitez, Turgutreis, Yalikavak i więcej", "Komfortowe, klimatyzowane pojazdy", "Stała cena uzgodniona przy rezerwacji", "Elastyczny czas dostosowany do Państwa planów", "Przyjaźni, anglojęzyczni kierowcy"]'::jsonb,
   '["Prywatny pojazd transferowy", "Odbiór z wybranej lokalizacji", "Bezpośrednie dowiezienie do celu", "Woda butelkowana w pojeździe", "Wszystkie opłaty drogowe i inne", "Elastyczne planowanie"]'::jsonb, '["Dodatkowe postoje poza uzgodnioną trasą", "Czas oczekiwania powyżej 15 minut", "Napiwek dla kierowcy", "Bagaż powyżej standardowego limitu dla bardzo dużych grup"]'::jsonb,
   '[{"time": "Na życzenie", "title": "Potwierdzenie rezerwacji", "text": "Potwierdzamy punkt odbioru, cel podróży i godzinę."}, {"time": "Na czas", "title": "Odbiór", "text": "Kierowca przybywa na uzgodnione miejsce."}, {"time": "Bezpośrednio", "title": "Transfer", "text": "Bezpośrednia, komfortowa jazda do celu."}]'::jsonb, '[{"q": "Czy mogę zarezerwować transfer lokalny tego samego dnia?", "a": "Tak, transfery lokalne zazwyczaj można zorganizować z krótkim wyprzedzeniem, w zależności od dostępności kierowców - w pilnych sprawach prosimy o bezpośredni kontakt."}, {"q": "Czy obsługujecie wszystkie miejscowości na półwyspie?", "a": "Tak, obsługujemy miasto Bodrum i wszystkie okoliczne miejscowości wypoczynkowe, w tym Gumbet, Bitez, Turgutreis, Yalikavak, Gundogan i Torba."}, {"q": "Czy to pojazd współdzielony czy prywatny?", "a": "To prywatny, bezpośredni transfer wyłącznie dla Państwa grupy."}, {"q": "Czy mogę zarezerwować przejazd w obie strony?", "a": "Tak, wystarczy podać nam godziny wyjazdu i powrotu przy rezerwacji."}]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-city-tour'), 'tr',
   'Bodrum Şehir Turu', 'Bodrum Kalesi, antik tiyatro, eski çarşı ve marina boyunca yarım günlük rehberli bir yürüyüş.', 'Bodrum Şehir Merkezi, Muğla, Türkiye',
   '6 Saat - Yarım Gün', '09:00, Her Gün', '15:00',
   'Bodrum yarımadası genelinde otel alışı',
   '["Bodrum''un kendi eski şehri, genellikle daha uzaktaki günübirlik tur rotalarının gölgesinde kalır - oysa Dünyanın Yedi Harikası''ndan birinin çevresinde büyüyen bu şehrin, yavaş geçirilecek bir sabahı hak eden pek çok noktası var.", "Bu yarım günlük tur sizi liman kenarındaki Bodrum Kalesi''nden (Aziz John Şövalyeleri tarafından yıkılmış Mozole''nin taşlarından inşa edilmiştir), koya nefes kesici manzaralar sunan 2.400 yıllık Antik Tiyatro''dan ve eski çarşının dar sokaklarından geçirir; tur, serbest zaman ve kendi imkanlarınızla öğle yemeği için marinada sona erer."]'::jsonb, '["Limana bakan Aziz Petrus Kalesi (Bodrum Kalesi)", "2.400 yıllık Bodrum Antik Tiyatrosu", "Eski şehir çarşısı ve beyaz badanalı ara sokaklar", "Bodrum Körfezi''ne panoramik bakış noktası", "Marinada serbest zaman", "Yarım gün temposu - öğleden sonra otelinizde"]'::jsonb,
   '["Klimalı araçla gidiş-dönüş ulaşım", "Otelden alış ve otele bırakış", "İngilizce konuşan tur rehberi", "Bodrum Kalesi giriş ücreti", "Şişe suyu"]'::jsonb, '["Öğle yemeği (marinada kendi seçiminizle serbest zaman)", "Kişisel harcamalar ve hediyelik eşyalar", "Rehber ve şoför için bahşiş"]'::jsonb,
   '[{"time": "09:00", "title": "Otelden Alış", "text": "Bodrum şehir merkezine hareket."}, {"time": "09:45", "title": "Bodrum Kalesi", "text": "Aziz Petrus Kalesi ve liman manzarası eşliğinde rehberli yürüyüş."}, {"time": "11:15", "title": "Antik Tiyatro", "text": "Körfeze bakan 2.400 yıllık amfitiyatro ziyareti."}, {"time": "12:15", "title": "Eski Çarşı", "text": "Eski şehrin dükkanlarını ve ara sokaklarını keşfetmek için serbest zaman."}, {"time": "13:30", "title": "Marina Serbest Zaman", "text": "Kendi imkanlarınızla öğle yemeği ve deniz kenarında vakit."}, {"time": "15:00", "title": "Dönüş", "text": "Otelinize bırakılış."}]'::jsonb, '[]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-city-tour'), 'en',
   'Bodrum City Tour', 'A half-day guided walk through Bodrum Castle, the ancient theatre, the old bazaar and the marina.', 'Bodrum City Centre, Mugla Province, Turkiye',
   '6 Hours - Half Day', '09:00 AM, Daily', '15:00 PM',
   'Hotel pick-up across the Bodrum peninsula',
   '["Bodrum''s own old town rarely gets the same attention as the day-trip destinations further afield, which is a shame - the city that grew up around one of the Seven Wonders of the Ancient World has plenty worth a slow morning on foot.", "This half-day tour walks you through the harbour-front Bodrum Castle (built by the Knights of St. John from the stones of the ruined Mausoleum), the 2,400-year-old Antique Theatre with its sweeping bay views, and the narrow lanes of the old bazaar, before finishing at the marina for free time and lunch on your own."]'::jsonb, '["Bodrum Castle of St. Peter, overlooking the harbour", "The 2,400-year-old Bodrum Antique Theatre", "Old town bazaar and whitewashed backstreets", "Panoramic viewpoint over Bodrum Bay", "Free time at the marina", "Half-day pace - back at your hotel by mid-afternoon"]'::jsonb,
   '["Round-trip transport in air-conditioned vehicle", "Hotel pick-up and drop-off", "English-speaking tour guide", "Bodrum Castle entrance fee", "Bottled water"]'::jsonb, '["Lunch (free time at the marina to choose your own)", "Personal expenses and souvenirs", "Gratuities for the guide and driver"]'::jsonb,
   '[{"time": "09:00", "title": "Hotel Pick-up", "text": "Departure toward Bodrum city centre."}, {"time": "09:45", "title": "Bodrum Castle", "text": "Guided walk through the Castle of St. Peter and its harbour views."}, {"time": "11:15", "title": "Antique Theatre", "text": "Visit the 2,400-year-old amphitheatre overlooking the bay."}, {"time": "12:15", "title": "Old Bazaar", "text": "Free time to explore the old town''s shops and backstreets."}, {"time": "13:30", "title": "Marina Free Time", "text": "Lunch on your own and time by the water."}, {"time": "15:00", "title": "Return", "text": "Drop-off back at your hotel."}]'::jsonb, '[]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-city-tour'), 'de',
   'Bodrum Stadtrundfahrt', 'Ein halbtägiger Spaziergang durch die Burg von Bodrum, das antike Theater, den alten Basar und den Yachthafen.', 'Stadtzentrum Bodrum, Provinz Mugla, Türkei',
   '6 Stunden - Halbtags', '09:00 Uhr, täglich', '15:00 Uhr',
   'Hotelabholung auf der gesamten Bodrum-Halbinsel',
   '["Bodrum''s own old town rarely gets the same attention as the day-trip destinations further afield, which is a shame - the city that grew up around one of the Seven Wonders of the Ancient World has plenty worth a slow morning on foot.", "This half-day tour walks you through the harbour-front Bodrum Castle (built by the Knights of St. John from the stones of the ruined Mausoleum), the 2,400-year-old Antique Theatre with its sweeping bay views, and the narrow lanes of the old bazaar, before finishing at the marina for free time and lunch on your own."]'::jsonb, '["Bodrum Castle of St. Peter, overlooking the harbour", "The 2,400-year-old Bodrum Antique Theatre", "Old town bazaar and whitewashed backstreets", "Panoramic viewpoint over Bodrum Bay", "Free time at the marina", "Half-day pace - back at your hotel by mid-afternoon"]'::jsonb,
   '["Round-trip transport in air-conditioned vehicle", "Hotel pick-up and drop-off", "English-speaking tour guide", "Bodrum Castle entrance fee", "Bottled water"]'::jsonb, '["Lunch (free time at the marina to choose your own)", "Personal expenses and souvenirs", "Gratuities for the guide and driver"]'::jsonb,
   '[{"time": "09:00", "title": "Hotel Pick-up", "text": "Departure toward Bodrum city centre."}, {"time": "09:45", "title": "Bodrum Castle", "text": "Guided walk through the Castle of St. Peter and its harbour views."}, {"time": "11:15", "title": "Antique Theatre", "text": "Visit the 2,400-year-old amphitheatre overlooking the bay."}, {"time": "12:15", "title": "Old Bazaar", "text": "Free time to explore the old town''s shops and backstreets."}, {"time": "13:30", "title": "Marina Free Time", "text": "Lunch on your own and time by the water."}, {"time": "15:00", "title": "Return", "text": "Drop-off back at your hotel."}]'::jsonb, '[]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-city-tour'), 'ru',
   'Тур по Городу Бодрум', 'Полудневная экскурсия по замку Бодрум, античному театру, старому базару и марине.', 'Центр города Бодрум, провинция Мугла, Турция',
   '6 часов - Полдня', '09:00, ежедневно', '15:00',
   'Трансфер из отеля по всему полуострову Бодрум',
   '["Bodrum''s own old town rarely gets the same attention as the day-trip destinations further afield, which is a shame - the city that grew up around one of the Seven Wonders of the Ancient World has plenty worth a slow morning on foot.", "This half-day tour walks you through the harbour-front Bodrum Castle (built by the Knights of St. John from the stones of the ruined Mausoleum), the 2,400-year-old Antique Theatre with its sweeping bay views, and the narrow lanes of the old bazaar, before finishing at the marina for free time and lunch on your own."]'::jsonb, '["Bodrum Castle of St. Peter, overlooking the harbour", "The 2,400-year-old Bodrum Antique Theatre", "Old town bazaar and whitewashed backstreets", "Panoramic viewpoint over Bodrum Bay", "Free time at the marina", "Half-day pace - back at your hotel by mid-afternoon"]'::jsonb,
   '["Round-trip transport in air-conditioned vehicle", "Hotel pick-up and drop-off", "English-speaking tour guide", "Bodrum Castle entrance fee", "Bottled water"]'::jsonb, '["Lunch (free time at the marina to choose your own)", "Personal expenses and souvenirs", "Gratuities for the guide and driver"]'::jsonb,
   '[{"time": "09:00", "title": "Hotel Pick-up", "text": "Departure toward Bodrum city centre."}, {"time": "09:45", "title": "Bodrum Castle", "text": "Guided walk through the Castle of St. Peter and its harbour views."}, {"time": "11:15", "title": "Antique Theatre", "text": "Visit the 2,400-year-old amphitheatre overlooking the bay."}, {"time": "12:15", "title": "Old Bazaar", "text": "Free time to explore the old town''s shops and backstreets."}, {"time": "13:30", "title": "Marina Free Time", "text": "Lunch on your own and time by the water."}, {"time": "15:00", "title": "Return", "text": "Drop-off back at your hotel."}]'::jsonb, '[]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

insert into public.tour_translations
  (tour_id, language, name, short_description, location, duration_label, departure_label,
   return_time_label, meeting_point, description, highlights, included, excluded, program, faq)
values
  ((select id from public.tours where slug = 'bodrum-city-tour'), 'pl',
   'Wycieczka po Mieście Bodrum', 'Półdniowy spacer z przewodnikiem po zamku Bodrum, antycznym teatrze, starym bazarze i marinie.', 'Centrum miasta Bodrum, prowincja Mugla, Turcja',
   '6 godzin - Pół dnia', '09:00, codziennie', '15:00',
   'Odbiór z hotelu na całym półwyspie Bodrum',
   '["Bodrum''s own old town rarely gets the same attention as the day-trip destinations further afield, which is a shame - the city that grew up around one of the Seven Wonders of the Ancient World has plenty worth a slow morning on foot.", "This half-day tour walks you through the harbour-front Bodrum Castle (built by the Knights of St. John from the stones of the ruined Mausoleum), the 2,400-year-old Antique Theatre with its sweeping bay views, and the narrow lanes of the old bazaar, before finishing at the marina for free time and lunch on your own."]'::jsonb, '["Bodrum Castle of St. Peter, overlooking the harbour", "The 2,400-year-old Bodrum Antique Theatre", "Old town bazaar and whitewashed backstreets", "Panoramic viewpoint over Bodrum Bay", "Free time at the marina", "Half-day pace - back at your hotel by mid-afternoon"]'::jsonb,
   '["Round-trip transport in air-conditioned vehicle", "Hotel pick-up and drop-off", "English-speaking tour guide", "Bodrum Castle entrance fee", "Bottled water"]'::jsonb, '["Lunch (free time at the marina to choose your own)", "Personal expenses and souvenirs", "Gratuities for the guide and driver"]'::jsonb,
   '[{"time": "09:00", "title": "Hotel Pick-up", "text": "Departure toward Bodrum city centre."}, {"time": "09:45", "title": "Bodrum Castle", "text": "Guided walk through the Castle of St. Peter and its harbour views."}, {"time": "11:15", "title": "Antique Theatre", "text": "Visit the 2,400-year-old amphitheatre overlooking the bay."}, {"time": "12:15", "title": "Old Bazaar", "text": "Free time to explore the old town''s shops and backstreets."}, {"time": "13:30", "title": "Marina Free Time", "text": "Lunch on your own and time by the water."}, {"time": "15:00", "title": "Return", "text": "Drop-off back at your hotel."}]'::jsonb, '[]'::jsonb)
on conflict (tour_id, language) do update set
  name = excluded.name, short_description = excluded.short_description, location = excluded.location,
  duration_label = excluded.duration_label, departure_label = excluded.departure_label,
  return_time_label = excluded.return_time_label, meeting_point = excluded.meeting_point,
  description = excluded.description, highlights = excluded.highlights, included = excluded.included,
  excluded = excluded.excluded, program = excluded.program, faq = excluded.faq;

-- ============ tour_images ============
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kos-island'), 'assets/images/kos_images/kos_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kos-island'), 'assets/images/kos_images/kos_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kos-island'), 'assets/images/kos_images/kos_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kos-island'), 'assets/images/kos_images/kos_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kos-island'), 'assets/images/kos_images/kos_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kos-island'), 'assets/images/kos_images/kos_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kos-island'), 'assets/images/kos_images/kos_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'leros-island'), 'assets/images/leros_images/leros_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'leros-island'), 'assets/images/leros_images/leros_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'leros-island'), 'assets/images/leros_images/leros_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'leros-island'), 'assets/images/leros_images/leros_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'leros-island'), 'assets/images/leros_images/leros_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'leros-island'), 'assets/images/leros_images/leros_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'leros-island'), 'assets/images/leros_images/leros_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kalymnos-island'), 'assets/images/kalymnos_images/kalymnos_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kalymnos-island'), 'assets/images/kalymnos_images/kalymnos_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kalymnos-island'), 'assets/images/kalymnos_images/kalymnos_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kalymnos-island'), 'assets/images/kalymnos_images/kalymnos_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kalymnos-island'), 'assets/images/kalymnos_images/kalymnos_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kalymnos-island'), 'assets/images/kalymnos_images/kalymnos_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'kalymnos-island'), 'assets/images/kalymnos_images/kalymnos_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'boat-trip'), 'assets/images/boat_trip_images/boat_trip_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'boat-trip'), 'assets/images/boat_trip_images/boat_trip_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'boat-trip'), 'assets/images/boat_trip_images/boat_trip_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'boat-trip'), 'assets/images/boat_trip_images/boat_trip_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'boat-trip'), 'assets/images/boat_trip_images/boat_trip_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'boat-trip'), 'assets/images/boat_trip_images/boat_trip_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'boat-trip'), 'assets/images/boat_trip_images/boat_trip_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'turkish-bath'), 'assets/images/turkish_bath_images/turkish_bath_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'turkish-bath'), 'assets/images/turkish_bath_images/turkish_bath_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'turkish-bath'), 'assets/images/turkish_bath_images/turkish_bath_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'turkish-bath'), 'assets/images/turkish_bath_images/turkish_bath_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'turkish-bath'), 'assets/images/turkish_bath_images/turkish_bath_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'turkish-bath'), 'assets/images/turkish_bath_images/turkish_bath_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'turkish-bath'), 'assets/images/turkish_bath_images/turkish_bath_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'jeep-safari'), 'assets/images/jeep_safari_images/jeep_safari_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'jeep-safari'), 'assets/images/jeep_safari_images/jeep_safari_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'jeep-safari'), 'assets/images/jeep_safari_images/jeep_safari_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'jeep-safari'), 'assets/images/jeep_safari_images/jeep_safari_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'jeep-safari'), 'assets/images/jeep_safari_images/jeep_safari_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'jeep-safari'), 'assets/images/jeep_safari_images/jeep_safari_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'jeep-safari'), 'assets/images/jeep_safari_images/jeep_safari_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'atv-safari'), 'assets/images/atv_safari_images/atv_safari_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'atv-safari'), 'assets/images/atv_safari_images/atv_safari_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'atv-safari'), 'assets/images/atv_safari_images/atv_safari_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'atv-safari'), 'assets/images/atv_safari_images/atv_safari_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'atv-safari'), 'assets/images/atv_safari_images/atv_safari_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'atv-safari'), 'assets/images/atv_safari_images/atv_safari_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'atv-safari'), 'assets/images/atv_safari_images/atv_safari_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'horse-riding'), 'assets/images/horse_riding_images/horse_riding_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'horse-riding'), 'assets/images/horse_riding_images/horse_riding_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'horse-riding'), 'assets/images/horse_riding_images/horse_riding_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'horse-riding'), 'assets/images/horse_riding_images/horse_riding_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'horse-riding'), 'assets/images/horse_riding_images/horse_riding_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'horse-riding'), 'assets/images/horse_riding_images/horse_riding_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'horse-riding'), 'assets/images/horse_riding_images/horse_riding_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'scuba-diving'), 'assets/images/scuba_diving_images/scuba_diving_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'scuba-diving'), 'assets/images/scuba_diving_images/scuba_diving_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'scuba-diving'), 'assets/images/scuba_diving_images/scuba_diving_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'scuba-diving'), 'assets/images/scuba_diving_images/scuba_diving_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'scuba-diving'), 'assets/images/scuba_diving_images/scuba_diving_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'scuba-diving'), 'assets/images/scuba_diving_images/scuba_diving_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'scuba-diving'), 'assets/images/scuba_diving_images/scuba_diving_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dolphin-park'), 'assets/images/dolphin_park_images/dolphin_park_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dolphin-park'), 'assets/images/dolphin_park_images/dolphin_park_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dolphin-park'), 'assets/images/dolphin_park_images/dolphin_park_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dolphin-park'), 'assets/images/dolphin_park_images/dolphin_park_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dolphin-park'), 'assets/images/dolphin_park_images/dolphin_park_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dolphin-park'), 'assets/images/dolphin_park_images/dolphin_park_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dolphin-park'), 'assets/images/dolphin_park_images/dolphin_park_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'aquapark'), 'assets/images/aquapark_images/aquapark_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'aquapark'), 'assets/images/aquapark_images/aquapark_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'aquapark'), 'assets/images/aquapark_images/aquapark_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'aquapark'), 'assets/images/aquapark_images/aquapark_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'aquapark'), 'assets/images/aquapark_images/aquapark_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'aquapark'), 'assets/images/aquapark_images/aquapark_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'aquapark'), 'assets/images/aquapark_images/aquapark_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'pamukkale'), 'assets/images/pamukkale_images/pamukkale_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'pamukkale'), 'assets/images/pamukkale_images/pamukkale_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'pamukkale'), 'assets/images/pamukkale_images/pamukkale_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'pamukkale'), 'assets/images/pamukkale_images/pamukkale_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'pamukkale'), 'assets/images/pamukkale_images/pamukkale_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'pamukkale'), 'assets/images/pamukkale_images/pamukkale_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'pamukkale'), 'assets/images/pamukkale_images/pamukkale_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'ephesus'), 'assets/images/ephesus_images/ephesus_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'ephesus'), 'assets/images/ephesus_images/ephesus_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'ephesus'), 'assets/images/ephesus_images/ephesus_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'ephesus'), 'assets/images/ephesus_images/ephesus_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'ephesus'), 'assets/images/ephesus_images/ephesus_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'ephesus'), 'assets/images/ephesus_images/ephesus_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'ephesus'), 'assets/images/ephesus_images/ephesus_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dalyan'), 'assets/images/dalyan_images/dalyan_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dalyan'), 'assets/images/dalyan_images/dalyan_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dalyan'), 'assets/images/dalyan_images/dalyan_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dalyan'), 'assets/images/dalyan_images/dalyan_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dalyan'), 'assets/images/dalyan_images/dalyan_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dalyan'), 'assets/images/dalyan_images/dalyan_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'dalyan'), 'assets/images/dalyan_images/dalyan_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'rafting'), 'assets/images/rafting_images/rafting_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'rafting'), 'assets/images/rafting_images/rafting_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'rafting'), 'assets/images/rafting_images/rafting_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'rafting'), 'assets/images/rafting_images/rafting_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'rafting'), 'assets/images/rafting_images/rafting_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'rafting'), 'assets/images/rafting_images/rafting_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'rafting'), 'assets/images/rafting_images/rafting_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'airport-transfer'), 'assets/images/airport_transfer_images/airport_transfer_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'airport-transfer'), 'assets/images/airport_transfer_images/airport_transfer_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'airport-transfer'), 'assets/images/airport_transfer_images/airport_transfer_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'airport-transfer'), 'assets/images/airport_transfer_images/airport_transfer_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'airport-transfer'), 'assets/images/airport_transfer_images/airport_transfer_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'airport-transfer'), 'assets/images/airport_transfer_images/airport_transfer_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'airport-transfer'), 'assets/images/airport_transfer_images/airport_transfer_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'vip-transfer'), 'assets/images/vip_transfer_images/vip_transfer_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'vip-transfer'), 'assets/images/vip_transfer_images/vip_transfer_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'vip-transfer'), 'assets/images/vip_transfer_images/vip_transfer_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'vip-transfer'), 'assets/images/vip_transfer_images/vip_transfer_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'vip-transfer'), 'assets/images/vip_transfer_images/vip_transfer_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'vip-transfer'), 'assets/images/vip_transfer_images/vip_transfer_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'vip-transfer'), 'assets/images/vip_transfer_images/vip_transfer_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-transfer'), 'assets/images/bodrum_transfer_images/bodrum_transfer_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-transfer'), 'assets/images/bodrum_transfer_images/bodrum_transfer_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-transfer'), 'assets/images/bodrum_transfer_images/bodrum_transfer_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-transfer'), 'assets/images/bodrum_transfer_images/bodrum_transfer_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-transfer'), 'assets/images/bodrum_transfer_images/bodrum_transfer_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-transfer'), 'assets/images/bodrum_transfer_images/bodrum_transfer_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-transfer'), 'assets/images/bodrum_transfer_images/bodrum_transfer_07.jpg', 7, true)
on conflict do nothing;

insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-city-tour'), 'assets/images/bodrum_city_images/bodrum_city_01.jpg', 1, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-city-tour'), 'assets/images/bodrum_city_images/bodrum_city_02.jpg', 2, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-city-tour'), 'assets/images/bodrum_city_images/bodrum_city_03.jpg', 3, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-city-tour'), 'assets/images/bodrum_city_images/bodrum_city_04.jpg', 4, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-city-tour'), 'assets/images/bodrum_city_images/bodrum_city_05.jpg', 5, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-city-tour'), 'assets/images/bodrum_city_images/bodrum_city_06.jpg', 6, true)
on conflict do nothing;
insert into public.tour_images (tour_id, image_url, sort_order, active)
values ((select id from public.tours where slug = 'bodrum-city-tour'), 'assets/images/bodrum_city_images/bodrum_city_07.jpg', 7, true)
on conflict do nothing;

-- ============ hotels (335) ============
insert into public.hotels (id, name, created_at)
values ('htl-seed-0', 'The Marmara Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-1', 'Doubletree by Hilton Bodrum Marina Vista', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-2', 'Holiday Inn Resort Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-3', 'Mandarin Resort & Spa Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-4', 'Diamond Of Bodrum Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-5', 'METT Hotel Beach Resort Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-6', 'Noi Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-7', 'La Quinta by Wyndham Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-8', 'Azka Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-9', 'Gulet Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-10', 'Kılavuz Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-11', 'Okyanus Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-12', 'Merhaba Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-13', 'Petra Butik Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-14', 'Jasmin Beach Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-15', 'Costa Luvi Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-16', 'Jasmin Elite Residence & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-17', 'The Poyz Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-18', 'Nagi Beach Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-19', 'Canna Garden Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-20', 'Serpina Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-21', 'Royal Asarlık Beach Hotel & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-22', 'Gümbet Beach Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-23', 'Ramada Resort By Wyndham Bodrum Bitez', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-24', 'Sianji Well-Being Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-25', 'Kairaba Bodrum Princess & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-26', 'La Blanche Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-27', 'Greenblue Hotel Turgutreis', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-28', 'Yılmaz Hotel Ortakent', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-29', 'Sirene Luxury Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-30', 'Ruins Luxury Resort - Adults Only', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-31', 'Delta Hotels By Marriott Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-32', 'Le Jardin d''Oliviers Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-33', 'Avantgarde Collection Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-34', 'Amore Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-35', 'Elite Hotel Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-36', 'Green Beach Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-37', 'Macakızı Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-38', 'Faros Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-39', 'Lavinya Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-40', 'Selvi Beach Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-41', 'Daphnis Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-42', 'Elista Hotel & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-43', 'Rixos Premium Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-44', 'Duja Bodrum Torba', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-45', 'Vogue Hotel Supreme Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-46', 'Doubletree By Hilton Bodrum Isil Club', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-47', 'Grand Yazıcı Torba', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-48', 'Kairaba Bodrum Imperial', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-49', 'Armonia Holiday Village & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-50', 'Gümüşlük Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-51', 'La Blanche Island Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-52', 'Kempinski Hotel Barbaros Bay', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-53', 'The Bodrum EDITION', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-54', 'Allium Bodrum Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-55', '4reasons Hotel+Bistro', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-56', 'MGallery The Bodrum Hotel Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-57', 'Arts Hotel Bodrum Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-58', 'Princess Artemisia Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-59', 'Ailla Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-60', 'The Highlight Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-61', 'Yalıkavak Marina Hotel By Social Living Collection', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-62', 'Art Suites Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-63', 'Birdcage 33 Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-64', 'Sezz Hotels Spa Wellness', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-65', 'G Beyond Residences & Villas', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-66', 'Root Redrock Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-67', 'Sandora Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-68', 'Boho Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-69', 'Ala Suites & Villas', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-70', 'La Maison Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-71', 'Adahan Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-72', 'Saraya Bodrum Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-73', 'Moon Beach & Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-74', 'Aegean Hills', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-75', 'Bovilla Hotels & Villas Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-76', 'Maxx Royal Bodrum Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-77', 'Golden Age Bodrum Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-78', 'Club Cactus Fleur Beach', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-79', 'Yaz Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-80', 'Life Butiq Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-81', 'La Local Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-82', 'Cactus Mirage Family Club', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-83', 'Sea Palm Otel Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-84', 'Palmalife Bodrum Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-85', 'Ali Baba Hotel Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-86', 'Ayhan Suite Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-87', 'Yıldız Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-88', 'Dreams Bodrum Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-89', 'Mirada Exclusive Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-90', 'Costa Blu Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-91', 'Artı Hotels Adult Only', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-92', 'Bodrum Palm Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-93', 'Doria Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-94', 'Ambrosia Hotel Beach & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-95', 'Agaya Bodrum Adult Only', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-96', 'Bodrium Hotel & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-97', 'Very Chic Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-98', 'Voyage Torba', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-99', 'Hyde Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-100', 'Susona Bodrum LXR Hotels & Resorts', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-101', 'Mivara Luxury Resort & Spa Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-102', 'Arin Resort Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-103', 'Swissôtel Resort Bodrum Beach', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-104', 'Hillstone Bodrum Hotel & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-105', 'The Plaza Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-106', 'Xanadu Island Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-107', 'Esmana Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-108', 'Costa Bianca Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-109', 'Queen Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-110', 'Hotel Marmara Mandarin', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-111', 'Bitez Deniz Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-112', 'Sebastian Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-113', 'Lango Design Hotel & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-114', 'Merih Boutique Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-115', 'Roas Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-116', 'Azure By Yelken Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-117', 'Selectum Colours Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-118', 'Selectum Collection Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-119', 'Rammos Managed By Dedeman', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-120', 'Dragut Point South', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-121', 'Yasmin Bodrum Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-122', '7 Art Fesleğen Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-123', '1453 Bodrum Resort Hotel & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-124', 'Acanthus Cennet Barut Collection', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-125', 'Açelya Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-126', 'Agan Pansiyon', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-127', 'Agean Dream Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-128', 'Aegean Garden Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-129', 'Akça Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-130', 'Akkan Beach Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-131', 'Akkan Hotel Marina', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-132', 'Akkan Plus Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-133', 'Akyalı Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-134', 'Alabanda Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-135', 'Alacatur Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-136', 'Alba Marin Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-137', 'Alexander The Great Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-138', 'Alta Park Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-139', 'Amanruya', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-140', 'Amfora Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-141', 'Anadolu Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-142', 'Anfora Pension', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-143', 'Antik Zeytin Hotel & Art', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-144', 'Antique Theatre Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-145', 'Arion Resort Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-146', 'Artemis Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-147', 'Artunc Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-148', 'Asmin Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-149', 'Asteria Bodrum Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-150', 'Avantgarde Refined Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-151', 'Ayaz Aqua Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-152', 'Babana Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-153', 'Baia Bodrum Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-154', 'Bircan Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-155', 'Blue Dreams Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-156', 'Bodrum Park Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-157', 'Bronze Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-158', 'Caresse, a Luxury Collection Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-159', 'Casa Dell''Arte Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-160', 'Casa Nonna Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-161', 'Elementa Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-162', 'Elite Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-163', 'El Vino Hotel & Suites', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-164', 'Ersan Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-165', 'Eskiceshme Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-166', 'Eterna Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-167', 'Flamm Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-168', 'Forever Club Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-169', 'Golden Age Hotel Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-170', 'Golden Beach Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-171', 'Golden Spoon Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-172', 'Green Bay Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-173', 'Gumbet Cove Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-174', 'Gümbet Anıl Beach', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-175', 'Gümbet Life Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-176', 'Hotel Centro Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-177', 'Hotel Karia Princess', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-178', 'Hotel Samara', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-179', 'Hotel Su Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-180', 'Inone Mucho Selection Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-181', 'Kaya Palazzo Resort & Residences Le Chic Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-182', 'Kefaluka Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-183', 'Khai Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-184', 'Labranda TMT Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-185', 'La Local Suites', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-186', 'Liona Hotel & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-187', 'Liv Hotel by Bellazure', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-188', 'Lujo Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-189', 'Maçakızı Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-190', 'Mandarin Oriental Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-191', 'Marina Vista Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-192', 'Marvel Beach Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-193', 'Mavi Kumsal Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-194', 'Med-Inn Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-195', 'Moonshine Hotel & Suites', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-196', 'Ena Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-197', 'Gündem Resort Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-198', 'Hotel Vita Bella Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-199', 'No 81 Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-200', 'Okaliptus Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-201', 'Olira Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-202', 'Parkim Ayaz Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-203', 'Petunya Beach Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-204', 'Phoenix Sun Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-205', 'Prive Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-206', 'Rammos Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-207', 'Regia Mare Beach Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-208', 'Riva Bodrum Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-209', 'Royal Arena Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-210', 'Salmakis Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-211', 'Sami Beach Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-212', 'Sea Garden Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-213', 'Senses Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-214', 'Scorpios Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-215', 'Sunpoint Family Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-216', 'Sunhill Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-217', 'The Hello Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-218', 'The Norm Collection Door''a Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-219', 'Titanic Luxury Collection Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-220', 'Toloman Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-221', 'Torbahan Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-222', 'TUI Magic Life Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-223', 'Villa Cosy Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-224', 'Villa Rustica Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-225', 'Voyage Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-226', 'Voyage Torba Private', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-227', 'Yalıpark Beach Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-228', 'Yalıkavak Holiday Gardens', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-229', 'Yelken Mandalinci Spa & Wellness Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-230', 'Zest Exclusive Hotel & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-231', 'Afytos Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-232', 'Bagevleri Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-233', 'Baska Resort Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-234', 'Natur Garden Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-235', 'Nefes Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-236', 'Nomia Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-237', 'OKU Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-238', 'Omar Hotel & Suites', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-239', 'Radisson Collection Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-240', 'Smart Holiday Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-241', 'Mio Bianco Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-242', 'Mio Mare Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-243', 'Natur Med Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-244', 'Nio Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-245', 'Ocean Club Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-246', 'Oscar Seaside Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-247', 'Palm Garden Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-248', 'Pitos Bungalows', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-249', 'Rammos Managed Collection', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-250', 'Rota Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-251', 'Sade Butik Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-252', 'Sea Soul Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-253', 'Sevin Hotel Pension', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-254', 'Siesta Beach Apart', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-255', 'Smart Stay Beach Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-256', 'The Oba Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-257', 'The Professor''s Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-258', 'Tropicana Beach Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-259', 'Veltur Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-260', 'Villa Nergis Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-261', 'Voyage Türkbükü', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-262', 'Yalı Han Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-263', 'Yalıyanı Motel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-264', 'Yelken Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-265', 'Zuzu''s Kitchen & Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-266', 'Costa Maya Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-267', 'Costa Sariyaz Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-268', 'Bodrum Skylife Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-269', 'Bitez Garden Life Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-270', 'Bitez Marina Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-271', 'Club Muskebi Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-272', 'Club Dedeman Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-273', 'Club Blue Dream', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-274', 'Club Hotel Flora', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-275', 'Crystal Green Bay Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-276', 'Forever Club Adult Only', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-277', 'Göltürkbükü Suites', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-278', 'Gündoğan Suites Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-279', 'Hill Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-280', 'Villa Oliva Boutique Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-281', 'M Suite Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-282', 'Bodrum Beach Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-283', 'Bodrum Holiday Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-284', 'Akkan Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-285', 'Nagi Suites', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-286', 'Euphoria Suites and Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-287', 'Pittas Studios & Apartments', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-288', 'Kadıkale Resort Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-289', 'Peksimet Butik Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-290', 'Zena Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-291', 'Le Meridien Bodrum Beach Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-292', 'The Qasr Bodrum Halal Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-293', 'İnanç Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-294', 'By Muhtar Otel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-295', 'Bodrum Vera Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-296', 'Wish Suites Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-297', 'R House Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-298', 'Oalis Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-299', 'Bodrum Blu', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-300', 'Station Hotel in Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-301', 'Alfa Apart Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-302', 'Sundance Suites Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-303', '9Bodrum Butik Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-304', 'The Lume Boutique Hotel & Restaurant & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-305', 'Quatro Life Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-306', 'Casa De Nova Hotel Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-307', 'Flag Suites Bodrum', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-308', 'Lizbonia Hotels Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-309', 'Tangiers Hotel Yalıkavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-310', 'Bombien Yalikavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-311', 'Marin Yalıkavak Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-312', 'Spektr Boutique Hotel Yalikavak', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-313', 'Olivia Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-314', 'Mira Suites', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-315', 'Hotel Zeytinada', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-316', 'Anar Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-317', 'Toka Bodrum Hotel & Beach Club', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-318', 'Panorama Hotel Turkbuku', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-319', 'Caja by Maxx Royal', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-320', 'MyElla Hotel Resort & Spa', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-321', 'Sundance Resort', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-322', 'Suum Bodrum Hotel & Beach', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-323', 'Liman Hotel Gümüslük', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-324', 'Myndos Bed & Breakfast Gümüşlük', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-325', 'Oda Bodrum Gümüşlük', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-326', 'Metin''s Gümüşlük Hotel & Restaurant', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-327', 'Oza Butik Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-328', 'Gümüşlük No3', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-329', 'Paradise Garden Apartments', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-330', 'Divan Bodrum Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-331', 'Dorman Suites Hotel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-332', 'Manzara Otel', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-333', 'Dinç Pansiyon', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;
insert into public.hotels (id, name, created_at)
values ('htl-seed-334', 'Ağan Pansiyon', '2026-08-11T18:58:07.306Z')
on conflict (id) do nothing;

-- ============ settings (single row) ============
insert into public.settings
  (id, company_name, phone, whatsapp, email, address, currency, island_min_advance_days, default_language)
values
  (1, 'MT TRAVEL', '+90 538 329 37 27', '905383293727', 'mttravelbodrum@gmail.com',
   'Neyzen Tevfik Street No. 45, Bodrum, Mugla, Turkiye', 'EUR', 1, 'en')
on conflict (id) do update set
  company_name = excluded.company_name, phone = excluded.phone, whatsapp = excluded.whatsapp,
  email = excluded.email, address = excluded.address, currency = excluded.currency,
  island_min_advance_days = excluded.island_min_advance_days, default_language = excluded.default_language;
