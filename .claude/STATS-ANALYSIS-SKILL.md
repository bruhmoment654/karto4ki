# Анализ статистики карточек

Справочник для работы с CSV-экспортом статистики (Settings → «Экспортировать в CSV»). Все примеры — pandas в `analysis/stats.ipynb`.

## Где лежат данные

- `analysis/question_stats_YYYYMMDD_HHMMSS.csv` — агрегат по уникальному вопросу (32 колонки)
- `analysis/cards_YYYYMMDD_HHMMSS.csv` — связь карточка ↔ тест ↔ группа (7 колонок)
- `analysis/stats.ipynb` сам подхватывает самые свежие по timestamp в имени

Экспорт реализован в [stats_export_service.dart](../lib/feature/question_stats/data/service/stats_export_service.dart). Формула score — [scoring_calculator.dart](../lib/feature/tinder_test/domain/mixup/scoring_calculator.dart) (один источник правды и для прода, и для экспорта).

## question_stats.csv — словарь колонок

### Идентификация
| Колонка | Тип | Примечание |
|---|---|---|
| `question_key` | str | `front\x1Fback` после `trim().toLowerCase()`. Содержит **невидимый разделитель `\x1F` (ASCII 31)** — для join по key это ОК, но не парсить через простой `split(',')` |
| `front_text` | str | исходный (не нормализованный) front |
| `back_text` | str | исходный back (может содержать `\|` — варианты ответа) |

### Сырые счётчики
| `total_shown` | int | сколько раз показывали |
| `total_correct` / `total_incorrect` | int | в сумме = `total_shown` |
| `streak` | int | текущая серия. + правильно подряд, − неправильно подряд. Сбрасывается на противоположном ответе |
| `accuracy` | float [0..1] | `total_correct / total_shown`. **Пусто (NaN)** если `total_shown == 0` (но такого в стате не бывает — стата создаётся при первом ответе) |

### Время
| `created_at`, `updated_at`, `last_shown_at`, `last_answered_at` | ISO8601 | `last_shown_at` и `last_answered_at` сейчас равны — фронт обновляет их одновременно |
| `days_since_last_shown` | int / пусто | calendar days. NaN для никогда-не-показанных. **Не используется в score** (заменено на active_days) |
| `active_days_since_last_shown` | int / пусто | сколько уникальных дат было в `last_answered_at` SET после `last_shown_at`. Используется в `decay_factor` |
| `age_days` | int | дней с `created_at` |

### Компоненты score (под текущими весами)
Все 4 — float, по формуле из `ScoringCalculator.components`:
| `streak_contribution` | если streak<0: `+w_streak_negative × min(-streak/5, 1)`. Если streak>0: `-w_streak_positive × min(streak/5, 1) × (1 - decay_factor)` (penalty затухает с decay). Если streak=0: 0 |
| `decay_factor` | `min(active_days_since_last_shown / n_active_days_cap, 1)`. По умолчанию `n_active_days_cap=10`. **1.0 для NaN last_shown** (cold-start) |
| `new_factor` | `1 - min(total_shown/5, 1)` — спадает к 0 после 5-го показа |
| `frequency_factor` | `total_incorrect / total_shown` (для нового вопроса = 0.5) |

### Итог
| `score_no_noise` | float | `streak_contribution + w_decay·decay + w_new·new + w_freq·freq`. **Без шума** (в проде ещё +`random[0..0.05]`) |
| `rank_global` | int | глобальный ранг по `score_no_noise` (1 = самый «нужный для подмешивания») |

### Контекст mixup-пула
| `in_mixup_pool` | 0/1 | 1 если вопрос может быть подмешан в хотя бы один тест |
| `hosting_test_ids` | `1\|3\|7` | id тестов, где есть карточка с этим `question_key` (через `\|`) |
| `hosting_group_ids` | `1\|2` | id групп этих тестов |
| `mixup_target_test_count` | int | в сколько тестов вопрос может быть подмешан |

⚠️ **Пустые `hosting_test_ids` означают orphan** — стата осталась от удалённой карточки. Бывает.

### Веса и константы (одинаковые для всего файла)
- `w_streak_negative, w_streak_positive, w_decay, w_new, w_freq` — веса использованные при расчёте `score_no_noise`. **Дефолты**: 0.35 / 0.35 / 0.30 / 0.20 / 0.15.
- `total_active_days` — общее число активных дней (= уникальных дат в `last_answered_at`) в БД на момент экспорта.
- `n_active_days_cap` — `N` в формуле `decay_factor = active_days / N`. Захардкожено в [scoring_calculator.dart](../lib/feature/tinder_test/domain/mixup/scoring_calculator.dart) (`kActiveDaysCap = 10`).

## cards.csv — словарь колонок

| `card_id` | int | PK карточки |
| `test_id`, `test_title` | int / str | где живёт |
| `group_ids` | `1\|2` | группы теста через `\|` |
| `question_key` | str | join с stats |
| `front`, `back` | str | исходные тексты |

Один `question_key` может быть у N карточек (одно и то же слово в разных тестах). Если хочется «вопрос → список тестов»: `cards.groupby('question_key')['test_id'].apply(list)`.

## Базовые операции

