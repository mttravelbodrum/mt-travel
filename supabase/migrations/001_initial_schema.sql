-- MT Travel - initial Supabase schema
-- Generated from a direct read of the existing backend/routes/*.js and
-- backend/data/db.json (the current JSON-file store) plus data/tours.json
-- (the static i18n content source) - every column below maps to a field
-- that code actually reads or writes today. Nothing here is invented.
--
-- Run this once in the Supabase SQL Editor (or `supabase db push` if you
-- use the CLI) before 002_rls_policies.sql.

create extension if not exists "pgcrypto"; -- gen_random_uuid()

-- ---------------------------------------------------------------------
-- tours
-- One row per tour. Holds every field the admin panel's Tour form and
-- the booking flow's pricing logic actually read (backend/routes/tours.js,
-- backend/seed.js), plus the two static-source fields (theme, related)
-- that only lived in data/tours.json before this migration.
-- ---------------------------------------------------------------------
create table public.tours (
  id                 uuid primary key default gen_random_uuid(),
  slug               text not null unique,
  category           text not null,
  is_island          boolean not null default false,
  badge              text not null default 'none',
  price              numeric(10,2) not null,
  price_adult        numeric(10,2),
  price_child        numeric(10,2),
  price_infant       numeric(10,2) not null default 0,
  -- 'standard' = adult/child/infant counters (every tour today except
  -- ATV Safari). 'single_double' = per-vehicle single/double counters
  -- (see booking.js's atvMode checks). Both price pairs are nullable so a
  -- tour only needs the pair its own pricing_mode actually uses.
  pricing_mode       text not null default 'standard'
                       check (pricing_mode in ('standard', 'single_double')),
  price_single       numeric(10,2),
  price_double       numeric(10,2),
  duration_hours     numeric(5,2),
  -- Kept as "HH:MM" text, matching every current read site (the booking
  -- page, the tour-program "Feribotla Hareket"/"Dönüş Yolculuğu" rows,
  -- the PDF) - none of them do timezone-aware time arithmetic on this
  -- value, they only display it, so a real TIME column would add a
  -- conversion step this project has never needed.
  departure_time     text,
  return_time        text,
  rating             numeric(2,1) not null default 5.0,
  review_count       integer not null default 0,
  featured           boolean not null default false,
  visible            boolean not null default true,
  available_days     text[] not null default array['monday','tuesday','wednesday','thursday','friday','saturday','sunday'],
  -- Slugs of related tours shown on the tour detail page - kept as a
  -- plain array rather than a join table since it's an ordered,
  -- editorial "you might also like" list of at most 3, not a real
  -- many-to-many relationship queried from the other direction.
  related_slugs      text[] not null default '{}',
  theme              text,
  created_at         timestamptz not null default now(),
  updated_at         timestamptz not null default now()
);
create index tours_category_idx on public.tours (category);
create index tours_visible_idx on public.tours (visible);

-- ---------------------------------------------------------------------
-- tour_translations
-- One row per (tour, language). All 5 languages the site already ships
-- (tr/en/de/ru/pl - see site/assets/js/i18n/*.json) get a row per tour.
-- The four list-shaped fields (description/highlights/included/excluded)
-- and the two nested-object-list fields (program/faq) are stored as
-- jsonb, matching their exact current shape in data/tours.json, instead
-- of being normalized into more join tables - they're always read and
-- written as a whole list for one tour+language, never queried or
-- filtered row-by-row, so jsonb keeps this migration low-risk without
-- losing anything queryable in practice.
-- ---------------------------------------------------------------------
create table public.tour_translations (
  id                 uuid primary key default gen_random_uuid(),
  tour_id            uuid not null references public.tours(id) on delete cascade,
  language           text not null check (language in ('tr','en','de','ru','pl')),
  name               text not null,
  short_description  text,
  location           text,
  duration_label     text,
  departure_label    text,
  return_time_label  text,
  meeting_point      text,
  -- array of paragraph strings
  description        jsonb not null default '[]',
  -- array of strings
  highlights         jsonb not null default '[]',
  included           jsonb not null default '[]',
  excluded           jsonb not null default '[]',
  -- array of {time, title, text}
  program            jsonb not null default '[]',
  -- array of {q, a}
  faq                jsonb not null default '[]',
  unique (tour_id, language)
);
create index tour_translations_tour_id_idx on public.tour_translations (tour_id);

-- ---------------------------------------------------------------------
-- tour_images
-- Mirrors the existing assets/images/{prefix}_images/{prefix}_0N.jpg
-- convention (see gen_js_data.py's folder/image_prefix/image_count
-- fields) - image_url stores that same relative path so the frontend's
-- existing <img src="assets/images/...">  usage does not need to change.
-- ---------------------------------------------------------------------
create table public.tour_images (
  id                 uuid primary key default gen_random_uuid(),
  tour_id            uuid not null references public.tours(id) on delete cascade,
  image_url          text not null,
  sort_order         integer not null default 0,
  active             boolean not null default true,
  created_at         timestamptz not null default now()
);
create index tour_images_tour_id_idx on public.tour_images (tour_id, sort_order);

-- ---------------------------------------------------------------------
-- hotels
-- Admin-managed list that powers the booking page's searchable
-- "Hotel Name" field (backend/routes/hotels.js). Name uniqueness is
-- case-insensitive there (h.name.toLowerCase() === name.toLowerCase()),
-- reproduced below with a unique index on lower(name) rather than a
-- plain unique constraint on name.
-- ---------------------------------------------------------------------
create table public.hotels (
  id                 text primary key,
  name               text not null,
  created_at         timestamptz not null default now()
);
create unique index hotels_name_lower_idx on public.hotels (lower(name));

-- ---------------------------------------------------------------------
-- reservations
-- id keeps the existing human-facing "MTG-XXXXXX" format (generated by
-- the backend, see generateReservationId() in routes/reservations.js) -
-- it is what's printed on the PDF voucher, searched by in the admin
-- panel, and put in email subject lines, so switching it to a uuid would
-- be a visible behaviour change this migration is not supposed to make.
-- tour_id is a soft reference (on delete set null): a reservation must
-- keep existing, searchable and printable even if its tour is later
-- deleted from the tours table - exactly how the JSON store behaves
-- today, where reservations are never cascade-deleted with their tour.
-- ---------------------------------------------------------------------
create table public.reservations (
  id                 text primary key,
  tour_id            uuid references public.tours(id) on delete set null,
  slug               text not null,
  tour_name_en       text not null,
  tour_name_tr       text,
  date               date not null,
  lang               text not null default 'tr' check (lang in ('en','tr','de','ru','pl')),
  pricing_mode       text not null default 'standard'
                       check (pricing_mode in ('standard', 'single_double')),
  adults             integer not null default 0,
  children           integer not null default 0,
  infants            integer not null default 0,
  single_count       integer not null default 0,
  double_count       integer not null default 0,
  customer           text not null,
  first_name         text not null,
  last_name          text not null,
  email              text not null,
  phone              text,
  country            text,
  hotel_name         text,
  notes              text,
  payment_method     text not null default 'reserve_pay_later',
  total              numeric(10,2) not null,
  status             text not null default 'Pending'
                       check (status in ('Pending','Confirmed','Completed','Cancelled')),
  created_at         timestamptz not null default now(),
  updated_at         timestamptz not null default now()
);
create index reservations_email_idx on public.reservations (email);
create index reservations_slug_idx on public.reservations (slug);
create index reservations_status_idx on public.reservations (status);
create index reservations_created_at_idx on public.reservations (created_at desc);
-- Backs the idempotency check in routes/reservations.js (same email +
-- slug + date within the last 60 seconds = treat as a resubmit, not a
-- new booking).
create index reservations_dedup_idx on public.reservations (email, slug, date, created_at desc);

-- ---------------------------------------------------------------------
-- settings
-- Single-row table (id is pinned to 1 by the check constraint) - a
-- direct typed version of backend/seed.js's DEFAULT_SETTINGS object,
-- which is the complete, authoritative list of settings fields this
-- project actually reads anywhere.
-- ---------------------------------------------------------------------
create table public.settings (
  id                       integer primary key default 1 check (id = 1),
  company_name             text not null default 'MT TRAVEL',
  phone                    text,
  whatsapp                 text,
  email                    text,
  address                  text,
  currency                 text not null default 'EUR',
  island_min_advance_days  integer not null default 1,
  default_language         text not null default 'en',
  updated_at               timestamptz not null default now()
);

-- ---------------------------------------------------------------------
-- activity_log
-- reservation_id is intentionally NOT a foreign key: routes/reservations.js
-- deletes a reservation's own log entries on delete but then writes one
-- final "Reservation Deleted" entry with reservation_id = null - a hard
-- FK would make that insert impossible right after the delete.
-- ---------------------------------------------------------------------
create table public.activity_log (
  id                 uuid primary key default gen_random_uuid(),
  action             text not null,
  reservation_id     text,
  customer           text,
  tour_name          text,
  slug               text,
  by                 text not null default 'System',
  at                 timestamptz not null default now()
);
create index activity_log_at_idx on public.activity_log (at desc);

-- ---------------------------------------------------------------------
-- notifications
-- Powers the admin bell icon (GET /api/notifications, PATCH
-- /notifications/read-all).
-- ---------------------------------------------------------------------
create table public.notifications (
  id                 text primary key,
  type               text not null,
  reservation_id     text,
  customer           text,
  tour               text,
  slug               text,
  created_at         timestamptz not null default now(),
  read               boolean not null default false
);
create index notifications_created_at_idx on public.notifications (created_at desc);
create index notifications_read_idx on public.notifications (read);

-- ---------------------------------------------------------------------
-- updated_at trigger (tours, reservations, settings only - the other
-- tables have no update path in the current code, only insert/delete)
-- ---------------------------------------------------------------------
create or replace function public.set_updated_at()
returns trigger as $$
begin
  new.updated_at = now();
  return new;
end;
$$ language plpgsql;

create trigger tours_set_updated_at
  before update on public.tours
  for each row execute function public.set_updated_at();

create trigger reservations_set_updated_at
  before update on public.reservations
  for each row execute function public.set_updated_at();

create trigger settings_set_updated_at
  before update on public.settings
  for each row execute function public.set_updated_at();
