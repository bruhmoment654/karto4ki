# План рефакторинга `test_detail_view.dart`

## Текущее состояние

Экран `TestDetailView` использует `DefaultAppBar.expanded` — кастомный AppBar, который **не скроллится** вместе с контентом. Хедер содержит иконку старта, название теста и опционально описание. Кнопка "Настройка теста" — `OutlinedButton` без акцента. Вся структура `_TestDetailContent` содержит вложенную логику прямо в `build`-методах (пустое состояние, список карточек).

**Целевой результат:** экран по структуре аналогичен `GroupDetailView` — хедер внутри `CustomScrollView` как `SliverToBoxAdapter`, чистые приватные виджеты, кнопка настроек акцентная и фиксированная.

---

## Шаг 1. Убрать `DefaultAppBar`, заменить на `AppPageHeader.withBack`

**Что:**
- Удалить виджет `_TestDetailAppBar` целиком (строки 88–154).
- Удалить виджет `_TestDescription` (строки 156–173) — описание переедет в `subtitle` хедера.
- Заменить `appBar` в `AppScaffold` на `null` (или убрать параметр).
- Хедер станет `SliverToBoxAdapter` внутри `CustomScrollView`.

**Как выглядит хедер:**
```dart
AppPageHeader.withBack(
  title: test.title,
  subtitle: test.description,
  onBackPressed: () => Navigator.of(context).pop(),
  onTitlePressed: viewModel.onEditTestPressed,
  action: _StartTestButton(
    canStart: cards.isNotEmpty,
    onPressed: viewModel.onStartTestPressed,
  ),
)
```

**Новый виджет `_StartTestButton`:**
- `AppGlowButton` с иконкой `Icons.play_arrow_rounded`.
- Если `canStart == false` — кнопка неактивна (серый цвет, `onPressed: null` через обёртку).

**Импакт:**
- Удалить импорт `karto4ki_app_bar.dart`.
- Добавить импорт `app_page_header.dart`, `app_glow_button.dart`.
- Убрать `useSafeArea: false` из `AppScaffold` (SafeArea теперь в `AppPageHeader.withBack`).

---

## Шаг 2. Перестроить `TestDetailView.build` — разделить состояния

**Что:**
- `Loading` и `Error` остаются как есть (прямо в switch body).
- `Loaded` делегирует в `_TestDetailLoadedBody` (по аналогии с `_LoadedBody` в group_detail).

**Структура `_TestDetailLoadedBody`:**
```dart
class _TestDetailLoadedBody extends StatelessWidget {
  final TestEntity test;
  final List<CardEntity> cards;
  final ITestDetailViewModel viewModel;
  // + onBackPressed callback
}
```

Внутри — `CustomScrollView` с:
1. `SliverToBoxAdapter` → хедер (`AppPageHeader.withBack`)
2. `SliverToBoxAdapter` → `_TestSettingsButton` (кнопка настроек)
3. `SliverToBoxAdapter` → `_CardsCountWithImport`
4. Если `cards.isEmpty` — `SliverFillRemaining` → `_EmptyCardsPlaceholder`
5. Если `cards.isNotEmpty` — `SliverList.builder` → `_CardListItem`
6. `SliverPadding` (bottom safe area + FAB offset)

**Убираем:**
- Отдельный виджет `_TestDetailContent` — его роль берёт на себя `_TestDetailLoadedBody`.

---

## Шаг 3. Хедер с glow-эффектом и цветным фоном

**Что:**
Обернуть хедер (`AppPageHeader.withBack`) в контейнер с визуальными эффектами:

**Новый виджет `_TestDetailHeader`:**
```dart
class _TestDetailHeader extends StatelessWidget {
  final TestEntity test;
  final bool canStart;
  final ITestDetailViewModel viewModel;
  final VoidCallback onBackPressed;
}
```

