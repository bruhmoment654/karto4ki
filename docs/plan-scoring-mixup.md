# План: Скоринговый алгоритм подмешивания вопросов

## Обзор

Создать новый сервис подмешивания (`ScoringMixupService`) на основе скоринговой модели, извлечь общий интерфейс `IQuestionMixupService`, добавить настройку выбора алгоритма в `SettingsDto` / `MixupBloc` и UI переключатель.

---

## Шаг 1. Интерфейс `IQuestionMixupService`

**Файл:** `lib/feature/tinder_test/domain/mixup/i_question_mixup_service.dart`

```dart
abstract interface class IQuestionMixupService {
  Future<List<CardEntity>> getMixupCards({
    required int testId,
    required List<CardEntity> mainCards,
    required int mixupMin,
    required int mixupMax,
  });
}
```

**Изменения в существующем сервисе:**
- `lib/feature/tinder_test/domain/mixup/question_mixup_service.dart` — добавить `implements IQuestionMixupService`

---

## Шаг 2. Enum алгоритма подмешивания

**Файл:** `lib/feature/tinder_test/domain/mixup/mixup_algorithm.dart`

```dart
enum MixupAlgorithm {
  /// Оригинальный алгоритм: две ветки сортировки (streak / lastShown).
  classic,

  /// Скоринговый алгоритм: единый score по нескольким факторам.
  scoring,
}
```

---

## Шаг 3. `ScoringMixupService`

**Файл:** `lib/feature/tinder_test/domain/mixup/scoring_mixup_service.dart`

Реализует `IQuestionMixupService`. Логика получения кандидатов (группы → тесты → карточки → фильтрация дубликатов) — **идентична** `QuestionMixupService`, поэтому:

### Вариант A (рекомендуемый): вынести общую логику в приватный хелпер

**Файл:** `lib/feature/tinder_test/domain/mixup/mixup_candidate_loader.dart`

```dart
class MixupCandidateLoader {
  final ICardRepository _cardRepository;
  final GroupsDatabase _groupsDatabase;
  final IQuestionStatsRepository _questionStatsRepository;

  /// Загружает карточки-кандидаты и их статистику.
  Future<MixupCandidates> loadCandidates({
    required int testId,
    required List<CardEntity> mainCards,
  }) async { ... }
}

class MixupCandidates {
  final List<CardEntity> cards;
  final Map<String, QuestionStatsEntity> statsMap;
}
```

Оба сервиса (`QuestionMixupService` и `ScoringMixupService`) принимают `MixupCandidateLoader` и делегируют ему загрузку кандидатов, оставляя себе только **логику сортировки/скоринга**.

### Скоринговая модель

Для каждого кандидата вычисляется `score` (чем выше — тем приоритетнее):

```
score = W_streak  * streakFactor
      + W_decay   * decayFactor
      + W_new     * newFactor
      + W_freq    * frequencyFactor
      + noise
```

| Фактор | Формула | Что делает |
|---|---|---|
| `streakFactor` | `clamp(-streak / 5, 0, 1)` при streak < 0, иначе 0 | Приоритет сложных вопросов (отрицательный streak) |
| `decayFactor` | `clamp(daysSince(lastShownAt) / 30, 0, 1)`, null → 1.0 | Приоритет давно не показанных / никогда не показанных |
| `newFactor` | `1 - clamp(totalShown / 5, 0, 1)` | Приоритет малоизученных вопросов (< 5 показов) |
| `frequencyFactor` | `totalShown > 0 ? totalIncorrect / totalShown : 0.5` | Приоритет вопросов с высоким % ошибок |
| `noise` | `random.nextDouble() * 0.05` | Лёгкая рандомизация (±5%) |

**Веса (константы):**
```dart
static const _wStreak = 0.35;
static const _wDecay  = 0.30;
static const _wNew    = 0.20;
static const _wFreq   = 0.15;
```

**Сортировка:** кандидаты сортируются по убыванию score, берутся первые `count` штук.

---

## Шаг 4. Настройки — `SettingsDto`

**Файл:** `lib/persistence/settings/data/settings_dto.dart`

Добавить поле:

```dart
final MixupAlgorithm mixupAlgorithm; // default: MixupAlgorithm.classic
```

`MixupAlgorithm` нужно будет сериализовать — `json_serializable` поддерживает enum'ы из коробки.

После изменения — запустить `make gen-all`.

---

## Шаг 5. `MixupBloc` — расширение состояния

**Файл:** `lib/feature/mixup/domain/bloc/mixup_bloc.dart`

### State
Добавить в `MixupState`:
```dart
@Default(MixupAlgorithm.classic) MixupAlgorithm algorithm,
```

### Event
Добавить событие:
```dart
const factory MixupEvent.algorithmChanged({
  required MixupAlgorithm algorithm,
}) = _MixupEvent$AlgorithmChanged;
```

### Bloc
- Инициализация: читать `settingsStorage.get().mixupAlgorithm`
- Обработчик `_onAlgorithmChanged`: emit + save
- `_saveSettings`: добавить параметр `MixupAlgorithm? algorithm`

После изменения — запустить `make gen-all` (freezed).

