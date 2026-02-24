# План: Доработка фона приложения

## Текущее состояние

- Фон — GLSL-шейдер (`assets/shaders/background.frag`), анимация 30 секунд в цикле
- Цвета шейдера: `#101816` ↔ `#121212` — очень тёмные, переход малозаметен
- Шейдер рендерится через `ShaderBackground` → `CustomPaint`
- `AppScaffold` оборачивает каждый экран шейдерным фоном
- В настройках (`SettingsDto`) сейчас только `animationDurationMs`

## Файлы проекта (справочник)

| Компонент | Путь | Назначение |
|-----------|------|------------|
| Шейдер | `assets/shaders/background.frag` | GLSL-фрагментный шейдер фона |
| ShaderBackground | `lib/uikit/background/shader_background.dart` | Виджет рендеринга шейдера (StatefulWidget + AnimationController) |
| ShaderHandler | `lib/core/shader/shader_handler.dart` | Загрузка FragmentProgram, InheritedWidget `ShaderScope` |
| AppScaffold | `lib/uikit/scaffold/app_scaffold.dart` | Обёртка экранов: Stack(ShaderBackground, Scaffold) |
| SettingsDto | `lib/persistence/settings/data/settings_dto.dart` | DTO настроек (json_serializable, checked: true) |
| SettingsDto.g | `lib/persistence/settings/data/settings_dto.g.dart` | Сгенерированный файл — **НЕ РЕДАКТИРОВАТЬ** |
| ISettingsStorage | `lib/persistence/settings/i_settings_storage.dart` | Интерфейс хранилища настроек |
| SettingsStorage | `lib/persistence/settings/settings_storage.dart` | Реализация на SharedPreferences |
| ProfileScreen | `lib/feature/profile/presentation/profile_screen.dart` | Экран профиля (State реализует IProfileViewModel) |
| ProfileView | `lib/feature/profile/presentation/profile_view.dart` | UI-слой профиля (ListView с карточками настроек) |
| AppTheme | `lib/uikit/theme/app_theme.dart` | Тема приложения, seedColor = `#23FF8E` |
| AppThemeScope | `lib/uikit/theme/app_theme_scope.dart` | InheritedWidget для темы (сейчас StatelessWidget, станет StatefulWidget) |
| App | `lib/app/app.dart` | Корневой виджет MaterialApp, применяет тему |
| ContentCardPainter | `lib/uikit/content_card/content_card_painter.dart` | Градиентные декорации карточек (использует accent-цвет) |
| Локализация RU | `lib/l10n/app_ru.arb` | Русские строки |
| Локализация EN | `lib/l10n/app_en.arb` | Английские строки |

---

## Задача 1: Усилить заметность шейдера

### Что менять

**Файл:** `assets/shaders/background.frag`

### Текущие значения (строки 17–22)

```glsl
vec3 dark   = vec3(0.0627, 0.0941, 0.0863); // #101816
vec3 accent = vec3(0.0706, 0.0706, 0.0706);  // #121212

float peak = 0.5;
float w = 0.35;
float blend = exp(-pow((st - peak) / w, 2.0));
```

Проблема: оба цвета почти одинаковые по яркости (~9–10%), разница незаметна глазу.

### Что нужно сделать

1. **Заменить `accent` цвет** — добавить слабый оттенок зелёного (accent-цвет приложения `#23FF8E`):
   ```glsl
   vec3 dark   = vec3(0.0627, 0.0941, 0.0863); // #101816 — без изменений
   vec3 accent = vec3(0.06, 0.14, 0.10);        // ~#0F2419 — тёмно-зелёный с лёгким accent-оттенком
   ```
   Accent-цвет должен оставаться тёмным (яркость не более 14–15%), но с заметной зелёной компонентой. Конкретные значения подбирать визуально на устройстве.

2. **Увеличить ширину волны** для более плавного и заметного перехода:
   ```glsl
   float w = 0.45; // было 0.35
   ```

3. **(Опционально) Добавить лёгкий glow от accent-цвета** — дополнительный слой поверх основного blend:
   ```glsl
   vec3 glow = vec3(0.137, 1.0, 0.557); // #23FF8E
   float glowStrength = 0.015;           // очень слабый
   col += glow * glowStrength * blend;
   ```
   Это добавит едва заметное зелёное свечение в области волны. Если визуально перебор — убрать.

