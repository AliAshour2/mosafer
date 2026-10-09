# Temporary phone-only demo entry

The current auth screen is a temporary UI flow. It accepts one international
phone number and creates an in-memory demo session. It does not call Supabase
Auth, send an SMS/email, verify phone ownership, or create a persistent
account. Restarting the app clears the demo session.

The user must enter the full international phone number themselves. The field
does not prefill a country calling code. The current format validation expects
the number to include its country calling code.

Do not use this demo session to authorize protected backend operations. Before
production use, replace `DemoAuthRepository` with a real authentication flow
that verifies control of the phone number and applies server-side authorization.
