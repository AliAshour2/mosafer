insert into public.trips (
  id,
  origin,
  destination,
  departure_at,
  price,
  currency,
  seats_available,
  status,
  is_demo
)
values
  (
    '00000000-0000-4000-8000-000000000001',
    'Alexandria',
    'Cairo',
    date_trunc('day', now()) + interval '3 days 14 hours 41 minutes',
    250,
    'EGP',
    5,
    'scheduled',
    true
  ),
  (
    '00000000-0000-4000-8000-000000000002',
    'Cairo',
    'Alexandria',
    date_trunc('day', now()) + interval '4 days 9 hours 30 minutes',
    220,
    'EGP',
    8,
    'scheduled',
    true
  ),
  (
    '00000000-0000-4000-8000-000000000003',
    'Cairo',
    'Giza',
    date_trunc('day', now()) + interval '5 days 12 hours',
    75,
    'EGP',
    12,
    'scheduled',
    true
  )
on conflict (id) do update
set origin = excluded.origin,
    destination = excluded.destination,
    departure_at = excluded.departure_at,
    price = excluded.price,
    currency = excluded.currency,
    seats_available = excluded.seats_available,
    status = excluded.status,
    is_demo = excluded.is_demo;
