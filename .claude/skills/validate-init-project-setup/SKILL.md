---
name: validate-init-project-setup
description: Validate that init_project.sh and initialization documentation are consistent with the current project state. Checks that all template values referenced in the script actually exist in target files, that file paths are valid, and that no new template-specific values have appeared uncovered. Use when init_project.sh, project structure, native configs, or initialization docs are modified. Also use proactively after any structural changes to the template project.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash(python3 *)
---

# Validate Init Project Setup

This skill validates that the project initialization infrastructure (`init_project.sh` + `docs/guides/008-project-initialization.ru.md`) is consistent with the actual template project state.

The template evolves: files get added, paths change, naming conventions shift. This skill catches drift between what the init script expects and what actually exists.

## When to run

- After modifying `init_project.sh`
- After modifying `docs/guides/008-project-initialization.ru.md`
- After changes to native configs (Android `build.gradle.kts`, iOS `project.pbxproj`, `Info.plist`)
- After changes to `pubspec.yaml` files (root or app)
- After adding/removing modules or apps
- After changes to Makefile targets
- After changes to Mason brick templates

---

## Phase 1: Deterministic Validation

Run the Python validation script:

```bash
python3 ${CLAUDE_SKILL_DIR}/scripts/validate_init.py --project-root .
```

The script outputs JSON. Parse it and record all errors and warnings.

**What it checks:**
- `init_project.sh` exists and is executable
- `docs/guides/008-project-initialization.ru.md` exists
- Each OLD_* value from the script exists in its expected target file(s)
- All file paths referenced in the script exist on disk
- Makefile `init-project` and `init-project-dry` targets exist
- Codebase scan for uncovered template values (files containing OLD values that the script doesn't process)
- Documentation file paths point to existing files
- Script placeholder values (non-constant patterns like flavor names, export plist placeholders) exist in target files
- Bidirectional OLD_* constant sync (script ↔ validator — catches new/removed constants in either direction)
- New app modules under `apps/` that contain template values but aren't handled by the script

---

## Phase 2: Semantic Analysis

Read these files for semantic analysis:

**Script & Documentation:**
- `init_project.sh`
- `docs/guides/008-project-initialization.ru.md`

**Android configs:**
- `apps/main/android/app/build.gradle.kts`

**iOS configs (use Grep for specific values in large files):**
- `apps/main/ios/Runner.xcodeproj/project.pbxproj` — grep for PRODUCT_BUNDLE_IDENTIFIER and DEVELOPMENT_TEAM
- `apps/main/ios/Runner/Info.plist`
- `apps/main/ios/prodExportOptions.plist`
- `apps/main/ios/stageExportOptions.plist`

**Dart configs:**
- `pubspec.yaml` (root)
- `apps/main/pubspec.yaml`

Perform these 4 checks:

### 2.1 Replacement Order Correctness

iOS Bundle ID replacement order is critical. Verify that the script replaces the LONGER string first (e.g., `surfSkeleton.RunnerTests` before `surfSkeleton`). If order is wrong, the shorter replacement would corrupt the longer entries.

Check: In `phase_ios()`, the RunnerTests replacement must come BEFORE the base Bundle ID replacement.

### 2.2 Value Consistency

Verify that OLD_* constants in the script header match the actual values found in the target files. For example:
- `OLD_ANDROID_PACKAGE` must match the `namespace` in `build.gradle.kts`
- `OLD_IOS_BUNDLE_ID` must match `PRODUCT_BUNDLE_IDENTIFIER` in `project.pbxproj`
- `OLD_IOS_TEAM_ID` must match `DEVELOPMENT_TEAM` in `project.pbxproj`
- `OLD_DISPLAY_NAME` must match `CFBundleDisplayName` in `Info.plist`
- `OLD_BUNDLE_NAME` must match `CFBundleName` in `Info.plist`
- `OLD_DART_NAME` must match `name:` in `apps/main/pubspec.yaml`

If any mismatch is found, it is a CRITICAL error — the script will silently fail to replace that value.

### 2.3 Script-Project Drift

Verify that the script's phase logic still matches the actual project structure:

- **Phase functions reference existing patterns**: Read each `phase_*()` function in the script and verify that every hardcoded string it expects to find (sed patterns, grep patterns) actually exists in the corresponding file. For example, `phase_android()` expects `resValue("string", "app_name", "Stage")` in `build.gradle.kts` — confirm it's there.
- **Derived value formulas are still valid**: The `compute_derived()` function produces values (workspace name, Android app ID, iOS bundle ID, Kotlin path) based on assumptions about naming conventions. Verify these match the actual conventions used in the project files.
- **No new native configs added outside script scope**: Check if new `build.gradle.kts`, `project.pbxproj`, `Info.plist`, or `strings.xml` files exist beyond the paths the script handles. If they contain template values, the script needs updating.

### 2.4 Documentation Accuracy

Verify that:
- All file paths in the documentation use correct monorepo paths (e.g., `apps/main/android/...` not `android/...`)
- The phases described in the documentation match what the script actually does
- The checklist items in the documentation cover all replacements the script performs
- The derived value formulas in the documentation match the script's `compute_derived()` function

---

## Phase 3: Report

Generate a markdown report with this structure:

```markdown
# Init Project Setup Validation Report

## Summary
- Script: init_project.sh [OK/MISSING/NOT EXECUTABLE]
- Documentation: docs/guides/008-project-initialization.ru.md [OK/MISSING]
- Makefile targets: [OK/MISSING targets listed]
- Errors: N, Warnings: N

## 1. Structural Issues
<!-- From Python script: script_exists, script_executable, doc_exists,
     target_file_missing, dart_dir_missing, kotlin_dir, mdc_dir_missing,
     makefile_target -->

## 2. Script-Project Sync
<!-- From Python script: script_constant_missing, script_constant_mismatch,
     script_constant_unknown, old_value_not_found, old_value_target_missing,
     placeholder_not_found -->

## 3. Coverage Gaps
<!-- From Python script: uncovered_template_value, new_app_module -->

## 4. Documentation Paths
<!-- From Python script: doc_path_invalid -->

## 5. Replacement Order
<!-- From LLM semantic analysis: iOS Bundle ID order check -->

## 6. Value Consistency
<!-- From LLM semantic analysis: OLD_* vs actual file content -->

## 7. Script-Project Drift
<!-- From LLM semantic analysis: phase function patterns vs actual files,
     derived value formulas, new native configs outside script scope -->

## 8. Documentation Accuracy
<!-- From LLM semantic analysis: path correctness, phase matching,
     checklist completeness, derived value formulas -->

## 9. Recommendations
<!-- Prioritized list of fixes, synthesizing all findings above -->
```

Each finding must include:
- **Severity**: ERROR (will break initialization) or WARNING (potential issue)
- **File(s)**: Affected file path(s)
- **Description**: What is wrong
- **Suggestion**: How to fix it

If a section has no findings, write "No issues found." — do not omit the section.
