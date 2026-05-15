# План симуляций: multiplicative streak decay

## Цель

Перед внедрением в Dart — подтвердить устойчивость новой формулы scoring на дополнительных срезах и калибровать параметры. Принципиально проверяемые гипотезы:
1. Новая формула не ломает обработку cold-start / новых карточек.
2. `N = 10` действительно оптимально (или есть лучшее значение).
3. Симметрия (затухает только positive streak) не создаёт перекоса.
4. В гипотетическом «через 10 активных дней» состоянии well-learned действительно вылезают.

## Окружение

- **CWD:** `/Users/user/Documents/work/karto4ki/analysis`
- **Python:** `.venv/bin/python` (3.12, pandas/numpy/matplotlib/seaborn уже установлены)
- **Данные:** последние `question_stats_*.csv` и `cards_*.csv` в этой же папке
- **Существующий notebook:** `stats.ipynb` — **НЕ модифицировать**. Использовать `.py` скрипты или ad-hoc python через bash. Финальный отчёт — отдельный md.

## Формула (для воспроизводимости)

```python
def recompute_score_v2(df, N=10, w_neg=0.5, w_pos=0.35, w_decay=0.30, w_new=0.20, w_freq=0.15):
    streak = df['streak'].to_numpy()
    ads = df['active_days_since_last_shown'].fillna(N).to_numpy()
    active_decay = np.clip(ads / N, 0, 1)
    streak_neg = np.minimum(np.maximum(-streak, 0) / 5, 1)
    streak_pos = np.minimum(np.maximum(streak, 0) / 5, 1)
    streak_contrib = w_neg * streak_neg - w_pos * streak_pos * (1 - active_decay)
    new_f = (1 - (df['total_shown'] / 5).clip(0, 1)).to_numpy()
    freq = np.where(df['total_shown'] > 0,
                    df['total_incorrect'] / df['total_shown'].clip(lower=1),
                    0.5)
    return streak_contrib + w_decay * active_decay + w_new * new_f + w_freq * freq
```

Вычисление `active_days_since_last_shown`:

```python
active = np.sort(pd.to_datetime(stats['last_answered_at']).dt.normalize().dropna().unique())
def ad(ts):
    if pd.isna(ts): return np.nan
    return int((active > pd.to_datetime(ts).normalize()).sum())
stats['active_days_since_last_shown'] = pd.to_datetime(stats['last_shown_at']).apply(ad)
```

Текущие веса берутся из колонок `w_*` (значение в нулевой строке — оно одинаковое во всех строках одного экспорта).

## Что проверять

### Этап 1. Cold-start / новые карточки — robustness
- Карточки **из cards.csv без записи в stats.csv** — это cold-start. Их score под новой формулой должен совпадать со старой (streak=0, decay=1, new=1, freq=0.5).
- Карточки с `streak ∈ {1, 2}` и `total_shown ∈ {1, 2, 3}` — посчитать их score под обеими формулами. Penalty маленький, отличия должны быть минимальные. **Подтвердить:** разница ≤ 0.05.
- Карточки с `streak < 0` — penalty не меняется, decay меняется только из-за переключения календарных → активных дней. **Подтвердить:** изменения умеренные (≤ 0.15 по модулю).

### Этап 2. Распределение score: новая vs старая
| метрика | старая | новая | дельта |
|---|---|---|---|
| mean | — | — | — |
| std | — | — | — |
| min | — | — | — |
| max | — | — | — |
| % положительных | — | — | — |
| % с score > 0.5 (вероятные кандидаты в mixup) | — | — | — |

Plus Pearson correlation (score_old, score_new) — ожидание: > 0.8 (та же сортировка в крупном, отличия на хвостах).

### Этап 3. Sensitivity w_decay × N

Сетка: `w_decay ∈ {0.20, 0.25, 0.30, 0.35, 0.40}` × `N ∈ {5, 7, 10, 12, 14}`. Остальные веса фиксированные текущими.

Метрики (для каждой ячейки):
- A) **well-learned в top-20 при ads=10** (симуляция): `(streak≥3) ∧ (n_shown≥5) ∧ (acc≥0.8)` карточки + предположение что у них ads=10. Сколько штук попадает в top-20 пула.
- B) **new_raw в top-20 при текущих ads**: `(total_shown < 3)` штук в top-20.
- C) **streak_neg в top-20 при текущих ads**: `(streak < 0)` штук в top-20.
- D) **mean_accuracy top-20 при текущих ads** (ниже = лучше).

