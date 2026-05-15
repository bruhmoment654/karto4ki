# Multiplicative streak decay + active days

## Цель

Решить проблему: well-learned карточки (streak ≥ 3, n_shown ≥ 5, accuracy ≥ 0.8) **никогда** не попадают в mixup при текущей формуле — `streak_contribution = -0.35` всегда побивает `decay_factor × 0.30`. Они сидят в хвосте ранкинга (median rank 595/624).

Решение:
1. **Active days** вместо calendar days в `decay_factor`.
2. **Penalty за положительный streak затухает** с давностью: после `N` активных дней без показа — 0.

Калибровано симуляцией: при N=10 половина well-learned (14 из 32) попадает в top-20 после 10 активных дней без показа. См. [analysis/stats.ipynb](../analysis/stats.ipynb) (ячейки 6.x).

## Изменения формулы

В [scoring_calculator.dart](../lib/feature/tinder_test/domain/mixup/scoring_calculator.dart):

```
БЫЛО:
  decay_factor = min(days_since_last_shown / 30, 1)
  если streak < 0:  +w_neg × min(-streak/5, 1)
  если streak > 0:  -w_pos × min(streak/5, 1)
  иначе:            0

СТАЛО:
  active_days_since_last_shown = |{ d in activeDates : d > last_shown_at.date() }|
  decay_factor = min(active_days_since_last_shown / 10, 1)
  если streak < 0:  +w_neg × min(-streak/5, 1)                  # не меняется
  если streak > 0:  -w_pos × min(streak/5, 1) × (1 - decay_factor)
  иначе:            0
score = streak_contribution + w_decay × decay_factor + w_new × new_factor + w_freq × frequency_factor
```

Negative streak бонус НЕ трогаем — «плохо знаю» актуально всегда.
`new_factor` и `frequency_factor` — без изменений.

`N = 10` — хардкод-константа `kActiveDaysCap` в калькуляторе. Не выносить в SettingsDto.

## Что менять (по файлам)

### 1. [lib/feature/tinder_test/domain/mixup/scoring_calculator.dart](../lib/feature/tinder_test/domain/mixup/scoring_calculator.dart)
- Добавить `static const int kActiveDaysCap = 10;`.
- Сигнатура `ScoringCalculator.components` принимает `Set<DateTime> activeDates` (даты нормализованные до `dateOnly`, то есть time = 00:00).
- Вычислять `activeDaysSinceLastShown` = count of `activeDates` где `date > lastShownAt.dateOnly`. Для `lastShownAt == null` использовать `kActiveDaysCap` (cold-start → max decay).
- Заменить `decay_factor` на `min(activeDaysSinceLastShown / kActiveDaysCap, 1.0)`.
- Для `streak > 0`: умножить вклад на `(1 - decay_factor)`.

### 2. [lib/feature/question_stats/data/database/question_stats_database.dart](../lib/feature/question_stats/data/database/question_stats_database.dart)
Добавить метод:
```dart
Future<List<DateTime>> getActiveDates() async {
  // SELECT DISTINCT DATE(last_answered_at) ...
  // возвращает отсортированный список DateTime с time=00:00
}
```

### 3. [lib/feature/tinder_test/domain/mixup/mixup_candidate_loader.dart](../lib/feature/tinder_test/domain/mixup/mixup_candidate_loader.dart)
- На старте `loadCandidates` один раз получить `activeDates`.
- Расширить `MixupCandidates` полем `Set<DateTime> activeDates`.

### 4. [lib/feature/tinder_test/domain/mixup/scoring_mixup_service.dart](../lib/feature/tinder_test/domain/mixup/scoring_mixup_service.dart)
- Передавать `result.activeDates` в `ScoringCalculator.components`.

### 5. [lib/feature/question_stats/data/service/stats_export_service.dart](../lib/feature/question_stats/data/service/stats_export_service.dart)
- Получать `activeDates` через новый метод DAO.
- В CSV `question_stats_*.csv` добавить колонки:
  - `active_days_since_last_shown` — int / пусто
  - `total_active_days` — одно значение на весь файл
  - `n_active_days_cap` — значение константы (10) для воспроизводимости
- Все компоненты (`streak_contribution`, `decay_factor`, `score_no_noise`) — пересчитать через новую формулу (передавая `activeDates` в калькулятор — уже работает).

### 6. [.claude/STATS-ANALYSIS-SKILL.md](../.claude/STATS-ANALYSIS-SKILL.md)
- Обновить описание `decay_factor`: основан на active_days, cap = 10.
- Обновить описание `streak_contribution`: penalty затухает с decay.
- Обновить функцию `recompute_score` в snippets.
- Добавить колонки в словарь.

### 7. [CLAUDE.md](../CLAUDE.md)
- Если есть запись про текущую формулу — обновить. (По состоянию на сейчас прямого описания формулы нет — только линк на skill).

## Не делать

- Не выносить `N` в настройки.
- Не менять negative-streak часть.
- Не трогать `QuestionMixupService` (classic algorithm) — остаётся как есть.
- Не добавлять таблицу `app_sessions` — отдельная задача на будущее.
- Не писать новые юнит-тесты — проект их не использует под эту фичу.

## Verification

- `fvm flutter analyze` — без новых ошибок.
- Ручная проверка edge cases:
  - `lastShownAt = null` → decay = 1, streak_contribution = 0 (streak обычно 0) → cold-start ведёт себя как раньше.
  - Пустой `activeDates` (свежая БД) → активных дней нет → activeDaysSince = 0 для всех → decay = 0 для всех → streak penalty полный. **Это не регресс**: новая БД и так не имеет mixup-кейсов.
  - streak = 0 → streak_contribution = 0 → ok.
  - streak > 0, lastShownAt вчера: activeDates содержит вчерашнюю дату → activeDaysSince = 0 → decay = 0 → penalty полный (как раньше). ✓

## Reporting

После завершения вернуть:
- Список изменённых файлов (с короткими описаниями)
- Скриншот / выжимка вывода `fvm flutter analyze` (хвост 20 строк)
- Любые отклонения от плана + причина
- Незавершённое (если что-то невозможно сделать)