### Критерии готовности

- Фон остаётся тёмным, не отвлекает от контента
- Волна визуально различима при внимательном взгляде
- Переход плавный, без резких границ
- Зелёный оттенок гармонирует с accent-цветом темы (`#23FF8E`)

---

## Задача 2: Настройка отключения анимации шейдера

### Шаг 2.1: Добавить поле в SettingsDto

**Файл:** `lib/persistence/settings/data/settings_dto.dart`

Добавить поле `shaderAnimationEnabled` типа `bool` с дефолтом `true`:

```dart
@JsonSerializable(checked: true)
class SettingsDto {
  final int animationDurationMs;
  final bool shaderAnimationEnabled; // <-- НОВОЕ

  const SettingsDto({
    this.animationDurationMs = 300,
    this.shaderAnimationEnabled = true, // <-- НОВОЕ
  });

  factory SettingsDto.fromJson(Map<String, dynamic> json) =>
      _$SettingsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsDtoToJson(this);
}
```

**После изменения запустить:** `make gen-all`

Это перегенерирует `settings_dto.g.dart`. Убедиться, что `json_serializable` корректно обрабатывает дефолтное значение для существующих пользователей (у которых поля нет в сохранённом JSON).

### Шаг 2.2: Добавить переключатель в ProfileScreen

#### 2.2.1: Расширить IProfileViewModel

**Файл:** `lib/feature/profile/presentation/profile_screen.dart`

Добавить в интерфейс `IProfileViewModel` (строка 38):

```dart
abstract interface class IProfileViewModel {
  int get animationDurationMs;
  bool get shaderAnimationEnabled; // <-- НОВОЕ

  void onAnimationDurationChanged(double value);
  void onShaderAnimationToggled(bool value); // <-- НОВОЕ
}
```

#### 2.2.2: Реализовать в _ProfileScreenState

В том же файле, в `_ProfileScreenState` добавить:

```dart
@override
bool get shaderAnimationEnabled => _settings.shaderAnimationEnabled;

@override
void onShaderAnimationToggled(bool value) {
  setState(() {
    _settings = SettingsDto(
      animationDurationMs: _settings.animationDurationMs,
      shaderAnimationEnabled: value,
    );
    _settingsStorage.save(_settings);
  });
}
```

**Важно:** при создании нового `SettingsDto` нужно передавать все существующие поля, чтобы не сбросить их в дефолт.

#### 2.2.3: Добавить UI-карточку в ProfileView

**Файл:** `lib/feature/profile/presentation/profile_view.dart`

Создать новый виджет `_ShaderAnimationCard` (по аналогии с `_AnimationSpeedCard`):

```dart
class _ShaderAnimationCard extends StatelessWidget {
  final IProfileViewModel viewModel;

  const _ShaderAnimationCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: const BeveledRectangleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                context.l10n.profileShaderAnimationTitle,
                style: theme.textTheme.titleMedium,
              ),
            ),
            Switch(
              value: viewModel.shaderAnimationEnabled,
              onChanged: viewModel.onShaderAnimationToggled,
            ),
          ],
        ),
      ),
    );
  }
}
```

Добавить в `ListView.children` в `ProfileView.build` (строка 19):

```dart
children: [
  _ShaderAnimationCard(viewModel: viewModel), // <-- НОВОЕ
  const SizedBox(height: 12),
  _AnimationSpeedCard(viewModel: viewModel),
],
```

#### 2.2.4: Добавить строки локализации

**Файл:** `lib/l10n/app_ru.arb` — добавить после строки 630:

```json
"profileShaderAnimationTitle": "Анимация фона"
```

**Файл:** `lib/l10n/app_en.arb` — добавить после строки 192:

```json
"profileShaderAnimationTitle": "Background animation"
```

**После изменения запустить:** `make gen-l10n`

---

## Задача 3: Интеграция — ShaderBackground реагирует на настройку

### Шаг 3.1: Передать настройку в ShaderBackground

**Файл:** `lib/uikit/background/shader_background.dart`

Добавить параметр `animationEnabled` в `ShaderBackground`:

```dart
class ShaderBackground extends StatefulWidget {
  final bool animationEnabled;

  const ShaderBackground({
    this.animationEnabled = true,
    super.key,
  });
  // ...
}
```

