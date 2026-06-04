---
name: sync-review-rules
description: >-
  Regenerate AI_CODE_REVIEW_RULES.md from current .cursor/rules/*.mdc files.
  Use when /validate-ai-setup reports AI review rules drift, or after adding/modifying architecture rules.
---

# Sync Review Rules

Regenerates `AI_CODE_REVIEW_RULES.md` — a self-contained document for an AI agent that reviews MRs in GitLab. The agent can ONLY read this one file, so it must contain all architecture rules in a condensed, reviewable format.

**Hard limit: the file MUST be under 10 000 tokens** (o200k_base tokenizer). Files exceeding this budget are truncated by the AI Code Review system. After generation, verify the token count:

```bash
python3 -c "import tiktoken; enc = tiktoken.get_encoding('o200k_base'); print(len(enc.encode(open('AI_CODE_REVIEW_RULES.md').read())))"
```

If over budget, condense the longest sections (reduce code examples, merge similar rules) until under 10K.

---

## Step 1: Read All Rule Files

Read every `.cursor/rules/*.mdc` file in the project.

**Exclude** these workflow-only rules (not relevant for code review):
- `fvm-usage.mdc`
- `use-makefile.mdc`

---

## Step 2: Compute SHA-256 Fingerprints

For each included rule file, compute `sha256` of the file content. These will be embedded as HTML comments in the output for drift detection.

Use Bash:
```bash
shasum -a 256 .cursor/rules/<filename>.mdc | cut -d' ' -f1
```

---

## Step 3: Generate Document

Write `AI_CODE_REVIEW_RULES.md` at the project root with the following structure.

### Document Template

The document must follow this exact section structure:

```
# AI CODE REVIEW RULES

> Auto-generated notice + purpose description

## How to Use This Document
(Brief guide for the AI reviewer)

## 1. Architecture Components
<!-- source: .cursor/rules/components-index.mdc | sha256: {hash} -->
(from components-index.mdc)

## 2. Project & Feature Structure
<!-- source: .cursor/rules/project-structure.mdc | sha256: {hash} -->
<!-- source: .cursor/rules/feature-structure.mdc | sha256: {hash} -->
(from project-structure.mdc + feature-structure.mdc)

## 3. Screen Architecture
<!-- source: .cursor/rules/screen-structure.mdc | sha256: {hash} -->
### 3.1 Flow
<!-- source: .cursor/rules/flow.mdc | sha256: {hash} -->
### 3.2 ViewModel
<!-- source: .cursor/rules/view-model.mdc | sha256: {hash} -->
### 3.3 View
<!-- source: .cursor/rules/view.mdc | sha256: {hash} -->
### 3.4 Widget
<!-- source: .cursor/rules/widget.mdc | sha256: {hash} -->

## 4. Business Logic (BLoC)
### 4.1 Bloc Pattern
<!-- source: .cursor/rules/bloc-pattern.mdc | sha256: {hash} -->
### 4.2 Events
<!-- source: .cursor/rules/bloc-event.mdc | sha256: {hash} -->
### 4.3 States
<!-- source: .cursor/rules/bloc-state.mdc | sha256: {hash} -->
### 4.4 Actions
<!-- source: .cursor/rules/bloc-action.mdc | sha256: {hash} -->

## 5. Domain Layer
### 5.1 Entity
<!-- source: .cursor/rules/entity.mdc | sha256: {hash} -->
### 5.2 Result
<!-- source: .cursor/rules/result.mdc | sha256: {hash} -->
### 5.3 Failure
<!-- source: .cursor/rules/failure.mdc | sha256: {hash} -->

## 6. Data Layer
### 6.1 Repository
<!-- source: .cursor/rules/repository.mdc | sha256: {hash} -->
### 6.2 Converter
<!-- source: .cursor/rules/converter-creation.mdc | sha256: {hash} -->
### 6.3 Data Source
<!-- source: .cursor/rules/data-source.mdc | sha256: {hash} -->

## 7. Data Sources
### 7.1 Retrofit API / DTO
<!-- source: .cursor/rules/retrofit-api-generation.mdc | sha256: {hash} -->
### 7.2 Persistence Storage
<!-- source: .cursor/rules/persistence-storage.mdc | sha256: {hash} -->
### 7.3 Database DAO
<!-- source: .cursor/rules/database-dao.mdc | sha256: {hash} -->

## 8. Dependency Injection
<!-- source: .cursor/rules/dependency-injection.mdc | sha256: {hash} -->

## 9. UI Conventions
### 9.1 UI Decomposition
<!-- source: .cursor/rules/ui-components-decomposition.mdc | sha256: {hash} -->
### 9.2 UI Implementation
<!-- source: .cursor/rules/ui-impl-conventions.mdc | sha256: {hash} -->
### 9.3 UIKit Usage
<!-- source: .cursor/rules/uikit-usage.mdc | sha256: {hash} -->

## 10. Code Style
### 10.1 Dart Conventions
<!-- source: .cursor/rules/dart-code-style.mdc | sha256: {hash} -->
### 10.2 Import Rules
<!-- source: .cursor/rules/imports.mdc | sha256: {hash} -->
### 10.3 Freezed Patterns
<!-- source: .cursor/rules/freezed.mdc | sha256: {hash} -->
### 10.4 Localization
<!-- source: .cursor/rules/localization-process.mdc | sha256: {hash} -->
```

### Content Guidelines

For each section:
1. **Strip frontmatter** — do not include YAML frontmatter from `.mdc` files
2. **Convert `mdc:` links** to internal section references within the document (e.g., `(see Section 6.1)`)
3. **Condense for review** — focus on what a reviewer needs to check, not how to generate code
4. **Include key code examples** — show correct and incorrect patterns with `✅`/`❌` markers
5. **Preserve all rules and constraints** — nothing may be omitted or softened
6. **Keep tables** from the original rules where they add clarity

### New Rules

If a new `.mdc` file exists that is not in the template above:
- Determine which section it belongs to based on its content
- Add it to the appropriate section with its `<!-- source: ... -->` comment
- If it doesn't fit any existing section, add a new section at the end

---

## Step 4: Verify

After writing the file, run the validation script to confirm zero drift:

```bash
python3 .claude/skills/validate-ai-setup/scripts/validate.py --project-root .
```

Check that there are no `ai_review_rules_*` findings in the output.
