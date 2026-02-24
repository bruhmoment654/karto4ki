# ContentCard — кастомный контейнер для контента

## Статус: РЕАЛИЗОВАНО

## Файлы компонента

```
lib/uikit/content_card/
├── content_card.dart          — основной виджет
├── content_card_type.dart     — enum (large, medium, smallWide, small)
└── content_card_painter.dart  — CustomPainter с градиентами
```

## Архитектура виджета

```
Material (elevation/тень, transparent)
  └── ClipRRect (обрезка градиентов по borderRadius)
       └── ColoredBox (фон: Color(0xFF1E1E1E) alpha 0.85)
            └── CustomPaint (ContentCardPainter — градиенты ПОД контентом)
                 └── Padding → child
```

## Типы и параметры

| Тип | borderRadius | padding | elevation | Градиент |
|-----|-------------|---------|-----------|----------|
| **large** | 16 | all(24) | 8 | RadialGradient: 3 круга (primary 0.15, info 0.12, primary 0.08) |
| **medium** | 16 | all(16) | 0 | RadialGradient: 2 круга (primary 0.13, info 0.08) |
| **smallWide** | 8 | h:24 v:16 | 0 | LinearGradient: справа налево (primary 0.10) |
| **small** | 8 | all(16) | 0 | RadialGradient: 1 большой круг (primary 0.08, radius 1.2x) |

## Детали реализации градиентов

### RadialGradient (large, medium, small)
- Три стопа: `[0.0, 0.5, 1.0]`
- Цвет затухает плавно с центра: `100% alpha → 40% alpha → 0`
- Круги рисуются через `canvas.drawCircle` с `Paint..shader`
- Цвета: primary `#23FF8E`, info `#42A5F5`

### LinearGradient (smallWide)
- Направление: `Alignment.centerRight → Alignment.centerLeft`
- Три стопа: `[0.0, 0.5, 1.0]` — аналогично радиальным
- Цвет: primary alpha 0.10, затухает влево
- Рисуется через `canvas.drawRect`

## Параметры ContentCard

```dart
ContentCard({
  required Widget child,
  ContentCardType type = ContentCardType.small,
  Color? backgroundColor,      // дефолт: Color(0xFF1E1E1E).withValues(alpha: 0.85)
  BorderRadius? borderRadius,
  EdgeInsetsGeometry? padding,
  double? elevation,
})
```

## Где используется

| Место | Тип | Файл |
|-------|-----|------|
| Свайп-карточка (2 места) | large | `lib/uikit/question_card/question_card.dart` |
| Аппбар деталки теста | medium | `lib/feature/test_detail/presentation/test_detail_view.dart` |
| Карточка в списке карточек | smallWide | `lib/feature/test_detail/presentation/test_detail_view.dart` |
| Карточка результата теста | smallWide | `lib/feature/tinder_test/presentation/tinder_test_view.dart` |
| Подсказки свайпа (2 шт) | small | `lib/feature/tinder_test/presentation/tinder_test_view.dart` |
| Настройка скорости анимации | small | `lib/feature/profile/presentation/profile_view.dart` |

## Заметки для визуальной настройки

- Фон контейнера `Color(0xFF1E1E1E) alpha 0.85` — подобран чтобы выделяться на шейдерном фоне `#121212`
- Opacity градиентов подобрана вручную: large самые яркие (0.15), small самые мягкие (0.08)
- Для small-контейнеров радиус круга увеличен до 1.2x от shortestSide, чтобы градиент был заметен даже на маленьких виджетах
- ClipRRect обрезает градиенты по краям — круги могут «выходить» за границы, создавая эффект свечения
- FAB (`app_fab.dart`) НЕ использует ContentCard — оставлен на Material + StadiumBorder