### Шаг 3.2: Управление AnimationController

В `_ShaderBackgroundState`:

1. При `animationEnabled = false` — остановить контроллер и зафиксировать `uTime` на значении `0.35` (визуально удачный статичный кадр — подобрать точное значение).
2. При `animationEnabled = true` — запустить `repeat()`.
3. Реагировать на изменение через `didUpdateWidget`:

```dart
@override
void didUpdateWidget(ShaderBackground oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (widget.animationEnabled != oldWidget.animationEnabled) {
    if (widget.animationEnabled) {
      _controller.repeat();
    } else {
      _controller.stop();
      _controller.value = 0.35; // статичный кадр
    }
  }
}

@override
void initState() {
  super.initState();
  _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 30),
  );
  if (widget.animationEnabled) {
    _controller.repeat();
  } else {
    _controller.value = 0.35;
  }
}
```

**Примечание:** значение `0.35` для статичного кадра — ориентировочное. Нужно проверить визуально, при каком `uTime` волна выглядит наиболее привлекательно в статике. Хороший кадр — когда волна частично видна, но не по центру экрана.

### Шаг 3.3: Прокинуть настройку из AppScaffold

**Файл:** `lib/uikit/scaffold/app_scaffold.dart`

`AppScaffold` должен читать настройку из `SettingsStorage` и передавать в `ShaderBackground`.

Вариант через контекст (DI):

```dart
@override
Widget build(BuildContext context) {
  // ...
  final settings = context.read<IAppScope>().settingsStorage.get();

  return Stack(
    children: [
      ShaderBackground(animationEnabled: settings.shaderAnimationEnabled),
      Scaffold(/* ... */),
    ],
  );
}
```

**Проблема:** `AppScaffold` — StatelessWidget, и `context.read` вызывается при каждом build. Это нормально для `read` (в отличие от `watch`), но изменение настройки не вызовет перестроение `AppScaffold` автоматически.

**Решение:** поскольку `ProfileScreen` вызывает `setState`, который перестраивает `ProfileView` → `AppScaffold` → `ShaderBackground`, настройка подхватится при следующем build текущего экрана. На других экранах изменение применится при навигации (когда build вызовется заново). Это приемлемое поведение.

### Шаг 3.4: (Опционально) Учесть системную настройку reduce motion

В `_ShaderBackgroundState.initState` или `build` проверить:

```dart
final reduceMotion = MediaQuery.of(context).disableAnimations;
final shouldAnimate = widget.animationEnabled && !reduceMotion;
```

Если `disableAnimations == true` — принудительно отключать анимацию независимо от пользовательской настройки.

**Внимание:** `MediaQuery` доступен только в `build`/`didChangeDependencies`, а не в `initState`. Нужно использовать `didChangeDependencies` для первичного чтения и `didUpdateWidget` для обновлений.

---

---

## Задача 4: Выбор основного цвета приложения

### Обзор

Пользователь может выбрать accent-цвет приложения через ползунок оттенка (hue). Цвет влияет на:
- **Тему Material** — `ColorScheme.fromSeed(seedColor: выбранныйЦвет)`
- **Шейдер фона** — тонировка волны и glow подстраиваются под выбранный цвет
- **ContentCardPainter** — акцентные градиенты карточек

### Выбор подхода к UI выбора цвета

#### Вариант A: Ползунок оттенка (Hue Slider) — **рекомендуется**

- Один Slider (0–360°), фиксированная насыщенность (1.0) и светлость (0.57)
- `HSLColor.fromAHSL(1.0, hue, 1.0, 0.57).toColor()` → всегда яркий, насыщенный цвет
- Трек ползунка отрисован радужным градиентом — пользователь видит, какой цвет выбирает
- Под ползунком — превью: кружок или полоска с текущим цветом

**Почему этот вариант лучше:**
- Простота — один параметр в настройках (`double accentColorHue`)
- Гарантия результата — фиксированная насыщенность/светлость = всегда читаемый цвет на тёмном фоне
- Компактный UI — помещается в одну карточку
- Нет внешних зависимостей

#### Вариант B: Полноценный Color Picker

