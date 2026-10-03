# План: редизайн Material You — профиль, главная, настройки, predictive back

> Источник дизайна: проект Claude Design «karto4ki»,
> https://claude.ai/design/p/a1a78f7b-9e47-4933-8bcb-a0de15ec7a43?file=karto4ki.html
> (`screens-profile.jsx`, `screens-home.jsx`, `screens-sync.jsx`, `screens-settings.jsx`,
> `m3-loaders.jsx`, `screens-m3e-map.jsx`, `design_handoff_material_you/M3E_WIDGETS.md`).
> Локальная папка `design_handoff_material_you/` — более старая копия; при расхождениях
> верна версия из проекта.
> Дата: 2026-10-03. Ветка: `design-fixes`.

## Статус (2026-10-03)

Этапы 0–4 реализованы, анализатор чистый, неиспользуемое удалено.
Полоски синхронизации (главная, карточка профиля, диалог) — «змейка»
`M3EProgressIndicator.linearWavy` (`AppLinearProgress(isWavy: true)`) с плавной
амплитудой у краёв. Стрик остаётся плоским. При неизвестном прогрессе змейка
идёт от левого края (длина тянется вперёд-назад), а не бегущими сегментами пакета.
Трек и stop-точка — свой `_TrackPainter` по дизайну: точка 4 px отдельно у края
(пакет рисует её внутри трека и сжимает до 2 px).
Смена состояний карточки синка — `AppAnimatedSwitcher` + `AppAnimatedSize`
(uikit, по образцу gloria-jeans-flutter); на него же переведён свитчер главной.
Полоска прогресса убрана из карточки синка и с главной (лишние скачки высоты):
загрузку в карточке показывает круговая «змейка» M3E в кнопке действия
(`AppWavyCircularProgress`), глиф карточки при этом статичный (`cloud_sync`).
Кнопка есть во всех состояниях — ширина подписей не прыгает. В диалоге синка
полоска осталась. Фон плашек «Изучено», «Без ошибок» и стрика медленно вращается
(`ShapePlate.isRotating`, оборот за 24 с); корни табов «Главная» и «Профиль»
обёрнуты в `ActiveTabTickerMode`, чтобы скрытый таб не тикал.
Осталось:
- проверка predictive back на устройстве Android 14–16 и свайпа назад на iOS;
- голдены `test_detail` падали и до этих изменений: эталоны со старого дизайна (февраль 2026).

Отклонения от плана:
- Голдена всего экрана настроек нет: внизу экрана бесконечный GIF, а `zolotoTest`
  ждёт `pumpAndSettle`. Покрыты uikit-голденами `HueSlider` и `ExpandableSection`.
- Кольцо «Точность» адаптивное: 132 на ширине из дизайна (412), до 88 на 360 —
  иначе названия метрик в строках обрезаются.
- Переходы обёрнуты в `ReducedMotionPageTransitionsBuilder`: при системном
  «убрать анимацию» на Android экран сменяется без анимации (как было с shared axis).

## Скоуп

| # | Что | Статус |
|---|---|---|
| 1 | Профиль: сверка с голденом, контейнер истекшей сессии | делаем (голдены) |
| 2 | Профиль: блок статистики (1 кольцо + 2 строки) и карточка стрика | делаем |
| 3 | Главная: лоадер M3E в углу + линейный прогресс M3E | делаем |
| 3 | Главная: вариант B «Ещё N групп загружается» | **скип** |
| 4 | Настройки: один слайдер цвета по дизайну вместо двух | делаем |
| 5 | Настройки: блок «Карточки» — раскрывающийся | делаем |
| 5 | Настройки: напоминания, синхронизация | **скип** |
| 6 | Predictive back | делаем отдельным этапом (см. риски) |

**Принцип:** дизайн отстаёт от скоупа приложения. Всё, чего в дизайне нет (доп. метрики,
скорость анимации, экспорт CSV, версия и т. п.), **оставляем**, если не сказано обратное.

Не делаем: пресеты цвета (8 кружков) и «Сгенерированная палитра» в настройках,
`M3ERefreshIndicator` (pull-to-refresh), остальные экраны.

---

## 0. Фундамент: M3E в боевых экранах

Сейчас `material_3_expressive 1.1.5` используется **только** в UIKit-каталоге.
Пакет построен на `material_ui` — отдельной копии Material, поэтому `Theme` приложения
ему не виден. Без `M3ETheme` над виджетом пакет берёт дефолтную тему `material_ui`, и цвета
получатся не наши.

