# План: Возврат к предыдущему вопросу в tinder_test

## Текущее состояние

- В `TinderTestBloc` уже есть событие `discard()` и обработчик `_onDiscard` (строка 178 `tinder_test_bloc.dart`)
- `TestSession` имеет геттер `previous` (строка 50 `test_session.dart`), который декрементирует `currentIndex` и удаляет последний `CardResult`
- В UI есть метод `onDiscardPressed` в `ITinderTestViewModel` (строка 81 `tinder_test_screen.dart`), но **нигде не вызывается** — нет кнопки/жеста
- Откат уже не влияет на статистику в БД — статы сохраняются только при завершении теста (`_saveStats` вызывается в `completed`)

---

## Шаг 1. Доработка `TestSession` — добавить `canUndo`

**Файл:** `lib/feature/tinder_test/domain/entity/test_session.dart`

**Что сделать:**

1. Добавить геттер `canUndo` после геттера `progress` (после строки 48):
```dart
/// Можно ли откатить последний ответ.
bool get canUndo => currentIndex > 0 && results.isNotEmpty;
```

2. Заменить `assert` в геттере `previous` (строка 51) на безопасную проверку:
```dart
TestSession get previous {
  assert(canUndo, 'Cannot undo: no previous answers');

  return copyWith(
    currentIndex: currentIndex - 1,
    results: results.sublist(0, results.length - 1),
  );
}
```

**Зачем:** `canUndo` будет использоваться в BLoC для проверки и в UI для отключения кнопки. Сейчас `previous` имеет `assert(currentIndex > 0)`, но не проверяет `results.isNotEmpty` — теоретически возможен рассинхрон.

**После изменения:** Запустить `make gen-all` (freezed-класс, нужна перегенерация).

---

## Шаг 2. Доработка BLoC — исправить `_onDiscard`

**Файл:** `lib/feature/tinder_test/domain/bloc/tinder_test_bloc.dart`

**Текущий код `_onDiscard` (строки 178-188):**
```dart
Future<void> _onDiscard(
  _TinderTestEvent$Discard event,
  Emitter<TinderTestState> emit,
) async {
  final currentState = state;
  if (currentState is! TinderTestState$InProgress) return;
  if (currentState.session.isCompleted) return;
  emit(currentState.copyWith(session: currentState.session.previous));
}
```

**Что изменить:**

1. Заменить проверку `isCompleted` на `canUndo`:
```dart
Future<void> _onDiscard(
  _TinderTestEvent$Discard event,
  Emitter<TinderTestState> emit,
) async {
  final currentState = state;
  if (currentState is! TinderTestState$InProgress) return;
  if (!currentState.session.canUndo) return;

  final previousSession = currentState.session.previous;
  emit(TinderTestState.inProgress(
    session: previousSession,
    currentCard: previousSession.currentCard!,
  ));
}
```

**Зачем:** Текущая реализация использует `currentState.copyWith(session: ...)`, что **не обновляет поле `currentCard`** в стейте `InProgress`. Нужно создавать новый стейт `TinderTestState.inProgress(...)` явно, как это делается в `_handleSwipe` (строка 127), чтобы `currentCard` обновился на предыдущую карточку.

---

## Шаг 3. UI — кнопка «Отменить» в `_TestContent`

**Файл:** `lib/feature/tinder_test/presentation/tinder_test_view.dart`

### 3.1. Добавить кнопку undo под карточкой

В виджете `_TestContent`, в методе `build` (строка 182), между `Expanded` с карточкой и `SizedBox(height: 16)` (строки 216-217) — добавить кнопку отмены:

```dart
Expanded(
  child: Padding(
    padding: const EdgeInsets.all(16),
    child: AnimatedBuilder(
      // ... существующий код карточки ...
    ),
  ),
),
// === НОВЫЙ КОД: кнопка отмены ===
_UndoButton(
  canUndo: widget.session.canUndo,
  onPressed: widget.viewModel.onDiscardPressed,
),
const SizedBox(height: 16),
```

### 3.2. Создать виджет `_UndoButton`

Добавить новый приватный виджет в том же файле (после `_SwipeHints`, перед `_ResultsContent`):

```dart
class _UndoButton extends StatelessWidget {
  final bool canUndo;
  final VoidCallback onPressed;

  const _UndoButton({
    required this.canUndo,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: canUndo ? 1.0 : 0.3,
      duration: const Duration(milliseconds: 200),
      child: IconButton.filled(
        onPressed: canUndo ? onPressed : null,
        icon: const Icon(Icons.undo),
        tooltip: context.l10n.tinderTestUndoTooltip,
        style: IconButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
```

### 3.3. Сброс `_showAnswer` при откате

В `_TestContentState.didUpdateWidget` (строка 161) уже сбрасывается `_showAnswer` при смене карточки:
```dart
if (oldWidget.currentCard.id != widget.currentCard.id) {
  _showAnswer.value = false;
  _enableFlipAnimation.value = false;
  // ...
}
```
Это сработает и при откате, потому что `currentCard` изменится на предыдущую. **Дополнительных изменений не нужно.**

