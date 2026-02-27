# Zoloto — Golden Testing Library for Flutter

A convenient wrapper over Flutter golden tests. Automates multi-platform and multi-device golden testing: manages device configurations, themes, localization, fonts, and CI environments.

**Package:** `zoloto`
**Package dependencies:** `flutter_test`, `meta`, `octo_image`

---

## Quick Start

### 1. Setting up flutter_test_config.dart

Create `flutter_test_config.dart` in the test directory root:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zoloto/zoloto.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  return Zoloto.runWithConfiguration(
    () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      await loadAppFonts();
      await testMain();
    },
    config: ZolotoConfig(
      testCases: [
        ZolotoTestCase(
          name: 'pixel_4',
          size: const Size(360, 760),
          theme: ZolotoTestingTheme(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            data: ThemeData.light(),
            mode: ThemeMode.light,
          ),
        ),
        ZolotoTestCase(
          name: 'iphone_14',
          size: const Size(390, 844),
          safeArea: const EdgeInsets.only(top: 47, bottom: 34),
          theme: ZolotoTestingTheme(
            brightness: Brightness.dark,
            backgroundColor: Colors.black,
            data: ThemeData.dark(),
            mode: ThemeMode.dark,
          ),
        ),
      ],
      // Dependencies wrapper (providers, DI, etc.)
      dependenciesWrapper: (child) => ProviderScope(child: child),
    ),
  );
}
```

### 2. Writing a golden test for a widget

```dart
import 'package:zoloto/zoloto.dart';

void main() {
  Zoloto.zolotoTestWidget<MyButton>(
    widgetBuilder: (context, testCase) => MyButton(onPressed: () {}),
  );
}
```

The golden file name is generated automatically from the type `T` (`MyButton` -> `my_button.png`).

### 3. Test with custom name and state

```dart
Zoloto.zolotoTestWidget<MyButton>(
  widgetBuilder: (context, testCase) => MyButton(
    onPressed: () {},
    isLoading: true,
  ),
  screenState: 'loading', // -> my_button_loading.png
);
```

### 4. Full-screen test

```dart
Zoloto.zolotoTest(
  'home_screen',
  widgetBuilder: (context, tester, testCase) {
    return HomeScreen();
  },
  setUp: (context, testCase) {
    // Mock setup for each testCase
  },
);
```

### 5. Controlling golden height

```dart
// Height based on device size (default)
testHeight: TestHeight.basedOnDevice()

// Height based on content (for scrollable lists)
testHeight: TestHeight.basedOnContent(
  additionalInsets: EdgeInsets.only(top: 50, bottom: 50),
)