- Перенести `lib/feature/uikit_catalog/presentation/widgets/m3e_sandbox.dart` →
  `lib/uikit/m3e/m3e_scope.dart`. Каталог и фичи используют один мост.
- Оборачивать **только** M3E-виджеты: тема M3E подменяет `IconTheme` и `DefaultTextStyle`.
- Индикаторам цвета передавать явно (`color`, `trackColor`): так они не зависят от того,
  что мост берёт seed из `colorScheme.primary`, а не из настоящего seed.
- Голдены: `M3ELoadingIndicator` и неопределённый линейный индикатор крутятся бесконечно,
  поэтому `pumpAndSettle` в голдене повиснет. Состояния `syncing` уже исключены из голденов
  (`sync_status_golden_test.dart:40`), правило сохраняем.

---

## 1. Профиль: сверка с голденом

Голден `test/feature/profile/presentation/goldens/*/profile_with_data.*.png` против
`screens-profile.jsx`:

| Блок | Сейчас (код/голден) | Дизайн | Действие |
|---|---|---|---|
| Шапка «Профиль» | `AppPageHeader` | display-s | без изменений |
| Аккаунт / «Войдите в аккаунт» | `ProfileAccountCard` / `ProfileSignInCard` | то же | без изменений |
| Синхронизация | `SyncStatusCard`, только при сессии | `SyncCard` | спиннер → M3E (этап 3) |
| Статистика | 3 × `FillRing` | 1 кольцо + 2 строки | **переделать** (этап 2) |
| Стрик | плашка-квадрат + 7 кружков `StreakWeekStrip` | плашка cookie7 + линейный прогресс + подписи дней | **переделать** (этап 2) |
| Доп. метрики (всего ответов и т. д.) | `_ExtraMetricsCard` | нет в дизайне | оставляем без изменений |
| Настройки / Выйти | `_SettingsCard` | то же | без изменений |
| Загрузка | `CircularProgressIndicator` | — | по желанию → `M3ELoadingIndicator` |

### Контейнер истекшей сессии — есть в коде, нет в голденах профиля

- Состояние `expired` реализовано в `SyncStatusCardView`
  (`lib/feature/sync/presentation/sync_status_card.dart`): «Сессия истекла», круглая
  кнопка «Войти» на `primary`. Совпадает с дизайном (`reauth-profile`).
- Голден самой карточки есть: `test/feature/sync/presentation/goldens/*/sync_card_expired.*.png`.
- Бейдж на табе «Профиль» при истекшей сессии есть: `_ProfileTabIcon` в `home_view.dart`.
- **Голдены экрана профиля этот блок не показывают.** `profile_view_golden_test.dart`
  рендерит только гостя (`AuthState.unauthorized`) с `SyncStatus.disabled`, а блок
  синхронизации виден только при сессии.

Задача: добавить голдены экрана `profile_signed_in_synced` и `profile_signed_in_expired`
(`AuthState.authorized/expired` + `SyncStatus.synced/expired`).

---

## 2. Профиль: блок статистики и стрик

### 2.1 Оставшееся кольцо — есть в M3E

`M3EProgressIndicator.circular` (`material_3_expressive-1.1.5/lib/components/progress_indicators/m3e_progress_indicators.dart:33-51`):

- концы скруглены (`StrokeCap.round`), зазор active↔track с обеих сторон, stop-точки нет —
  как в дизайне;
- параметры: `value` (0..1), `size`, `strokeWidth`, `trackStrokeWidth`, `color`,
  `trackColor`, `showTrack`, `semanticsLabel`;
- `gapSize` в `.circular` не передаётся, берётся из темы (по умолчанию 4 → зазор
  4 + stroke). Для дизайна достаточно;
- **значение не анимируется.** Заполнение от 0 делаем снаружи через `TweenAnimationBuilder`
  с той же кривой и длительностью, что у `CountUpText` (850 мс, `easeOutCubic`). При
  `AppMotion.reduced` значение финальное сразу.

Новый uikit-виджет `lib/uikit/progress/animated_circular_progress.dart`: M3E-кольцо,
твин 0 → value, `delay`, reduced-motion, `child` по центру. Заменяет `FillRing`.

### 2.2 Новая карточка «Статистика»

Раскладка: `Row(hero 132, gap 18, Expanded(Column(gap 14, [row, row])))`. Заголовок карточки
(«Статистика · Подробнее ›») без изменений, тап → `onStatsTap`.

