---
name: create-golden-test
description: Create Alchemist golden tests for screens, widgets, and UIKit components. Use when adding visual regression tests for a View, ViewModel-driven screen, reusable widget, or UIKit element.
---

# Create Golden Test

Add visual regression tests using **Alchemist** + **mocktail**. Tests live at the workspace root under `/test/`, mirroring the source path.

The project uses goldens *only* — there are no unit/widget logic tests in this repo. Every visual surface (screen, widget, UIKit card) is covered by a `*_golden_test.dart`.

## Choose Your Path

| Subject under test                     | Wrapper                  | Mocks needed                 | Section |
|---------------------------------------|--------------------------|------------------------------|---------|
| Reusable widget / UIKit component      | `buildWidgetWrapper`     | none — pass real props       | [Widget Golden Test](#widget-golden-test) |
| Full screen driven by a ViewModel      | `buildScreenWrapper`     | `MockXxxViewModel` + `StubBloc` | [Screen Golden Test](#screen-golden-test) |
| Widget that depends on a domain entity | `buildWidgetWrapper`     | construct the entity inline  | [Widget Golden Test](#widget-golden-test) |

## File Locations

Tests mirror the lib path of the subject under `/test/`:

| Subject                                                                            | Test path                                                                                |
|------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| `apps/main/lib/feature/profile/presentation/profile_view.dart`                     | `test/feature/profile/presentation/profile_view_golden_test.dart`                        |
| `apps/main/lib/feature/profile/presentation/widgets/profile_info_card.dart`        | `test/feature/profile/presentation/widgets/profile_info_card_golden_test.dart`           |
| `modules/ui/lib/uikit/cards/app_up_coins_card.dart`                                | `test/widgets/cards/app_up_coins_card_golden_test.dart`                                  |

Goldens are written next to each test in `goldens/macos/` (local) and `goldens/ci/` (CI). The runner picks the directory automatically — never commit goldens to a different path.

## Required File Header

Every golden test starts with this directive line — Alchemist + mocktail trip these lints in normal use:

```dart
// ignore_for_file: avoid-non-ascii-symbols, unawaited_futures, prefer-test-matchers, avoid-async-call-in-sync-function
```

## Shared Infrastructure

All tests rely on `test/helpers/golden_test_helpers.dart`. Read it before writing a new test — it exports:

- `TestHelpers.buildScreenWrapper(child, {size})` — full-screen wrapper (sized box, `Material(transparency)`, theme, l10n, asset bundle).
- `TestHelpers.buildWidgetWrapper(child)` — minimal wrapper for components (`Material(transparency)`, theme, l10n, no fixed size).
- `TestHelpers.createMockXxxViewModel(...)` — typed mock factories for ViewModels.
- `StubBloc<S>` — `Cubit`-based stub that emits a single fixed state. Use it for every BLoC field on a mocked ViewModel.
- `TestDevices` — canonical device sizes (`pixel4a`, `iPhone16Plus`, `iPhoneSE`, etc.).

Both wrappers wrap their child in `Material(type: MaterialType.transparency, ...)` — see [Material wrapping](#material-wrapping-yellow-underline-debug-artifact) below for why this matters.

Global config is in `test/flutter_test_config.dart` (fonts, theme, sqflite/path_provider mocks). It is auto-loaded by the runner — do not import it.

### Material wrapping (yellow-underline debug artifact)

Flutter draws a **yellow double-underline** under any `Text` whose ancestor chain has no `Material` widget — it's a debug indicator that "default text styles are not applied". In production this never happens because every text lives inside `Material`/`Scaffold`/`CupertinoSheetRoute`. In tests, plain widgets and bottom-sheet-style scaffolds (e.g., `AppBottomSheetScaffold`, which is just `ColoredBox` + `Column`) have no Material — so the runner captures yellow stripes that are pure noise and can mask real `decoration:` regressions on text.

Both wrappers in `golden_test_helpers.dart` already include `Material(type: MaterialType.transparency)`. **Never call `goldenTest` with a child that is not wrapped via these helpers.** If you build a custom wrapper for a one-off test, add `Material(transparency)` yourself.

**Warn the user proactively** when adding a screen-level test for a widget that is **not** a `Scaffold` (bottom sheets, dialogs, raw `Stack`-based layouts) — confirm that the production parent provides `Material` and that the wrapper preserves that contract. The yellow underlines are a strong signal something in the wrapper chain is wrong.

---

## Widget Golden Test

Use this for any subject that takes plain props (entity, callbacks, primitives) and renders without a ViewModel.

```dart
// ignore_for_file: avoid-non-ascii-symbols, unawaited_futures, prefer-test-matchers, avoid-async-call-in-sync-function

import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:upsushi_client/feature/profile/presentation/widgets/profile_info_card.dart';
import 'package:upsushi_client/feature/user/domain/entity/gender_type.dart';
import 'package:upsushi_client/feature/user/domain/entity/user_profile_entity.dart';

import '../../../../helpers/golden_test_helpers.dart';

void main() {
  goldenTest(
    'ProfileInfoCard — states',
    fileName: 'profile_info_card',
    constraints: const BoxConstraints(maxWidth: 393),
    pumpWidget: (tester, widget) =>
        mockNetworkImagesFor(() => tester.pumpWidget(widget)),
    builder: () {
      return GoldenTestGroup(
        columns: 1,
        children: [
          GoldenTestScenario(
            name: 'male',
            child: TestHelpers.buildWidgetWrapper(
              ProfileInfoCard(user: _TestData.male, onEditPressed: () {}),
            ),
          ),
          GoldenTestScenario(
            name: 'female',
            child: TestHelpers.buildWidgetWrapper(
              ProfileInfoCard(user: _TestData.female, onEditPressed: () {}),
            ),
          ),
        ],
      );
    },
  );
}

abstract final class _TestData {
  static const male = UserProfileEntity(
    id: '1',
    name: 'Александр Иванов',
    phone: '+7 900 123 4567',
    gender: GenderType.male,
  );

  static const female = UserProfileEntity(
    id: '2',
    name: 'Мария Петрова',
    phone: '+7 912 345 6789',
    gender: GenderType.female,
  );
}
```

> Verify the entity's current constructor before copy-pasting fixture code. Entities evolve (fields move into nested entities, become required, get renamed) and stale fixtures will fail to compile silently inside the file.

### Conventions

- **`fileName`** — snake_case, no `_golden` suffix. The runner appends the device dir (`goldens/macos/<fileName>.png`).
- **`constraints`** — for components, use `BoxConstraints(maxWidth: <design width>)`. For full screens, use `BoxConstraints.tight(TestDevices.<device>)`.
- **`columns`** — `1` for stacked scenarios, `2+` for cards rendered in a grid (see `bonus_product_card_golden_test.dart`).
- **Scenario names** — short, lowercase, English; describe the *state* not the test (`'unauthorized'`, `'with notification'`, `'long text ellipsis'`).
- **Callbacks** — pass empty closures `() {}`, not `null`. Visual rendering depends on whether the callback is non-null.
- **Fixtures** — keep them in a private `abstract final class _TestData` at the bottom of the file. Reuse across scenarios.
- **Cyrillic strings** — the file header already disables `avoid-non-ascii-symbols`; write Russian copy directly.

### Network images

Anytime the widget tree may render `Image.network` / `CachedNetworkImage`, wrap the pump with `mockNetworkImagesFor`:

```dart
pumpWidget: (tester, widget) =>
    mockNetworkImagesFor(() => tester.pumpWidget(widget)),
```

Without this, network images throw in tests and the golden becomes a grey rectangle.

### Asset images (`AppImage`, raw `Image`)

The widget tree often holds asset rasters (`AppImage(provider: AssetImage(...))`, `Image.asset`, `BoxDecoration(image: ...)`). The `dart:ui` image decoder does not run under fake-async, so without precaching the asset stays unloaded and the golden captures the placeholder.

Use `precacheImagesAndPumpNTimes(N)` from `golden_test_helpers.dart` for `pumpBeforeTest`:

```dart
pumpBeforeTest: precacheImagesAndPumpNTimes(3),
```

It walks the tree for `Image` / `FadeInImage` / `OctoImage` (the widget under `AppImage`) / `DecoratedBox`, precaches every `ImageProvider` inside `tester.runAsync`, then pumps `N` zero-duration frames. Use this whenever any `AppImage`-bearing widget is on screen.

> Do **not** use Alchemist's stock `precacheImages` directly — it ends with `tester.pumpAndSettle()`, which hangs forever on trees that own a repeating animation (see next section).

### Animations

Both wrappers (`buildScreenWrapper`, `buildWidgetWrapper`) install `TickerMode(enabled: false)` over the child. That mutes every `Ticker` in the subtree, so any `AnimationController` — including `..repeat()`-ed ones (`AppShimmer`, `Lottie`, custom `AnimatedBuilder`s) — never schedules frames. The controller is created and `.start()`/`.repeat()` runs, but `value` stays at its initial state. Frames are not pending, the runner doesn't deadlock, and the snapshot is deterministic.

What this means in practice:

1. **Repeating-animation widgets are testable without any extra setup.** Just wrap them via `buildScreenWrapper`/`buildWidgetWrapper`. The shimmer/lottie/coin renders its first frame.

2. **Never call `pumpAndSettle`** (or Alchemist's `precacheImages`/`onlyPumpAndSettle`) in golden tests. With `TickerMode` off, the scheduler usually settles, but `pumpAndSettle` is still the wrong tool — anything that schedules a non-ticker timer (network mocks, real `Future.delayed`) makes it spin. Always use `pumpNTimes(N)` or `precacheImagesAndPumpNTimes(N)`.

3. **If you need a specific animation phase rather than the initial frame** (e.g. shimmer at 50% gradient sweep, coin mid-float), expose the animated leaf with an `Animation<double>` prop and pass `AlwaysStoppedAnimation<double>(<phase>)` per scenario:

   ```dart
   GoldenTestScenario(
     name: 'phase 0.25',
     child: TestHelpers.buildWidgetWrapper(
       MyAnimatedThing(animation: const AlwaysStoppedAnimation<double>(0.25)),
     ),
   ),
   ```

   `TickerMode` doesn't help here — `AlwaysStoppedAnimation` doesn't tick at all, you control the value directly.

4. **One-shot transitions** (`forward()`, `reverse()`) are also frozen at their initial frame under `TickerMode(enabled: false)`. If your test depends on the post-animation state and the widget API allows it, swap the controller for an `AlwaysStoppedAnimation` at the final value. Otherwise accept the initial-frame snapshot.

### Local layout wrappers

When the widget needs a fixed background or a colored container that is *not* part of the widget itself (e.g., a nav bar that paints over a dark Scaffold), declare a private `_Wrapper` `StatelessWidget` at the bottom of the file — do **not** inline the layout:

```dart
class _NavBarWrapper extends StatelessWidget {
  final DeliveryStatusEntity deliveryStatus;
  const _NavBarWrapper({required this.deliveryStatus});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xFF181C20),
      child: MainNavBar(deliveryStatus: deliveryStatus, bonusBalance: 150),
    );
  }
}
```

This keeps `GoldenTestScenario` children readable and avoids deep nesting.

---

## Screen Golden Test

Use this when the subject is a `View` that consumes a `ViewModel`. Mock the ViewModel via `TestHelpers.createMockXxxViewModel(...)` and feed each BLoC field a `StubBloc<...>` with a fixed state.

```dart
// ignore_for_file: avoid-non-ascii-symbols, unawaited_futures, prefer-test-matchers, avoid-async-call-in-sync-function

import 'package:alchemist/alchemist.dart';
import 'package:flutter/rendering.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:upsushi_client/feature/app/domain/failure/unknown_failure.dart';
import 'package:upsushi_client/feature/profile/domain/bloc/profile/profile_bloc.dart';
import 'package:upsushi_client/feature/profile/presentation/profile_view.dart';

import '../../../helpers/golden_test_helpers.dart';

void main() {
  final screenConstraints = BoxConstraints.tight(TestDevices.pixel4a);
  final pumpFewTimes = pumpNTimes(3);

  goldenTest(
    'ProfileView — loading',
    fileName: 'profile_view_loading',
    constraints: screenConstraints,
    pumpBeforeTest: pumpFewTimes,
    builder: () {
      final viewModel = TestHelpers.createMockProfileViewModel(
        profileState: StubBloc<ProfileState>(const ProfileState.loading()),
      );

      return GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'loading',
            child: TestHelpers.buildScreenWrapper(
              ProfileView(viewModel: viewModel),
            ),
          ),
        ],
      );
    },
  );

  goldenTest(
    'ProfileView — error',
    fileName: 'profile_view_error',
    constraints: screenConstraints,
    pumpBeforeTest: pumpFewTimes,
    builder: () {
      final viewModel = TestHelpers.createMockProfileViewModel(
        profileState: StubBloc<ProfileState>(
          const ProfileState.error(UnknownFailure(message: 'Ошибка загрузки')),
        ),
      );
      return GoldenTestGroup(
        children: [
          GoldenTestScenario(
            name: 'error',
            child: TestHelpers.buildScreenWrapper(
              ProfileView(viewModel: viewModel),
            ),
          ),
        ],
      );
    },
  );
}
```

### Conventions

- **One state = one `goldenTest`**, even when the scenarios collapse into a single `GoldenTestGroup`. This keeps golden filenames per-state and diffs scoped.
- **`pumpBeforeTest` vs `pumpWidget`** — different parameters, often used together:
  - `pumpBeforeTest: pumpNTimes(3)` — runs *additional* pump frames after the initial pump. Required for any tree with `BlocBuilder`/`StreamBuilder`; a single frame is not enough to settle the tree. **Never use `onlyPumpAndSettle` / `pumpAndSettle` here** — it deadlocks on repeating animations. See [Animations](#animations).
  - `pumpBeforeTest: precacheImagesAndPumpNTimes(3)` — same as above, but also precaches every `AppImage`/asset image in the tree. Use this for any tree that renders raster assets.
  - `pumpWidget: (tester, widget) => ...` — overrides *how* the initial pump is done. Used to wrap the pump in `mockNetworkImagesFor`. Combine with `pumpBeforeTest` when you need both image mocking and frame settling (see `profile_view_golden_test.dart` `authorized full` test).
- **`buildScreenWrapper`** — *always* for full screens. It pins the tree to `size` via `SizedBox` so that `CustomScrollView`/`Scaffold` bodies have bounded constraints. `buildWidgetWrapper` produces an unbounded parent and screen-level widgets will overflow or render as a zero-height tree.
- **Cover at minimum**: `loading`, `error`, primary `data` state(s). Add `unauthorized`/`empty`/`minimal` variants if the View branches on them.
- **Stub every BLoC the ViewModel exposes.** The mock factory will fill in defaults for the ones you don't pass — read `golden_test_helpers.dart` to confirm what's defaulted.

For a non-`Scaffold` screen example (driven by `AppBottomSheetScaffold` with form fields, formz validation, loading button), see `test/feature/settings/presentation/settings_view_golden_test.dart`.

### Multi-device variants

When a screen has device-dependent layout (compact phone vs. large phone), iterate over a device map and emit one golden per device. Goldens get a `_<device>` suffix:

```dart
const devices = <String, Size>{
  'iphone_16_plus': TestDevices.iPhone16Plus,
  'iphone_se': TestDevices.iPhoneSE,
};

for (final entry in devices.entries) {
  final deviceName = entry.key;
  final size = entry.value;
  final constraints = BoxConstraints.tight(size);

  goldenTest(
    'MainView — data — $deviceName',
    fileName: 'main_view_data_$deviceName',
    constraints: constraints,
    pumpBeforeTest: pumpFewTimes,
    builder: () { /* ... */ },
  );
}
```

See `test/feature/main/presentation/main_view_golden_test.dart` for the full pattern.

---

## Adding a New Mocked ViewModel to `TestHelpers`

If the screen under test exposes a ViewModel that does **not** yet have a `createMockXxxViewModel` factory, add one to `test/helpers/golden_test_helpers.dart` rather than mocking inline. Keeps mock setup centralized and reusable across multiple scenario tests.

1. Add a `Mock` class:
   ```dart
   class MockOrdersViewModel extends Mock implements OrdersViewModel {}
   ```
2. Add a factory on `TestHelpers` that:
   - Takes `required StateStreamable<XxxState> xxxState` for the primary BLoC.
   - Takes optional `StateStreamable<...>?` for any secondary BLoCs, with sensible defaults.
   - Stubs every getter the View reads (`appVersion`, `scrollController`, `selectedCategoryId`, …) — `mocktail` throws on unstubbed calls.
   - Stubs every callback (`when(mock.onXxxPressed).thenReturn(null)`).
3. **Controllers** (`ScrollController`, `ListController`, `ValueNotifier<T>`) — return *fresh* instances inside the factory: `when(() => mock.scrollController).thenReturn(ScrollController())`. Don't share controller instances between mocks; Flutter attaches each to a single render object.
4. **Helper methods that take non-primitive args** (`BuildContext`, `AppLocalizations`, custom enums, `DateTime?`) — use `thenAnswer` to return realistic values based on `invocation.positionalArguments`. Register fallbacks once via `registerFallbackValue(...)` (no generic param — mocktail infers from the value), and gate with a `_xxxFallbacksRegistered` flag so registration runs only once per process. Use private `_FakeXxx extends Fake implements Xxx {}` classes for `BuildContext`/`AppLocalizations` fallbacks — `Fake` is the canonical mocktail idiom for fallback values (it's a no-op stand-in, not a stubbable spy like `Mock`).

Look at `createMockMainViewModel` (controllers + delivery/order BLoCs), `createMockProfileViewModel` (simple state-only), and `createMockSettingsViewModel` (helper methods with non-primitive args + fallback registration) in `golden_test_helpers.dart` for the full shape.

---

## Step-by-Step Process

1. **Locate** the source file. Mirror its path under `/test/` and append `_golden_test.dart`.
2. **Pick the path** — Widget vs. Screen (table at top).
3. **For screens**: confirm `TestHelpers.createMockXxxViewModel` exists; add it if not.
4. **Add the file header** (`// ignore_for_file: ...`).
5. **Write `goldenTest`s** — one per logical state.
6. **Wrap network images** with `mockNetworkImagesFor` if any may render.
7. **Run goldens** to generate the baseline. From the **workspace root** (`/Users/.../up-sushi-flutter`):
   ```bash
   fvm flutter test --update-goldens test/feature/<name>
   ```
   To regenerate everything: `make reset-goldens`. Use the targeted form when iterating on one test — full reset is slow and risks unrelated diffs.
8. **Visually inspect** the produced PNGs in `goldens/macos/` next to the test before committing — open each one and confirm there are no debug yellow underlines, no grey rectangles for images, and no clipped content.
9. **Run the suite** to confirm all goldens still pass:
   ```bash
   fvm flutter test test/feature/<name>   # targeted
   make run-tests                          # full suite via melos
   ```

## Common Pitfalls

- **Yellow double-underline under text** — Flutter debug indicator: the text has no `Material` ancestor. Never reproduce this in goldens — both wrappers already handle it; if you see underlines, a custom wrapper is missing `Material(type: MaterialType.transparency)`. See [Material wrapping](#material-wrapping-yellow-underline-debug-artifact). Always **flag this to the user** when reviewing or generating goldens for non-`Scaffold` screens.
- **Empty / grey goldens** — caused by missing fonts (rare; global config handles it), missing `mockNetworkImagesFor`, missing `precacheImagesAndPumpNTimes` (asset images won't decode under fake-async — see [Asset images](#asset-images-appimage-raw-image)), or `buildWidgetWrapper` used for a full screen. Switch to `buildScreenWrapper`.
- **Test hangs for 10 minutes then times out** — almost always `pumpAndSettle` (or Alchemist's `precacheImages`/`onlyPumpAndSettle`) running against a tree with a repeating `AnimationController`. Replace with `pumpNTimes(N)` or `precacheImagesAndPumpNTimes(N)`. The wrappers also install `TickerMode(enabled: false)` so tickers in the subtree are muted — if you build a custom wrapper, copy that or expect hangs. See [Animations](#animations).
- **Mocktail "no stub" exceptions** — every getter and method the View reads must be stubbed. Add it to the factory in `golden_test_helpers.dart`, not inline.
- **Mocktail fallback values** — for matchers like `any<BuildContext>()` / `any<AppLocalizations>()` / `any<DateTime?>()`, register a fallback once via `registerFallbackValue(...)` (no generic type param — mocktail infers from the value). Use `class _FakeXxx extends Fake implements Xxx {}` for non-trivial types — this is the canonical mocktail idiom (do **not** rename `Fake` to `Mock`; they have different semantics — `Fake` is a no-op stand-in for fallbacks, `Mock` is a stubbable spy).
- **Flaky pixel diffs** — `pumpBeforeTest: pumpNTimes(3)` for any tree with `BlocBuilder`, animations, or async image loaders. The tolerance is set globally (`0.05`) — don't override per-test.
- **Goldens written to wrong dir** — local runs go to `goldens/macos/`, CI to `goldens/ci/`. Both are committed. If only `macos/` exists after a run, that's expected locally; CI will produce its own on the first run.
- **Don't reuse `fileName` across `goldenTest`s** — each `goldenTest` writes one PNG; clashing names overwrite each other.

## Commands

All commands run from the **workspace root** (`/Users/.../up-sushi-flutter`). Tests live at `/test/`, not `apps/main/test/`.

| Command                                                | What it does                                                                |
|--------------------------------------------------------|-----------------------------------------------------------------------------|
| `make run-tests`                                       | Run the full test suite via melos.                                          |
| `make reset-goldens`                                   | Wipe all `goldens/` directories and regenerate baselines.                   |
| `fvm flutter test test/feature/<name>`                 | Run a single feature's tests against existing goldens.                      |
| `fvm flutter test --update-goldens test/feature/<name>` | Regenerate goldens for a single feature only — preferred while iterating.   |

[use-makefile](mdc:.cursor/rules/use-makefile.mdc) and [fvm-usage](mdc:.cursor/rules/fvm-usage.mdc) apply: never call `flutter` / `dart` directly *except* for the targeted `--update-goldens` / `test <path>` cases above, where there is no Makefile target.
