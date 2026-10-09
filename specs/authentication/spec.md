# Google authentication and profile specification

## Purpose

Allow a traveler to authenticate with Google through Supabase, then collect
and save their name and phone number before entering the app.

## Scope and decisions

- Google is the only sign-up/sign-in method. Supabase creates an account on
  first Google sign-in and signs in existing users.
- After authentication, users without a complete profile must provide their
  name and phone number before reaching Home.
- Prefill the name from Google when available and let the user edit it.
- Normalize and validate the phone as an international number with a country
  calling code; do not prefill a country prefix.
- Do not send an SMS code or claim the phone number is verified.
- Save profile data in `public.profiles`, linked to the authenticated user.
- Returning users with a saved profile go directly to Home.
- Sign-out clears the Supabase session and returns to onboarding.

## Data and security

- The app must never contain a Google client secret or Supabase service-role
  key.
- Enable RLS on `public.profiles`; users may only read, insert, and update the
  row whose ID matches their Supabase auth user ID.
- Treat the collected phone number as unverified.
- Configure Google OAuth credentials and app redirect URLs in the Google and
  Supabase dashboards before testing real sign-in.

## Acceptance criteria

- Only the Google authentication button is shown on the entry screen.
- First-time Google users complete a required name and phone form; the name is
  prefilled when Google provides it.
- The phone input has no prefilled country code and requires a valid
  international number.
- No SMS code is sent; the phone is clearly labeled as unverified.
- A completed profile opens Home, and a returning complete profile opens Home
  without repeating setup.
- Sign-out clears the Supabase session and returns to onboarding.
