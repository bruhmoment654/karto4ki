---
name: create-pr
description: Build a GitLab merge request for the current branch — generates title and description following the project's MR template, parses JIRA ticket from branch name, summarizes the diff, runs pre-push safety checks, pushes the branch, and outputs a ready-to-open GitLab "new MR" URL. Use when finishing a feature branch.
---

# Create Merge Request

Build a GitLab merge request for the current branch.

> **GitLab project, not GitHub.** Origin is `surfstudio.gitlab.yandexcloud.net`. The `gh` CLI does not work here. `glab` is also not installed by default. The skill produces the MR text + a ready-to-open GitLab URL; the user pastes the description and creates the MR via the web UI (or via `glab` if they install it).

## Inputs

- Current branch (must not be `main`).
- Target branch to compare against — **must be confirmed with the user before any diff/log work**. See "Target Branch" below.
- Commits diverging from the resolved target branch.

## Target Branch

**Never silently default to `main`.** Before reading commits or building the diff:

1. If the user explicitly named a target branch in the request (e.g. "сделай MR в `develop`"), use it.
2. Otherwise, **ask the user** which branch to compare against. Suggest sensible candidates from the local repo state:
   - `main` (project default base).
   - The branch that the current branch was forked from, if detectable (e.g. `feature/profile` for `UPSH-112-delivery-adress` — visible in `git log --oneline --all --decorate` or recent merge commits).
   - Any branch matching `feature/*` that the current branch's history points to.
3. Wait for an explicit answer before proceeding. Do not guess.

Once confirmed, use the chosen branch everywhere the skill currently references `main` (merge-base, log range, diff range, MR URL `target_branch` param, `glab --target-branch`).

## Branch Name → JIRA Ticket

Parse the ticket ID from the branch name. Conventions seen in this repo:

| Branch                       | Ticket    |
|------------------------------|-----------|
| `UPSH-101-main-order-view`   | `UPSH-101` |
| `UPSH-93/cart-view`          | `UPSH-93`  |
| `feature/profile`            | none      |
| `no-task/golden-tests`       | none → `no-task` literal in commit/title |

Regex: first match of `[A-Z]+-\d+` in the branch name. If none, fall back to `no-task` for the title prefix when the branch path starts with `no-task/`; otherwise omit the parenthesized ticket entirely.

## Title

Format: `<type>(<ticket>): <short imperative>`

- `<type>` from history: `feat`, `fix`, `chore`, `docs`, `refactor`.
- Russian short summary (matches repo convention — see `git log`).
- ≤ 70 characters; details go in the body.

Examples from history:
- `feat(UPSH-91): оверлей-вариант БС`
- `feat(no-task): тесты настроек`
- `fix(UPSH-112): правки по ревью`

If multiple commits exist, derive the title from the **dominant theme** of the diff, not from the latest commit subject.

## Body — Изменения + Проблемы only

The saved file contains **only** the `## Изменения` section and, if any caveats exist, the `## Проблемы` section. Nothing else — no `## Скриншот / Видео`, no checklists, no template scaffolding. The GitLab MR template auto-populates the rest when the user opens the create-MR URL; the user pastes the Изменения/Проблемы block into the corresponding sections in the GitLab UI and fills the rest manually.

### `## Изменения` — keep it short

Goal: tell the reviewer *what* changed. Not *how*, not file-by-file.

Pick the bullet style by intent:

| Intent                          | Style                                                               |
|---------------------------------|---------------------------------------------------------------------|
| New screen / feature            | **One line.** E.g. `Сделан экран "Адреса доставки"`. Don't enumerate Flow/ViewModel/Bloc/Repository — derivable from the diff. |
| Modification to existing code   | **2–5 short bullets**, one line each, focused on behavior change.   |
| Bugfix                          | **One line** — what was broken, now works.                          |
| Refactor                        | **One line** on the goal (e.g. `Вынесены price-методы в PriceEntity`). |
| Mixed                           | Group by intent, still ≤ ~6 bullets total.                          |

Hard rules:
- Never list every changed file.
- Never restate commit messages verbatim.
- Never include generated artifacts (`*.g.dart`, `*.freezed.dart`, `app_localizations*.dart`, `assets.gen.dart`, `fonts.gen.dart`). Add a single line `обновлена кодогенерация` only if the regenerated artifacts span unrelated areas.
- > ~6 bullets means you're describing implementation, not changes. Cut it down.

Examples:

