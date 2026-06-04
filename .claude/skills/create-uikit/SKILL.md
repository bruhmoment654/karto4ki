---
name: create-uikit
description: Create a new reusable component in module_ui (modules/ui/lib/uikit) with proper theming, asset access, naming, exports, golden test, and Figma mapping update. Use when adding a new design system component shared across features.
---

# Create UIKit Component

Add a new reusable widget to `modules/ui/lib/uikit/` following the design system conventions.

For theme, asset, typography, l10n, and Figma mapping rules, see [uikit-usage](mdc:.cursor/rules/uikit-usage.mdc).
For widget structure and constructor rules, see [widget](mdc:.cursor/rules/widget.mdc).
For decomposition (atom/molecule/organism), see [ui-components-decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc).

## Difference from /mason-gen widget

| Aspect       | `/mason-gen` widget                                     | `/create-uikit`                                       |
|--------------|---------------------------------------------------------|-------------------------------------------------------|
| Location     | `apps/main/lib/feature/<f>/presentation/widgets/`       | `modules/ui/lib/uikit/`                               |
| Naming       | `<DomainName>` (`ProfileInfoCard`)                      | `App<Name>` (`AppPromoCodeCard`)                      |
| Reusability  | feature-local                                           | cross-feature, design-system                          |
| Theme tokens | optional                                                | mandatory `context.appColorScheme` / `appTypography`  |
| Test path    | `test/feature/<f>/presentation/widgets/`                | `test/widgets/<category>/`                            |
| Figma map    | not required                                            | must update `uikit-usage.mdc` table                   |

If the component is feature-specific and won't be reused, use `/mason-gen` widget instead.

## Choose the Folder

UIKit uses a mixed atomic-design + functional layout. Pick by what's already there:

| Component kind                                           | Folder                          | Examples                                          |
|----------------------------------------------------------|---------------------------------|---------------------------------------------------|
| Buttons                                                  | `uikit/buttons/`                | `app_primary_button.dart`, `app_id_button.dart`   |
| Cards / tiles                                            | `uikit/cards/`                  | `app_promo_code_card.dart`, `app_order_history_card.dart` |
| Atoms (smallest indivisible)                             | `uikit/atom/<kind>/`            | `atom/badge/`, `atom/control/`, `atom/text/`      |
| Molecules (atom compositions, no business logic)         | `uikit/molecule/<kind>/`        | `molecule/error_stub/`, `molecule/settings/`      |
| Organisms (complex, multi-part components)               | `uikit/organism/<kind>/`        | `organism/product_card/` (with private `src/`)    |
| App bar / nav / scaffold                                 | `uikit/appbar/`, `uikit/scaffold/`, `uikit/bottom_bar/` | —                                |
| Bottom sheets / dialogs                                  | `uikit/bottom_sheet/`           | `app_bottom_sheet.dart`                           |
| Form fields                                              | `uikit/fields/`                 | `app_text_field.dart`                             |
| Icons (specialized icon containers)                      | `uikit/icons/`                  | `app_svg.dart`, `app_icon_badge.dart`             |
| Loaders / shimmer                                        | `uikit/loaders/`                | `app_shimmer.dart`                                |
| Switches / toggles                                       | `uikit/switch/`                 | `app_switch.dart`                                 |

Don't invent a new top-level folder unless none of the above fits — ask the user first.

For complex organisms with private subwidgets, put them under `organism/<name>/src/<part>.dart` per [ui-components-decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc).

## Constructor Rules

Per [widget](mdc:.cursor/rules/widget.mdc):

- Class name: `App<Name>` (e.g., `AppOrderCard`, `AppBonusBadge`).
- Extends `StatelessWidget`, or `StatefulWidget` if it owns animation/controllers.
- Constructor accepts only:
  - Dart SDK types (`String`, `int`, `bool`, `double`, `Duration`, `Color`).
  - Flutter SDK types (`VoidCallback`, `Widget`, `EdgeInsets`, `BoxConstraints`, `TextEditingController`).
  - UIKit-local enums (size/variant/state) defined next to the component.
- **Forbidden** in constructor: `ViewModel`, `Bloc`, `Repository`, freezed sealed states, raw DTOs, **domain `Entity` types**.
- **No domain entities in UIKit.** UIKit is decoupled from the domain layer — pass primitives (`title`, `price`, `imageUrl`, `isAvailable`) instead of `ProductEntity`. If the component needs so many fields that an entity feels necessary, that's a signal it's not a design-system primitive — put it in the consuming feature via `/mason-gen` widget instead.
- Callbacks: `onXxxPressed` for taps, `onXxxChanged` for value changes. `onTap` / `onCancelTap` are acceptable when unambiguous.
- Always `super.key`. Use `const` constructor when all fields are const-compatible.

## State Management

UIKit components are stateless w.r.t. business logic — see [widget](mdc:.cursor/rules/widget.mdc):

- No `BlocBuilder` / `BlocProvider` / `BlocListener` / `StateStreamableBuilder` / `BlocSelector` / `BlocConsumer`.
- Local UI state is fine: `setState`, `AnimationController`, `TextEditingController`, focus nodes, scroll controllers.
- Stateful behavior must be expressible via constructor params + callbacks.

## Theme & Assets

Inside `build`:

```dart
final colorScheme = context.appColorScheme;
final typography = context.appTypography;
```