---

## Шаг 6. DI — передача сервиса через `TinderTestFlow`

**Файл:** `lib/feature/tinder_test/presentation/tinder_test_flow.dart`

Сейчас `QuestionMixupService` создаётся прямо в `wrappedRoute`. Изменения:

1. Читать текущий `MixupBloc.state.algorithm` из `scope.mixupBloc`
2. Создавать `MixupCandidateLoader` (общий)
3. В зависимости от `algorithm`:
   - `MixupAlgorithm.classic` → `QuestionMixupService(candidateLoader: loader)`
   - `MixupAlgorithm.scoring` → `ScoringMixupService(candidateLoader: loader)`
4. Передавать как `IQuestionMixupService` в `TinderTestBloc`

**Файл:** `lib/feature/tinder_test/domain/bloc/tinder_test_bloc.dart`

Заменить тип поля:
```dart
// было:
final QuestionMixupService? _mixupService;
// стало:
final IQuestionMixupService? _mixupService;
```

---

## Шаг 7. UI — переключатель алгоритма

**Файл:** `lib/feature/group_detail/presentation/group_detail_view.dart`

Добавить виджет `_MixupAlgorithmSelector` — сегментированная кнопка (SegmentedButton) или выпадающий список с двумя вариантами:
- «Классический» (`MixupAlgorithm.classic`)
- «Умный» (`MixupAlgorithm.scoring`)

Показывать его внутри `AnimatedCrossFade` вместе с `_MixupRangeSlider`, только когда mixup включён.

При выборе — отправлять `MixupEvent.algorithmChanged(algorithm: ...)` в `MixupBloc`.

---

## Шаг 8. Локализация

Добавить строки в ARB-файлы:
- `groupDetailMixupAlgorithm` — «Алгоритм подмешивания»
- `groupDetailMixupAlgorithmClassic` — «Классический»
- `groupDetailMixupAlgorithmScoring` — «Умный»
- (опционально) описания-подсказки для каждого алгоритма

Запустить `make gen-l10n`.

---

## Шаг 9. Кодогенерация и проверка

1. `make gen-all` — для `settings_dto.g.dart`, `mixup_bloc.freezed.dart`, `mixup_algorithm`
2. `make gen-l10n` — для локализации
3. `fvm flutter analyze` — проверка линтера
4. Ручная проверка: включить mixup → выбрать алгоритм → пройти тест → убедиться, что подмешанные вопросы соответствуют ожиданиям

---

## Итоговая структура файлов

```
lib/feature/tinder_test/domain/mixup/
├── i_question_mixup_service.dart      ← НОВЫЙ (интерфейс)
├── mixup_algorithm.dart               ← НОВЫЙ (enum)
├── mixup_candidate_loader.dart        ← НОВЫЙ (общая логика загрузки)
├── question_mixup_service.dart        ← ИЗМЕНЁН (implements интерфейс, использует loader)
└── scoring_mixup_service.dart         ← НОВЫЙ (скоринговый алгоритм)

lib/persistence/settings/data/
├── settings_dto.dart                  ← ИЗМЕНЁН (+mixupAlgorithm)
└── settings_dto.g.dart                ← ПЕРЕГЕНЕРИРОВАН

lib/feature/mixup/domain/bloc/
├── mixup_bloc.dart                    ← ИЗМЕНЁН (+algorithmChanged, +algorithm в state)
├── mixup_event.dart                   ← ИЗМЕНЁН (+algorithmChanged)
├── mixup_state.dart                   ← ИЗМЕНЁН (+algorithm)
└── mixup_bloc.freezed.dart            ← ПЕРЕГЕНЕРИРОВАН

lib/feature/tinder_test/domain/bloc/
├── tinder_test_bloc.dart              ← ИЗМЕНЁН (тип IQuestionMixupService)
└── tinder_test_bloc.freezed.dart      ← БЕЗ ИЗМЕНЕНИЙ

lib/feature/tinder_test/presentation/
└── tinder_test_flow.dart              ← ИЗМЕНЁН (фабрика сервисов по алгоритму)

lib/feature/group_detail/presentation/
└── group_detail_view.dart             ← ИЗМЕНЁН (+_MixupAlgorithmSelector)

l10n/
├── app_ru.arb                         ← ИЗМЕНЁН (+строки)
└── app_en.arb                         ← ИЗМЕНЁН (+строки)
```

---

## Порядок реализации

1. `mixup_algorithm.dart` — enum
2. `i_question_mixup_service.dart` — интерфейс
3. `mixup_candidate_loader.dart` — общая логика
4. `scoring_mixup_service.dart` — новый сервис
5. `question_mixup_service.dart` — рефакторинг (implements + loader)
6. `settings_dto.dart` → `make gen-all`
7. `mixup_bloc.dart` / `mixup_event.dart` / `mixup_state.dart` → `make gen-all`
8. `tinder_test_bloc.dart` — смена типа
9. `tinder_test_flow.dart` — фабрика
10. ARB-файлы → `make gen-l10n`
11. `group_detail_view.dart` — UI
12. `fvm flutter analyze` — финальная проверка
