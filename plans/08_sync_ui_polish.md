# 08. Полировка UI синхронизации

Две задачи:

1. Тап по статусу синхронизации в профиле открывает тот же диалог, что и тап по индикатору на главной.
2. Полоска прогресса синхронизации получает дизайн полоски из статистики (`WaveFillBar`).

## Текущее состояние

| Место | Виджет | Файл |
| --- | --- | --- |
| Главная (шапка) | `SyncStatusBadge` → `showSyncStatusDialog` | [groups_list_view.dart:85](../lib/feature/groups_list/presentation/groups_list_view.dart#L85), [groups_list_screen.dart:44](../lib/feature/groups_list/presentation/groups_list_screen.dart#L44) |
| Профиль | `SyncStatusCard` — тапа нет, только кнопка-действие | [sync_status_card.dart](../lib/feature/sync/presentation/sync_status_card.dart) |
| Полоска на главной | `LinearProgressIndicator` | [groups_list_view.dart:110](../lib/feature/groups_list/presentation/groups_list_view.dart#L110) |
| Полоска в карточке профиля | `LinearProgressIndicator` | [sync_status_card.dart:131](../lib/feature/sync/presentation/sync_status_card.dart#L131) |
| Полоска в диалоге | `LinearProgressIndicator` | [sync_status_dialog.dart:257](../lib/feature/sync/presentation/sync_status_dialog.dart#L257) |
| Эталон дизайна | `WaveFillBar` (волнистый фронт, блик, скруглённый трек) | [wave_fill_bar.dart](../lib/uikit/progress/wave_fill_bar.dart), применение — [question_stats_view.dart:413](../lib/feature/question_stats/presentation/question_stats_view.dart#L413) |

---

## Задача 1. Диалог синхронизации из профиля

### Что делаем

`SyncStatusCardView` становится тапабельным: вся площадь карточки открывает `showSyncStatusDialog`. Кнопка-действие («Войти» / «Синхронизировать») остаётся — она перехватывает свой тап, остальное поле карточки ведёт в диалог.

### Шаги

1. **`sync_status_card.dart`**
   - Добавить в `SyncStatusCard` и `SyncStatusCardView` параметр `VoidCallback onCardTap` (навигация остаётся снаружи — правило то же, что у `SyncStatusBadge`).
   - Обернуть `ContentCard` в `ScalePressable` — так сделаны остальные тапабельные карточки профиля ([`_StatsSummaryCard`](../lib/feature/profile/presentation/profile_view.dart#L160)). `ContentCard` своего `onTap` не имеет.
   - Обернуть в `Semantics(button: true, label: visual.title)` по образцу `SyncStatusBadgeView`.

2. **`IProfileViewModel` / `ProfileScreen`** ([profile_screen.dart](../lib/feature/profile/presentation/profile_screen.dart))
   - Добавить в контракт `void onSyncStatusTap()`.
   - Реализация — тот же вызов, что в `GroupsListScreen.onSyncBadgeTap`:
     ```dart
     showSyncStatusDialog(
       context: context,
       syncState: context.read<SyncBloc>(),
       onSignInTap: onSignInTap,
       onSyncTap: onSyncTap,
     );
     ```

3. **`profile_view.dart`** — прокинуть `onCardTap: viewModel.onSyncStatusTap` в `SyncStatusCard`.

### Заметки

- Вызов `showSyncStatusDialog` теперь дублируется в двух экранах, но тела разные (в профиле `onSyncTap` уже есть во ViewModel). Дублирование — 5 строк, выносить общий хелпер не стоит.
- В профиле кнопка «Синхронизировать» и диалог дают одно и то же действие. Это нормально: кнопка — быстрый путь, диалог — подробности (время последней синхронизации, причина ошибки).

### Тесты

- `test/feature/sync/presentation/sync_status_card_tap_test.dart`: тап по `SyncStatusCardView` дёргает `onCardTap`; тап по кнопке-действию — только `onSyncTap`.
- Golden'ы `sync_card_*` и `profile_with_data` не поехали — прогнаны, зелёные.

---

## Задача 2. Дизайн полоски синхронизации

### Проблема

`WaveFillBar` спроектирован под однократное значение: entrance-анимация 0 → `value`, при смене `value` заливка перезапускается с нуля, блик проигрывается два раза, indeterminate-режима нет. Прогресс синка, наоборот, меняется часто (десятки обновлений за прогон) и может быть неизвестен — `state.status.progress == null`, сейчас это даёт бесконечный `LinearProgressIndicator`.

### Решение: вынести painter, сделать отдельный виджет

Рекомендуемый вариант — не трогать `WaveFillBar` (за ним golden'ы статистики), а переиспользовать его отрисовку:

1. **Вынести `_FillPainter`** из `wave_fill_bar.dart` в `lib/uikit/progress/wave_fill_painter.dart` как `WaveFillPainter` (публичный). `WaveFillBar` начинает использовать его же — визуально ничего не меняется, golden'ы статистики остаются зелёными.

2. **Новый `lib/uikit/progress/wave_progress_bar.dart`** — `WaveProgressBar`:
   - `final double? value` — `null` означает «прогресс неизвестен»;
   - `color`, `backgroundColor`, `minHeight = 6`, скругление 99 (как у `WaveFillBar`);
   - определённый прогресс: плавный tween от **текущего** значения к новому (`AnimationController` + `Tween`, длительность `AppMotion`), фронт колышется синусоидой через `WaveFillPainter`;
   - неопределённый прогресс: залитый сегмент ~30 % ширины бежит слева направо по циклу, края — тот же волновой фронт;
   - reduced-motion (`AppMotion.reduced`): плоский фронт, без колыхания; в indeterminate — статичный трек либо обычный `LinearProgressIndicator` (решить при реализации, вариант с `LinearProgressIndicator` честнее — иначе полоска выглядит замершей);
   - блика-shimmer нет: он уместен как награда за результат в статистике, но на рабочем прогрессе будет шуметь.

Альтернатива — расширять `WaveFillBar` флагами `indeterminate`/`animateFromCurrent`. Не берём: виджет станет режимным, и любая правка задевает golden'ы статистики.

### Применение

Заменить `LinearProgressIndicator` на `WaveProgressBar` в трёх местах:

- [sync_status_card.dart:131](../lib/feature/sync/presentation/sync_status_card.dart#L131) — цвет `visual.color`, фон `surfaceContainerHighest`;
- [sync_status_dialog.dart:257](../lib/feature/sync/presentation/sync_status_dialog.dart#L257) — там фон блока `surfaceContainer`, трек взять на тон выше;
- [groups_list_view.dart:110](../lib/feature/groups_list/presentation/groups_list_view.dart#L110) — полоса под шапкой главной.

Вне scope: `LinearProgressIndicator` в [active_session_card.dart:84](../lib/feature/groups_list/presentation/widget/active_session_card.dart#L84) — это прогресс прохождения теста, не синхронизации. Если нужно единообразие — отдельной задачей.

### Тесты

Сделано:

- `test/uikit/progress/wave_progress_bar_golden_test.dart` — golden значений 0.15 / 0.5 / 0.9 / 1.0 в reduced-motion. Zoloto не даёт снять кадр анимации: `zolotoTest` пампит только `pumpAndSettle`, а `multiScreenGolden` напрямую запрещён (проверка «Golden tests MUST be run within a testGoldens method»).
- `test/uikit/progress/wave_progress_bar_test.dart` — поведение вместо golden'а: заливка едет от текущего значения к новому, сегмент при неизвестном прогрессе бежит по треку и держит ширину 0.3, в reduced-motion фронт плоский, а неизвестный прогресс отдан `LinearProgressIndicator`.

Не сделано и почему: golden'ы `sync_card_syncing` / `sync_dialog_syncing` по-прежнему невозможны — глиф при `syncing` это `CircularProgressIndicator`, он крутится и в reduced-motion, так что `pumpAndSettle` виснет независимо от полоски.

---

## Порядок работ

1. Задача 1 целиком (мелкая, ни от чего не зависит).
2. Вынос `WaveFillPainter` + прогон golden'ов статистики — убедиться, что рефакторинг нейтрален.
3. `WaveProgressBar` + golden на него.
4. Замена в трёх местах.
5. `fvm flutter analyze` и `fvm flutter test` (или `make` -цели проекта). Кодогенерация и l10n не нужны: новых строк и моделей нет.

## Файлы

| Действие | Файл |
| --- | --- |
| правка | `lib/feature/sync/presentation/sync_status_card.dart` |
| правка | `lib/feature/profile/presentation/profile_screen.dart` |
| правка | `lib/feature/profile/presentation/profile_view.dart` |
| правка | `lib/feature/sync/presentation/sync_status_dialog.dart` |
| правка | `lib/feature/groups_list/presentation/groups_list_view.dart` |
| правка | `lib/uikit/progress/wave_fill_bar.dart` |
| новый | `lib/uikit/progress/wave_fill_painter.dart` |
| новый | `lib/uikit/progress/wave_progress_bar.dart` |
| тесты | `test/feature/sync/presentation/sync_status_golden_test.dart`, новый golden на `WaveProgressBar`, widget-тест тапа по карточке |
