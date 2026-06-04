---
name: extract-strings
description: Extract hardcoded user-facing strings from a Dart file into ARB localization keys, replace literals with context.l10n calls, and hand off ARB editing to /localize. Use when migrating a View or Widget that contains literal Russian/English copy.
---

# Extract Hardcoded Strings

Find user-facing string literals in a `.dart` file, propose ARB keys, replace literals with `context.l10n.<key>`, then hand off ARB editing + codegen to [/localize](mdc:.claude/skills/localize/SKILL.md).

This skill is the migration counterpart to `/localize`:
- `/localize` — *adds new* keys to ARB (you already know what string and what name).
- `/extract-strings` — *finds existing* literals, names them, edits source, then chains into `/localize`.

For naming, grouping, and placeholder conventions, see [localization-process](mdc:.cursor/rules/localization-process.mdc).

## What to Extract

**Strong signals (extract):**
- Cyrillic text inside `Text('...')`, `Text.rich(TextSpan(text: '...'))`, `SnackBar(content: Text(...))`.
- String args to user-facing params: `title:`, `subtitle:`, `label:`, `hint:`, `hintText:`, `labelText:`, `helperText:`, `errorText:`, `tooltip:`, `semanticsLabel:`, `message:`, `description:`, `placeholder:`, `buttonText:`.
- Dialog / bottom-sheet titles and bodies, button captions, empty/error stub copy.
- Literals passed to a child widget's user-facing param at the **call site** (the call site is where extraction happens, not the receiving widget).

**Do NOT extract:**
- Asset references (`Assets.icons.foo.path`, `'assets/...'`).
- Route names, BLoC event names, `Key('...')`, `Hero(tag: '...')`.
- `throw Exception('...')`, `assert(..., '...')`, `debugPrint`, `log()` — developer-facing in this project; user errors flow through `Failure` types, see [failure](mdc:.cursor/rules/failure.mdc).
- Strings inside `// comments` or `///` doc comments.
- Test files (`*_test.dart`, `*_golden_test.dart`) and `_TestData` fixtures — they use Cyrillic on purpose.
- Already-localized calls (`context.l10n.<x>`).
- Single-character / whitespace separators (`' • '`, `'\n'`, `' '`).
- Pure numeric / symbolic strings (`'100'`, `'%'`).

**Ambiguous — ask the user:**
- Latin-only words in `Text(...)` (could be brand: `'UP Coins'`, or untranslated copy).
- Strings in `static const` fields at the top level — likely config, not UI.

## Naming and Segments

Per [localization-process](mdc:.cursor/rules/localization-process.mdc):

- **camelCase**, prefixed with feature/screen name: `profileScreenLogoutButton`, `cartItemRemoveAction`.
- Open `modules/ui/lib/l10n/app_ru.arb`. If a `@segment<Feature>` block already exists for this feature/screen, reuse it. Otherwise create a new segment block (see `/localize`).
- Preserve ` ` non-breaking spaces from the original literal.

### Interpolation → Placeholder

```dart
// before
Text('У вас $count заказов')

// after
Text(context.l10n.profileOrdersCount(count))
```

```json
"profileOrdersCount": "У вас {count} заказов",
"@profileOrdersCount": {
  "placeholders": { "count": { "type": "int" } }
}
```

The placeholder `type` is the **Dart type of the runtime value**, not `"String"` by default. Wrong type → wrong codegen signature. Common types: `int`, `num`, `String`, `DateTime`.

For string concatenation (`'Привет, ' + name + '!'`) — convert to interpolation first, then extract.

## Replacement Patterns

| Source                                        | Replacement                                                |
|-----------------------------------------------|------------------------------------------------------------|
| `Text('Профиль')`                             | `Text(context.l10n.profileTitle)`                          |
| `Text('Привет, $name')`                       | `Text(context.l10n.greetingMessage(name))`                 |
| `MyWidget(label: 'Сохранить')`                | `MyWidget(label: context.l10n.saveButton)`                 |
| `const Text('Профиль')`                       | `Text(context.l10n.profileTitle)` *(drop the inner const)* |

### `BuildContext` and `const`

- Replacing a literal with `context.l10n.<key>` makes the call non-`const`. Drop `const` on **that** node only — preserve `const` on ancestors and siblings where possible.
- Private helper widgets without `BuildContext` in scope: add `BuildContext context` to the helper's `build`/method signature (it's a `StatelessWidget` — `build` already has it).
- Top-level `static const` fields: do **not** auto-extract; flag to the user — these are usually config, not UI.

### Imports

If the file calls `context.l10n` for the first time, add:

```dart
import 'package:module_ui/l10n/app_localizations_x.dart';
```

Place it among `package:` imports per [imports](mdc:.cursor/rules/imports.mdc).

### Reusable widget boundary

**Never move a hardcoded string *into* a reusable Widget.** The widget keeps its `String` param; the *call site* (View / parent widget) is where the literal becomes `context.l10n.<key>`. This preserves widget reusability — see [widget](mdc:.cursor/rules/widget.mdc).

## Step-by-Step Process

1. **Read** the target file. Bail out if it's `*_test.dart` / `*_golden_test.dart` / a fixture file.
2. **Scan** for literals matching the "extract" rules above. Build a candidate list: `(line, original literal, proposed key, placeholders if any)`.
3. **Show the user the list** before any edits. Get explicit confirmation if any candidate is ambiguous (Latin-only, ambiguous param, etc.).
4. **Pick the segment** — read `modules/ui/lib/l10n/app_ru.arb` and find or create the `@segment<Feature>` block.
5. **Edit the source file**:
   - Replace each literal with `context.l10n.<key>` (or `(arg)` form for placeholders).
   - Add the `app_localizations_x.dart` import if missing.
   - Adjust `const` modifiers minimally.
6. **Hand off to [/localize](mdc:.claude/skills/localize/SKILL.md)** with the prepared key/value/placeholder list. `/localize` handles:
   - Adding entries to `app_ru.arb` (template).
   - Mirroring keys to `app_en.arb` (mark untranslated entries with a TODO so the user fills English copy — never auto-translate).
   - Running `make gen-l10n`.
7. **Verify** — run static analysis on the touched module; new `context.l10n.<key>` calls must resolve. Use [/feedback-loop](mdc:.claude/skills/feedback-loop/SKILL.md) if anything is red.

## Common Pitfalls

- **Const churn cascade** — removing one `const` should not require removing others. Keep `const` on every node where the children remain compile-time constants.
- **Wrong placeholder type** — defaulting every placeholder to `"String"` produces wrong codegen for `int`/`num`/`DateTime`. Inspect the source variable's type.
- **Hardcoded copy moved into a Widget** — extraction must happen at the call site, never inside a reusable widget. See [widget](mdc:.cursor/rules/widget.mdc).
- **Auto-translating English** — `app_en.arb` needs human translation. Leave a clearly-marked TODO so the user fills it; do not guess.
- **Extracting `Failure.message`** — Failures may carry developer-readable messages. User-visible error copy is produced by the View when mapping failures, not pulled from `Failure.message` directly. See [failure](mdc:.cursor/rules/failure.mdc).
- **Extracting from tests / fixtures** — golden scenarios depend on stable Cyrillic literals. Skip every file under `/test/`.
- **Brand names** — `'UP Coins'`, `'UP Sushi'` may be intentionally untranslated. Confirm with the user instead of auto-keying them.
