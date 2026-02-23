# План: Кастомный контейнер для контента

## Концепция

Универсальный контейнер с полупрозрачным фоном и декоративными размытыми кругами, которые обрезаются по границам контейнера. Контейнер не должен сливаться с фоном приложения (шейдерный фон `#101816` / `#121212`).

## Типы карточек

| Тип | Примерное применение | Размытые круги |
|-----|---------------------|----------------|
| **large** | Свайп-карточка tinder_test | 2-3 больших круга по углам/краям |
| **medium** | Аппбар на деталке теста | 1-2 средних круга |
| **smallWide** | Вариант ответа на деталке, карточки результатов | 1 небольшой круг сбоку |
| **small** | Настройки профиля, подсказки свайпа | 1 маленький круг или без кругов |

---

## Этап 1: Создание файловой структуры

Создать директорию и файлы:

```
lib/uikit/content_card/
├── content_card.dart          — основной виджет ContentCard
├── content_card_type.dart     — enum ContentCardType
└── content_card_painter.dart  — CustomPainter для декоративных кругов
```

---

## Этап 2: Enum `ContentCardType`

**Файл:** `lib/uikit/content_card/content_card_type.dart`

```dart
enum ContentCardType {
  large,
  medium,
  smallWide,
  small,
}
```

Без дополнительных методов — вся логика конфигурации кругов будет в painter.

---

## Этап 3: `ContentCardPainter` (CustomPainter)

**Файл:** `lib/uikit/content_card/content_card_painter.dart`

Рисует декоративные размытые круги поверх фона контейнера. Каждый круг — это `drawCircle` с `MaskFilter.blur(BlurStyle.normal, sigma)` на `Paint`.

### Структура данных для круга

```dart
class _BlurCircle {
  final Offset relativeCenter; // от 0.0 до 1.0, относительно размера контейнера
  final double relativeRadius;  // относительно min(width, height) или фиксированный
  final Color color;
  final double blurSigma;
}
```

### Конфигурация кругов по типам

**large** (свайп-карточка, полноэкранная):
- Круг 1: верхний левый угол, `relativeCenter: (0.1, 0.15)`, радиус ~0.35, цвет `Color(0xFF23FF8E)` (primary) с opacity 0.06-0.08, sigma 40-60
- Круг 2: нижний правый, `relativeCenter: (0.85, 0.8)`, радиус ~0.3, цвет `Color(0xFF42A5F5)` (info) с opacity 0.05-0.07, sigma 40-60
- Круг 3 (опционально): центр-низ, `relativeCenter: (0.5, 0.95)`, радиус ~0.25, цвет primary с opacity 0.04, sigma 50

**medium** (аппбар деталки):
- Круг 1: правый край, `relativeCenter: (0.9, 0.3)`, радиус ~0.4, цвет primary с opacity 0.06, sigma 30-40
- Круг 2 (опционально): левый нижний, `relativeCenter: (0.15, 0.8)`, радиус ~0.3, цвет info с opacity 0.04, sigma 30

**smallWide** (вариант ответа, карточка результата):
- Круг 1: правый край по центру, `relativeCenter: (0.95, 0.5)`, радиус ~0.4, цвет primary с opacity 0.05, sigma 20-30

**small** (кнопки, настройки, подсказки):
- Круг 1: один из углов, `relativeCenter: (0.85, 0.3)`, радиус ~0.3, цвет primary с opacity 0.04, sigma 15-20
- Или без кругов вовсе (пустой список)

### Реализация painter

```dart
class ContentCardPainter extends CustomPainter {
  final ContentCardType type;
  final Color? accentColor; // для кастомного акцентного цвета кругов

  @override
  void paint(Canvas canvas, Size size) {
    final circles = _getCircles(type, size);
    for (final circle in circles) {
      final paint = Paint()
        ..color = circle.color
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, circle.blurSigma);
      canvas.drawCircle(circle.center, circle.radius, paint);
    }
  }

  List<_ResolvedCircle> _getCircles(ContentCardType type, Size size) {
    // switch по type, вычисление абсолютных позиций из relative
  }

  @override
  bool shouldRepaint(ContentCardPainter oldDelegate) =>
      type != oldDelegate.type || accentColor != oldDelegate.accentColor;
}
```

