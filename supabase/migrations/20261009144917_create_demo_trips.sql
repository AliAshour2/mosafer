create table public.trips (
  id uuid primary key default gen_random_uuid(),
  origin text not null check (length(btrim(origin)) > 0),
  destination text not null check (length(btrim(destination)) > 0),
  departure_at timestamptz not null,
  price numeric(10, 2) not null check (price >= 0),
  currency text not null check (currency ~ '^[A-Z]{3}$'),
  seats_available integer not null check (seats_available >= 0),
  status text not null default 'scheduled'
    check (status in ('scheduled', 'cancelled', 'completed')),
  is_demo boolean not null default true,
  created_at timestamptz not null default now(),
  check (origin <> destination)
);

create index trips_scheduled_departure_idx
  on public.trips (departure_at)
  where status = 'scheduled' and is_demo;

alter table public.trips enable row level security;

revoke all on table public.trips from anon, authenticated;
grant select on table public.trips to anon, authenticated;

create policy "Anyone can read scheduled demo trips"
  on public.trips
  for select
  to anon, authenticated
  using (is_demo and status = 'scheduled' and departure_at >= now());