- Круговой hue-wheel + 2D площадка saturation/brightness
- Нужен пакет (`flex_color_picker`, `flutter_colorpicker` и т.п.)
- Пользователь может выбрать нечитаемый цвет (тёмный на тёмном)
- Сложнее хранить (3–4 значения вместо одного)
- Оверинжиниринг для данного приложения

#### Вариант C: Сетка пресетов

- 8–12 предустановленных цветных кружков
- Всегда выглядит хорошо, быстрый выбор
- Ограниченная свобода выбора

**Итог:** реализуем **Вариант A** (Hue Slider). При необходимости можно добавить ряд пресетных кружков для быстрого выбора поверх ползунка (опционально).

---

### Шаг 4.1: Добавить поле в SettingsDto

**Файл:** `lib/persistence/settings/data/settings_dto.dart`

Добавить поле `accentColorHue` — оттенок цвета (0–360°), дефолт `149.0` (текущий зелёный `#23FF8E`):

```dart
@JsonSerializable(checked: true)
class SettingsDto {
  final int animationDurationMs;
  final bool shaderAnimationEnabled;
  final double accentColorHue; // <-- НОВОЕ

  const SettingsDto({
    this.animationDurationMs = 300,
    this.shaderAnimationEnabled = true,
    this.accentColorHue = 149.0, // <-- НОВОЕ — оттенок #23FF8E
  });

  // ...
}
```

**После изменения запустить:** `make gen-all`

Дефолтное значение `149.0` — hue текущего `#23FF8E`. При десериализации старых настроек без этого поля подставится дефолт.

---

### Шаг 4.2: Добавить реактивность в хранилище настроек

Чтобы тема приложения обновлялась при смене цвета, `ISettingsStorage` должен уведомлять слушателей.

#### 4.2.1: Расширить интерфейс ISettingsStorage

**Файл:** `lib/persistence/settings/i_settings_storage.dart`

```dart
import 'package:flutter/foundation.dart';

abstract interface class ISettingsStorage {
  SettingsDto get();
  ValueListenable<SettingsDto> get listenable;
  Future<void> save(SettingsDto dto);
}
```

#### 4.2.2: Реализовать в SettingsStorage

**Файл:** `lib/persistence/settings/settings_storage.dart`

Добавить `ValueNotifier<SettingsDto>` внутрь реализации:

```dart
class SettingsStorage implements ISettingsStorage {
  final SharedPreferences _prefs;
  late final ValueNotifier<SettingsDto> _notifier;

  SettingsStorage(this._prefs) {
    _notifier = ValueNotifier<SettingsDto>(get());
  }

  @override
  ValueListenable<SettingsDto> get listenable => _notifier;

  @override
  SettingsDto get() {
    // ... существующая логика ...
  }

  @override
  Future<void> save(SettingsDto dto) async {
    // ... существующая логика сохранения ...
    _notifier.value = dto; // уведомить слушателей
  }
}
```

---

### Шаг 4.3: Динамическая тема — AppTheme

**Файл:** `lib/uikit/theme/app_theme.dart`

Сделать `dark` фабрикой, принимающей `seedColor`:

```dart
class AppTheme {
  /// Дефолтный accent-цвет приложения.
  static const defaultSeedColor = Color.fromARGB(255, 35, 255, 142);

  /// Генерирует тёмную тему с заданным seedColor.
  static ThemeData dark({Color seedColor = defaultSeedColor}) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colorScheme.scaffoldBackground,
      // ... остальные поля без изменений, но используют локальный colorScheme ...
    );
  }

  /// Конвертация hue (0–360) в Color с фиксированной насыщенностью и светлостью.
  static Color seedColorFromHue(double hue) {
    return HSLColor.fromAHSL(1.0, hue.clamp(0, 360), 1.0, 0.57).toColor();
  }

  static const dividerColor = Color(0xFF2A2A2A);
}
```

**Важно:** `_colorScheme` больше не static final — она генерируется внутри метода `dark()`. Все ссылки на `_colorScheme` в теме заменяются на локальную переменную `colorScheme`.

Extension `AppThemeColorSchemeX` — без изменений (scaffoldBackground, success, info — не зависят от accent).

---

### Шаг 4.4: Динамическая тема — AppThemeScope

**Файл:** `lib/uikit/theme/app_theme_scope.dart`

Конвертировать в StatefulWidget, который слушает `ISettingsStorage.listenable`:

