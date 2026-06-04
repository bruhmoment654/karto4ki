---
name: feedback-loop
description: Verification and quality assurance feedback loop. Runs auto-fix, static analysis, and iterates until all errors are resolved.
---

# Feedback Loop

Run automated fixes and static analysis iteratively until zero errors remain.

**Critical rule:** DO NOT STOP until all errors are resolved.

---

## Allowed Commands (Strict Allowlist)

You MUST use ONLY the following commands during verification. **Do NOT call underlying tools directly.**

| Action | Command | Notes |
|--------|---------|-------|
| Autofix (scoped) | `make autofix-scope DIR=<package_dir> SCOPE=<relative_path>` | Runs both `dart fix` and `dcm fix` in the specified package |
| Analyze (scoped) | `make analyze-scope DIR=<package_dir> SCOPE=<relative_path>` | Runs both `dart analyze` and `dcm analyze` in the specified package |

- `DIR` — package directory from project root (e.g. `apps/main`, `modules/datasource/network`)
- `SCOPE` — path relative to the package directory (e.g. `lib/feature/app/app.dart`, `lib/feature/app`). Defaults to `lib`.

**FORBIDDEN — never call these directly:**
- `dart analyze` / `fvm dart analyze`
- `dcm analyze` / `dcm fix`
- `fvm dart fix`
- Any other analysis or fix command not listed above

The `make` wrappers ensure consistent flags and tool ordering. Always use them.

---

## Workflow

For each target file (newly created or modified `*.dart` files):

```
REPEAT:
    1. make autofix-scope DIR=<package_dir> SCOPE=<relative/path/to/file.dart>
    2. make analyze-scope DIR=<package_dir> SCOPE=<relative/path/to/file.dart>
    3. IF errors persist after autofix → fix manually, then GOTO 1
    4. CONTINUE until zero errors
```

**Escalation:** If the same error persists after 3+ manual fix attempts, document as blocker.

---

## Output

```markdown
### Verification Results

**Files verified:** {count}
**Iterations:** {number}

| File | Iterations | Status |
|------|------------|--------|
| path/to/file.dart | 2 | PASSED |

**Manual fixes:** {list if any}
**Final status:** PASSED / BLOCKED
```

---

## Rules

- Always run autofix before analyze
- Try autofix again after manual changes
- Do not skip files or ignore warnings
- Do not proceed with unresolved errors
- Use ONLY the commands from the Allowed Commands table — no exceptions
