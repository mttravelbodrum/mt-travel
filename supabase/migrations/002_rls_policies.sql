-- MT Travel - Row Level Security
--
-- Architecture note (read this before changing anything below):
-- the Node backend is the ONLY thing that talks to Supabase - the
-- frontend still calls the Node API exactly as it does today
-- (site/assets/js/api-client.js is unchanged), and the Node backend
-- authenticates to Supabase with the SECRET (service_role) key, which
-- bypasses RLS entirely. That means every policy below is a *defense in
-- depth* measure, not something the app's normal traffic depends on -
-- it's what protects this data if the publishable key ever ends up
-- somewhere it can reach Supabase directly (e.g. a future feature that
-- calls Supabase from the browser), matching Supabase's own guidance to
-- enable RLS on every exposed table regardless of current access
-- patterns.
--
-- All admin-only tables therefore get NO anon policy at all (default
-- deny) rather than a policy that tries to detect "is this an admin" -
-- this project's admin session is a custom signed token
-- (backend/lib/auth.js), not a Supabase Auth session, so there is no
-- Supabase-visible identity to write a policy against. Admin access
-- control stays exactly where it already is: the requireAuth middleware
-- in backend/middleware/auth.js, unchanged by this migration.

alter table public.tours              enable row level security;
alter table public.tour_translations  enable row level security;
alter table public.tour_images        enable row level security;
alter table public.hotels             enable row level security;
alter table public.reservations       enable row level security;
alter table public.settings           enable row level security;
alter table public.activity_log       enable row level security;
alter table public.notifications      enable row level security;

-- ---------------------------------------------------------------------
-- Public read access - matches the routes that already have no
-- requireAuth today (GET /api/tours, /api/tours/:slug, /api/hotels).
-- ---------------------------------------------------------------------

-- Visible tours only - mirrors the ?visibleOnly=true filter already
-- used by the public site (see routes/tours.js).
create policy "anon can read visible tours"
  on public.tours for select
  to anon
  using (visible = true);

create policy "anon can read translations of visible tours"
  on public.tour_translations for select
  to anon
  using (
    exists (
      select 1 from public.tours t
      where t.id = tour_translations.tour_id and t.visible = true
    )
  );

create policy "anon can read images of visible tours"
  on public.tour_images for select
  to anon
  using (
    active = true
    and exists (
      select 1 from public.tours t
      where t.id = tour_images.tour_id and t.visible = true
    )
  );

-- The booking page's hotel search reads every hotel, unfiltered - same
-- as today's GET /api/hotels.
create policy "anon can read hotels"
  on public.hotels for select
  to anon
  using (true);

-- ---------------------------------------------------------------------
-- reservations - intentionally locked down for anon in both directions.
--
-- No anon SELECT: "müşteri başka rezervasyonları okuyamaz" - a customer
-- must never be able to list or read anyone's reservation, including
-- their own, straight from the database (today they only ever see their
-- own booking's confirmation email/PDF, never a read-back from the API).
--
-- No anon INSERT either, even though guests do create reservations:
-- POST /api/reservations runs real business rules first - the
-- availableDays check, the island minimum-advance-notice check read
-- from settings, the rate limiter, and the 60-second duplicate-submit
-- guard (all in routes/reservations.js). None of that is expressible as
-- a static RLS policy without re-implementing it twice in two different
-- languages and risking the two copies drifting apart. The Node backend
-- keeps validating and inserting with the service_role key exactly as
-- it does today; this table simply has no direct anon access at all.
-- ---------------------------------------------------------------------
-- (no anon policies on public.reservations - default deny)

-- settings, activity_log, notifications: admin-only in the current app
-- (every route reading them has requireAuth) - no anon policy needed.
