begin;
select plan(11);

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
    '00000000-0000-4000-8000-000000000101',
    'Alexandria',
    'Cairo',
    now() + interval '1 day',
    250,
    'EGP',
    5,
    'scheduled',
    true
  ),
  (
    '00000000-0000-4000-8000-000000000102',
    'Alexandria',
    'Cairo',
    now() + interval '1 day',
    250,
    'EGP',
    5,
    'scheduled',
    false
  ),
  (
    '00000000-0000-4000-8000-000000000103',
    'Alexandria',
    'Cairo',
    now() + interval '1 day',
    250,
    'EGP',
    5,
    'cancelled',
    true
  ),
  (
    '00000000-0000-4000-8000-000000000104',
    'Alexandria',
    'Cairo',
    now() - interval '1 day',
    250,
    'EGP',
    5,
    'scheduled',
    true
  );

select ok(
  (select relrowsecurity from pg_class where oid = 'public.trips'::regclass),
  'RLS is enabled on trips'
);

select ok(has_table_privilege('anon', 'public.trips', 'select'), 'anon can read trips');
select ok(has_table_privilege('authenticated', 'public.trips', 'select'), 'authenticated can read trips');
select ok(not has_table_privilege('anon', 'public.trips', 'insert'), 'anon cannot insert trips');
select ok(not has_table_privilege('anon', 'public.trips', 'update'), 'anon cannot update trips');
select ok(not has_table_privilege('anon', 'public.trips', 'delete'), 'anon cannot delete trips');
select ok(not has_table_privilege('authenticated', 'public.trips', 'insert'), 'authenticated cannot insert trips');
select ok(not has_table_privilege('authenticated', 'public.trips', 'update'), 'authenticated cannot update trips');
select ok(not has_table_privilege('authenticated', 'public.trips', 'delete'), 'authenticated cannot delete trips');

set local role anon;
select is(
  (select count(*) from public.trips where id::text like '00000000-0000-4000-8000-00000000010%'),
  1::bigint,
  'anon sees only a future scheduled demo trip'
);
reset role;

set local role authenticated;
select is(
  (select count(*) from public.trips where id::text like '00000000-0000-4000-8000-00000000010%'),
  1::bigint,
  'authenticated sees only a future scheduled demo trip'
);
reset role;

select * from finish();
rollback;
