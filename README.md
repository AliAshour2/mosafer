# Mosafer

Flutter client for Mosafer. It uses Supabase Auth and the Supabase Data API.

## Local configuration

The Flutter client requires three compile-time values:

| Define | Purpose |
| --- | --- |
| `APP_ENV` | `development`, `staging`, or `production` |
| `SUPABASE_URL` | Supabase project URL |
| `SUPABASE_PUBLISHABLE_KEY` | Supabase publishable key (or legacy `anon` key) |

Create a local development config from the checked-in example:

```powershell
Copy-Item config\app_config.example.json config\development.json
```

Replace the URL and key in `config/development.json` with the values from the
intended Supabase project, then run:

```powershell
flutter run --dart-define-from-file=config/development.json
```

For other environments, create `config/staging.json` or
`config/production.json` with that environment's Supabase URL and publishable
key, and pass its path to `--dart-define-from-file`. Those files are ignored by
Git. Do not commit local environment configuration.

Configuration is validated before Supabase initializes. Production and staging
require HTTPS; HTTP is accepted only for localhost in development. Missing or
invalid values show a setup screen rather than silently using another project.

## Client keys and secrets

Flutter applications are distributed to users. Dart defines, bundled JSON,
obfuscation, and native resources do **not** make a value secret. The Supabase
URL and publishable/legacy `anon` key are client identifiers designed to be
public; protect data with RLS and least-privilege grants.

Never put a Supabase secret/service-role key, Google OAuth client secret,
database password, or other privileged credential in this repository, a
Flutter define, or the app binary. Keep provider secrets in the Supabase
Dashboard and server-only credentials in a trusted backend or CI secret store.
If a privileged key has already been committed or shipped, rotate it.

See [Google authentication setup](docs/features/google-auth.md) for provider
configuration and redirect URLs.
