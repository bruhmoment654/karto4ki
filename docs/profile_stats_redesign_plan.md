# План: редизайн профиля + расширение статистики и стрик

> Источник дизайна: `design_handoff_material_you/screens-profile.jsx`,
> `screens-stats.jsx`, `screens-settings.jsx` (Material You, тёмная/светлая темы).
> Дата составления: 2026-06-05.

## 1. Цель

Доработать блок статистики в **Профиле** и привести экран к дизайну Material You:

- карточка-идентичность (аватар-инициал, счётчики «N групп · M тестов»);
- тап-карточка «Статистика» с тремя кольцами (Точность / Изучено / Без ошибок),
  открывает экран `QuestionStats`;
- карточка **стрика** с числом «дней подряд», рекордом и недельной лентой;
- список настроек (Настройки / Выйти);
- расширенный набор агрегированных метрик.

## 2. Зафиксированные решения

- **Стрик = день активности.** День засчитывается, если решена ≥1 карточка.
  Считаем из уже существующего `QuestionStatsDatabase.getActiveDates()`.
  Отдельный трекинг запусков приложения и app-lifecycle хуки **не нужны**.
- **Добавляемые метрики** (помимо 3 колец):
  1. Текущая / лучшая серия (стрик);
  2. Всего ответов / карточек;
  3. Слабые карточки (низкий/отрицательный streak);
  4. Дней активности / среднее число ответов в день.

## 3. Текущее состояние (что есть / чего нет)

**Есть:**
- `lib/feature/question_stats/` — посписочная статистика по карточкам
  (ok/no/streak/accuracy, поиск, сортировка, CSV-экспорт). Экран `QuestionStats`
  уже близок к `screens-stats.jsx` — серьёзных доработок не требует.
- `QuestionStatsDatabase.getActiveDates()` — отсортированные уникальные даты
  с ≥1 ответом (`last_answered_at`), нормализованные до 00:00.
- `QuestionStatsEntity { streak, totalCorrect, totalIncorrect, totalShown,
  lastAnsweredAt, ... }`, репозиторий `IQuestionStatsRepository.getAllStats()`.
- Счётчики для идентичности: `IGroupsListRepository.getGroups()`,
  `ITestsListRepository.getTests()` (берём `.length`).
- UIKit: `CountUpText`, `WaveFillBar`, `ContentCard`, `AppPageHeader`,
  `ScalePressable`, `StaggeredAppear`, `AppScaffold`.
- Тема/внешний вид уже живут в `settings_view.dart` (как и предполагает дизайн).

**Чего нет:**
- Профиль (`profile_view.dart`) — сейчас одна кнопка «Настройки».
- Агрегированной сводки по всем карточкам.
- Вычисления стрика (current/best) и недельной активности.
- UIKit-компонентов: кольцо-заполнение (`FillRing`) и недельная лента стрика.
- Метода доступа к `getActiveDates()` через репозиторий (он только в БД-слое).

## 4. Доменный слой (новый код в `lib/feature/profile/domain/`)

### 4.1. Entity `ProfileSummaryEntity` (freezed)
`lib/feature/profile/domain/entity/profile_summary_entity.dart`

Поля:
- `int answersTotal` — сумма `totalCorrect + totalIncorrect` по всем карточкам;
- `int correctTotal` — сумма `totalCorrect`;
- `int accuracyPercent` — `round(correctTotal / answersTotal * 100)`, 0 если нет ответов;
- `int totalCards` — `stats.length`;
- `int masteredCount` — карточек со `streak >= kMasteredThreshold` (=3, как в дизайне);
- `int masteredPercent`;
- `int flawlessCount` — `totalIncorrect == 0 && totalShown > 0`;
- `int flawlessPercent`;
- `int weakCardsCount` — `streak < 0` (порог вынести константой `kWeakThreshold`);
- `int currentStreak`, `int bestStreak`;
- `int activeDaysCount`;
- `double avgAnswersPerDay` — `answersTotal / activeDaysCount` (0 если дней нет);
- `List<bool> weekActivity` — 7 значений Пн..Вс текущей недели;
- `int groupsCount`, `int testsCount` — для карточки-идентичности.

После создания → `make gen-all` (freezed).

### 4.2. Калькулятор `ProfileStatsCalculator` (чистые функции, тестируемый)
`lib/feature/profile/domain/profile_stats_calculator.dart`