**Важно:** `MaskFilter.blur` на `Paint` — самый простой способ сделать размытые круги без `BackdropFilter` или `ImageFiltered`. Это рисует круг с размытием прямо на canvas, без дополнительных слоёв.

---

## Этап 4: Виджет `ContentCard`

**Файл:** `lib/uikit/content_card/content_card.dart`

### Параметры

```dart
class ContentCard extends StatelessWidget {
  final Widget child;
  final ContentCardType type;
  final Color? backgroundColor;    // дефолт: Colors.white.withOpacity(0.06)
  final BorderRadius? borderRadius; // дефолт: BorderRadius.circular(AppDimens.radius16) для large/medium, radius8 для small/smallWide
  final EdgeInsetsGeometry? padding;
  final double? elevation;          // для тени, дефолт: 0

  const ContentCard({
    required this.child,
    this.type = ContentCardType.small,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
    this.elevation,
    super.key,
  });
}
```

### Дефолтные значения по типам

| Параметр | large | medium | smallWide | small |
|----------|-------|--------|-----------|-------|
| borderRadius | 16 | 16 | 8 | 8 |
| padding | EdgeInsets.all(24) | EdgeInsets.all(16) | EdgeInsets.symmetric(h:24, v:16) | EdgeInsets.all(16) |
| elevation | 8 | 0 | 0 | 0 |

### Дерево виджетов (build)

```dart
@override
Widget build(BuildContext context) {
  final resolvedBorderRadius = borderRadius ?? _defaultBorderRadius(type);
  final resolvedBg = backgroundColor ?? const Color(0xFF1E1E1E).withOpacity(0.85);
  // Вариант: Colors.white.withOpacity(0.06) — подбирать визуально

  return Material(
    elevation: elevation ?? _defaultElevation(type),
    color: Colors.transparent,
    borderRadius: resolvedBorderRadius,
    child: ClipRRect(
      borderRadius: resolvedBorderRadius,
      child: ColoredBox(
        color: resolvedBg,
        child: CustomPaint(
          painter: ContentCardPainter(type: type),
          child: Padding(
            padding: padding ?? _defaultPadding(type),
            child: child,
          ),
        ),
      ),
    ),
  );
}
```

**Почему так:**
- `Material` — для elevation/тени (вместо Card, чтобы полностью контролировать рендеринг)
- `ClipRRect` — обрезает декоративные круги по borderRadius
- `ColoredBox` — фон контейнера (быстрее чем Container с color)
- `CustomPaint` с `painter` — рисует круги ПОД child
- `Padding` + `child` — контент поверх всего

---

## Этап 5: Расширение `AppDimens`

**Файл:** `lib/uikit/app_radii.dart`

Добавить недостающий радиус:

```dart
static const double radius12 = 12; // используется в кнопках (ElevatedButton)
```

(Опционально — если понадобится для `ContentCard`. Текущие `radius8` и `radius16` покрывают основные кейсы.)

---

## Этап 6: Интеграция

### 6.1. `QuestionCardContent` → `ContentCard(type: large)`

**Файл:** `lib/uikit/question_card/question_card.dart`

Текущий код (строки 156-168 и 201-216):
```dart
Card(
  elevation: 8,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16),
  ),
  child: Container(
    width: double.infinity,
    height: double.infinity,
    padding: const EdgeInsets.all(24),
    child: Center(child: face),
  ),
)
```

Заменить на:
```dart
ContentCard(
  type: ContentCardType.large,
  child: SizedBox.expand(
    child: Center(child: face),
  ),
)
```

**Два места замены:** в блоке `if (!enableFlipAnimation)` (строка 156) и в `TweenAnimationBuilder` (строка 204). Оба идентичны по структуре.

### 6.2. Аппбар деталки теста → `ContentCard(type: medium)`

**Файл:** `lib/feature/test_detail/presentation/test_detail_view.dart`

Текущий код (строки 43-93): `PreferredSize` → `Material(color: colorScheme.primary)` → `Stack`

Заменить `Material(color: colorScheme.primary, ...)` на:
```dart
ContentCard(
  type: ContentCardType.medium,
  backgroundColor: colorScheme.primary,
  borderRadius: BorderRadius.zero, // аппбар без скруглений
  padding: EdgeInsets.zero, // padding внутри Container
  child: Stack(
    children: [
      InkWell(...), // существующий InkWell
      Positioned(...), // кнопка назад
    ],
  ),
)
```