- **Hero «Точность»:** кольцо 132, stroke 10/10, `color: cs.success`,
  `trackColor: cs.surfaceContainerHigh`. Внутри: `CountUpText(%)` 30/w800 цветом метрики,
  подпись `labelMedium`, `247/278` в `bodySmall` (`onSurfaceVariant`). Задержка 140 мс.
- **Строки «Изучено» и «Без ошибок»** вместо двух колец, цифры остаются:
  - плашка 40×40 `M3EShapeContainer.pentagon` (`Icons.school`, `cs.primary`) и
    `.cookie7Sided` (`Icons.verified`, `cs.warning`), фон — цвет метрики α 0.22;
  - название `labelLarge` w600 и `142/200` `bodySmall`;
  - справа `CountUpText(%)` 16/w800 цветом метрики, ширина 42, выравнивание вправо;
  - задержки 340 / 460 мс.
- `CountUpText` сейчас без задержки: добавить параметр `delay`.

Виджеты — отдельные классы в `lib/feature/profile/presentation/widget/`
(`profile_stats_card.dart`), без build-методов.

### 2.3 Карточка стрика

- Плашка: скруглённый квадрат 48 (r14) → `M3EShapeContainer.cookie7Sided` 48×48,
  `tertiaryContainer`, огонь `onTertiaryContainer`.
- Заголовок `CountUpText(N) + «дней подряд»` и «Лучшая серия: …» не меняются.
- Неделя: `StreakWeekStrip` (7 кружков) → `M3EProgressIndicator.linear(value: active/7,
  linearSize: s, color: cs.tertiary, trackColor: cs.surfaceContainerHigh)`. Под ним
  `Row` из 7 подписей: активный день `onSurface` w700, неактивный `onSurfaceVariant` w500.
  Отступы: 14 до полосы, 8 до подписей.
- У `.linear` stop-точка есть всегда, отключить нельзя — в дизайне она есть.
- В дизайне полоса плоская. Волнистый `.linearWavy` возможен, но волна анимируется
  постоянно — не берём.

### 2.4 Голдены и чистка

- Перегенерировать `profile_with_data`, `profile_empty`, добавить голдены из п. 1.
- `FillRing` и `StreakWeekStrip` удаляем вместе с секциями в каталоге (см. «Удаление»).
  В каталог вместо них — новые `AnimatedCircularProgress` и линейный M3E.

---

## 3. Главная: лоадер и прогресс

По дизайну (`load-shimmer`): иконка-спиннер в углу на уровне заголовка, под подзаголовком
линейный индикатор, ниже — скелетоны карточек (как сейчас).

- **Спиннер в углу.** `SyncStatusGlyph` (`lib/feature/sync/presentation/widget/sync_status_glyph.dart:44`):
  `CircularProgressIndicator` → `M3ELoadingIndicator(color: visual.color, size: …)`,
  вариант `defaultStyle` (тональная подложка уже есть у глифа). Глиф общий, поэтому
  спиннер сменится сразу в трёх местах: бейдж на главной, карточка в профиле, диалог.
  - **Ограничение пакета:** `size` должен быть 24–240 (assert). Сейчас
    `glyphSize = size * 0.54`, у бейджа 44 → 23.76 → assert упадёт. Взять 0.56, как в
    дизайне, или `max(24, …)`.
- **Полоса прогресса.** `WaveProgressBar` → `M3EProgressIndicator.linear(value:
  progress?.value, linearSize: s, color: cs.primary, trackColor: cs.surfaceContainerHighest)`.
  `value: null` — неопределённый режим. Места: `_SyncProgressSliver` в
  `groups_list_view.dart:113`. Для единообразия так же в `sync_status_card.dart:145` и
  `sync_status_dialog.dart:258`: дизайн рисует там тот же `LinearProgress`.
- Скелетоны `GroupsListSkeleton` остаются (в пакете их нет, дизайн так и говорит).
- **Скип:** вариант B с карточкой-контуром «Ещё 1 группа загружается».
- `WaveProgressBar` удаляем вместе с тестами и голденами (см. «Удаление»).
  `wave_fill_painter.dart` остаётся: на нём `WaveFillBar` в статистике.
- Голдены: состояния загрузки и `syncing` бесконечно анимированы, голденами не
  покрываем. Проверяем вручную (marionette / эмулятор).

---

## 4. Настройки: слайдер цвета