- Never `Theme.of(context).extension<...>()`, never `AppColorScheme.of(context)`.
- Use `Assets.icons.<x>` / `Assets.images.<x>` for assets — never raw paths.
- Wrap SVGs with `AppSvg` (binary precompiled). **Never** `SvgPicture` directly. See [uikit-usage](mdc:.cursor/rules/uikit-usage.mdc).
- Wrap raster images with `AppImage`. Never raw `Image`/`Image.asset` for user-facing images.

## File Skeleton

```dart
import 'package:flutter/material.dart';
import 'package:module_ui/theme/app_color_scheme.dart';
import 'package:module_ui/theme/app_typography.dart';

class AppExampleCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onPressed;

  const AppExampleCard({
    required this.title,
    this.subtitle,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.appColorScheme;
    final typography = context.appTypography;
    final subtitle = this.subtitle;

    return // ...
  }
}
```

> Use local-variable shadowing for nullable fields (`final subtitle = this.subtitle`) per [dart-code-style](mdc:.cursor/rules/dart-code-style.mdc) — gives flow-typed non-null inside the block.

## Adding a New Asset (SVG / Image)

1. Drop the file in `modules/ui/assets/icons/<name>.svg` or `modules/ui/assets/images/<name>.png`.
2. Run `make gen-ui` — regenerates `Assets.icons.<name>` / `Assets.images.<name>` and recompiles SVGs to vector binary via `vector_graphics_compiler`.
3. Reference via the generated constant only.

## Adding a New Color or Typography Entry

If the design needs a token that doesn't exist yet:

1. Add a field to `AppColorScheme` (`modules/ui/lib/theme/app_color_scheme.dart`) or `AppTypography` (`app_typography.dart`).
2. Provide values for **every** declared variant — `theme_tailor` enforces this at codegen.
3. Run `make gen-ui` (regenerates the part file).
4. Use via `colorScheme.<name>` / `typography.<name>`.

A one-off `Color(0xFF...)` literal in a UIKit component is the bug that breaks the design system. Promote it to a token first.

## Adding User-Facing Copy

UIKit-owned strings live under `@segmentUiKit` in `modules/ui/lib/l10n/app_ru.arb`. Use [/localize](mdc:.claude/skills/localize/SKILL.md) to add them. Naming: prefix with `uikit<ComponentName>` (e.g., `uikitBonusCardLoadingTitle`).

If the literal is contextual to a feature (not the component itself) — keep a `String` constructor param and let the call site provide `context.l10n.<featureKey>`. UIKit owns only copy that belongs to the design system itself (placeholder texts, fixed labels).

## Golden Test (Mandatory)

Every UIKit component ships with a golden. Use [/create-golden-test](mdc:.claude/skills/create-golden-test/SKILL.md), **Widget Golden Test** branch.

Test path: `test/widgets/<category>/<file>_golden_test.dart`
(e.g., `test/widgets/cards/app_promo_code_card_golden_test.dart`)

Cover at minimum:
- Default state with required props only.
- Each visual variant the constructor enables (size enum, theme variant, with/without optional fields).
- Edge cases: long text (ellipsis), missing optional callback (disabled state), nullable fields both set and null.

## Figma → UIKit Mapping

Per [uikit-usage](mdc:.cursor/rules/uikit-usage.mdc) §7: after creating a component, add a row to the Figma → UIKit table in `uikit-usage.mdc`. Identify the corresponding Figma component name (ask the user if unclear) and place it in the right section (Buttons / Cards & Tiles / Controls / Badges / Fields / Other).

If the component has no Figma source (utility, internal helper) — skip this step and call it out in the MR description.

## Step-by-Step Process

1. **Confirm reusability** — feature-specific? Use `/mason-gen` widget instead.
2. **Pick the folder** (table above). Ask the user when ambiguous between `atom`/`molecule`/`organism` and a flat folder.
3. **Add missing tokens first** — colors, typography, assets needed by the design. Run `make gen-ui` so the generated symbols exist before you reference them.
4. **Write the component** — `App<Name>` class, constructor per rules, theme via `context.appColorScheme` / `context.appTypography`.
5. **Add l10n keys** for any internal UIKit copy via `/localize` (segment `@segmentUiKit`).
6. **Run codegen** — `make gen-ui` (covers theme_tailor + flutter_gen + l10n).
7. **Write the golden test** via `/create-golden-test` (Widget path, in `test/widgets/<category>/`).
8. **Update Figma mapping** in `uikit-usage.mdc`.
9. **Run /feedback-loop** — static analysis must be green.

## Common Pitfalls

- **Wrong folder** — don't create a new top-level uikit subdir; reuse what's there.
- **Hardcoded color or font family** — even one literal breaks the design system. Promote to a token first.
- **Constructor takes a ViewModel/Bloc** — banned in widgets. Components are pure render-from-props.
- **Constructor takes a domain `Entity`** — UIKit must stay domain-agnostic. Pass primitives; if the prop list explodes, the component belongs in a feature, not in UIKit.
- **Skipping the golden test** — UIKit changes ripple to every feature; goldens are the regression gate.
- **Forgetting the Figma mapping update** — leaves designers searching for a component that exists but is undocumented.
- **One-off l10n key in a feature segment** — UIKit copy belongs in `@segmentUiKit`, not in the consuming feature's segment.
- **Naming without `App` prefix** — every uikit class is `App<Name>` for grep-ability and to mark "this is a design-system component".
- **Raw `Icon` / `Image`** — banned project-wide. Use `AppSvg` for icons and `AppImage` for raster.
