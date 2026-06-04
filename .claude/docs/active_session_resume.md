# Возобновление последней сессии теста

## Цель

Сохранять активную сессию прохождения теста (tinder-режим) в локальное хранилище, чтобы после закрытия приложения её можно было возобновить с того же места. Точка входа — карточка "Продолжить сессию" на главном экране (`GroupsListView`), над списком групп.

## Текущее состояние

- `TinderTestBloc` ([tinder_test_bloc.dart](../../lib/feature/tinder_test/domain/bloc/tinder_test_bloc.dart)) хранит `TestSession` только в `TinderTestState` (in-memory).
- `TestSession` ([test_session.dart](../../lib/feature/tinder_test/domain/entity/test_session.dart)) — freezed-entity без JSON.
- Карта запуска теста: `TestDetailScreen.onStartTestPressed` → `TinderTestRoute(testId, swapSides, answerIndex, mixup, mixupMin, mixupMax)` ([test_detail_screen.dart:269-289](../../lib/feature/test_detail/presentation/test_detail_screen.dart#L269-L289)).
- В `TinderTestFlow.wrappedRoute` создаются `MixupCandidateLoader` и `mixupService` (classic/scoring), затем `TinderTestBloc` стартует событием `TinderTestEvent.started(...)`.
- Главный экран — `GroupsListView` ([groups_list_view.dart](../../lib/feature/groups_list/presentation/groups_list_view.dart)), `CustomScrollView` со SliverHeader + SliverList групп.
- Persistence-слой: drift БД ([app_database.dart](../../lib/persistence/database/app_database.dart)), `schemaVersion = 7`. Лёгкие настройки — `SettingsStorage` поверх `SharedPreferences`.

## Решение: где хранить

Сохраняем в **drift** (а не в `SharedPreferences`), потому что:

- Запись делается часто (после каждого свайпа/undo) — атомарные drift-апдейты надёжнее перезаписи JSON в SP.
- В сессии могут лежать десятки–сотни карточек-снэпшотов; в БД это нормальный TEXT, в SP — менее опрятно.
- В проекте уже есть устоявшийся паттерн drift + DAO + repository + converter.

Храним **одну** активную сессию (одиночка, `PRIMARY KEY` = константа `1`):

- UX: возобновляется именно «последняя сессия, которую проходил» (запрос пользователя).
- Запуск нового теста → перезаписываем эту единственную запись.
- Завершение теста (`completed`) или явный сброс — удаляем запись.
- Если пользователь вышел из теста по back, не завершив, — запись остаётся; на главной появится карточка «Продолжить».

### Архитектурный задел под web (SharedPreferences)

В будущем проект пойдёт на web, drift будет выпилен, для web потребуется альтернативная имплементация на `shared_preferences` (web build). Чтобы swap был максимально дешёвым, делаем так:

1. **Storage-agnostic интерфейс**. `IActiveSessionRepository` (см. ниже) — единственная точка, через которую domain/UI общается с хранилищем. В будущем создаётся `ActiveSessionPrefsRepository`, реализующий тот же интерфейс, и подменяется в `AppScopeRegister`. Никаких drift-типов наружу из реализации не торчит.

2. **Единый DTO-блоб, а не «плоские колонки»**. Сериализуем всю `ActiveTestSession` целиком в **один** JSON-объект (`ActiveTestSessionDto`, json_serializable, checked: true). Тогда:
   - drift-имплементация хранит этот JSON в **одной TEXT-колонке** (`data`).
   - SP-имплементация хранит **тот же JSON** под одним ключом (`active_session`).
   - Обе имплементации переиспользуют один и тот же DTO + конвертер DTO↔Entity. Меняется только обёртка чтения/записи и источник стрима.

3. **`Stream<ActiveTestSession?>` как контракт реактивности**. Drift отдаёт стрим нативно через `.watch()`; SP-имплементация эмитит через внутренний `BehaviorSubject<ActiveTestSession?>`, в который пушим значение после каждого `save/clear`. UI и `ActiveSessionBloc` про источник не знают.

4. **Никаких drift-типов в `domain/` и `presentation/`**. Companion'ы, Selectable, drift.Stream — только в `data/repository/active_session_repository.dart` и `data/database/...`. При выпиле drift удаляются ровно эти два файла + один блок в DI.

5. **Папка `test_execution`** — изолированный feature-модуль; replace = заменить файл репозитория и переключатель в DI.

### Будущее (НЕ делаем сейчас)

При переходе на web:

- удалить `active_sessions.drift`, `active_sessions_database.dart`, `active_session_repository.dart` (drift-вариант), `daos: [..., ActiveSessionsDatabase]`, миграцию в `app_database.dart`;
- добавить `lib/feature/test_execution/data/repository/active_session_prefs_repository.dart` с тем же `IActiveSessionRepository`, поверх `SharedPreferences` + `BehaviorSubject`;
- в `AppScopeRegister` ветвление по `kIsWeb` (или DI-flavor) — какой репозиторий собрать.

DTO, конвертер, entity, bloc, виджет и UI-встраивание при этом не трогаются.

## Сущности (domain)

### `ActiveTestSession` (новая freezed-entity)

Файл: `lib/feature/test_execution/domain/entity/active_test_session.dart`

```
@freezed
sealed class ActiveTestSession with _$ActiveTestSession {
  const factory ActiveTestSession({
    required TestSession session,            // прогресс и карточки
    required ActiveSessionLaunchParams params, // как тест запускался
    required String testTitle,               // для отображения в карточке "продолжить"
    required DateTime updatedAt,             // момент последнего сохранения
  }) = _ActiveTestSession;
}
```

### `ActiveSessionLaunchParams`

Файл: `lib/feature/test_execution/domain/entity/active_session_launch_params.dart`

```
@freezed
sealed class ActiveSessionLaunchParams with _$ActiveSessionLaunchParams {
  const factory ActiveSessionLaunchParams({
    required bool swapSides,
    required int answerIndex,
    required bool mixup,
    required int mixupMin,
    required int mixupMax,
    required MixupAlgorithm algorithm, // classic / scoring — для возобновления
  }) = _ActiveSessionLaunchParams;
}
```

> Существующие `TestSession` и `CardResult` остаются без изменений; `TestSession` уже содержит `cards`, `currentIndex`, `results`, `startedAt`, `completedAt`.

## DTO

Сериализуем всю сессию в **один** JSON-объект — это упрощает будущий перенос на SharedPreferences (один ключ = один blob). DTO образуют дерево:

- `ActiveTestSessionDto` (json_serializable, checked: true) — корень:
  - `int testId`
  - `String testTitle`
  - `int currentIndex`
  - `DateTime startedAt`
  - `DateTime updatedAt`
  - `List<CardSnapshotDto> cards`
  - `List<CardResultDto> results`
  - `LaunchParamsDto launchParams`
- `CardSnapshotDto` — поля `CardEntity`: id, testId, front, answers, createdAt, updatedAt, isMixedIn.
- `CardResultDto` — поля `CardResult`: cardId, isCorrect, answeredAt.
- `LaunchParamsDto` — поля `ActiveSessionLaunchParams` (включая `MixupAlgorithm` как enum).

Файлы: `lib/feature/test_execution/data/dto/*.dart` + `*.g.dart` (генерируется).

Этот DTO — единая точка сериализации. И drift-имплементация, и будущая SP-имплементация работают через `ActiveTestSessionDto.toJson() / fromJson()`.

## БД (drift)

### Новый .drift-файл

Файл: `lib/feature/test_execution/data/database/active_sessions.drift`

```
CREATE TABLE active_sessions (
  id INTEGER NOT NULL PRIMARY KEY,  -- всегда 1 (singleton)
  data TEXT NOT NULL                -- JSON ActiveTestSessionDto
) AS ActiveSessionDatabaseDto;
```

Намеренно **одна** TEXT-колонка с blob'ом, а не разнесённые поля: это делает swap на SP тривиальным (тот же JSON под ключом).

### DAO

Файл: `lib/feature/test_execution/data/database/active_sessions_database.dart`

```
@DriftAccessor(include: {'.../active_sessions.drift'})
class ActiveSessionsDatabase extends DatabaseAccessor<AppDatabase> with _$ActiveSessionsDatabaseMixin {
  Future<ActiveSessionDatabaseDto?> get()
  Future<void> upsert(String json)           // INSERT OR REPLACE с id=1
  Future<int> clear()
  Stream<ActiveSessionDatabaseDto?> watch()
}
```

### Миграция

В [app_database.dart](../../lib/persistence/database/app_database.dart):

- `schemaVersion = 8`.
- В `daos` добавить `ActiveSessionsDatabase`, в `include` — путь к `.drift`.
- В `onUpgrade` добавить ветку `if (from < 8) await m.createTable(activeSessions);`.

## Конвертер

Файл: `lib/feature/test_execution/data/converter/active_test_session_converter.dart`

`abstract final class ActiveTestSessionConverter` со статическими методами:

- `fromDto(ActiveTestSessionDto) → ActiveTestSession` — мапит вложенные DTO в `CardEntity / CardResult / ActiveSessionLaunchParams` и собирает `TestSession`.
- `toDto(ActiveTestSession) → ActiveTestSessionDto` — обратное преобразование.

Конвертер работает только с **DTO ↔ Entity** и ничего не знает про drift. Drift-имплементация репозитория сериализует `ActiveTestSessionDto.toJson()` в TEXT-колонку; SP-имплементация — в строку под ключом. Обе используют тот же конвертер для DTO↔Entity.

## Репозиторий

### Интерфейс

Файл: `lib/feature/test_execution/domain/repository/i_active_session_repository.dart`

```
abstract interface class IActiveSessionRepository {
  Future<Result<ActiveTestSession?>> getActiveSession();
  Future<Result<void>> saveActiveSession(ActiveTestSession session);
  Future<Result<void>> clearActiveSession();
  Stream<ActiveTestSession?> watchActiveSession();
}
```

### Реализации

Сейчас — только drift. В будущем рядом ляжет SP-вариант, выбор — в DI.

**`ActiveSessionDriftRepository`** (`lib/feature/test_execution/data/repository/active_session_drift_repository.dart`):

- Конструктор: `ActiveSessionsDatabase`, `IErrorLogger`.
- `save`: `dto = ActiveTestSessionConverter.toDto(entity); await dao.upsert(jsonEncode(dto.toJson()));`
- `get` / `watch`: читают TEXT, `jsonDecode → ActiveTestSessionDto.fromJson → конвертер → Entity`.
- Все операции через try/catch + `Result`.

**`ActiveSessionPrefsRepository`** (БУДУЩЕЕ, не пишем сейчас):

- Конструктор: `SharedPreferences`, `IErrorLogger`.
- Один ключ `active_session` → JSON-строка того же `ActiveTestSessionDto`.
- `watch()` — через внутренний `BehaviorSubject<ActiveTestSession?>`, в который пушим после `save/clear`. На старте сидим первым `get()`.

Оба класса реализуют `IActiveSessionRepository`, поэтому всё остальное приложение их не различает.

## Бизнес-логика: TinderTestBloc

### Новые события

В [tinder_test_event.dart](../../lib/feature/tinder_test/domain/bloc/tinder_test_event.dart):

```
const factory TinderTestEvent.resumed({
  required ActiveTestSession active,
}) = _TinderTestEvent$Resumed;
```

### Изменения в bloc

1. В конструктор добавить `required IActiveSessionRepository activeSessionRepository`, сохранить как поле.
2. Обработчик `_onResumed`:
   - Восстановить `_swapSides / _answerIndex / _mixup / _mixupMin / _mixupMax` из `active.params`.
   - Сразу эмитить `TinderTestState.inProgress(session: active.session, currentCard: active.session.currentCard!)`.
3. `_handleSwipe` и `_onDiscard`: после `emit(inProgress(...))` — `unawaited(_persistSession(updatedSession, testTitle))`.
4. `_onStarted`: после создания первой `session` — `_persistSession(session, ...)` (так что даже сразу после старта при kill приложения можно вернуться).
5. `_onCompleted` / завершение в `_handleSwipe` — `unawaited(_activeSessionRepository.clearActiveSession())` после эмита `completed`.
6. `_onRestarted` — без изменений по логике, но новая `_onStarted` уже перезатрёт запись.

### `testTitle`

Чтобы корректно подписывать карточку «Продолжить», передаём `testTitle` в bloc:

- Вариант A: `TinderTestEvent.started` уже знает `testId`; bloc дополнительно делает `testsListRepository.getTestById(testId)` для получения `title` (минимальный коупл).
- Вариант B: `TinderTestFlow` пробрасывает `testTitle` через параметр маршрута. Проще, но требует менять путь `TestDetailScreen → push(TinderTestRoute(...))`.
- **Выбираем A** — меньше точек правки, title живёт в БД, легко достать.

(Требуется добавить `getTestById` в `ITestsListRepository`, если ещё нет — проверить и при необходимости расширить.)

## Возобновление: TinderTestFlow

Файл: [tinder_test_flow.dart](../../lib/feature/tinder_test/presentation/tinder_test_flow.dart)

Добавить опциональный параметр:

```
@RoutePage()
class TinderTestFlow extends ... {
  ...
  final bool resume; // default false

  @override
  Widget wrappedRoute(BuildContext context) {
    final scope = context.read<IAppScope>();
    final activeRepo = scope.activeSessionRepository;
    // mixupService нужен и для resume (если пользователь сделает Restart)
    final algorithm = scope.mixupBloc.state.algorithm;
    ... // как сейчас

    return BlocProvider(
      create: (_) {
        final bloc = TinderTestBloc(
          cardRepository: scope.cardRepository,
          questionStatsRepository: scope.questionStatsRepository,
          mixupService: mixupService,
          activeSessionRepository: activeRepo,
        );
        if (resume) {
          // ActiveTestSession уже подгружен в state главного экрана, но безопаснее
          // снова дёрнуть getActiveSession() здесь, чтобы не зависеть от порядка чтения.
          unawaited(activeRepo.getActiveSession().then((r) => switch (r) {
            ResultOk(:final data) when data != null && data.session.testId == testId.toString() =>
              bloc.add(TinderTestEvent.resumed(active: data)),
            _ => bloc.add(TinderTestEvent.started(testId: testId, swapSides: swapSides, ...)),
          }));
        } else {
          bloc.add(TinderTestEvent.started(testId: testId, swapSides: swapSides, ...));
        }
        return bloc;
      },
      child: this,
    );
  }
}
```

> При возобновлении параметры запуска (`swapSides`, `mixup`, ...) берутся из самой `ActiveTestSession.params`, а не из path-аргументов; параметры в `TinderTestRoute(resume: true)` могут быть проигнорированы (передавать всё равно нужно из-за `@PathParam`).

## Главный экран: карточка «Продолжить»

### Состояние

Нужен реактивный источник, чтобы карточка появлялась/исчезала без ручного refresh.

Варианты:

- **Опция A — отдельный BLoC `ActiveSessionBloc`**, который подписывается на `repo.watchActiveSession()` и хранит `ActiveSessionState.none / .available(ActiveTestSession)`.
- Опция B — `StreamBuilder` прямо в `GroupsListView`.

Выбираем **A** ради единообразия с остальной фичей `groups_list` и тестируемости.

Файлы:

- `lib/feature/test_execution/domain/bloc/active_session_bloc.dart` + `_state.dart` + `_event.dart`.
- Регистрируем в `MainTabFlow` или `GroupsListFlow` через `BlocProvider`. Удобнее в `GroupsListFlow`, т.к. карточка отображается только там.

### Виджет

Файл: `lib/feature/groups_list/presentation/widget/active_session_card.dart`

`ContentCard` со скруглением и тинтом (как обычная группа), содержит:

- иконку «возобновить» (Icons.play_arrow или Icons.restore).
- заголовок `Продолжить: ${activeSession.testTitle}`.
- прогресс-строку: `${currentIndex} из ${cards.length}`, миниатюрный `LinearProgressIndicator` (или AnimatedLinearProgress, чтобы не плодить новые виджеты).
- кнопку-крестик «Отменить» (clear) в углу.
- `ScalePressable` оборачивает карточку, `onTap` → навигация.

### Встраивание в `GroupsListView`

В `_GroupsBody.build` поверх SliverList групп добавляем:

```
BlocBuilder<ActiveSessionBloc, ActiveSessionState>(
  builder: (context, state) => switch (state) {
    ActiveSessionState$Available(:final session) => SliverPadding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      sliver: SliverToBoxAdapter(
        child: ActiveSessionCard(
          session: session,
          onResume: () => context.router.push(TinderTestRoute(
            testId: int.parse(session.session.testId),
            swapSides: session.params.swapSides,
            answerIndex: session.params.answerIndex,
            mixup: session.params.mixup,
            mixupMin: session.params.mixupMin,
            mixupMax: session.params.mixupMax,
            resume: true,
          )),
          onDismiss: () => context.read<ActiveSessionBloc>().add(
            const ActiveSessionEvent.cleared(),
          ),
        ),
      ),
    ),
    _ => const SliverHeight(0),
  },
),
```

Расположение: сразу после `SliverToBoxAdapter` с `AppPageHeader`, до `SliverList` групп.

> По code-style проекта используем `Height` / `SliverHeight` вместо `SizedBox`.

## DI

В [app_scope.dart](../../lib/app/di/app_scope.dart) и [app_scope_register.dart](../../lib/app/di/app_scope_register.dart):

- В `AppScope` + `IAppScope` добавить `IActiveSessionRepository activeSessionRepository` (только интерфейс — реализация наружу не утекает).
- В `AppDatabase` добавить геттер `activeSessionsDatabase` (drift сгенерирует при `daos: [..., ActiveSessionsDatabase]`).
- В `AppScopeRegister.createScope()` создать `ActiveSessionDriftRepository(activeSessionsDatabase: database.activeSessionsDatabase, errorLogger: errorLogger)`.

> **Точка переключения для web.** Когда дойдёт до web — здесь же добавляется ветка (например, `kIsWeb ? ActiveSessionPrefsRepository(prefs, errorLogger) : ActiveSessionDriftRepository(...)`). Никаких других правок в коде делать не придётся, потому что весь остальной код видит только `IActiveSessionRepository`.

## Краевые случаи

| Случай | Поведение |
|---|---|
| Тест удалили, но сессия лежит в кэше | При чтении репозиторий проверяет существование `testId` в `tests` (через `testsListRepository` или дополнительный join в DAO). Если теста нет — `clear()` и возвращаем `null`. |
| Карточки теста изменили (добавили/удалили) | Игнорируем — сессия использует **snapshot** карточек, который сохранён. После завершения старой сессии новый запуск возьмёт актуальные карты. |
| Пользователь нажал Restart на экране результатов | `_onRestarted` дёргает `_onStarted`, тот сохраняет новую сессию (перезатирает старую). |
| Пользователь вышел из теста, не завершив | Запись остаётся. На главной видна карточка «Продолжить». |
| Пользователь начал новый тест без завершения старого | Запись перезаписывается (singleton-схема). |
| Завершение теста (`completed`) | `clearActiveSession()` вызывается **после** `_saveStats`, чтобы пользователь не потерял сессию, если приложение упадёт между ними; впрочем, обе операции независимы — можно параллельно. |

## Порядок реализации (чеклист)

1. [ ] `active_sessions.drift` + DAO + миграция (schemaVersion 8).
2. [ ] DTO: `CardSnapshotDto`, `CardResultDto`, `LaunchParamsDto` (json_serializable).
3. [ ] Entity: `ActiveTestSession`, `ActiveSessionLaunchParams`.
4. [ ] `ActiveSessionConverter`.
5. [ ] `IActiveSessionRepository` + `ActiveSessionRepository`.
6. [ ] DI: расширить `AppScope` / `AppScopeRegister`.
7. [ ] `TinderTestBloc`: новое событие `resumed`, поле `activeSessionRepository`, `_persistSession`, `_clearSession`, вызовы из `_onStarted / _handleSwipe / _onDiscard / _onCompleted`.
8. [ ] `TinderTestFlow`: параметр `resume`, ветвление при создании bloc.
9. [ ] `ActiveSessionBloc` + state + event с подпиской на `watchActiveSession()`.
10. [ ] `ActiveSessionCard` виджет.
11. [ ] Встраивание в `GroupsListView` (sliver-карточка над списком).
12. [ ] `GroupsListFlow`: добавить `BlocProvider<ActiveSessionBloc>`.
13. [ ] Локализация: ключи `groupsListActiveSessionTitle`, `groupsListActiveSessionProgress(current, total)`, `groupsListActiveSessionDismiss` в `lib/l10n/`.
14. [ ] `make gen-all` (freezed + json_serializable + drift + auto_route).
15. [ ] Ручная проверка: запустить тест, свайпнуть несколько карт, kill приложения, открыть — карточка «Продолжить» видна, тап → восстановилось состояние с прогрессом и счётом.

## Что НЕ делаем в этой итерации

- Не сохраняем mixup-кандидатов отдельно — они уже зашиты в `cards` snapshot.
- Не делаем «несколько активных сессий» (по одной на тест) — пользователь явно попросил «последнюю».
- Не делаем экспирацию (TTL) кэша — пусть сессия живёт, пока не завершена или не вытеснена новой.
- Не покрываем тестами в рамках этой задачи (отдельная подзадача при необходимости).