```dart
class AppThemeScope extends StatefulWidget {
  final Widget child;

  const AppThemeScope({required this.child, super.key});

  static AppThemeScopeData of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<_AppThemeScopeInherited>();
    assert(inherited != null, 'AppThemeScope is not found in context');
    return inherited!.data;
  }

  @override
  State<AppThemeScope> createState() => _AppThemeScopeState();
}

class _AppThemeScopeState extends State<AppThemeScope> {
  late final ISettingsStorage _settingsStorage;
  late SettingsDto _settings;

  @override
  void initState() {
    super.initState();
    _settingsStorage = context.read<IAppScope>().settingsStorage;
    _settings = _settingsStorage.get();
    _settingsStorage.listenable.addListener(_onSettingsChanged);
  }

  @override
  void dispose() {
    _settingsStorage.listenable.removeListener(_onSettingsChanged);
    super.dispose();
  }

  void _onSettingsChanged() {
    setState(() {
      _settings = _settingsStorage.listenable.value;
    });
  }

  Color get _seedColor => AppTheme.seedColorFromHue(_settings.accentColorHue);

  @override
  Widget build(BuildContext context) {
    return _AppThemeScopeInherited(
      data: AppThemeScopeData(seedColor: _seedColor),
      child: widget.child,
    );
  }
}

class AppThemeScopeData {
  final Color seedColor;

  const AppThemeScopeData({this.seedColor = AppTheme.defaultSeedColor});

  ThemeMode get themeMode => ThemeMode.dark;
  bool get isDark => true;
}
```

**Примечание:** `context.read` в `initState` — допустимо, т.к. Provider<IAppScope> находится выше в дереве.

---

### Шаг 4.5: Обновить App для динамической темы

**Файл:** `lib/app/app.dart`

В `_AppState.build` использовать `seedColor` из `AppThemeScope`:

```dart
@override
Widget build(BuildContext context) {
  return AppThemeScope(
    child: Builder(
      builder: (context) {
        final themeScope = AppThemeScope.of(context);
        final isDark = themeScope.isDark;
        final theme = AppTheme.dark(seedColor: themeScope.seedColor);

        return AnnotatedRegion<SystemUiOverlayStyle>(
          // ...
          child: MaterialApp.router(
            // ...
            theme: theme,
            darkTheme: theme,
            // ...
          ),
        );
      },
    ),
  );
}
```

Теперь при изменении hue в настройках → `SettingsStorage.save()` → `ValueNotifier` → `AppThemeScope.setState` → `Builder` перестраивается → новая тема во всём приложении.

---

### Шаг 4.6: Передать цвет в шейдер

#### 4.6.1: Изменить шейдер

**Файл:** `assets/shaders/background.frag`

Добавить uniform `uAccent` (vec3 — RGB компоненты accent-цвета, 0.0–1.0):

```glsl
uniform vec2 uSize;   // float 0, 1
uniform float uTime;  // float 2
uniform vec3 uAccent;  // float 3, 4, 5 — accent RGB

out vec4 fragColor;

void main() {
    vec2 uv = FlutterFragCoord().xy / uSize;

    vec2 dir = normalize(vec2(-0.4226, 0.9063));
    float t = dot(uv - 0.5, dir) + 0.5;

    float shift = uTime;
    float st = fract(t - shift);

    // Тёмные варианты accent-цвета для фона
    vec3 baseDark = vec3(0.07);
    vec3 dark   = mix(baseDark, uAccent, 0.08);  // едва заметный оттенок
    vec3 accent = mix(baseDark, uAccent, 0.15);   // чуть сильнее для волны

    float peak = 0.5;
    float w = 0.45;
    float blend = exp(-pow((st - peak) / w, 2.0));

    vec3 col = mix(dark, accent, blend);

    // Лёгкий glow от accent-цвета
    col += uAccent * 0.015 * blend;

    // Dithering noise
    vec2 seed = FlutterFragCoord().xy;
    float noise = fract(sin(dot(seed, vec2(12.9898, 78.233))) * 43758.5453);
    col += (noise - 0.5) / 255.0;

    fragColor = vec4(col, 1.0);
}
```

**Ключевая идея:** шейдер больше не содержит захардкоженных цветов. Вместо этого он получает accent-цвет как uniform и сам генерирует тёмные варианты через `mix()`. При смене accent-цвета — фон автоматически подстраивается.