---

## Шаг 4. Анимация отката — карточка появляется с обратной стороны

**Задача:** При откате карточка должна появляться визуально отлично от обычного перехода вперёд, чтобы пользователь понимал, что вернулся назад.

### 4.1. Передать направление перехода через стейт

**Файл:** `lib/feature/tinder_test/domain/bloc/tinder_test_state.dart`

Добавить поле `isUndo` в `inProgress`:
```dart
const factory TinderTestState.inProgress({
  required TestSession session,
  required CardEntity currentCard,
  @Default(false) bool isUndo,
}) = TinderTestState$InProgress;
```

**Файл:** `lib/feature/tinder_test/domain/bloc/tinder_test_bloc.dart`

В `_onDiscard` передавать `isUndo: true`:
```dart
emit(TinderTestState.inProgress(
  session: previousSession,
  currentCard: previousSession.currentCard!,
  isUndo: true,
));
```

В `_handleSwipe` (строка 127) — **не менять**, `isUndo` по умолчанию `false`.

**После изменения:** Запустить `make gen-all` (freezed-класс, нужна перегенерация).

### 4.2. Анимация в UI

**Файл:** `lib/feature/tinder_test/presentation/tinder_test_view.dart`

В `_TestContent` получить `isUndo` из виджета и передать во view:

1. Добавить параметр `isUndo` в `_TestContent`:
```dart
class _TestContent extends StatefulWidget {
  final TestSession session;
  final CardEntity currentCard;
  final bool isUndo;
  final ITinderTestViewModel viewModel;

  const _TestContent({
    required this.session,
    required this.currentCard,
    required this.isUndo,
    required this.viewModel,
  });
```

2. В `TinderTestView.build` (строка 48) передать `isUndo`:
```dart
TinderTestState$InProgress(:final session, :final currentCard, :final isUndo) =>
  _TestContent(
    session: session,
    currentCard: currentCard,
    isUndo: isUndo,
    viewModel: viewModel,
  ),
```

3. В `_TestContentState` — использовать `AnimatedSwitcher` или `SlideTransition` для обертки карточки. При `isUndo` — анимация слайда справа-налево (карточка прилетает слева), при обычном переходе — без дополнительной анимации (swipe-анимация уже обеспечивает визуальный переход):

В `didUpdateWidget` добавить проверку направления:
```dart
@override
void didUpdateWidget(_TestContent oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.currentCard.id != widget.currentCard.id) {
    _showAnswer.value = false;
    _enableFlipAnimation.value = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _enableFlipAnimation.value = true;
      }
    });
  }
}
```
Этот код не меняется — анимация отката будет реализована через `SwipeableCardWrapper`.

**Файл:** `lib/uikit/question_card/swipable_card_wrapper.dart`

Вариант реализации: при изменении карточки (в `didUpdateWidget`) запускать входную анимацию. Добавить параметр `enterFromLeft` в `SwipeableCardWrapper`:

```dart
class SwipeableCardWrapper extends StatefulWidget {
  // ... существующие поля ...
  final bool enterFromLeft;
  // ...
}
```

В `_SwipeableCardWrapperState.didUpdateWidget`:
```dart
@override
void didUpdateWidget(SwipeableCardWrapper oldWidget) {
  super.didUpdateWidget(oldWidget);
  if (oldWidget.card.id != widget.card.id && widget.enterFromLeft) {
    // Карточка появляется слева (откат)
    final screenWidth = MediaQuery.of(context).size.width;
    _dragOffset.value = Offset(-screenWidth, 0);
    _animateBack();
  }
}
```

В `_TestContent.build` передать `enterFromLeft: widget.isUndo` в `SwipeableCardWrapper`.

---

## Шаг 5. Статистика — колонка `total_shown`

### 5.1. Миграция схемы БД

**Файл:** `lib/feature/question_stats/data/database/question_stats.drift`

Добавить колонку:
```sql
CREATE TABLE question_stats (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  question_key TEXT NOT NULL UNIQUE,
  front_text TEXT NOT NULL,
  back_text TEXT NOT NULL,
  streak INTEGER NOT NULL DEFAULT 0,
  total_correct INTEGER NOT NULL DEFAULT 0,
  total_incorrect INTEGER NOT NULL DEFAULT 0,
  total_shown INTEGER NOT NULL DEFAULT 0,
  last_answered_at DATETIME,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
) AS QuestionStatsDatabaseDto;
```

### 5.2. Миграция в `AppDatabase`

**Файл:** `lib/persistence/database/app_database.dart`

1. Поднять `schemaVersion` до `3` (строка 25):
```dart
@override
int get schemaVersion => 3;
```

