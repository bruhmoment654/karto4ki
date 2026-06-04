---
name: code-generation
description: Execute code generation for created source files. Handles build_runner (freezed, json_serializable, retrofit, auto_route, theme_tailor, flutter_gen) and localization via Melos. Use after creating or modifying source files that require code generation.
---

# Code Generation Skill

## When to Use

After creating or modifying source files that contain `part` directives for generated files (`.g.dart`, `.freezed.dart`, `.gr.dart`, `.tailor.dart`) or localization `.arb` files.

## Prerequisites

- All source files are saved with correct annotations and `part` directives
- No syntax errors in source files
- Dependencies bootstrapped (`make bootstrap`)

## Execution

### 1. Choose Generation Scope

**Scoped (preferred)** — fastest, use when you changed a few files and want to regenerate only specific outputs.

`--build-filter` filters **output** files (`.g.dart`, `.freezed.dart`, etc.), not source files. It accepts glob patterns. The path is relative to the **project root** — the package is auto-resolved from the path prefix.

```bash
# Single output file
make gen-scope scope="apps/main/lib/feature/auth/domain/entity/user.g.dart"

# All freezed outputs in a folder
make gen-scope scope="apps/main/lib/feature/auth/**/*.freezed.dart"

# All generated outputs for a specific source (matches user.g.dart, user.freezed.dart, etc.)
make gen-scope scope="apps/main/lib/feature/auth/domain/entity/user.*.dart"

# All generated outputs in a module
make gen-scope scope="modules/datasource/network/lib/**/*.g.dart"

# Multiple generator types via brace expansion
make gen-scope scope="apps/main/lib/feature/auth/**/*.{g,freezed}.dart"
```

Parameters:
- `scope` — glob pattern for generated **output** files, relative to the project root. The package root (`pubspec.yaml`) is auto-resolved from the path prefix.

**Module-scoped** — use when many files in one module changed:
```bash
make gen-app           # apps/main (freezed, json_serializable, retrofit, auto_route, flutter_gen)
make gen-ui            # modules/ui (theme_tailor, flutter_gen + localization)
make gen-network       # modules/datasource/network (json_serializable, retrofit)
make gen-persistence   # modules/datasource/persistence (json_serializable)
```

**All modules** — use when changes span multiple modules:
```bash
make gen-all
```

**Localization only** — after modifying `.arb` files in `modules/ui/lib/l10n/`:
```bash
make gen-l10n
```

### 2. Verify Results

- Check expected generated files exist and are non-empty
- Review command output for errors

### 3. Handle Failures

**CRITICAL: NEVER modify generated files directly.**

If generation fails:
1. Fix syntax/annotation errors in **source files only**
2. Delete problematic generated file if corrupted
3. Re-run generation

For verbose output: add `--verbose` flag to the underlying `build_runner` command.

## Module Structure

This is a Melos monorepo. Each module runs `build_runner` independently.

**Important:** `build.yaml` does NOT inherit from parent directories. Every module using code generation must have its own `build.yaml`.

| Module | Path | Generators |
|--------|------|------------|
| app | `apps/main` | freezed, json_serializable, retrofit, auto_route |
| ui | `modules/ui` | theme_tailor, flutter_gen, gen-l10n |
| network | `modules/datasource/network` | json_serializable, retrofit |
| persistence | `modules/datasource/persistence` | json_serializable, drift |

## Output

```markdown
### Code Generation Results

**Command:** {executed command}
**Scope:** {scope pattern, module name, or "all"}

| Source File | Generated File | Status |
|-------------|----------------|--------|
| path/to/source.dart | path/to/source.g.dart | SUCCESS |

**Issues:** {any warnings or errors, or "None"}
**Final status:** SUCCESS / FAILED
```