#### 4.6.2: Обновить ShaderBackground

**Файл:** `lib/uikit/background/shader_background.dart`

Добавить параметр `accentColor`:

```dart
class ShaderBackground extends StatefulWidget {
  final bool animationEnabled;
  final Color accentColor;

  const ShaderBackground({
    this.animationEnabled = true,
    this.accentColor = AppTheme.defaultSeedColor,
    super.key,
  });
  // ...
}
```

В `_ShaderBackgroundPainter` передавать цвет как uniform'ы (float 3, 4, 5):

```dart
@override
void paint(Canvas canvas, Size size) {
  final shader = handler.shader()
    ..setFloat(0, size.width)
    ..setFloat(1, size.height)
    ..setFloat(2, animation.value)
    ..setFloat(3, accentColor.r)  // R (0.0–1.0)
    ..setFloat(4, accentColor.g)  // G (0.0–1.0)
    ..setFloat(5, accentColor.b); // B (0.0–1.0)

  canvas.drawRect(
    Offset.zero & size,
    Paint()..shader = shader,
  );
}
```

**Примечание:** `Color.r`, `Color.g`, `Color.b` — доступны начиная с Flutter 3.27+ как нормализованные значения (0.0–1.0). Для более ранних версий использовать `color.red / 255.0` и т.д.

#### 4.6.3: Обновить AppScaffold

**Файл:** `lib/uikit/scaffold/app_scaffold.dart`

Прокинуть accent-цвет вместе с `animationEnabled`:

```dart
@override
Widget build(BuildContext context) {
  final settings = context.read<IAppScope>().settingsStorage.get();
  final accentColor = AppTheme.seedColorFromHue(settings.accentColorHue);

  return Stack(
    children: [
      ShaderBackground(
        animationEnabled: settings.shaderAnimationEnabled,
        accentColor: accentColor,
      ),
      Scaffold(/* ... */),
    ],
  );
}
```

---

### Шаг 4.7: UI выбора цвета в ProfileView

#### Архитектура debounce и превью

Проблема: `Slider.onChanged` вызывается десятки раз в секунду. На каждый вызов пересоздавать тему (`ColorScheme.fromSeed` ~1–2 мс) + писать в `SharedPreferences` — расточительно.

**Решение — двухуровневое обновление:**

1. **Мгновенно (onChanged):** обновляется только `previewAccentColor` в VM → перестраивается только `_AccentColorCard` (лёгкая операция)
2. **С задержкой 500 мс (debounce):** если ползунок не двигался 500 мс — `save()` → `ValueNotifier` → перестроение всей темы + запись в storage

```
Палец на слайдере (onChanged, ~60 раз/сек)
  → setState({ _pendingHue = value })
  → _AccentColorCard перестраивается с новым цветом (мгновенно)
  → Timer(500ms) перезапускается

Палец отпущен / пауза 500мс
  → Timer срабатывает
  → save(SettingsDto с новым hue)
  → ValueNotifier → AppThemeScope.setState
  → Вся тема + шейдер обновляются
```

#### 4.7.1: Расширить IProfileViewModel

**Файл:** `lib/feature/profile/presentation/profile_screen.dart`

```dart
abstract interface class IProfileViewModel {
  int get animationDurationMs;
  bool get shaderAnimationEnabled;
  double get accentColorHue;
  Color get previewAccentColor; // <-- НОВОЕ — мгновенное превью для карточки

  void onAnimationDurationChanged(double value);
  void onShaderAnimationToggled(bool value);
  void onAccentColorHueChanged(double value);
}
```

#### 4.7.2: Реализовать в _ProfileScreenState с debounce

```dart
// Поля
double? _pendingHue;
Timer? _colorDebounceTimer;

@override
double get accentColorHue => _pendingHue ?? _settings.accentColorHue;

@override
Color get previewAccentColor => AppTheme.seedColorFromHue(accentColorHue);

@override
void onAccentColorHueChanged(double value) {
  // Мгновенно: обновить только превью
  setState(() {
    _pendingHue = value;
  });

  // Debounce: через 500 мс — применить тему + сохранить
  _colorDebounceTimer?.cancel();
  _colorDebounceTimer = Timer(const Duration(milliseconds: 500), () {
    setState(() {
      _settings = SettingsDto(
        animationDurationMs: _settings.animationDurationMs,
        shaderAnimationEnabled: _settings.shaderAnimationEnabled,
        accentColorHue: value,
      );
      _pendingHue = null;
    });
    _settingsStorage.save(_settings);
  });
}
```

