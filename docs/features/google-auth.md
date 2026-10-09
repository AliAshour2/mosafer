# Google authentication and profile setup

The app signs users in with Google through Supabase Auth. First-time users (and
accounts without a profile row) must save their name and international phone
number before accessing Home. Google-provided name is prefilled when available
and can be changed. The phone is stored as **unverified**; the app does not send
an SMS code.

## Configure Google OAuth

Google sign-in does not require a paid Google API or a paid Supabase Auth
feature. The applicable Google and Supabase plan limits and terms still apply.

1. In Google Cloud Console, configure the OAuth consent screen and create a
   **Web application** OAuth client.
2. Add this authorized redirect URI, replacing the project reference:
   `https://<project-ref>.supabase.co/auth/v1/callback`
3. In Supabase Dashboard, open **Authentication > Sign In / Providers > Google**,
   enable Google, and enter that OAuth client ID and secret. Keep the secret in
   Supabase; never put it in Flutter source or build arguments.
4. In Supabase **Authentication > URL Configuration**, add
   `com.example.mosafer://login-callback` under **Additional Redirect URLs**.
   Add the exact local or deployed web origins that will be used for web builds.
5. The Android manifest, iOS URL types, and Flutter OAuth redirect URI must use
   the same `com.example.mosafer://login-callback` callback. If the app ID or
   callback changes, update all three places and the dashboard allow-list.

The Android application ID and iOS bundle ID in this checkout are
`com.example.mosafer`. This browser-based OAuth flow uses the web OAuth client
configured in Supabase; it does not require a Google sign-in SDK in Flutter.
Real provider sign-in cannot succeed until the Google OAuth client and Supabase
provider settings above are configured.

## Profile data and deployment

`public.profiles` is keyed by the Supabase Auth user ID. RLS allows an
authenticated user to read, insert, and update only their own row. Anonymous
access and user profile deletion are not granted. Phone values must be
international-format strings (for example `+201012345678`); no calling code is
prefilled and no phone verification is performed.

After linking the Supabase CLI to the intended project, preview the pending
database changes, then apply them only after confirming the target:

```sh
supabase db push --linked --dry-run
supabase db push --linked --include-seed
```

This applies the profile migration as well as the demo-trip migration and seed.
Run the profile RLS tests with the local Supabase stack available:

```sh
supabase test db
```