**Сейчас** (`settings_view.dart`, `_HueSlider`): над треком кружок-превью, под ним
градиентная полоса 12 px, а под ней отдельный `AppSlider` — визуально два трека.

**Дизайн:** один трек-радуга 16 px с полным скруглением. Ручка — круг 28 px, залитый
текущим цветом, обводка 3 px цветом карточки (`surfaceContainer`), тень `0 1 6 α.4`.
Контейнер высотой 36. Ручка сама служит превью, отдельный кружок не нужен.

**M3E не подходит.** У `M3ESlider` градиента нет, цвета задаются только темой, а ручка в
expressive-стиле — вертикальная «палка», не круг. Через `trackBuilder`/`thumbBuilder` можно,
но `trackBuilder` целиком заменяет трек, так что выигрыша нет.

**Решение:** свой uikit-виджет `lib/uikit/slider/hue_slider.dart` на базе Flutter `Slider` +
`SliderTheme`:
- свой `SliderTrackShape` — градиент на всю ширину, высота 16, полное скругление,
  без деления на active/inactive;
- свой `SliderComponentShape` для ручки — круг 28 с заливкой
  `AppTheme.seedColorFromHue(hue)`, обводкой и тенью; оверлей прозрачный или мягкий;
- градиент строится **из той же функции hue → цвет**, что и seed (а не из захардкоженных
  стопов дизайна), чтобы цвет ручки совпадал с цветом трека под ней;
- семантика, клавиатура и драг остаются от `Slider`.

В `settings_view.dart` удалить `_HueSlider` и `_ColorPreview`, `_AccentColorSection`
использует `HueSlider`. Пресеты цвета и превью палитры из дизайна не добавляем.

---

## 5. Настройки: блок размера шрифта раскрывающимся

Раскрывающимся делаем блок размера шрифта `_CardFontSizeSection` (`settings_view.dart`)
внутри карточки «Карточки». Шапка карточки (иконка + «Карточки») не меняется.

- **Свёрнуто (по умолчанию):** текущая строка блока — «Размер шрифта на карточке» и
  значение `N px` (`primary`) — плюс шеврон `expand_more`. Вся строка кликабельна.
- **Развёрнуто:** под строкой слайдер размера и превью карточки 3:4, как сейчас.
- Состояние раскрытия локальное (`StatefulWidget`), не сохраняем.
- Анимация: `AnimatedSize` для тела, `AnimatedRotation` шеврона на 180°;
  при `AppMotion.reduced` без анимации.
- Реализация — свой uikit-виджет `lib/uikit/expandable/expandable_section.dart`
  (`header` + `child`, `initiallyExpanded`).
  - `ExpansionTile` не берём: внутри `ContentCard` придётся переопределять divider,
    shape и отступы.
  - `M3EExpandableItem` не берём: требует мост M3E, а `headline` у него — `String`.
- Напоминания и синхронизация — **скип**.

---

## 6. Predictive back

**Ответ: да, можно.** SDK и auto_route готовы, но сейчас predictive back отключён
архитектурно.

### Почему его нет сейчас

- `app_router.dart:50-54`: `defaultRouteType => RouteType.custom(shared axis)`. Custom-роут
  auto_route не создаёт детектор жеста (`enablePredictiveBackGesture: false` по умолчанию)
  и игнорирует `pageTransitionsTheme`.
- `AndroidManifest.xml`: нет `android:enableOnBackInvokedCallback="true"`.
- Побочный эффект: **на iOS сейчас не работает свайп назад** — custom-роут не строит
  Cupertino-детектор.

Flutter 3.47.4: для Android по умолчанию уже `PredictiveBackPageTransitionsBuilder`
(на жесте shared-element scale/скругление, без жеста — `FadeForwards`).
`targetSdk = 36`, `MainActivity` менять не нужно.

### Шаги

1. `AndroidManifest.xml`, `<application>`: `android:enableOnBackInvokedCallback="true"`.
2. `app_router.dart`: `defaultRouteType` → `RouteType.material()` (или `adaptive()`).
   Android получает predictive back, iOS — свайп назад. Shared axis на Android теряем —
   **согласовано**. `TransitionsBuildersX` удаляем, импорт `animations` из роутера убираем
   (пакет остаётся: `home_view.dart`, `tinder_test_view.dart`).
3. `app_theme.dart`: явно задать `pageTransitionsTheme` (android →
   `PredictiveBackPageTransitionsBuilder`, iOS → `CupertinoPageTransitionsBuilder`).
   Переходы SDK не смотрят на `disableAnimations`; для `AppMotion.reduced` нужна своя
   обёртка-билдер.
