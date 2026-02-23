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
| Локализация RU | `lib/l10n/app_ru.arb` | Русские строки (ключи `profileSettingsTitle`, `profileAnimationSpeedTitle`, `profileAnimationDurationLabel`) |
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

## Порядок выполнения

1. **Задача 1** — изменить шейдер (1 файл: `background.frag`)
2. **Задача 2, шаг 2.1** — добавить поле в SettingsDto + `make gen-all`
3. **Задача 2, шаги 2.2–2.2.4** — UI переключателя в профиле + `make gen-l10n`
4. **Задача 3, шаги 3.1–3.3** — интеграция ShaderBackground с настройкой
5. **Задача 3, шаг 3.4** — reduce motion (опционально)
6. **Проверка** — визуальная на устройстве/эмуляторе

## Заметки

- Статичный фон (без анимации) должен выглядеть хорошо сам по себе — подобрать удачный `uTime`
- `SettingsDto` использует `json_serializable` с `checked: true` — новое bool-поле с дефолтом корректно десериализуется из старого JSON без этого поля
- Файлы `*.g.dart` и `*.freezed.dart` — сгенерированные, **никогда не редактировать вручную**
- Комментарии в коде — на русском языке
- Не использовать build-методы (типа `_buildCard()`) — только отдельные виджеты
