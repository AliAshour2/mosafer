# Mosafer Design System

The Mosafer Design System is the shared source of truth for product UI. It uses Uber-minimal black, white, and gray foundations with one transit-green accent, prioritizing readable information and accessible controls.

## Where the system lives

Implementation is under `lib/core/design_system/`:

```text
app_design_system.dart
components/
  buttons/
  cards/
  feedback/
  inputs/
  transportation/
theme/
  light_theme.dart
  dark_theme.dart
tokens/
  app_colors.dart
  app_radius.dart
  app_shadows.dart
  app_sizes.dart
  app_spacing.dart
  app_typography.dart
```

Import `package:mosafer/core/design_system/app_design_system.dart` to consume shared tokens and components. `lib/theme/app_theme.dart` is the app-facing theme entry point. The root `MaterialApp` supplies the light and dark themes and supports English and Arabic locales.

Before adding a style or component, search this system and the existing feature code. Add a token or component here when a real product need cannot be served by an existing one, then document its purpose and use it from features.

## Design principles

- **Clarity first:** prioritize route, time, price, availability, pickup/drop-off, and booking status when those features are implemented.
- **Neutral foundation:** black, white, and gray carry most of the hierarchy; transit green marks important actions and selected states.
- **Consistent and calm:** use shared spacing and component shapes. Keep shadows, motion, decoration, and competing accents restrained.
- **Mobile first, responsive by constraints:** let content adapt to available space and text scaling. Do not size layouts from a presumed device width or height.
- **Meaning beyond color:** pair status color with a readable label and, where useful, an icon.

## Typography and fonts

Bundled fonts are registered in `pubspec.yaml` so text works offline:

- Latin family: **Inter**
- Arabic family: **IBM Plex Sans Arabic**
- Code/QR family: **JetBrains Mono**
- Supported weights: Regular 400, Medium 500, SemiBold 600, Bold 700

`AppTypography` sets Inter as the main family and IBM Plex Sans Arabic as the glyph fallback. Mixed Arabic/Latin text can therefore use Flutter's font fallback without screens changing families manually. The `code` style uses JetBrains Mono for codes and QR content. Use `Theme.of(context).textTheme` rather than local font sizes or weights.

The shared type scale maps `headlineLarge` to 32px/700 display, `titleLarge` to 20px/700, `bodyLarge` to 16px/500, `bodyMedium` to 14px/400, `bodySmall` to 12px/400, and `labelSmall` to 10px/600 eyebrow/tag text.

Do not force `TextDirection.ltr` or `TextDirection.rtl` for an entire screen. Flutter's localization delegates derive direction from the active locale. Use directional alignment and padding (`AlignmentDirectional`, `EdgeInsetsDirectional`) for layout intent. Set a field's text direction only when the field's content has a product-defined direction, such as a phone number or identifier. Font files and their SIL Open Font License texts are included under `assets/fonts/`.

## Color

Use `Theme.of(context).colorScheme` for component-facing colors so widgets respond to light and dark themes:

| Purpose | Light token | Value |
| --- | --- | --- |
| Ink | `AppColors.ink` | `#000000` |
| Surface | `AppColors.surface` | `#FFFFFF` |
| Muted surface | `AppColors.surfaceMuted` | `#F6F6F6` |
| Brand | `AppColors.brand` | `#009A62` |
| Brand dark | `AppColors.brandDark` | `#007A4D` |
| Brand darker | `AppColors.brandDarker` | `#00603D` |
| Brand light | `AppColors.brandLight` | `#E4F5EE` |
| Brand hover | `AppColors.brandHover` | `#008A57` |
| Brand pressed | `AppColors.brandPressed` | `#007A4D` |
| Gray 50 | `AppColors.gray50` | `#F6F6F6` |
| Gray 100 | `AppColors.gray100` | `#EEEEEE` |
| Gray 200 | `AppColors.gray200` | `#E2E2E2` |
| Gray 300 | `AppColors.gray300` | `#CBCBCB` |
| Gray 400 | `AppColors.gray400` | `#AFAFAF` |
| Gray 500 | `AppColors.gray500` | `#757575` |
| Gray 600 | `AppColors.gray600` | `#545454` |
| Gray 700 | `AppColors.gray700` | `#333333` |
| Gray 800 | `AppColors.gray800` | `#1F1F1F` |
| Gray 900 | `AppColors.gray900` | `#000000` |
| Background | `AppColors.background` | `#F6F6F6` |
| Primary text | `AppColors.textPrimary` | `#000000` |
| Secondary text | `AppColors.textSecondary` | `#545454` |
| Tertiary text | `AppColors.textTertiary` | `#757575` |
| Border | `AppColors.border` | `#E2E2E2` |
| Divider | `AppColors.divider` | `#EEEEEE` |
| Success | `AppColors.success` | `#059669` |
| Warning | `AppColors.warning` | `#F59E0B` |
| Error | `AppColors.error` | `#DC2626` |
| Information | `AppColors.info` | `#2563EB` |

The full neutral ramp is available as `AppColors.gray50` through `gray900`. Semantic foreground and container pairs are exposed by `AppSemanticColors`, a `ThemeExtension`. Read it from the theme for status, validation, and feedback surfaces. Dark theme values are defined centrally as neutral dark tokens; avoid using a light-only `AppColors` text or surface color directly in widgets.

Light-theme semantic foregrounds use darker companion values where needed to keep text readable on their corresponding light container colors. The base `AppColors.success`, `warning`, `error`, and `info` values are palette accents, not guaranteed foreground-on-container pairs. Green is intentionally limited to important actions, selected states, and brand emphasis. Check foreground/background contrast when adding a semantic color combination. Never use color as the sole signal for a status or validation result.