2. Добавить миграцию `from < 3` в `onUpgrade` (после строки 40):
```dart
onUpgrade: (m, from, to) async {
  if (from < 2) {
    await m.createTable(questionStats);
    await customStatement(
      'CREATE INDEX IF NOT EXISTS idx_question_stats_streak '
      'ON question_stats(streak)',
    );
  }
  if (from < 3) {
    await customStatement(
      'ALTER TABLE question_stats ADD COLUMN total_shown INTEGER NOT NULL DEFAULT 0',
    );
    await customStatement(
      'UPDATE question_stats SET total_shown = total_correct + total_incorrect',
    );
  }
},
```

### 5.3. Обновить `upsertStat` — инкрементировать `total_shown`

**Файл:** `lib/feature/question_stats/data/database/question_stats_database.dart`

В методе `upsertStat` (строка 27):

**При обновлении существующей записи** (внутри `if (existing != null)`, строка 36), добавить:
```dart
totalShown: Value(existing.totalShown + 1),
```

**При создании новой записи** (внутри `else`, строка 52), добавить:
```dart
totalShown: const Value(1),
```

### 5.4. Обновить entity и converter

**Файл:** `lib/feature/question_stats/domain/entity/question_stats_entity.dart`

Добавить поле `totalShown` в freezed-класс:
```dart
required int totalShown,
```

**Файл:** `lib/feature/question_stats/data/converters/question_stats_converter.dart`

Обновить конвертер, добавить маппинг `totalShown: dto.totalShown`.

**После изменений:** Запустить `make gen-all`.

---

## Шаг 6. Локализация — добавить строку для tooltip кнопки

**Файл:** `lib/l10n/app_en.arb`

Добавить после `tinderTestKnownBadge`:
```json
"tinderTestUndoTooltip": "Undo last answer",
```

**Файл:** `lib/l10n/app_ru.arb`

Добавить после `tinderTestKnownBadge`:
```json
"tinderTestUndoTooltip": "Отменить последний ответ",
```

**После изменений:** Запустить `make gen-l10n`.

---

## Порядок выполнения

1. **Шаг 5** — БД: schema drift, миграция, upsertStat, entity, converter
2. **Шаг 1** — `TestSession.canUndo`
3. **Шаг 2** — BLoC: `_onDiscard`
4. **Шаг 4.1** — Стейт: `isUndo` в `TinderTestState.inProgress`
5. `make gen-all` (перегенерировать freezed + drift)
6. **Шаг 6** — Локализация + `make gen-l10n`
7. **Шаг 3** — UI: кнопка `_UndoButton` в `_TestContent`
8. **Шаг 4.2** — Анимация отката в `SwipeableCardWrapper`
9. `make analyze-dart` — проверить линтер

---

## Файлы, которые будут изменены

| Файл | Изменение |
|---|---|
| `lib/feature/tinder_test/domain/entity/test_session.dart` | Добавить `canUndo`, обновить `previous` |
| `lib/feature/tinder_test/domain/bloc/tinder_test_bloc.dart` | Исправить `_onDiscard` |
| `lib/feature/tinder_test/domain/bloc/tinder_test_state.dart` | Добавить `isUndo` в `inProgress` |
| `lib/feature/tinder_test/presentation/tinder_test_view.dart` | Добавить `_UndoButton`, передать `isUndo` |
| `lib/uikit/question_card/swipable_card_wrapper.dart` | Добавить `enterFromLeft`, входная анимация |
| `lib/feature/question_stats/data/database/question_stats.drift` | Добавить колонку `total_shown` |
| `lib/persistence/database/app_database.dart` | Миграция v2→v3 |
| `lib/feature/question_stats/data/database/question_stats_database.dart` | `upsertStat`: инкремент `total_shown` |
| `lib/feature/question_stats/domain/entity/question_stats_entity.dart` | Добавить поле `totalShown` |
| `lib/feature/question_stats/data/converters/question_stats_converter.dart` | Маппинг `totalShown` |
| `lib/l10n/app_en.arb` | Строка `tinderTestUndoTooltip` |
| `lib/l10n/app_ru.arb` | Строка `tinderTestUndoTooltip` |

---

## Граничные случаи

- **Откат на первом вопросе** — `canUndo == false`, кнопка неактивна (`onPressed: null`), BLoC игнорирует событие
- **Множественный откат до первого вопроса** — ограничение через `canUndo`, кнопка станет неактивной при `currentIndex == 0`
- **Откат во время swipe-анимации** — swipe-анимация вызывает callback только после завершения (`_animateOut → .then(callback)`), поэтому BLoC получит событие swipe перед discard. Если пользователь нажмёт undo во время анимации, swipe завершится, состояние обновится, и только потом обработается discard — **корректно**
- **Откат не влияет на `total_shown`** — считается только финальный результат сессии, удалённые из `results` ответы не попадают в `_saveStats`
- **`isUndo` сбрасывается при следующем swipe** — поле `@Default(false)`, при создании нового `inProgress` в `_handleSwipe` значение будет `false`