```markdown
✅ New screen:
- Сделан экран "Адреса доставки"

✅ Modification:
- Добавлен бонусный счётчик в карточку товара
- Skeleton у `AppOrderHistoryCard` теперь учитывает количество позиций
- В `CartBloc` событие `priceUpdated` мёржится с предыдущим стейтом, а не перезаписывает

✅ Bugfix:
- Поправлен сброс выбранного адреса при перезаходе в корзину

❌ Too detailed (rewrite as one line):
- Создан `ProfileFlow` с роутингом
- Создан `ProfileViewModel` с полями profileState и onLogoutPressed
- Создан `ProfileBloc` с 4 events и 5 states
- Создан `IProfileRepository` и имплементация ProfileRepository
- Создан `ProfileApi` с GET /profile, PATCH /profile
- Добавлены ARB-ключи под segment Profile
```

### `## Проблемы (опционально)`

Only fill when the diff or git log surfaces real caveats: TODOs added (`// TODO`), `// FIXME`, skipped tests, deliberate partial work (commits like `feat: оставил TODO`). One short line per caveat. **If there are no caveats, omit the entire section** (heading and all) — don't leave an empty `## Проблемы` in the file.

## Submodule Bump Detection (КРИТИЧНО)

If the MR includes a bump of any git submodule, the body **MUST** carry an explicit blocker pointing at the submodule MR, otherwise the parent MR can be merged before the submodule MR — landing a parent commit that references a SHA living only on a feature branch. Once that feature branch is squash-merged or deleted, `git submodule update` breaks for everyone on `main`.

### Detect

Run from the parent repo root after resolving `<target>`:

```bash
# 1. List submodule paths
git config --file .gitmodules --get-regexp '^submodule\..*\.path$' | awk '{print $2}'

# 2. For each submodule path <sub>, check if its pointer changed in this MR
git diff <target>...HEAD -- <sub> | grep -E '^[+-]Subproject commit'
```

If the second command returns two lines (old and new `Subproject commit ...`), the MR contains a bump → continue to "Verify".

### Verify the bump points to an already-merged SHA

```bash
NEW_SHA=$(git -C <sub> rev-parse HEAD)
git -C <sub> fetch origin
git -C <sub> merge-base --is-ancestor "$NEW_SHA" origin/main && echo "ON MAIN" || echo "FEATURE BRANCH"
```

- **`ON MAIN`** → the submodule's main already contains this commit. No blocker needed. Add a short note to `## Изменения`: `Перебамплен указатель <sub> на main`.
- **`FEATURE BRANCH`** → the SHA only exists on a feature branch of the submodule. **Blocker required.**

### Find the submodule MR

The skill can't reliably read GitLab API without auth. Resolve the MR URL one of these ways, in order:

1. Recent push output — look at `git -C <sub> reflog` and the last `git push` stderr; GitLab prints "View merge request for ...: https://..."
2. Ask the user — "На какой MR в `<sub>` ссылается этот bump?"
3. Construct a search URL: `https://<host>/<group>/<sub>/-/merge_requests?scope=all&state=opened&source_branch=<branch>` where `<branch>` is `git -C <sub> rev-parse --abbrev-ref HEAD`.

### Required blocker in body

Add a **`## Блокировка`** section to `MR.md` (placed right after `## Изменения`, before `## Проблемы`):

```markdown
## Блокировка

Блокируется: `<sub>!<MR-number>` — <MR-url>. Не мерджить до его мержа и re-bump'а указателя на main сабмодуля (см. `/commit-submodule` Step 8).
```

If multiple submodules bumped — one bullet per submodule.

### Recommend Draft status

When a blocker is added, also tell the user in chat output to **mark the MR as Draft** on GitLab until the submodule MR is merged. Active reviewers can merge before reading the blocker line.

## Pre-Push Safety Checks

Surface these before pushing — **do not auto-fix**:

| Check                                                       | Action                                          |
|-------------------------------------------------------------|-------------------------------------------------|
| Working tree dirty (`git status --porcelain` non-empty)     | **Block** — prompt to commit or stash           |
| Commit messages contain `WIP`, `tmp`, `fixup!`, empty       | Warn, ask whether to squash/amend before push   |
| Diff > 400 lines (excluding generated)                      | Warn — MR checklist asks for atomic ≤400-line MRs |
| Sensitive files in diff: `.env*`, `*credentials*`, `*.keystore`, `*.p12`, fresh `google-services.json` | **Block** — confirm with user                  |
| `print(`, `debugPrint(` added in non-test source            | Warn — ask whether intentional                  |
| Branch is `main` / `master`                                 | **Block** — refuse to MR from default branch    |
| Submodule pointer bumped to a SHA not on submodule's `origin/main` | **Block** — `## Блокировка` section is mandatory; see "Submodule Bump Detection" |

## Push

After explicit confirmation:

```bash
git push -u origin <branch>
```

- **Never** `--force` push. If history rewrite is needed, stop and ask.
- If branch already tracks remote and is up-to-date, skip the push.
- Never bypass hooks (`--no-verify`).

## Output

### Saved file

