---
name: validate-ai-setup
description: >-
  Validate consistency of .cursor/rules and .claude/skills files.
  Checks cross-references, frontmatter, logical contradictions,
  and code example consistency. Use when rules/skills are added or modified.
disable-model-invocation: true
allowed-tools: Read, Grep, Glob, Bash(python3 *)
---

# Validate Rules & Skills

Validates the consistency and correctness of `.cursor/rules/*.mdc` and `.claude/skills/*/SKILL.md` files. Combines deterministic checks (Python script) with LLM-based semantic analysis.

---

## Phase 1: Deterministic Validation

Run the validation script:

```bash
python3 ${CLAUDE_SKILL_DIR}/scripts/validate.py --project-root .
```

Parse the JSON output. Record all errors and warnings — they will be included in the final report.

If the script fails to execute, check that Python 3 is available and report the error.

---

## Phase 2: Semantic Analysis

Read ALL files in `.cursor/rules/*.mdc`, `.claude/skills/*/SKILL.md`, and `CLAUDE.md`.

Perform these 4 checks:

### 2.1 Logical Contradictions

Compare instructions across all rules and skills. Flag cases where:
- One rule prescribes a pattern and another rule prohibits it
- Two rules give conflicting guidance for the same scenario
- A rule's "Correct" example matches another rule's "Incorrect" example

Do NOT flag: stylistic differences, different levels of detail, or rules that apply to different contexts (e.g., View vs Widget rules are intentionally different).

### 2.2 Code Example Consistency

For each code example in a rule, check whether it violates patterns described in OTHER rules:
- Import style (relative vs package imports — see `imports.mdc`)
- Naming conventions (boolean prefixes, callback naming, class suffixes — see `dart-code-style.mdc`)
- Architecture boundaries (what can depend on what — see `feature-structure.mdc`)
- Freezed patterns (sealed class usage, factory naming — see `freezed.mdc`)

### 2.3 Terminology Consistency

Flag cases where the same concept is referred to by different names across rules. Examples:
- "Assembly" vs "DI container" vs "dependency provider"
- "ViewModel" vs "view model" vs "VM"
- "Side effect" vs "action" vs "one-time event"

Ignore: intentional synonyms used for readability within a single rule.

### 2.4 AI Review Rules Completeness

Check `AI_CODE_REVIEW_RULES.md` against the current rules:
- Each review-relevant rule's key requirements should be represented in the document (not just the heading — the substantive checks a reviewer needs)
- Document sections should not contain outdated patterns that rules have since updated
- Cross-references within the document (section anchors) should be consistent

If issues are found, recommend running `/sync-review-rules` to regenerate.

### 2.5 Skill–Rule Alignment

For each skill, verify that:
- Patterns described in the skill match what the corresponding rules prescribe
- Skills don't reference obsolete conventions that rules have since updated
- Command usage in skills is consistent with what rules recommend
- CLAUDE.md index descriptions are consistent with the actual rule/skill content

---

## Phase 3: Report

ultrathink

Output a unified markdown report with these sections:

```markdown
# Rules & Skills Validation Report

## Summary
- Rules checked: {count}
- Skills checked: {count}
- Errors: {count}
- Warnings: {count}

## 1. Broken References
{findings from Python script — broken_rule_reference, broken_project_reference}

## 2. Structural Issues
{findings from Python script — frontmatter, empty body}

## 2a. Index & Cross-Reference Issues
{findings — CLAUDE.md index sync, Makefile command validation}

## 3. Logical Contradictions
{findings from LLM analysis — contradictions, code example issues}

## 4. Terminology Issues
{findings from LLM analysis}

## 5. AI Review Rules Drift
{findings from Python script — ai_review_rules_missing, ai_review_rules_stale, ai_review_rules_removed_rule, ai_review_rules_missing_rule}
{findings from LLM analysis — content completeness}

## 6. Skill–Rule Alignment
{findings from LLM analysis}

## 7. Recommendations
{actionable suggestions for improvement}
```

Each finding must include:
- **Severity**: ERROR (must fix) or WARNING (should review)
- **File(s)**: which rule/skill files are involved
- **Description**: what the issue is
- **Suggestion**: how to fix it

If a section has no findings, write "No issues found." — do not omit the section.
