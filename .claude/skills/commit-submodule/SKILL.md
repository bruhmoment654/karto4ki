---
name: commit-submodule
description: >-
  Automate the full submodule-change lifecycle: detect modified submodules,
  create a feature branch inside the submodule, commit, push, generate the
  GitLab MR URL, then bump the submodule pointer in the parent repo as a
  separate commit. Picks up any intermediate state (dirty / staged / committed
  but unpushed / pushed but parent pointer not bumped) and continues from
  there. Use when you've edited a file inside `docs/flutter-rules/` (or any
  other submodule) and need to land the change properly.
---

# Commit Submodule

End-to-end automation for committing into a git submodule and bumping the
pointer in the parent repository.

> **GitLab, not GitHub.** Origin is `surfstudio.gitlab.yandexcloud.net`. The
> `gh` CLI does not work; `glab` may or may not be installed. The skill prints
> a ready-to-open "New MR" URL for the submodule; landing the MR is a manual
> step (or via `glab` if present).

## Why this is non-trivial

A submodule is an independent git repository nested inside the parent. Editing
a file inside it produces **two** changes:

1. A real file diff inside the submodule (`<submodule>/...mdc`).
2. A "pointer moved" diff in the parent (`Subproject commit <old> → <new>`).

Both must be committed, pushed, and merged **in the right order**. If you
push the parent pointer before pushing the submodule branch, anyone who pulls
the parent will land on a SHA that doesn't exist on the submodule's remote and
their `git submodule update` will fail.

The skill enforces the order: submodule first, parent second.

## Inputs

- Parent repo `.gitmodules` (list of submodules and their remotes).
- `git status` of the parent and each submodule.
- Parent branch name (for ticket parsing).
- Optional user-supplied:
  - Submodule path (if more than one is dirty).
  - Submodule branch name (skill suggests one).
  - Commit type / summary (skill suggests one).

## State Machine

Before doing anything, run discovery and classify each submodule into one of
these states. Then jump to the right step.

| State | How to detect | Where to resume |
|---|---|---|
| `clean` | Submodule working tree clean AND `HEAD` SHA equals what the parent points at | Nothing to do — skip this submodule |
| `dirty` | `git -C <sub> status --porcelain` non-empty | Step 1 (Resolve branch) |
| `committed_local` | Submodule clean, `HEAD` ≠ parent pointer, but `HEAD` not on a remote-tracking branch / branch ahead of upstream | Step 4 (Push) |
| `pushed` | Submodule clean, `HEAD` ≠ parent pointer, `HEAD` is on a remote-tracking branch and up to date with upstream | Step 6 (Bump parent) |
| `bumped` | Parent has the submodule path staged or committed with the new SHA AND the new SHA is reachable on the submodule remote | Step 7 (Verify + print summary) |

The skill is **idempotent**: running it repeatedly on the same state is safe
and converges toward `bumped`.

## Discovery

Run from the parent repo root:

```bash
# List all submodules and their paths
git config --file .gitmodules --get-regexp '^submodule\..*\.path$' \
  | awk '{print $2}'

# For each submodule path <sub>:
git -C <sub> rev-parse --abbrev-ref HEAD
git -C <sub> status --porcelain
git -C <sub> rev-parse HEAD
git -C <sub> log -1 --format='%h %s'
git ls-tree HEAD <sub>                # parent's recorded SHA for the submodule
git -C <sub> rev-list @{u}..HEAD      # unpushed commits, fails if no upstream
```

If more than one submodule needs attention, **process them one at a time**:
ask the user which to start with, finish the full cycle for that submodule
(steps 1–7), then loop back.

## Step 1: Resolve the Submodule Branch

Inside the submodule:

```bash
git -C <sub> rev-parse --abbrev-ref HEAD
```

Decision matrix:

| Current state | Action |
|---|---|
| Detached HEAD (`HEAD`) | **Create a new branch** (see naming below). Refuse to commit on detached HEAD. |
| `main` / `master` | **Block by default.** Suggest creating a feature branch. Only proceed on `main` if the user explicitly confirms — and warn that shared rule submodules usually require an MR. |
| Existing feature branch matching `[A-Z]+-\d+.*` | Reuse it. Show the user the branch name and ask for confirmation before committing on top. |
| Existing feature branch not matching the parent ticket | Warn, ask: reuse or create new from parent ticket? |

### Branch name

