# karto4ki

## Code Style

- Use `Height`, `SliverHeight` (and analogous `Width`) instead of `SizedBox` for spacing. Example: `const Height(16)` instead of `const SizedBox(height: 16)`, `const SliverHeight(8)` instead of `SliverToBoxAdapter(child: SizedBox(height: 8))`.

## Reference Materials

- [Zoloto — Golden Testing](.claude/ZOLOTO-SKILL.md) — full documentation for the `zoloto` library (API, examples, usage patterns)
- [Система множественных ответов](.claude/docs/answer_system.md) — парсинг, форматирование, хранение и импорт множественных вариантов ответа
- [Анализ статистики карточек](.claude/STATS-ANALYSIS-SKILL.md) — словарь колонок CSV-экспорта, формула score, рецепты pandas и sensitivity-анализа
- [Mixup research — multiplicative streak decay](.claude/MIXUP-RESEARCH-SKILL.md) — контекст и результаты исследования по перераспределению весов scoring (май 2026): почему сменили формулу, цифры, риски, что ещё не сделано
