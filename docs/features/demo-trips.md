# Demo trips in Supabase

The home screen reads upcoming demo trips from `public.trips`. The migration
grants the `anon` and `authenticated` Data API roles read access only. RLS
restricts results to future, scheduled rows marked `is_demo`; client roles
cannot insert, update, or delete trip rows.

The demo phone flow is still a local, in-memory session. It is not Supabase
authentication and does not identify a user. These publicly readable demo
trips must not be treated as personal bookings or verified inventory.

## Deploying

After authenticating the Supabase CLI and linking this checkout to the intended
project, preview and apply the migration and seed:

```sh
supabase db push --linked --dry-run
supabase db push --linked --include-seed
```

The seed uses stable IDs and upserts its rows, so reapplying it is safe. It
creates sample Alexandria–Cairo, Cairo–Alexandria, and Cairo–Giza routes.

To validate policies locally with Supabase running:

```sh
supabase test db
```
