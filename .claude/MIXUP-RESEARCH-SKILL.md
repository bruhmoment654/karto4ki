# Исследование: переработка формулы scoring для mixup

Контекст и результаты исследования по перераспределению весов в scoring-алгоритме подмешивания карточек. Документ нужен чтобы при потере контекста (или при передаче новому агенту) можно было сразу понять: что было, что сделали, почему, что ещё не сделано.

**Период проведения:** май 2026.
**Snapshot данных:** `question_stats_20260515_182108.csv` (624 stats, 23 active days за 66 календарных), `cards_20260515_182108.csv` (299 cards).

## Постановка задачи

Пользователь играет тесты с включенным mixup и видит, что:
1. В подмешивание часто попадают новые карточки (n_shown ≤ 3, positive streak).
2. **Хорошо знаемые карточки** (которые юзер давно выучил) почти никогда не попадают в mixup.
3. Хотелось бы повысить им частоту на ~20%.

Гипотеза пользователя сначала формулировалась как «добавить фактор от `last_shown_at`». Но `decay_factor` уже это делает — `min(days_since_last_shown / 30, 1)`. Значит проблема не в недостающем факторе, а в том как существующая формула баллансирует.

## Что обнаружили

### Главное открытие — well-learned cohort в хвосте ранга

Найдено **32 карточки** с `streak ≥ 3 ∧ total_shown ≥ 5 ∧ accuracy ≥ 0.8`. Их позиция в глобальном ранге по `score_no_noise`: **median 595 из 624**. Лучший из них — на 572-м месте.

Причина: при `streak ≥ 5` контрибуция `streak_contribution = -0.35 × 1.0 = -0.35`. Это **больше** чем максимальный вклад `decay_factor` (`0.30 × 1.0 = +0.30`). То есть **математически невозможно** чтобы well-learned попал в положительную зону score, пока streak penalty не «остынет». А он не остывает — `streak_contribution` не зависит от давности.

Параллельно: `active_days_since_last_shown` у этой когорты = 0-1, потому что они продолжают показываться в «домашнем» тесте (где живёт карточка). Чтобы они «состарились», нужно перестать играть их домашний тест 7-10 активных дней.

### Что юзер реально видел

«Новые часто попадаются» — это правда: 6 из топ-10 пула — карточки с streak +1..+2 и n_shown=2-3, у которых score ~0.27 за счёт `decay_factor + new_factor`. Это не баг, это работающая формула.

«Старые с большим streak редко» — это проявление вышеописанного — well-learned буквально невозможно вытянуть из хвоста при текущей формуле.

### Корреляции компонентов score (по пулу 181)

```
                     streak  decay  new    freq
streak_contribution    1.00   0.16   0.23   0.59
decay_factor                  1.00   0.62  -0.26
new_factor                           1.00  -0.53
frequency_factor                            1.00
```

Сильные пары:
- `streak × freq` = 0.59 — оба про «знаешь ли сейчас».
- `decay × new` = 0.62 — оба про «давно/мало видел».

Юзер счёл 0.62 недостаточным для merge — оставили факторы как есть. Структурно факторы НЕ дублируются полностью (карточка с n_shown=20, last_shown=вчера: decay=0, new=0).

## Что сделали (внедрено в Dart)

Сводный plan: [plans/04_multiplicative_streak_decay.md](../plans/04_multiplicative_streak_decay.md).

Две формулы изменены:

### 1. decay_factor от active days, не calendar days

Активный день = уникальная дата в SET `last_answered_at` всех вопросов в БД. На текущих данных: 23 активных дня за 66 календарных (юзер учится ~раз в 3 календарных дня).

Старое: `min(calendar_days_since_last_shown / 30, 1)`
Новое: `min(active_days_since_last_shown / 10, 1)`

Параметр `N=10` — захардкожен как `kActiveDaysCap` в [scoring_calculator.dart](../lib/feature/tinder_test/domain/mixup/scoring_calculator.dart). Не вынесён в SettingsDto (sensitivity показала: N=5 и N=14 дают ноль well-learned в top-20, sweet-spot узкий).