## Spacing, radius, size, and elevation

Use `AppSpacing` for layout: `xs` 4, `sm` 8, `md` 12, `lg` 16, `xl` 24, `xxl` 32, `xxxl` 40, and `huge` 48 logical pixels.

Use `AppRadius` for shape: `none` 0, `small` 6, `medium` 10, `large` 14, `xlarge` 20, and `pill` 999. Prefer the shape constants for common radii.

`AppSizes` owns shared control heights, tap-target minimum, icon sizes, focus/border widths, sheet-handle dimensions, and feedback content max width. Components should use these rather than inventing their own control dimensions.

Use `AppShadows.none`, `small`, `medium`, and `large` only when elevation communicates hierarchy or interaction. Prefer surfaces, borders, spacing, and typography to decoration. Do not stack shadows.

## Theme and components

`buildLightTheme()` and `buildDarkTheme()` configure Material `ColorScheme`, `TextTheme`, input and button themes, cards, dialogs, bottom sheets, navigation bars, dividers, progress, snack bars, and icon defaults. In app UI, use `Theme.of(context)` and shared components; do not style every widget individually.

Available components:

- **Actions:** `AppButton` (`primary`, `secondary`, `outlined`, `text`, `danger`) supports disabled and loading states; `AppIconButton` requires a semantic label and meets the minimum target size.
- **Inputs:** `AppTextField`, `AppSearchField`, and typed `AppDropdown<T>`. Form fields support validation and their visual states come from the theme. Add specialized phone/date/time controls only when a real screen requirement defines the interaction and accessibility needs.
- **Surfaces:** `AppCard` supports interactive, selected, and disabled presentations. Use it for related content, not as a default wrapper for every section.
- **Feedback:** `AppLoadingIndicator`, `AppSkeleton`, `AppEmptyState`, `AppErrorState`, and `AppInlineError`. Show a useful user-facing message; do not render raw exception details. Use retry only when retrying is a valid action.
- **Bottom sheets:** use `showAppBottomSheet` and `AppBottomSheetSurface` to apply shared theme geometry and spacing. Keep their content responsive and scrollable when it may exceed the available height.
- **Mobility primitives:** `AppRouteDisplay`, `AppPriceDisplay`, and `AppStatusBadge` provide shared route, price, and semantic status treatments. Higher-level components such as trip or vehicle cards should be added in response to real feature needs and composed from these primitives.

Buttons and controls inherit interaction colors from the active theme. Keep native focus, keyboard, and accessibility behavior intact. Give icon-only actions a concise accessible label. Use `Semantics` when a visual grouping needs one meaningful announcement.

## Statuses

`AppStatusBadge` accepts a localized label, an `AppStatusTone`, and an optional icon. Select the tone according to the meaning, not the wording:

- `success`: confirmed, completed, available
- `warning`: pending, approaching attention
- `error`: cancelled, unavailable due to an error
- `info`: in progress or informational
- `neutral`: inactive or not yet categorized

Product-specific status transitions and authorization belong in their feature/domain layers, not in the Design System. Always show the status text; the tone and icon are supplementary.

## RTL, localization, and responsive behavior

The root app supports `en` and `ar` through Flutter's material, widgets, and Cupertino localization delegates. RTL layout follows the selected locale. Prefer `start`/`end` concepts and directional insets. For directional icons, set `matchTextDirection: true` or choose the appropriate semantic icon; do not mirror non-directional symbols.

Use `Flexible`, `Expanded`, `Wrap`, constraints, and scrollable content where appropriate. Respect system text scaling and avoid fixed screen dimensions. Reusable feedback surfaces cap their readable content width using `AppSizes`; feature layouts should otherwise respond to parent constraints.

## Accessibility and motion

- Preserve the 48 logical-pixel minimum touch target for interactive controls.
- Keep text readable and contrast sufficient in both themes.
- Provide semantic labels for icon-only actions and meaningful feedback.
- Use live regions for loading and error updates where appropriate.
- Do not communicate selection, availability, or errors by color alone.
- Keep transitions short and purposeful; avoid decorative or continuous motion.
- Respect platform accessibility settings and text scaling.

## Examples

```dart
import 'package:mosafer/core/design_system/app_design_system.dart';

AppButton(
  label: 'Continue',
  variant: AppButtonVariant.primary,
  onPressed: onContinue,
  expand: true,
)
```

```dart
final semanticColors = Theme.of(context).extension<AppSemanticColors>()!;

AppStatusBadge(
  label: localizedStatus,
  tone: AppStatusTone.success,
  icon: Icons.check_circle_outline,
)
```

```dart
AppRouteDisplay(
  origin: pickupName,
  destination: dropoffName,
)
```

## Do / Don't

**Do**

- Look up an existing token/component before styling a feature.
- Use the current `ColorScheme` and `AppSemanticColors` for light/dark behavior.
- Use theme typography and `AppSpacing`/`AppRadius`/`AppSizes`.
- Compose new feature UI from shared components and keep feature-specific logic in its feature.
- Introduce and document a new token/component when a real reusable requirement is not covered.

**Don't**

- Add feature-local `Color(0x...)`, arbitrary font sizes/weights, spacing, radii, or shadows.
- duplicate global buttons, cards, inputs, feedback, or status presentations in a feature.
- expose backend exceptions directly in UI.
- assume left-to-right layout, a fixed device size, or a specific theme brightness.
- add decorative gradients, heavy elevation, motion, or icons without a usability purpose.

## Validation

After changing the Design System, run:

```sh
dart format .
flutter analyze
flutter test
```

Add or update tests for token/theme configuration, accessibility-relevant component states, and behavioral variants. Review both light and dark themes and at least one RTL locale during UI review.