**Не забыть** отменить таймер в `dispose`:
```dart
@override
void dispose() {
  _colorDebounceTimer?.cancel();
  super.dispose();
}
```

**Важно:** `_pendingHue` — промежуточное значение во время перетаскивания. Когда `null` — используется значение из `_settings`. Это гарантирует, что Slider не «прыгает» при debounce.

#### 4.7.3: Создать _AccentColorCard

**Файл:** `lib/feature/profile/presentation/profile_view.dart`

Карточка использует `viewModel.previewAccentColor` — реактивно красится при перетаскивании ползунка, без ожидания debounce:

```dart
class _AccentColorCard extends StatelessWidget {
  final IProfileViewModel viewModel;

  const _AccentColorCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ContentCard(
      type: ContentCardType.smallWide,
      accentColor: viewModel.previewAccentColor, // реактивное превью
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.profileAccentColorTitle,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            _HueSlider(
              hue: viewModel.accentColorHue,
              previewColor: viewModel.previewAccentColor,
              onChanged: viewModel.onAccentColorHueChanged,
            ),
          ],
        ),
      ),
    );
  }
}
```

#### 4.7.4: Создать _HueSlider — ползунок с позиционированным превью

Превью цвета — кружок над ползунком, привязанный к позиции thumb.

**Сложность реализации — низкая.** Позиция thumb вычисляется простой формулой:
```
thumbX = thumbPadding + (hue / 360) * (totalWidth - 2 * thumbPadding)
```
Где `thumbPadding` — горизонтальный отступ Slider до центра thumb при min/max значении. В Material 3 это `overlayRadius` (дефолт ~20 px). Задаём явно через `SliderTheme`, чтобы гарантировать совпадение.

```dart
class _HueSlider extends StatelessWidget {
  final double hue;
  final Color previewColor;
  final ValueChanged<double> onChanged;

  const _HueSlider({
    required this.hue,
    required this.previewColor,
    required this.onChanged,
  });

  static const _thumbPadding = 20.0;
  static const _previewSize = 28.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final trackWidth = constraints.maxWidth - 2 * _thumbPadding;
        final thumbX = _thumbPadding + (hue / 360) * trackWidth;

        return Column(
          children: [
            // Превью цвета, привязанное к позиции thumb
            SizedBox(
              height: _previewSize + 4,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: thumbX - _previewSize / 2,
                    child: _ColorPreview(color: previewColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Радужная полоска
            Container(
              height: 12,
              margin: const EdgeInsets.symmetric(horizontal: _thumbPadding),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                gradient: LinearGradient(
                  colors: List.generate(
                    7,
                    (i) => HSLColor.fromAHSL(1, i * 60.0, 1, 0.57).toColor(),
                  ),
                ),
              ),
            ),
            // Ползунок с фиксированным padding
            SliderTheme(
              data: SliderThemeData(
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: _thumbPadding,
                ),
              ),
              child: Slider(
                value: hue,
                min: 0,
                max: 360,
                onChanged: onChanged,
              ),
            ),
          ],
        );
      },
    );
  }
}
```

**Ключевой момент:** `SliderTheme` с явным `overlayRadius: _thumbPadding` гарантирует, что фактический padding Slider совпадает с нашим расчётным. Без этого возможно расхождение на 2–4 px.

**Альтернатива (OverlayPortal):** `// TODO: обсудить — если превью должно выходить за пределы карточки`

#### 4.7.5: Создать _ColorPreview — индикатор цвета

```dart
class _ColorPreview extends StatelessWidget {
  final Color color;

  const _ColorPreview({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _HueSlider._previewSize,
      height: _HueSlider._previewSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white24,
          width: 1.5,
        ),
      ),
    );
  }
}
```

#### 4.7.6: Добавить карточку в ListView

