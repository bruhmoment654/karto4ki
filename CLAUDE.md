# karto4ki

## Code Style

- Use `Height`, `SliverHeight` (and analogous `Width`) instead of `SizedBox` for spacing. Example: `const Height(16)` instead of `const SizedBox(height: 16)`, `const SliverHeight(8)` instead of `SliverToBoxAdapter(child: SizedBox(height: 8))`.

## Skills

Проект содержит набор скиллов в `.claude/skills/`. Используй их в приоритете для соответствующих задач:

### Кодогенерация и качество
- **code-generation** — запуск `build_runner` (freezed, json_serializable, retrofit, auto_route, theme_tailor, flutter_gen) и локализации. Вызывай после создания/изменения файлов, требующих кодогенерации.
- **after-generation** — оркестрация кодогенерации + проверки качества для созданных/изменённых Dart-файлов.
- **feedback-loop** — авто-фикс, статический анализ и итерации до устранения всех ошибок. Запускай после изменений кода.

### Создание сущностей
- **create-api** — Retrofit API-интерфейсы и DTO с nullability и JSON-сериализацией.
- **create-storage** — локальное хранилище (key-value/secure) или Drift/SQLite DAO с интерфейсами, DTO и DI.
- **create-uikit** — новый переиспользуемый компонент дизайн-системы (theming, assets, экспорт, golden-тест).
- **create-golden-test** — Alchemist golden-тесты для экранов, виджетов и UIKit-компонентов.
- **mason-gen** — скаффолдинг экранов, BLoC, репозиториев и assembly через Mason-bricks. Использовать при создании фич и когда нужен boilerplate.

### Локализация
- **extract-strings** — извлечение хардкод-строк из Dart-файла в ARB-ключи с заменой на `context.l10n`.
- **localize** — добавление локализованных строк в ARB (группировка, именование, плейсхолдеры, кодогенерация).

### Дизайн и git
- **implement-design** — перенос Figma-дизайнов в код с 1:1 fidelity (требует Figma MCP).
- **create-pr** — сборка GitLab MR для текущей ветки (title, описание по шаблону, JIRA из ветки, pre-push проверки).
- **commit-submodule** — полный цикл изменений в submodule (ветка, коммит, push, MR URL, бамп указателя в родителе).

### Поддержка инфраструктуры
- **sync-review-rules** — регенерация `AI_CODE_REVIEW_RULES.md` из `.cursor/rules/*.mdc`.
- **validate-ai-setup** — проверка консистентности `.cursor/rules` и `.claude/skills`.
- **validate-init-project-setup** — проверка консистентности `init_project.sh` и init-документации.

## Reference Materials

- [Zoloto — Golden Testing](.claude/ZOLOTO-SKILL.md) — full documentation for the `zoloto` library (API, examples, usage patterns)
- [Система множественных ответов](.claude/docs/answer_system.md) — парсинг, форматирование, хранение и импорт множественных вариантов ответа
- [Анализ статистики карточек](.claude/STATS-ANALYSIS-SKILL.md) — словарь колонок CSV-экспорта, формула score, рецепты pandas и sensitivity-анализа
- [Mixup research — multiplicative streak decay](.claude/MIXUP-RESEARCH-SKILL.md) — контекст и результаты исследования по перераспределению весов scoring (май 2026): почему сменили формулу, цифры, риски, что ещё не сделано