Write the body **directly to `MR.md` in the repo root** (use the `Write` tool with absolute path). The file contains exactly:

1. `## Изменения` — populated per the rules above.
2. `## Проблемы (опционально)` — **only if** real caveats exist; otherwise omit the heading entirely.

Nothing else. No title, no URL, no checklists, no template wrappers — those go to the chat output, not the file.

After saving, remind the user to delete `MR.md` or add it to `.gitignore` so it doesn't end up in a commit.

### Chat output

Print to chat (not to the file):

1. **Title** — single line, ready to paste.
2. **Create-MR URL** — opens GitLab's "New MR" with source/target preselected:
   ```
   https://<host>/<group>/<repo>/-/merge_requests/new?merge_request[source_branch]=<branch>&merge_request[target_branch]=<target>
   ```
   Build `<host>/<group>/<repo>` from `git remote get-url origin` (parse SSH/HTTPS form). `<target>` is the branch confirmed in step 2 of the process — never hardcode `main`.
3. **Path to `MR.md`** — tell the user where the body was written.
4. **Optional `glab` command** — for users who have it:
   ```bash
   glab mr create --title "<title>" --description-file MR.md --target-branch <target>
   ```

GitLab's `merge_request[description]` URL param is unreliable across versions, so don't try to pre-fill the body via URL. The user opens the URL → source branch is preselected → user pastes the contents of `MR.md` into the Изменения/Проблемы sections of the GitLab template.

## Step-by-Step Process

1. **Verify branch** — `git rev-parse --abbrev-ref HEAD`. Refuse if it's `main`/`master`.
2. **Resolve target branch** — if the user didn't specify one, **ask** (see "Target Branch"). Do not default to `main` silently. All subsequent `git` commands use the confirmed `<target>`.
3. **Find base** — `git merge-base HEAD <target>`. Confirm with the user if it looks unusual.
4. **Read commits and diff**:
   - `git log --reverse --pretty='%h %s' <target>..HEAD` — commit list.
   - `git diff --stat <target>...HEAD` — file-level summary.
   - `git diff <target>...HEAD` — full diff (skim for the body).
5. **Parse ticket** from branch name (regex above). Set title prefix.
6. **Detect submodule bumps** — for every entry in `.gitmodules`, check if its pointer changed in `<target>...HEAD`. For each bumped submodule, verify whether the new SHA is on its `origin/main`. If not — record a blocker (see "Submodule Bump Detection").
7. **Run pre-push checks**. Block on dirty tree / sensitive files / wrong branch / un-merged submodule bump.
8. **Build title** and the body content (`## Изменения` + `## Блокировка` if any submodule bump is not yet on main + `## Проблемы` if any caveats — no other sections).
9. **Write `MR.md`** to the repo root with the body content via the `Write` tool.
10. **Show the user** title, push command, MR URL, path to `MR.md`, and a reminder to gitignore/delete it. If a `## Блокировка` section was added, also tell the user to mark the MR as Draft. Get explicit confirmation before pushing.
11. **Push** the branch (`git push -u origin <branch>`).
12. **Print** the MR URL and the optional `glab` command.

## Common Pitfalls

- **`gh` doesn't work here** — this is GitLab. Don't try `gh pr create`.
- **Force-pushing** — never. If the user explicitly asks, warn first; never force-push to `main`.
- **Pasting raw diff into the body** — summarize, don't paste.
- **Counting generated files** — `*.g.dart`/`*.freezed.dart`/ARB outputs inflate the diff and don't belong in "Изменения".
- **Putting checklist / Скриншот / template scaffolding in `MR.md`** — the file holds only `## Изменения` (and `## Проблемы` if any). The GitLab template provides everything else when the MR is opened.
- **Hardcoding the GitLab host** — always read `git remote get-url origin` and parse; the host varies across surf projects.
- **Pushing with uncommitted work** — always block.
- **Title from latest commit only** — the latest commit may be `fix: typo`. Derive title from the dominant theme of the *whole* branch.
- **Picking up the wrong base** — `merge-base HEAD main` can return an old SHA if the branch was rebased; prefer `main..HEAD` for log/diff and confirm with the user when in doubt.
- **Forgetting to gitignore/delete `MR.md`** — always remind the user; the file is scratch output, not a tracked artifact.
- **Missing `## Блокировка` on a submodule-bump MR** — if the MR moves a `Subproject commit` pointer to a SHA that isn't on the submodule's `origin/main`, the parent can be merged before the submodule MR → after the submodule MR squashes/rebases, the SHA disappears and `git submodule update` breaks on `main`. Always check, always block.
- **Defaulting submodule MR target to `main` of parent** — the submodule MR lives in the submodule repo, not the parent. The blocker URL points at `<host>/<group>/<sub>/-/merge_requests/<N>`, not at the parent's MR list.
