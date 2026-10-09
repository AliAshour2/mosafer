# Phone-only demo entry specification

## Purpose

Allow a traveler to enter the app using only a phone number while real
authentication and phone verification are deferred.

## Scope and decisions

- The first-run welcome carousel introduces the travel experience.
- The entry screen has one phone-number field and a continue action.
- The user enters their own number; no country code or phone prefix is
  pre-populated.
- The phone number is normalized and validated as an international number with
  a country calling code.
- Submitting creates only an in-memory demo session. It does not call Supabase
  Auth, send a verification code, or establish a verified identity.
- The demo session is lost when the app process restarts.
- Sign-out clears the in-memory demo session.

## Data and security

- Demo phone data is held in process memory only.
- Do not treat demo sessions or entered phone numbers as verified identity.
- Do not use demo identity to authorize protected backend operations.
- Real Supabase authentication and access-control checks must be implemented
  before enabling protected production data.

## Acceptance criteria

- The sign-in/sign-up email and password methods are removed.
- The entry screen contains only one phone-number input.
- No country code is prefilled.
- No code is sent and no verification step is shown.
- A valid international number opens the demo app; invalid numbers show a
  localized validation error.
- The UI clearly states that demo numbers are not verified and do not create a
  secure account.
- Sign-out clears the local session and returns to onboarding.