На вход: `List<QuestionStatsEntity>`, `List<DateTime> activeDates`,
`DateTime today`, `groupsCount`, `testsCount`. На выход: `ProfileSummaryEntity`.

Логика стрика (важно — отдельно покрыть тестами):
- `currentStreak`: нормализуем даты в `Set`. Берём `today`; если его нет в
  множестве — разрешаем вчера (день ещё мог не начаться). Если и его нет → 0.
  Иначе шагаем назад по дням, пока день есть в множестве, считая длину.
- `bestStreak`: проход по отсортированным датам, максимум подряд идущих
  (разница ровно 1 день).
- `weekActivity`: понедельник текущей недели + 7 дней, для каждого — есть ли
  в множестве активных дат.

`today` передаём аргументом (не `DateTime.now()` внутри) — для детерминизма тестов.

## 5. Изменения в data/repository

1. В `IQuestionStatsRepository` добавить
   `RequestOperation<List<DateTime>> getActiveDates();`
   и проксировать на существующий `QuestionStatsDatabase.getActiveDates()`
   в `question_stats_repository.dart`.
2. Профиль агрегирует данные из готовых репозиториев через `IAppScope`
   (`questionStatsRepository`, `groupsListRepository`, `testsListRepository`).
   **Новых таблиц/Drift-миграций не требуется.**

## 6. Presentation: редизайн профиля

Файлы: `lib/feature/profile/presentation/profile_screen.dart` (+ `_view`).
Паттерн как в проекте: `Screen` (StatefulWidget implements `IProfileViewModel`)
+ `View` (StatelessWidget). Загрузка сводки в `initState` через `IAppScope`
(аналогично `QuestionStatsScreen._loadStats`), состояния loading/error/data.

`IProfileViewModel` расширить: `ProfileSummaryEntity? get summary`,
`bool get isLoading`, `Object? get error`, `void onStatsTap()`,
`void onSettingsTap()`, `void onRetryTap()`, (опц.) `void onLogoutTap()`.

`onStatsTap` → переход на `QuestionStatsRoute` (роут уже есть в `app_router.dart`).

Состав `ProfileView` по `screens-profile.jsx` — **только виджеты, без build-методов**
(требование CLAUDE.md), вертикальный список через `ListView`/`CustomScrollView`,
интервалы через `Height`/`SliverHeight` (требование проекта):

1. **Заголовок** «Профиль» (`AppPageHeader` / display-стиль).
2. **`_IdentityCard`** — круг-инициал (primary), имя, подпись
   «`{groupsCount}` групп · `{testsCount}` тестов», chevron.
3. **`_StatsSummaryCard`** — `ScalePressable` → `onStatsTap`. Заголовок
   «Статистика · Подробнее ›», ряд из трёх `FillRing`:
   - Точность — `accuracyPercent`, цвет success, подпись `correctTotal/answersTotal`;
   - Изучено — `masteredPercent`, цвет primary, подпись `masteredCount/totalCards`;
   - Без ошибок — `flawlessPercent`, цвет amber, подпись `flawlessCount/totalCards`.
4. **`_StreakCard`** — иконка `local_fire_department`, «`currentStreak` дней подряд»
   (через `CountUpText`), подпись «Лучшая серия: `bestStreak`», лента `_StreakWeek`.
5. **`_ExtraMetricsCard`** — компактная сетка/строки для добавленных метрик:
   всего ответов, всего карточек, слабые карточки, дней активности,
   среднее в день. «Слабые карточки» — просто счётчик (некликабельный);
   сами карточки пользователь находит через экран `QuestionStats`.
6. **`_SettingsList`** — строка «Настройки» (→ `onSettingsTap`).
   «Выйти» **не делаем** (авторизации в приложении нет) — строку не добавляем.

Пустое состояние (нет ни одной карточки со статистикой): кольца и метрики
показывают нули / приглашение пройти первый тест.

## 7. UIKit — новые переиспользуемые компоненты

Через скилл **create-uikit** (theming, экспорт, golden-тест, Figma-mapping):

1. **`FillRing`** (`lib/uikit/progress/fill_ring.dart`) — кольцо-заполнение:
   conic-подобный прогресс (через `CustomPainter` с `sweepAngle`), внутренний
   диск под цвет карточки, центр — `CountUpText` с `%`. Параметры: `percent`,
   `color`, `label`, `sub`, `animationDelay`. Учесть reduced-motion
   (`AppMotion.reduced`) — без анимации сразу финальное значение.