Format: `<TICKET>-<short-kebab-scope>` (matches the convention seen in this
repo's submodule history, e.g. `UPSH-131-uikit-changes`).

- `<TICKET>` — parsed from the parent branch with regex `[A-Z]+-\d+` (first
  match). If the parent branch starts with `no-task/` or has no ticket, use
  `no-task` as the prefix.
- `<short-kebab-scope>` — derived from the changed files inside the submodule.
  Heuristics:
  - One file changed under `.cursor/rules/<name>.mdc` → `<name>-rules`.
  - Many rule files → `rules-update`.
  - File under `.claude/skills/<name>/` → `<name>-skill`.
  - Otherwise — propose `update` and let the user override.

Show the proposed name and **wait for confirmation** before creating.

```bash
git -C <sub> checkout -b <branch>
```

## Step 2: Build the Commit Message

Format: `<type>(<ticket>): <short summary in Russian>`

- `<type>` — inferred from changed paths:
  - `.cursor/rules/`, `.claude/skills/`, `docs/` → `docs` (rules are docs)
  - source code (`.dart`, `.py`, etc.) → `feat` or `fix` based on diff
  - config (`pubspec.yaml`, `.gitignore`, hooks) → `chore`
  - When mixed → ask.
- `<ticket>` — parent's ticket; if none, `no-task` (matches repo convention,
  e.g. `feat(no-task): скиллы клиентского приложения`).
- Russian short imperative summary — see existing log: `git -C <sub> log --oneline -10`.

Example output to confirm with the user:

```
docs(UPSH-131): добавить маппинги для UIKit курьерского приложения
```

The user can edit before commit. Never commit without confirmation.

## Step 3: Stage & Commit

