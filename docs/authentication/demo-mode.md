# Retired phone-only demo entry

The temporary phone-only demo login has been removed. The app now uses
Supabase Google authentication and requires a saved name and phone number
before Home. See [Google authentication and profile setup](../features/google-auth.md)
for the current flow, profile RLS policy, and provider configuration steps.

Phone numbers are stored as unverified profile data; no SMS code is sent.