**Внимание:** InkWell требует Material-предка для ripple-эффекта. Нужно обернуть child в `Material(color: Colors.transparent, child: InkWell(...))` или использовать `Ink` виджет, так как `ContentCard` использует `Material` на верхнем уровне — ripple должен работать.

### 6.3. Варианты ответов (карточки списка) → `ContentCard(type: smallWide)`

**Файл:** `lib/feature/test_detail/presentation/test_detail_view.dart`

Виджет `_CardListItem` (строки 252-319). Текущий код:
```dart
Card(
  shape: const BeveledRectangleBorder(),
  color: colorScheme.secondary,
  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  child: ListTile(...),
)
```

Заменить на:
```dart
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
  child: ContentCard(
    type: ContentCardType.smallWide,
    padding: EdgeInsets.zero, // ListTile сам управляет padding
    child: ListTile(...),
  ),
)
```

**Примечание:** `Card` имеет `margin`, а `ContentCard` — нет. Margin вынести во внешний `Padding`.

### 6.4. Карточки результатов тиндер-теста → `ContentCard(type: smallWide)`

**Файл:** `lib/feature/tinder_test/presentation/tinder_test_view.dart`

Виджет `_ResultCard` (строки 394-441). Текущий код:
```dart
Card(
  child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    child: Row(...),
  ),
)
```

Заменить на:
```dart
ContentCard(
  type: ContentCardType.smallWide,
  child: Row(...),
)
```

### 6.5. Подсказки свайпа → `ContentCard(type: small)`

**Файл:** `lib/feature/tinder_test/presentation/tinder_test_view.dart`

Виджет `_SwipeHints` (строки 267-312). Текущий код (два хинта):
```dart
Material(
  color: colorScheme.surfaceContainer,
  elevation: 2,
  child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    child: Row(...),
  ),
)
```

Заменить каждый на:
```dart
ContentCard(
  type: ContentCardType.small,
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  child: Row(...),
)
```

### 6.6. Карточка настройки анимации → `ContentCard(type: small)`

**Файл:** `lib/feature/profile/presentation/profile_view.dart`

Виджет `_AnimationSpeedCard` (строки 27-70). Текущий код:
```dart
Card(
  shape: const BeveledRectangleBorder(),
  child: Padding(
    padding: const EdgeInsets.all(24),
    child: Column(...),
  ),
)
```

Заменить на:
```dart
ContentCard(
  type: ContentCardType.small,
  padding: const EdgeInsets.all(24),
  child: Column(...),
)
```

---

## Этап 7: Визуальная настройка

После интеграции во все экраны — запустить приложение и подобрать:

1. **Цвет фона контейнера** — начать с `Colors.white.withOpacity(0.06)`, регулировать чтобы контейнер выделялся на шейдерном фоне но не был слишком ярким
2. **Цвета кругов** — использовать primary (`#23FF8E`) и info (`#42A5F5`) с очень низкой opacity (0.04-0.08)
3. **Sigma размытия** — начать с 30-50 для large, 20-30 для medium, 15-20 для small. Чем больше sigma, тем мягче край круга
4. **Позиции кругов** — подбирать чтобы край круга немного выходил за границы контейнера (обрезается ClipRRect), создавая эффект "свечения"

---

## Контрольный список

- [ ] Создать `content_card_type.dart` с enum
- [ ] Создать `content_card_painter.dart` с CustomPainter
- [ ] Создать `content_card.dart` с основным виджетом
- [ ] Заменить Card в `QuestionCardContent` (2 места)
- [ ] Заменить Material аппбара в `test_detail_view.dart`
- [ ] Заменить Card в `_CardListItem` (`test_detail_view.dart`)
- [ ] Заменить Card в `_ResultCard` (`tinder_test_view.dart`)
- [ ] Заменить Material в `_SwipeHints` (`tinder_test_view.dart`, 2 хинта)
- [ ] Заменить Card в `_AnimationSpeedCard` (`profile_view.dart`)
- [ ] Визуально проверить все экраны, подобрать цвета/blur

## Открытые вопросы

- Точные цвета и прозрачности кругов — подбирать визуально после интеграции
- Анимация кругов (статичные или с лёгким движением) — реализовать статичные, анимацию добавить позже при необходимости
- `MaskFilter.blur` достаточно для нужного эффекта; `BackdropFilter`/`ShaderMask` избыточны