**Визуал:**
- `Container` или `DecoratedBox` с `gradient` (лёгкий градиент от `primary.withValues(alpha: 0.08)` к `transparent`).
- Опционально `BoxShadow` с `blurRadius: 24`, `alpha: 0.1` для мягкого свечения.
- Внутри — `AppPageHeader.withBack(...)` с кнопкой старта как `action`.

Результат: хедер выглядит кастомно, выделяется от остального контента, но не перегружен.

---

## Шаг 4. Кнопка "Настройка теста" — фиксированный размер, контрастная

**Что:**
Переделать `_TestSettingsButton`.

**Было:** `OutlinedButton.icon` с текстом "Настройка теста", растянутая по ширине.

**Стало:**
- `AppGlowButton` (или аналогичный стиль) фиксированного размера.
- Располагается **справа** (не по центру, не stretch).
- Контрастный цвет: `colorScheme.secondary` или `primary` с glow-эффектом.
- Иконка `Icons.tune` + текст.

**Вёрстка в `_TestDetailContent`:**
```dart
Row(
  children: [
    // _CardsCountWithImport слева (Expanded)
    // _TestSettingsButton справа (фиксированный)
  ],
)
```

Или объединить в один ряд: счётчик карточек слева, кнопки импорта и настроек справа.

**Альтернатива (по аналогии с переключателем темы):**
Если имеется в виду `SegmentedButton`-подобный переключатель, можно сделать `_TestSettingsButton` как компактную кнопку в стиле `AppGlowButton`:
```dart
AppGlowButton(
  onPressed: viewModel.onTestSettingsPressed,
  color: colorScheme.secondary,
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.tune, size: 18),
      SizedBox(width: 6),
      Text('Настройки'),
    ],
  ),
)
```

---

## Шаг 5. Вынести все вложенные виджеты в чистые приватные классы

Убедиться, что каждый элемент — отдельный приватный `StatelessWidget`:

| Виджет | Назначение |
|---|---|
| `_TestDetailHeader` | Хедер с gradient-фоном, AppPageHeader.withBack, кнопка старта |
| `_StartTestButton` | AppGlowButton с play_arrow |
| `_TestSettingsButton` | Компактная glow-кнопка настроек (фиксированный размер, справа) |
| `_CardsCountWithImport` | Строка: кол-во карточек + кнопка импорта |
| `_EmptyCardsPlaceholder` | Заглушка "нет карточек" |
| `_CardListItem` | Элемент списка с Dismissible |
| `_TestDetailLoadedBody` | Основной контент Loaded-состояния с CustomScrollView |

---

## Шаг 6. Обновить `ITestDetailViewModel`

Проверить, что интерфейс содержит все нужные методы. Текущий интерфейс уже содержит `onEditTestPressed` — он будет использоваться для `onTitlePressed` в хедере.

Новых методов не требуется.

---

## Шаг 7. Финальная структура файла

```
TestDetailView                    — корневой виджет, switch по состояниям
├── Loading → CircularProgressIndicator
├── Error → текст + retry
└── Loaded → _TestDetailLoadedBody
    └── CustomScrollView
        ├── _TestDetailHeader     — gradient-фон, AppPageHeader.withBack + _StartTestButton
        ├── _ActionsRow           — _TestSettingsButton + _CardsCountWithImport в одной строке
        ├── _EmptyCardsPlaceholder (если пусто)
        ├── SliverList → _CardListItem (если есть карточки)
        └── SliverPadding (bottom)
```

FAB (`AppFloatingActionButton`) остаётся в `AppScaffold.floatingActionButton`.

---

## Удаляемые виджеты / импорты

- `_TestDetailAppBar` — полностью
- `_TestDescription` — полностью
- `_TestDetailContent` — заменяется на `_TestDetailLoadedBody`
- Импорт `karto4ki_app_bar.dart` — удалить
- Импорт `spacing/sliver_height.dart` — удалить (если не используется)

## Новые импорты

- `app_page_header.dart`
- `app_glow_button.dart`
- `app_theme.dart` (для `foreground`, `mutedForeground`)
