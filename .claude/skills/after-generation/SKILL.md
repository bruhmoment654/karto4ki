---
name: after-generation
description: Post-generation workflow that orchestrates code generation and quality verification for created or modified Dart files.
---

# After Generation

Orchestration skill to run after creating or modifying `*.dart` files. Executes two phases in order.

---

## Phase 1: Code Generation (conditional)

**Trigger:** You created or modified files that use **freezed**, **json_serializable**, **retrofit**, or **auto_route** annotations.

**Skip** this phase if no generated outputs are affected.

**NEVER edit generated files** (`.g.dart`, `.freezed.dart`, `.gr.dart`) manually.

**Action:** Invoke the `code-generation` skill for all affected files.

---

## Phase 2: Code Review (always)

After code generation completes (or is skipped), invoke the `feedback-loop` skill on **every** `.dart` file you created or modified.

---

## Workflow Summary

```
1. IF source files use code-generation annotations:
       → run code-generation skill
2. ALWAYS:
       → run feedback-loop skill on all created/modified .dart files
```