### 2. Multiplicative streak decay (асимметричный)

Penalty за **положительный** streak затухает с decay:

Старое: `streak > 0: -w_pos × min(streak/5, 1)`
Новое: `streak > 0: -w_pos × min(streak/5, 1) × (1 - decay_factor)`

Бонус за **отрицательный** streak оставлен как был — «плохо знаю» актуально и через месяц без показа.

```dart
// scoring_calculator.dart — после изменений
если streak < 0:  +w_neg × min(-streak/5, 1)
если streak > 0:  -w_pos × min(streak/5, 1) × (1 - decay_factor)
иначе:            0
score = streak_contribution + w_decay × decay_factor + w_new × new_factor + w_freq × frequency_factor
```

### Изменённые файлы (внедрение)

| Файл | Что |
|---|---|
| [scoring_calculator.dart](../lib/feature/tinder_test/domain/mixup/scoring_calculator.dart) | `kActiveDaysCap=10`, новая формула, `ScoreComponents.activeDaysSinceLastShown` |
| [question_stats_database.dart](../lib/feature/question_stats/data/database/question_stats_database.dart) | `getActiveDates()` — distinct dates from `last_answered_at` |
| [mixup_candidate_loader.dart](../lib/feature/tinder_test/domain/mixup/mixup_candidate_loader.dart) | загружает activeDates 1 раз, кладёт в `MixupCandidates.activeDates` |
| [scoring_mixup_service.dart](../lib/feature/tinder_test/domain/mixup/scoring_mixup_service.dart) | пробрасывает `activeDates` в калькулятор |
| [tinder_test_flow.dart](../lib/feature/tinder_test/presentation/tinder_test_flow.dart) | DI: передаёт `questionStatsDatabase` в loader |
| [stats_export_service.dart](../lib/feature/question_stats/data/service/stats_export_service.dart) | в CSV: `active_days_since_last_shown`, `total_active_days`, `n_active_days_cap` |

`fvm flutter analyze` — без новых ошибок (1 preexisting info в нетронутом файле).

## Калибровка (откуда взялись цифры)

### N=10 — sensitivity

Sensitivity matrix `w_decay × N`, метрика A = «well-learned в top-20 при ads=10» (из 32):

```
            N=5   N=7   N=10  N=12  N=14
w_decay=0.20    0     1    14     0     0
w_decay=0.25    0     1    14     0     0
w_decay=0.30    0     5    15     7     0
w_decay=0.35    0    15    15    14     0
w_decay=0.40    0    16    16    14     1
```

**N=10 — единственное значение где `w_decay=0.20-0.25` стабильно даёт 14-15.** Это означает: формула наименее чувствительна к выбору `w_decay` именно при N=10. Не выносить N в настройки — юзер легко может поставить N=5 или N=14 и сломать.

### Веса не трогаем

Sweet-spot search (max A с ограничениями C≥4 и D≤0.65):

| config | well-learned@ads=10 | streak<0 в top-20 | mean_accuracy |
|---|---|---|---|
| **w_decay=0.30, N=10** (текущий) | 15 | 4 | 0.643 |
| w_decay=0.35, N=10 | 15 | 4 | 0.643 |
| w_decay=0.40, N=10 | 16 | 4 | 0.643 |

Текущие веса уже находятся в sweet-spot. Изменять не надо.

## Проверка робастности

Подробный отчёт: [analysis/simulation-report.md](../analysis/simulation-report.md).

- **Cold-start** (26 карточек в `cards.csv` без статы): score не меняется (детерминированно 0.575).
- **Новые с streak 1-2, n_shown≤3** (165 шт): max abs дельта 0.14, mean 0.05. Регрессов нет.
- **streak < 0** (115 шт): max abs дельта 0.08, mean 0.03. Меняется только из-за перехода calendar→active days в decay.
- **Pearson(score_old, score_new) = 0.986** — общая сортировка сохраняется, отличия концентрированы на хвостах.
- **Future-state (через 10 active days без показа well-learned)**: 15/32 well-learned попадают в top-20. ✓
- **Симметрия streak в top-20** на текущих ads: распределение почти не меняется (perskew нет).
- **Пустые active_dates** (свежая БД): не падает. decay=0 для всех, поведение разумное.

