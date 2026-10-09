begin;
select plan(11);

select has_table('public', 'profiles', 'profiles table exists');
select ok(
  (select relrowsecurity from pg_class where oid = 'public.profiles'::regclass),
  'RLS is enabled on profiles'
);
select ok(not has_table_privilege('anon', 'public.profiles', 'select'), 'anon cannot read profiles');
select ok(not has_table_privilege('anon', 'public.profiles', 'insert'), 'anon cannot insert profiles');
select ok(not has_table_privilege('anon', 'public.profiles', 'update'), 'anon cannot update profiles');
select ok(has_table_privilege('authenticated', 'public.profiles', 'select'), 'users can read their own profile');
select ok(has_table_privilege('authenticated', 'public.profiles', 'insert'), 'users can create their own profile');
select ok(has_table_privilege('authenticated', 'public.profiles', 'update'), 'users can update their own profile');
select ok(not has_table_privilege('authenticated', 'public.profiles', 'delete'), 'users cannot delete profiles');
select is(
  (select count(*) from pg_policies where schemaname = 'public' and tablename = 'profiles'),
  3::bigint,
  'profiles has separate select, insert, and update policies'
);
select ok(
  (select bool_and(
    case
      when cmd = 'SELECT' then coalesce(qual, '') like '%auth.uid()%'
      when cmd = 'INSERT' then coalesce(with_check, '') like '%auth.uid()%'
      when cmd = 'UPDATE' then
        coalesce(qual, '') like '%auth.uid()%'
        and coalesce(with_check, '') like '%auth.uid()%'
      else false
    end
  )
   from pg_policies
   where schemaname = 'public'
     and tablename = 'profiles'
     and cmd in ('SELECT', 'INSERT', 'UPDATE')),
  'all profile policies bind row access to the authenticated user'
);

select * from finish();
rollback;