2. **`StreakWeekStrip`** (`lib/uikit/progress/streak_week_strip.dart`) — 7 чипов
   Пн..Вс: активный день — заполненный кружок с иконкой огня
   (`tertiaryContainer`), неактивный — контур `outlineVariant`. Вход:
   `List<bool> activity` (длина 7) + подписи дней (из локализации).

Обе — с golden-тестами (Alchemist/zoloto, скилл **create-golden-test**).

## 8. Экран статистики (`QuestionStats`)

Текущая реализация уже соответствует `screens-stats.jsx` (поиск по
написанию+переводам, сортировка, цветовые пороги, mini-stats, wave-bar).
Доработки минимальны / опциональны:
- (опц.) добавить компактную сводную «шапку» над списком, переиспользуя те же
  агрегаты из `ProfileStatsCalculator`, если захотим дублировать summary здесь;
- сверить иконки/пороги цветов с дизайном — расхождений по коду не выявлено.

Если сводная шапка не нужна — экран не трогаем.

## 9. Локализация

Новые строки — через скиллы **extract-strings** + **localize** (ARB +
`fvm flutter gen-l10n`). Ключи (черновик):
`profileTitle`, `profileIdentitySubtitle(groups, tests)`,
`profileStatsCardTitle`, `profileStatsCardMore`,
`profileRingAccuracy`, `profileRingMastered`, `profileRingFlawless`,
`profileStreakDays(count)`, `profileStreakBest(count)`,
`profileWeekdayMon..Sun` (или короткие Пн..Вс),
`profileMetricAnswers`, `profileMetricCards`, `profileMetricWeak`,
`profileMetricActiveDays`, `profileMetricAvgPerDay`, `profileLogout`.
Открытый файл `app_localizations_en.dart` — генерируемый, править ARB, не его.

## 10. Кодогенерация

После Entity (freezed) и локализации:
- `make gen-all` (`fvm dart run build_runner build --delete-conflicting-outputs`);
- `make gen-l10n` (`fvm flutter gen-l10n`).
Затем скилл **feedback-loop** (auto-fix + анализ до нуля ошибок).

## 11. Решено / опционально

- **«Выйти» не делаем** — авторизации нет, строку в список настроек не добавляем.
- **«Слабые карточки» — только счётчик** (некликабельный). Отдельный экран
  least-remembered не делаем; пользователь находит слабые карточки через
  `QuestionStats` (сортировка по streak ↑). `getLeastRemembered(limit)` пока
  не задействуем в профиле.
- Порог «изучено» = streak ≥ 3, «слабые» = streak < 0 — вынести константами,
  при желании потом сделать настраиваемыми.

## 12. Порядок работ (этапы)

1. **Домен**: `ProfileSummaryEntity` + `ProfileStatsCalculator` → `make gen-all`.
   Юнит-тесты калькулятора (стрик: пусто / 1 день / разрывы / сегодня-vs-вчера;
   агрегаты; неделя).
2. **Repository**: добавить `getActiveDates()` в интерфейс и реализацию.
3. **UIKit**: `FillRing`, `StreakWeekStrip` (+ golden) через create-uikit.
4. **Presentation**: расширить `IProfileViewModel`, загрузка сводки,
   собрать `ProfileView` из карточек (§6), состояния loading/error/empty.
5. **Локализация**: extract-strings → localize → gen-l10n.
6. **Тесты**: golden профиля (create-golden-test), прогон feedback-loop.
7. (опц.) сводная шапка в `QuestionStats`.

## 13. Чеклист соответствия дизайну

- [ ] 3 кольца с count-up и корректными знаменателями (верные/всего, mastered/всего, flawless/всего)
- [ ] Карточка стрика: текущая серия (count-up), рекорд, недельная лента Пн..Вс
- [ ] Карточка-идентичность со счётчиками групп/тестов
- [ ] Доп. метрики: ответы, карточки, слабые, дни активности, среднее/день
- [ ] Тап по статистике открывает `QuestionStats`
- [ ] Reduced-motion корректно отключает анимации колец/лент
- [ ] Светлая и тёмная темы (цветовые пороги success/amber/error)
- [ ] Интервалы через `Height`/`SliverHeight`, верстка только виджетами