## Ожидаемый эффект и риски

### Что юзер увидит сразу
Почти ничего. Pearson(old, new) = 0.986 — сортировка топа не меняется на текущих ads.

### Что юзер увидит со временем
Когда well-learned «состарятся» (active_days_since ≥ 7-10 = ~3 календарных недели при текущем темпе) — они начнут попадать в подмешивание. **Это и есть желаемый эффект.**

### Главные риски
1. Юзер может НЕ увидеть эффекта первые 2-3 недели после релиза и решить что изменения не работают. Стоит предупредить или сделать измерение «было / стало» через месяц.
2. `N=10` — на узкой «полке». Если позже понадобится крутить — менять только осторожно (предварительно прогонять симуляцию на свежих данных).
3. `ads` считается из `last_answered_at` DISTINCT. Если карточки массово удалят, `active_dates` сжимается → может временно скакнуть. Долгосрочно: завести отдельную таблицу `app_sessions(date)`.

## Что НЕ сделали (опционально на будущее)

1. **Отдельная таблица `app_sessions`** — текущий метод (union `last_answered_at`) даёт хорошее приближение, но недосчитывает дни когда юзер открыл приложение, но не ответил.
2. **`N` в SettingsDto** — sensitivity показала что не стоит, но может появиться запрос.
3. **Эксперимент с альтернативой `new_factor`** — на данных юзера фактор почти не работает (max=0.6 в пуле, медиана 0.4). Возможно стоит поднять порог с n_shown=5 до n_shown=10. Не реализовывали — выходит за scope текущей задачи.
4. **Корреляции `streak × freq = 0.59`** — оставлено как есть. Если потом окажется проблема — рассмотреть merge.

## Артефакты исследования

| Файл | Назначение |
|---|---|
| [plans/04_multiplicative_streak_decay.md](../plans/04_multiplicative_streak_decay.md) | Подробный план внедрения (был дан агенту-имплементатору) |
| [analysis/SIMULATION-PLAN.md](../analysis/SIMULATION-PLAN.md) | План симуляций (6 этапов проверки) |
| [analysis/simulation-report.md](../analysis/simulation-report.md) | Полный отчёт по симуляциям с цифрами |
| [analysis/stats.ipynb](../analysis/stats.ipynb) | Notebook с графиками, sensitivity и diff-анализом |
| [.claude/STATS-ANALYSIS-SKILL.md](STATS-ANALYSIS-SKILL.md) | Словарь колонок CSV-экспорта + формулы для pandas |

## Как продолжить исследование

1. **Через 2-3 недели** — сделать новый экспорт. Проверить что well-learned cohort начала появляться в `cards.csv` mixup-выбора. Можно проверить через визуальный осмотр в-течение-сессии или добавить mini-логгер mixup в `TinderTestBloc`.
2. **Если эффект слишком слабый** — поднять `w_decay` до 0.35-0.40 (sensitivity показывает 16 well-learned в top-20 при w_decay=0.40).
3. **Если эффект слишком сильный** — well-learned доминируют → уменьшить `kActiveDaysCap` (но не ниже 8 — N=5 даёт 0).
4. **Если хочется data-driven подход** — добавить таблицу sessions и считать active days честно. Стало бы важно если юзер начнёт открывать приложение без ответов (например, просматривает прогресс).

## Текущие веса (на момент исследования)

`w_streak_negative=0.5, w_streak_positive=0.35, w_decay=0.30, w_new=0.20, w_freq=0.15`

Юзер поднял `w_streak_negative` с дефолта 0.35 → 0.5 ранее. Остальное — дефолт. Это видно в каждой строке экспорта (колонки `w_*`).