Stage **only the intended files** — never `git add -A` inside a submodule
(shared rule repos may have stale local-only files like `.idea/` or
`AI_CODE_REVIEW_RULES.md` that you don't want to sweep in).

```bash
git -C <sub> add <explicit paths>
git -C <sub> status            # show user what's staged
git -C <sub> diff --staged     # surface the actual diff
```

Show the staged diff to the user. After explicit confirmation:

```bash
git -C <sub> commit -m "<message>"
```

**Hook failures.** If the commit fails on a pre-commit hook:
- Read the hook output, fix the underlying issue (lint / format / generated
  files).
- Re-stage, **create a new commit** (do not `--amend`; see CLAUDE.md /
  Git Safety Protocol).
- Never pass `--no-verify`.

## Step 4: Pre-Push Safety Checks

Surface these before pushing — **do not auto-fix**:

| Check | Action |
|---|---|
| Branch is `main` / `master` | **Block** by default; confirm explicitly to override |
| Commit messages contain `WIP`, `tmp`, `fixup!`, empty subject | Warn |
| Diff > 400 lines (excluding generated) | Warn |
| Sensitive files (`.env*`, `*credentials*`, `*.keystore`, `*.p12`) | **Block** |
| Remote branch already exists with diverged history | **Block** — needs rebase/merge, not force-push |

## Step 5: Push

```bash
git -C <sub> push -u origin <branch>
```

- `-u` only on first push for that branch. If `@{u}` already resolves, drop it.
- **Never** `--force` or `--force-with-lease` without explicit user request,
  and never on shared branches (`main`, `master`, `develop`).
- Never bypass hooks (`--no-verify`).

## Step 6: Bump Parent Pointer

After the submodule branch is on the remote, bump the parent.

### Read the submodule remote URL

```bash
git -C <sub> remote get-url origin
```

Parse host/group/repo for the MR URL (same logic as `/create-pr`):

- SSH form: `git@<host>:<group>/<repo>.git` → `https://<host>/<group>/<repo>`
- HTTPS form: `https://<host>/<group>/<repo>.git` → strip `.git`

### Stage and commit ONLY the submodule path

```bash
# from the parent root
git status                       # may show many unrelated dirty files
git add <sub>                    # stage ONLY the submodule pointer
git status                       # verify nothing else is staged
git diff --staged                # should be a single 'Subproject commit ...' line
```

**Critical:** never `git add .` or `git add -A` here. The parent repo often
has unrelated dirty files (other work in progress). Stage exactly the
submodule path.

Commit message:

```
chore(<ticket>): bump <sub> to include <short-scope>
```

Examples:

- `chore(UPSH-131): bump flutter-rules to include courier UIKit mapping`
- `chore(no-task): bump flutter-rules to main`

Run after confirmation:

```bash
git commit -m "<message>"
```

### When to push the parent

**Do not push the parent automatically.** The parent push is part of the
feature branch workflow and belongs to `/create-pr`. The skill prints the
parent commit SHA and reminds the user that the submodule MR must be merged
**before** the parent MR is merged.

## Step 7: Output

Print to chat:

1. **Submodule branch** and **submodule commit SHA**.
2. **MR URL** for the submodule (ready to open):
   ```
   https://<host>/<group>/<repo>/-/merge_requests/new?merge_request[source_branch]=<branch>&merge_request[target_branch]=main
   ```
3. **Parent commit SHA** (the pointer bump).
4. **Order-of-merge reminder**: submodule MR → merge → parent MR.
5. If the user wants the parent on `main` of the submodule eventually, remind
   them to re-run the skill after the submodule MR merges, picking the
   `Re-bump to main` flow (Step 8).

## Step 8: Re-Bump to Main (Post-Merge)

After the submodule MR is merged, the parent should point at the merged main
SHA, not the feature branch SHA. Detect this state and offer a re-bump:

```bash
git -C <sub> fetch origin
git -C <sub> checkout main
git -C <sub> pull --ff-only
cd ../..
git add <sub>
git commit -m "chore(<ticket>): bump <sub> to main"
```

The skill should detect this scenario by comparing the parent's pointer with
`origin/main` of the submodule: if `origin/main` contains the previous
feature-branch SHA, offer the re-bump.

## Step-by-Step Process (Runtime)

1. **Discovery** — list submodules, classify state per the state machine.
2. **Pick target submodule** — if multiple are dirty, ask user which to do
   first; otherwise proceed with the only candidate.
3. **Resolve branch** (Step 1) — show current branch, propose a branch name
   if a new one is needed, wait for confirmation.
4. **Build commit message** (Step 2) — propose, wait for confirmation.
5. **Stage & commit** (Step 3) — show staged diff, confirm, commit.
6. **Pre-push checks** (Step 4) — block on red, warn on yellow.
7. **Push** (Step 5) — confirm, push.
8. **Bump parent pointer** (Step 6) — show `git diff --staged` (must be only
   the submodule line), confirm, commit.
9. **Print summary** (Step 7) — branch / SHAs / MR URL / reminders.
10. **Offer `/create-pr`** for the parent branch if the user is finishing the
    feature.

## Picking Up Intermediate State

If the skill is invoked when the submodule is already past step N, **skip
the completed steps** and resume from N+1. Always re-run discovery first.

Common intermediate states:

| Scenario | Resume at |
|---|---|
| User already created a feature branch, committed, but not pushed | Step 4 (Pre-push checks) |
| User pushed but parent pointer not bumped | Step 6 (Bump parent) |
| Submodule MR was merged; parent still points at feature SHA | Step 8 (Re-bump to main) |
| Multiple submodules dirty | Loop steps 1–7 per submodule |

## Common Pitfalls

- **Auto-staging the entire parent repo** — `git add .` in the parent often
  pulls in dozens of unrelated work-in-progress files. Stage only `<sub>`.
- **Pushing the parent before the submodule** — anyone who pulls the parent
  lands on a SHA that doesn't exist on the submodule's remote. The skill
  enforces submodule push first.
- **Force-pushing a shared submodule branch** — never. If history needs to be
  rewritten, abandon the branch and start a new one.
- **`--amend` after a hook failure** — the failed commit didn't happen, so
  `--amend` modifies the *previous* commit. Always create a new commit.
- **Skipping hooks with `--no-verify`** — fix the underlying issue instead.
- **Bumping to a feature branch SHA and merging the parent before the
  submodule** — order of merge matters; warn the user.
- **Detached HEAD commits** — commits on detached HEAD are not on any branch
  and disappear after the next checkout. Always create a branch first.
- **Submodule remote different from parent remote** — they are independent
  repos. Build the MR URL from `git -C <sub> remote get-url origin`, never
  from the parent's remote.
- **Wrong ticket on the submodule branch** — the parent's ticket usually
  applies; if the submodule change is generic and serves multiple parent
  tickets, prefer `no-task` and document it in the commit body.
- **Forgetting the re-bump to `main`** — if the parent merges while the
  submodule pointer still references the feature branch, future `git
  submodule update` works but the history graph looks weird. Re-bump after
  the submodule MR merges.

## Quick Reference (manual fallback)

If something goes wrong and the skill can't continue, here is the canonical
sequence the user can run by hand:

```bash
# --- inside the submodule ---
cd docs/flutter-rules
git checkout -b UPSH-XXX-short-scope          # or reuse existing
git add <files>
git status
git diff --staged
git commit -m "docs(UPSH-XXX): краткое описание"
git push -u origin UPSH-XXX-short-scope

# --- back in the parent ---
cd ../..
git status
git add docs/flutter-rules                    # ONLY the submodule path
git diff --staged                             # one 'Subproject commit ...' line
git commit -m "chore(UPSH-XXX): bump flutter-rules to include ..."

# --- later, after the submodule MR is merged ---
cd docs/flutter-rules
git fetch origin
git checkout main
git pull --ff-only
cd ../..
git add docs/flutter-rules
git commit -m "chore(UPSH-XXX): bump flutter-rules to main"
```