// Fixed height
testHeight: TestHeight.fixed(1200)
```

### 6. Advanced test via multiScreenGolden

```dart
testWidgets('animated widget', (tester) async {
  await Zoloto.multiScreenGolden(
    tester,
    'animated_widget',
    widgetBuilder: (context, testCase) => AnimatedWidget(),
    customPump: (tester) async {
      await tester.pumpAndSettle(Duration(milliseconds: 500));
    },
  );
});
```

---

## API Reference

### Zoloto (main class)

| Method | Description |
|--------|-------------|
| `Zoloto.runWithConfiguration<T>(body, config:)` | Runs tests with configuration via Zone |
| `Zoloto.zolotoTest(description, widgetBuilder:, setUp:, skip:, testHeight:)` | Full-screen golden test |
| `Zoloto.zolotoTestWidget<T>(widgetBuilder:, name:, test:, setup:, testHeight:, skip:, screenState:)` | Single widget golden test (name auto-generated from `T`) |
| `Zoloto.multiScreenGolden(tester, name, widgetBuilder:, finder:, testHeight:, customPump:, deviceSetup:, testCases:)` | Low-level multi-screen golden |
| `Zoloto.configuration` | Get current `ZolotoConfig` from Zone |

### ZolotoConfig (configuration)

```dart
const ZolotoConfig({
  required List<ZolotoTestCase> testCases,        // Device list
  Widget Function(Widget)? dependenciesWrapper,    // Dependencies wrapper
  ComparatorFactory comparatorFactory,             // Comparator factory (default tolerance 10%)
  WidgetWrapperFactory appWrapperFactory,           // Wrapper for platform tests
  WidgetWrapperFactory ciWrapperFactory,            // Wrapper for CI (Ahem font)
  FileNameFactory fileNameFactory,                  // Golden file name factory
  TestCaseFileNameFactory testCaseFileNameFactory,  // File name factory with device suffix
  PrimeAssets primeAssets,                          // Asset precaching
  bool shouldLoadFonts = true,                     // Load custom fonts
  bool enableRealShadows = true,                   // Render real shadows
  bool skipGoldenAssertion = false,                // Skip golden comparison
  bool skipPlatformTests = false,                  // CI tests only
})
```

**Factory typedefs:**
- `ComparatorFactory = LocalFileComparator Function(Uri testFile)`
- `WidgetWrapperFactory = WidgetWrapper Function(ZolotoTestCase testCase)`
- `FileNameFactory = String Function(String name)`
- `TestCaseFileNameFactory = String Function(String name, ZolotoTestCase testCase, bool isCi)`
- `PrimeAssets = Future<void> Function(WidgetTester tester)`

### ZolotoTestCase (device configuration)

```dart
const ZolotoTestCase({
  required Size size,                    // Screen size (logical pixels)
  required String name,                  // Identifier ("pixel_4", "iphone_14")
  required ZolotoTestingTheme theme,     // Theme
  double pixelRatio = 1.0,              // Pixel density
  double textScale = 1.0,               // Text scale
  EdgeInsets safeArea = EdgeInsets.zero, // SafeArea
  TargetPlatform platform = TargetPlatform.android,
  Iterable<LocalizationsDelegate>? localeOverrides,
  Iterable<Locale>? localizations,
  void Function()? setup,               // Called before each use
})
```

Has a `copyWith(...)` method for creating copies with modified fields.

### ZolotoTestingTheme (theme)

```dart
const ZolotoTestingTheme({
  required ThemeData data,          // Flutter ThemeData
  required ThemeMode mode,          // light / dark / system
  required Brightness brightness,   // Brightness
  required Color backgroundColor,   // Golden file background
})
```

### TestHeight (golden height)

Sealed class with three variants:

| Variant | Description |
|---------|-------------|
| `TestHeight.basedOnDevice()` | Height from `ZolotoTestCase.size` (default) |
| `TestHeight.basedOnContent({EdgeInsets? additionalInsets})` | Content-adaptive (for scrollable views) |
| `TestHeight.fixed(double height)` | Fixed height |

### WidgetTester Extensions

| Method | Description |
|--------|-------------|
| `tester.waitForAssets()` | Precaches images |
| `tester.view.runWithDeviceOverrides(device, body:)` | Applies device settings, runs body, resets |
| `tester.view.applyDeviceOverrides(device)` | Applies device settings |
| `tester.view.resetDeviceOverrides()` | Resets device settings |
| `tester.safeAreaTestValue = EdgeInsets(...)` | Sets SafeArea |

### Font Utilities

| Function / Constant | Description |
|---------------------|-------------|
| `loadAppFonts()` | Loads all fonts from FontManifest.json |
| `ciFontFamily` | Constant `'Ahem'` — CI font |
| `TextStyle.toCi` | Extension — returns style with Ahem font |

### TestAssetBundle

Custom AssetBundle for tests — bypasses the 10KB asset size limit.

```dart
DefaultAssetBundle(
  bundle: TestAssetBundle(),
  child: widget,
)
```

### ZolotoFileComparator

Golden file comparator with tolerance threshold.

```dart
ZolotoFileComparator(testFile, toleranceThreshold: 0.1) // 10% by default
```

### Network Image Mocks

| Class / Constant | Description |
|------------------|-------------|
| `MockHttpClient` | HTTP client mock, returns transparent PNG |
| `MockHttpClientRequest` | HTTP request mock |
| `MockHttpClientResponse` | HTTP response mock |
| `kTransparentImage` | Transparent 1x1 PNG in bytes |

### Pump Utilities

| Function | Description |
|----------|-------------|
| `pumpNTimes(n, [duration])` | Returns PumpAction that pumps n times |
| `pumpOnce` | Pumps once |
| `onlyPumpAndSettle(tester)` | `pumpAndSettle` |
| `precacheImages(tester)` | Precaches Image, FadeInImage, DecoratedBox, OctoImage |
| `twoPumps(testCase, tester)` | Pumps twice |

---

## Golden File Structure

By default golden files are generated in:

```
goldens/
├── ci/              <- CI tests (Ahem font, platform-independent)
│   ├── pixel_4/
│   │   └── my_widget.png
│   └── iphone_14/
│       └── my_widget.png
├── macos/           <- Platform-specific (macOS)
│   ├── pixel_4/
│   │   └── my_widget.png
│   └── iphone_14/
│       └── my_widget.png
├── linux/           <- Platform-specific (Linux)
└── windows/         <- Platform-specific (Windows)
```

---

## Important Notes

1. **Zone configuration** — `ZolotoConfig` is passed via Dart Zone, available globally through `Zoloto.configuration`
2. **Ahem font** — CI tests use the Ahem font (black squares) so goldens are identical across all platforms
3. **Tolerance 10%** — by default 10% difference between golden and result is allowed
4. **loadAppFonts()** — must be called before tests to load custom fonts
5. **dependenciesWrapper** — use it to wrap with DI containers, providers, etc.
6. **skipPlatformTests: true** — if only CI goldens are needed (saves time)
7. **TestAssetBundle** — automatically wrapped in `defaultAppWrapper`, bypasses 10KB limit