Тепловая карта по A + балансы B/C. Sweet-spot — где A максимально, C не падает ниже текущего, B не растёт.

### Этап 4. Future-state: «через 10 активных дней»

Симуляция: предположить что юзер 10 активных дней играет тесты НЕ содержащие well-learned cohort. То есть:
- Для well-learned: ads → 10.
- Для всех остальных: ads → ads + 10? Нет — реалистичнее, что остальные продолжают показываться → их ads ~ распределение текущих.
- Альтернатива: симулировать что юзер играет N других тестов и часть карточек получает новый last_shown_at вчера. Слишком сложно — упрощаем: для well-learned добавить +10 к ads, для остальных оставить как есть.

Под новой формулой — топ-20 в этом будущем. Сколько well-learned попало. Если ≥ 10 → формула эффективна на этом сценарии.

### Этап 5. Симметрия streak

- Сколько `streak ≥ 3` в top-20 при текущих ads под новой формулой.
- Сколько `streak ≤ -3` в top-20 при текущих ads под новой формулой.
- Сравнить с базовой (старая формула).
- Опасение: новая формула могла перекосить в сторону positive streak (если ads большие). Проверить: на текущих данных (ads в основном 0-3) этого быть не должно.

### Этап 6. Краевой случай — пустой active_dates

- Если бы база была пустая, `active_dates = []`, `ads = 0` для всех, `decay = 0` для всех. Прокрутить — что получается?
- Это симулирует «свежая база, ничего не отвечено». Все streak=0, freq=0.5, new=1.0 → score = 0 + 0 + 0.20 + 0.075 = 0.275 для всех. Случайный выбор. **Подтвердить, что не падает с ZeroDivision.**

## Формат отчёта

**Сохранить в:** `analysis/simulation-report.md`

Структура:

```markdown
# Simulation report: multiplicative streak decay

## TL;DR

- Робастность: ✅ / ⚠️ / ❌
- Рекомендация по N: ...
- Рекомендация по w_decay: ...
- Главные риски: ...

## 1. Cold-start / новые карточки
- Cold-start (нет статы): N карточек, score изменился на M в среднем
- Новые с streak 1-2, n_shown ≤ 3: max дельта M, mean M
- Отрицательный streak: max дельта M, mean M
- **Вердикт:** [регресса нет / есть и где]

## 2. Распределение score
| метрика | old | new | Δ |
|---|---|---|---|
| mean | … | … | … |
| std | … | … | … |
| min | … | … | … |
| max | … | … | … |
| %>0 | … | … | … |
| %>0.5 | … | … | … |
| Pearson(old, new) | — | — | … |

## 3. Sensitivity (w_decay × N)

### A. Well-learned в top-20 при ads=10
| | N=5 | N=7 | N=10 | N=12 | N=14 |
|---|---|---|---|---|---|
| w_decay=0.20 | … | … | … | … | … |
| w_decay=0.25 | … | … | … | … | … |
| w_decay=0.30 | … | … | … | … | … |
| w_decay=0.35 | … | … | … | … | … |
| w_decay=0.40 | … | … | … | … | … |

### B/C/D — аналогично

**Sweet-spot:** w_decay = X, N = Y. Обоснование: ...

## 4. Future-state (10 active days)
- Top-20 содержит N well-learned (из 32 в когорте).
- Top-20 содержит M streak<0.
- Список (5-10 первых) кто оказался в топе:
  | front | back | streak | n_shown | ads | score_new |
  | … | … | … | … | … | … |

## 5. Симметрия streak
| | старая | новая |
|---|---|---|
| `streak ≥ 3` в top-20 | … | … |
| `streak ≤ -3` в top-20 | … | … |
| `0 ≤ streak < 3` в top-20 | … | … |

## 6. Краевой случай: пустая БД
[ok / падает / странное поведение]

## Финальная рекомендация
1. Внедрять с N = …, w_decay = …
2. Не внедрять — потому что …
3. Внедрять с правками: …

## Замеченные риски
- …

## Сырые цифры (для воспроизводимости)
[любые табличные dump для будущей сверки]
```

## Не делать

- Не модифицировать `stats.ipynb`.
- Не править Dart-код.
- Не запускать `jupyter nbconvert`.
- Не устанавливать новые python-пакеты.
- Не трогать CSV-данные.
