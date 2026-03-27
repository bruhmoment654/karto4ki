# karto4ki

## Code Style

- Use `Height`, `SliverHeight` (and analogous `Width`) instead of `SizedBox` for spacing. Example: `const Height(16)` instead of `const SizedBox(height: 16)`, `const SliverHeight(8)` instead of `SliverToBoxAdapter(child: SizedBox(height: 8))`.

## Reference Materials

- [Zoloto — Golden Testing](.claude/ZOLOTO-SKILL.md) — full documentation for the `zoloto` library (API, examples, usage patterns)
- [Система множественных ответов](.claude/docs/answer_system.md) — парсинг, форматирование, хранение и импорт множественных вариантов ответа