```dart
children: [
  _AccentColorCard(viewModel: viewModel),     // <-- НОВОЕ
  const SizedBox(height: 12),
  _ShaderAnimationCard(viewModel: viewModel),
  const SizedBox(height: 12),
  _AnimationSpeedCard(viewModel: viewModel),
],
```

#### 4.7.7: Строки локализации

**Файл:** `lib/l10n/app_ru.arb`:
```json
"profileAccentColorTitle": "Цвет приложения"
```

**Файл:** `lib/l10n/app_en.arb`:
```json
"profileAccentColorTitle": "App color"
```

**После изменения запустить:** `make gen-l10n`

---

### Шаг 4.8: (Опционально) ContentCardPainter — подхватывать цвет из темы

**Файл:** `lib/uikit/content_card/content_card_painter.dart`

Сейчас: `final primary = accentColor ?? const Color(0xFF23FF8E)` — хардкод.

Два варианта исправления:
1. **Передавать accentColor из ContentCard** — в `build()` читать `Theme.of(context).colorScheme.primary` и прокидывать. Это уже возможно — параметр `accentColor` есть.
2. **Ничего не менять** — если `ContentCard` не передаёт `accentColor`, будет дефолтный зелёный. Это приемлемо, если все вызовы `ContentCard` прокидывают цвет.

**Рекомендация:** в `ContentCard.build` автоматически подставлять `Theme.of(context).colorScheme.primary` если `accentColor` не задан.

---

### Критерии готовности Задачи 4

- Ползунок hue работает плавно, без лагов при перетаскивании
- Карточка `_AccentColorCard` перекрашивается мгновенно при движении ползунка (превью)
- Кружок-превью цвета точно следует за позицией thumb
- Тема (кнопки, навбар, primary-элементы) обновляется через 500 мс после остановки ползунка
- Фон шейдера отражает выбранный цвет (обновляется вместе с темой после debounce)
- При перезапуске приложения выбранный цвет сохраняется
- Дефолтный цвет (hue=149) визуально идентичен текущему `#23FF8E`
- Timer корректно отменяется при dispose (нет утечек)

---

## Порядок выполнения

1. **Задача 1** — изменить шейдер (1 файл: `background.frag`)
2. **Задача 2, шаг 2.1** — добавить поле `shaderAnimationEnabled` в SettingsDto + `make gen-all`
3. **Задача 4, шаг 4.1** — добавить поле `accentColorHue` в SettingsDto + `make gen-all` *(объединить с шагом 2.1 — одна кодогенерация)*
4. **Задача 4, шаг 4.2** — реактивность хранилища настроек (ValueNotifier)
5. **Задача 4, шаги 4.3–4.5** — динамическая тема (AppTheme, AppThemeScope, App)
6. **Задача 2, шаги 2.2–2.2.4** — UI переключателя анимации + `make gen-l10n`
7. **Задача 4, шаги 4.7** — UI выбора цвета + `make gen-l10n` *(объединить с шагом выше — одна генерация l10n)*
8. **Задача 3, шаги 3.1–3.3** — интеграция ShaderBackground с настройкой анимации
9. **Задача 4, шаг 4.6** — передача цвета в шейдер (uniform'ы + ShaderBackground + AppScaffold)
10. **Задача 3, шаг 3.4** — reduce motion (опционально)
11. **Задача 4, шаг 4.8** — ContentCardPainter подхватывает цвет из темы (опционально)
12. **Проверка** — визуальная на устройстве/эмуляторе

## Заметки

- Статичный фон (без анимации) должен выглядеть хорошо сам по себе — подобрать удачный `uTime`
- `SettingsDto` использует `json_serializable` с `checked: true` — новые поля с дефолтом корректно десериализуются из старого JSON
- Файлы `*.g.dart` и `*.freezed.dart` — сгенерированные, **никогда не редактировать вручную**
- Комментарии в коде — на русском языке
- Не использовать build-методы (типа `_buildCard()`) — только отдельные виджеты
- `Color.r/.g/.b` возвращают нормализованные значения (0.0–1.0) начиная с Flutter 3.27+. Для ранних версий использовать `color.red / 255.0`
- Hue `149.0` = текущий `#23FF8E`. HSL(149°, 100%, 57%) → RGB(35, 255, 142)
- Шейдер при `uAccent = vec3(0,0,0)` (чёрный) корректно отрисует нейтральный тёмный фон — проверить edge-case