4. `home_view.dart:44-48`: при смене таба сбрасывать стек **покидаемого** таба (или всех
   неактивных), а не только выбранного. Причина — см. риски.
5. Проверка на устройстве (жестовая навигация): Android 14 (включить «Predictive back
   animations» в Developer options), 15, 16.

### Риски (найдены чтением кода, на устройстве не воспроизводились)

- **Скрытые роуты в неактивных табах.** Predictive back рассылается всем observers, а
  верхний роут вложенного навигатора остаётся `isCurrent`, даже когда таб скрыт.
  Сценарий: Главная → GroupDetail → таб Профиль → Settings → жест назад: закроются и
  Settings, и невидимый GroupDetail. Лечится шагом 4.
- **Диалоги.** `showDialog` открывается в root-навигаторе. Жест может закрыть страницу
  под диалогом, а диалог останется. Проверить «GroupDetail → диалог → жест». Если
  подтвердится — `useRootNavigator: false` в `DialogController`/`app_dialog.dart`
  (минус: scrim не накроет NavigationBar) или свой route с более строгим `popGestureEnabled`.
- **Тиндер-экран:** жест от края может конфликтовать со свайпом карточек.
- Анимация внутри приложения работает только на Android 14+ при жестовой навигации.
  Длительности и кривые predictive-перехода в SDK константы, настроить нельзя.

---

## Порядок работ

| Этап | Содержание | Проверка |
|---|---|---|
| 0 | Мост `M3EScope` в `lib/uikit/m3e/`, каталог на него | каталог открывается, `m3e_sections_smoke_test` |
| 1 | Главная: глиф-спиннер M3E, линейный прогресс M3E (главная, карточка, диалог синка) | ручная проверка syncing; голдены sync без изменений, кроме прогресса |
| 2 | Профиль: `AnimatedCircularProgress`, `ProfileStatsCard`, стрик, `CountUpText.delay` | голдены профиля + 2 новых |
| 3 | Настройки: `HueSlider`, `ExpandableSection` для размера шрифта | ручная проверка, по желанию голден настроек |
| 4 | Predictive back: манифест, `RouteType.material`, `pageTransitionsTheme`, сброс табов | устройство Android 14–16 + iOS свайп |

После каждого этапа: `/feedback-loop` (`make analyze`), голдены — `make reset-goldens`
или точечно. Кодогенерация не нужна: freezed/DTO не меняются. Новые строки — через `/localize`.

## Удаление (неиспользуемое после замены)

Согласовано удалить. Перед фактическим удалением — показать итоговый список и дождаться
подтверждения.

| Что | Файлы | Этап |
|---|---|---|
| `WaveProgressBar` | `lib/uikit/progress/wave_progress_bar.dart`, `test/uikit/progress/wave_progress_bar_golden_test.dart`, `test/uikit/progress/wave_progress_bar_test.dart`, `test/uikit/progress/goldens/{ci,macos}/wave_progress_bar_values.*.png` | 1 |
| `FillRing` | `lib/uikit/progress/fill_ring.dart` | 2 |
| `StreakWeekStrip` | `lib/uikit/progress/streak_week_strip.dart` | 2 |
| Секции каталога | правка `uikit_catalog/.../karto4ki/progress_section.dart` (не удаление файла) | 1–2 |
| `_HueSlider`, `_ColorPreview` | правка `settings_view.dart` | 3 |
| `TransitionsBuildersX` | правка `app_router.dart` | 4 |

`wave_fill_painter.dart` и `WaveFillBar` **не трогаем**: используются в `question_stats_view.dart`.
Перед удалением повторно проверить `rg` по `lib/` и `test/`: тест `wave_progress_bar_test.dart`
может проверять и `WaveFillPainter`. Если так — эту часть перенести, а не удалять.

## Решения (2026-10-03)

1. Всё, чего нет в дизайне, оставляем (дизайн отстаёт от скоупа), в т. ч. `_ExtraMetricsCard`.
2. Неиспользуемое после замены удаляем (таблица выше).
3. Пресеты цвета и превью палитры не нужны.
4. Раскрывающимся делаем блок размера шрифта в настройках.
5. Shared axis на Android теряем ради predictive back.
6. Полоса стрика — по дизайну, `active/7`. Если при проверке на живых данных покажется
   вводящей в заблуждение (активность не с понедельника), вернёмся к этому.
