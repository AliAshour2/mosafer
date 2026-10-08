---
name: Mosafer feature development
description: Architecture, design, security, and validation conventions for Flutter feature work.
applyTo: "lib/**/*.dart,test/**/*.dart"
---

# Feature Development Rules

Every feature in this Flutter application must follow the repository's established architecture, Flutter best practices, design system, and engineering conventions. Do not introduce a different architecture, state-management approach, UI system, or coding pattern for an individual feature.

## Project architecture

Use the project's established stack:

- Feature-first organization and Clean Architecture
- Riverpod for state management and dependency injection
- GoRouter for navigation
- Repository Pattern for external data access
- Freezed and `json_serializable` where immutable or serialized models benefit from them
- Supabase/PostgreSQL as backend infrastructure

Keep dependencies pointing inward: presentation may depend on application/domain abstractions; application coordinates domain behavior; data implements domain repository interfaces. Domain must not depend on Flutter UI, Supabase, or other infrastructure. Keep Supabase queries in data sources/repositories or shared infrastructure, not in widgets.

Use this feature structure as needed; do not create empty folders just to match it:

```text
lib/features/<feature_name>/
  data/
    datasources/
    models/
    repositories/
  domain/
    entities/
    repositories/
    usecases/
  presentation/
    pages/
    widgets/
    providers/
    controllers/
```

Shared infrastructure belongs in `lib/core/`; global design-system components and tokens belong in their established shared location. Before adding anything, inspect the repository's existing architecture and reuse its conventions.

## Before implementing

Inspect the relevant project architecture, similar features, providers/controllers, repositories, shared components, theme and design tokens, navigation, and tests. Check for a feature specification under `specs/<feature-name>/` and follow it. Do not duplicate existing functionality or silently change requirements.

For complex features without a specification, define the purpose, flows, requirements, business rules, states, permissions, data, navigation, UI, and acceptance criteria before implementation. Identify the files and layers to change, then implement and validate the agreed scope. Ask for clarification when a requirement or specification conflict materially affects behavior.

## State and business logic

Riverpod is the only approved state-management and dependency-injection solution. Do not introduce Provider, Bloc/Cubit, GetX, MobX, Redux, GetIt, or a custom global state system.

Choose the simplest suitable Riverpod provider (`Provider`, `FutureProvider`, `StreamProvider`, `Notifier`, or `AsyncNotifier`). Do not add controllers, notifiers, use cases, or other layers without a concrete responsibility.

Keep widgets focused on rendering, receiving input, invoking feature actions, and displaying state. Put business rules in the appropriate application/domain layer. Asynchronous UI must handle loading, success, error, and empty states where applicable. Prefer Riverpod async state over collections of unmanaged loading/error booleans.

## Data access and Supabase

All external data access must go through repository abstractions. Repository interfaces belong in Domain; implementations and infrastructure-specific mapping belong in Data. Do not access Supabase from widgets or expose Supabase response objects to presentation. Convert external records to typed application/domain models.

Respect PostgreSQL constraints, Supabase Row Level Security (RLS), authentication, authorization, and server-side validation. Client-side checks are not authorization. Booking, seat locking, payments, inventory changes, and other concurrency-sensitive operations must not rely solely on client-side validation.

Never place service-role keys, secrets, passwords, or private credentials in the Flutter application. Use the repository's approved configuration approach and public client keys only.

## Design system and accessibility

The single source of truth is documented in `docs/design/design-system.md` and implemented in `lib/core/design_system/`. Read the relevant token and component APIs before building or changing feature UI.

Before creating styling or a component:

1. Search for an existing component.
2. Search for an existing token.
3. Reuse it if it meets the behavior and accessibility need.
4. If it does not, explain why, add the smallest reusable token/component to the Design System, document it, and then consume it from the feature.

Do not introduce feature-local arbitrary colors (`Color(0x...)`), font sizes/weights, spacing, border radii, shadows, button/input/card styles, or status palettes. Do not create feature-specific versions of existing global components. Consume the active `ThemeData`, `ColorScheme`, `AppSemanticColors`, `AppTypography`, `AppSpacing`, `AppRadius`, `AppSizes`, and shared components.

Keep the product experience coherent and prioritize transportation-use-case qualities: trust, clarity, speed, safety, predictability, and ease of use. Follow the design direction and density/motion principles in `docs/design/design-system.md`; the Design System is the implementation source of truth. Avoid decorative UI, excessive gradients, glassmorphism, shadows, animations, icons, or rounded containers without a clear purpose.

Consider small and large phones, tablets, landscape where applicable, and text scaling. Prefer flexible constraints and the repository's existing responsive approach over fixed screen dimensions. Support accessibility with readable text, sufficient contrast, meaningful semantics and labels, appropriate touch targets, and usable focus behavior. Do not convey important information by color alone.

Data-driven screens should provide appropriate loading, error, and empty states, reusing shared state components when available. Do not expose raw technical errors to users; transform errors into useful messages and preserve appropriate logging/diagnostics rather than silently swallowing failures.

Support both English LTR and Arabic RTL. Let localization establish text direction; use directional padding/alignment and direction-aware icons. Do not hardcode left/right layout assumptions. Consider contrast, text scaling, touch targets, screen-reader semantics, keyboard/focus use, and responsive constraints. Do not communicate state by color alone.

## Navigation and models

Use GoRouter and the repository's centralized route conventions. Do not introduce ad hoc navigation patterns or use `Navigator.push` when GoRouter is appropriate. Keep navigation concerns separate from low-level UI where practical. Structure routes so authentication and role guards can be added without implementing them prematurely.

Separate domain entities from database/API representations when their responsibilities differ. Use Freezed for immutable data, unions, or serialization where useful; use `json_serializable` for JSON mapping where appropriate. Never manually edit generated files.

## Code quality and performance

Follow Dart and Flutter conventions. Keep code readable, strongly typed, null-safe, cohesive, and testable. Prefer composition, `const` where applicable, selective Riverpod watching, and efficient/lazy lists. Avoid giant widgets/controllers, deeply nested logic, duplication, magic values, unnecessary abstractions, and premature optimization. Measure before adding complex performance mechanisms.

## Testing and validation

Test meaningful behavior, not just line coverage. Add appropriate unit tests for business rules and transformations, provider/controller tests for async states and transitions, widget tests for important UI behavior, and integration tests for critical end-to-end flows when appropriate.

For feature changes, run the relevant validation commands:

```sh
dart format .
flutter analyze
flutter test
```

When generated code changes, regenerate it:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Fix relevant failures before considering the feature complete. Do not modify generated output by hand.

## Git and review discipline

Keep each feature independently reviewable and avoid mixing unrelated changes. Follow the repository's branch conventions; the recommended flow is `main` → `dev` → `feature/<feature-name>`.

Before finishing, review architecture boundaries, state handling, business logic, repository isolation, security, performance, error handling, naming, duplication, test coverage, formatting, analyzer output, test results, and generated-code freshness. Ensure no unrelated changes were introduced.

## Source of truth

Before generating feature code, inspect the repository. Project conventions and specifications in `.github/instructions/`, `docs/`, `specs/`, `lib/core/`, `lib/design_system/`, and `lib/features/` take precedence over generic recommendations unless they violate a security or correctness requirement.