```python
# Загрузка
stats = pd.read_csv(latest('question_stats_*.csv'))
cards = pd.read_csv(latest('cards_*.csv'))

# Только то, что реально может быть подмешано
pool = stats[stats['in_mixup_pool'] == 1].copy()

# Top-20 кандидатов
pool.nlargest(20, 'score_no_noise')[
    ['front_text', 'back_text', 'streak', 'accuracy',
     'days_since_last_shown', 'score_no_noise']
]

# Группы для каждого вопроса
cards.groupby('question_key').agg(
    test_count=('test_id', 'nunique'),
    tests=('test_title', lambda s: list(set(s))),
)
```

## Пересчёт score под альтернативными весами

Формула должна 1-в-1 совпадать с `ScoringCalculator.components`. При изменении формулы в Dart — обновить и здесь:

```python
def recompute_score(df, N=10, w_neg=0.35, w_pos=0.35, w_decay=0.30, w_new=0.20, w_freq=0.15):
    streak = df['streak'].to_numpy()
    ads = df['active_days_since_last_shown'].fillna(N).to_numpy()
    decay = np.clip(ads / N, 0, 1)

    streak_neg = np.minimum(np.maximum(-streak, 0) / 5, 1)
    streak_pos = np.minimum(np.maximum(streak, 0) / 5, 1)
    # Penalty за positive streak затухает с decay; bonus за negative — нет.
    streak_contrib = w_neg * streak_neg - w_pos * streak_pos * (1 - decay)

    new_f = (1 - (df['total_shown'] / 5).clip(0, 1)).to_numpy()
    freq = np.where(df['total_shown'] > 0,
                    df['total_incorrect'] / df['total_shown'].clip(lower=1),
                    0.5)
    return streak_contrib + w_decay * decay + w_new * new_f + w_freq * freq
```

Вычисление `active_days_since_last_shown` (если экспорт старый и колонки нет):

```python
active = np.sort(pd.to_datetime(stats['last_answered_at']).dt.normalize().dropna().unique())
def ad(ts):
    if pd.isna(ts): return np.nan
    return int((active > pd.to_datetime(ts).normalize()).sum())
stats['active_days_since_last_shown'] = pd.to_datetime(stats['last_shown_at']).apply(ad)
```

## Sensitivity-анализ (рецепт)

```python
# Сетка весов: меняем 2 коэффициента, фиксируем остальные
from itertools import product

grid = []
for w_d, w_n in product([0.2, 0.3, 0.4, 0.5], [0.1, 0.2, 0.3]):
    pool['s'] = recompute_score(pool, w_decay=w_d, w_new=w_n)
    top = pool.nlargest(20, 's')
    grid.append({
        'w_decay': w_d, 'w_new': w_n,
        'mean_accuracy_top20': top['accuracy'].fillna(0).mean(),
        'mean_streak_top20': top['streak'].mean(),
        'pct_new_top20': (top['total_shown'] < 3).mean(),
    })
pd.DataFrame(grid).pivot(index='w_decay', columns='w_new', values='mean_accuracy_top20')
```

Чем **ниже** `mean_accuracy_top20` — тем «правильнее» выбираем то, что плохо знаем. Чем выше `pct_new_top20` — тем сильнее `w_new` доминирует.

## Что искать для перераспределения весов

1. **Вырожденные факторы**. `pool[fac].describe()`: если стандартное отклонение фактора около нуля — вес ничего не делает.
2. **Корреляции**. `pool[['streak_contribution','decay_factor','new_factor','frequency_factor']].corr()`: высокая корреляция = факторы дублируют друг друга, их совокупный вес «удваивается».
3. **Outliers**:
   - `pool.query('streak >= 3 and accuracy < 0.5')` — серия 5+ при низкой точности (окно streak слишком мягкое)
   - `pool.query('total_shown < 3 and rank_global < 20')` — шумные «сырые» вопросы лезут в топ
4. **Cold-start**. Вопросы без статы (нет в `stats`, но есть в `cards`): `cards[~cards['question_key'].isin(stats['question_key'])]`. У них при подмешивании все факторы = дефолтные значения для `stat=None` (`new=1, decay=1, freq=0.5, streak=0`) — score = `0.30 + 0.20 + 0.075 = 0.575` плюс шум. Сравни с распределением `score_no_noise` чтобы понять, как «свежие» конкурируют со «старыми».

## Ограничения данных

- **Истории сессий нет** — только текущий snapshot агрегатов. Эволюцию `streak` по времени не восстановить.
- **`rank_global` — глобальный**, не внутри конкретного mixup-пула. В реальной сессии пул фиксирован тестом, который запустили. Для точного «что именно попадёт в подмешивание для теста X» нужно фильтровать пул по `cards` (вычесть карточки теста X из кандидатов) и ранжировать там.
- **Orphan-статы** (`hosting_test_ids` пустые) — стата от удалённой карточки. При анализе пула безопасно отфильтровать `in_mixup_pool == 1`.
- **Веса `w_*` — снимок** на момент экспорта. Если будешь сравнивать несколько экспортов — обязательно сверь `w_*` колонки, иначе `score_no_noise` несопоставим. Для честного сравнения — пересчитай `recompute_score` с фиксированным набором весов поверх обоих snapshot-ов.

## Связанные документы

- [scoring_algorithm.md](docs/question_mixup/scoring_algorithm.md) — продовая логика scoring
- [classic_algorithm.md](docs/question_mixup/classic_algorithm.md) — альтернативный (sort-based) алгоритм
- [answer_system.md](docs/answer_system.md) — формат back-поля и множественных ответов
