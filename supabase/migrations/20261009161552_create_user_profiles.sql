create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  full_name text not null
    check (char_length(trim(full_name)) between 1 and 100),
  phone text not null
    check (phone ~ '^\+[1-9][0-9]{7,14}$'),
  created_at timestamptz not null default now()
);

alter table public.profiles enable row level security;

revoke all on table public.profiles from public, anon, authenticated;
grant usage on schema public to authenticated;
grant select, insert, update on table public.profiles to authenticated;

create policy "Users can read their own profile"
  on public.profiles
  for select
  to authenticated
  using ((select auth.uid()) = id);

create policy "Users can create their own profile"
  on public.profiles
  for insert
  to authenticated
  with check ((select auth.uid()) = id);

create policy "Users can update their own profile"
  on public.profiles
  for update
  to authenticated
  using ((select auth.uid()) = id)
  with check ((select auth.uid()) = id);