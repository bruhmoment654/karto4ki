---
name: mason-gen
description: Scaffold screens, BLoCs, repositories, and assemblies using Mason bricks. Use when creating or scaffolding Flutter features — both on user request and autonomously when boilerplate is needed.
---

# Mason Brick Code Generator

Generate boilerplate code using Mason CLI bricks in this project.

## Discovering Available Bricks

Do not assume a fixed set of bricks. Instead, read the bricks directory to discover what's currently available:

1. List directories in `apps/main/tools/bricks/` — each subdirectory is a brick.
2. For each brick, read its `brick.yaml` to learn:
   - `name` — the brick identifier used in the make command
   - `description` — what it generates
   - `vars` — the required variables with their types, prompts, and defaults

This ensures you always use the actual, up-to-date brick definitions rather than stale documentation.

## Workflow

### Step 1: Identify Which Brick(s) to Use

Based on the user's request (or your own assessment of what's needed), determine which brick(s) to generate. If the task is "create a new feature", you likely need multiple bricks — read each `brick.yaml` to decide which ones apply.

### Step 2: Gather Variables

Read the `brick.yaml` for each brick you plan to use. Extract variable values from context where possible (the user's request, existing feature directory names, etc.).

**If any required variable is unclear or missing, use the `AskUserQuestion` tool to ask the user.** Generating code with wrong names creates rework, so it's better to ask. When asking, explain what each variable controls — for example, that `feature_name` determines the directory path under `lib/feature/`.

All identifier variables (feature_name, screen_name, bloc_name, etc.) should be in `snake_case`. If the user provides PascalCase or other formats, convert to snake_case before running the command.

### Step 3: Run Generation via Makefile

Follow the project rule defined in `.cursor/rules/use-makefile.mdc`: always use `make` targets, never call tools directly.

Each brick has a corresponding make target: `gen-screen`, `gen-bloc`, `gen-repository`, `gen-assembly`. Pass variables as make arguments:

```bash
make gen-<brick> feature_name=<value> <other_var>=<value>
```

**Example:**
```bash
make gen-screen feature_name=auth screen_name=login name="Login Screen"
make gen-bloc feature_name=auth bloc_name=login
```

When variables are provided, the Makefile automatically adds `--on-conflict overwrite` to avoid interactive prompts. If generating multiple bricks for the same feature, run them sequentially.

### Step 4: Post-Generation

After generating brick code, run code generation for the app module to process freezed/auto_route annotations:

```bash
make gen-app
```

Then inform the user which files were created. For screens, remind them to register the new route in the app router.

## Common Patterns

**New feature from scratch** — Generate bricks in this order: assembly (DI) → screen (presentation) → bloc (state) → repository (data, if needed). All should share the same `feature_name`.

**Adding to an existing feature** — Check existing directories under `lib/feature/` to match the correct `feature_name`.

## Post-Generation Conventions

After scaffolding, when filling in screen/widget/repository bodies, two conventions are enforced. Both have full rule bodies in `.cursor/rules/`; the short version is repeated here so it surfaces during scaffolding.

### Private Widget Naming

When extracting private widget classes inside a View or Widget (`class _Foo extends StatelessWidget`), give them **domain-specific** names — not generic placeholders.

**Forbidden** (banlist): `_Inner`, `_Wrapper`, `_Loaded`, `_Success`, `_Data`, `_Ready`, `_Skeleton`, `_Placeholder`, `_Empty`, `_Loader`, and generic positional/structural words (`_Header`, `_Footer`, `_Top`, `_Bottom`, `_Item`, `_Row`, `_Tile`, `_Card`) when not qualified by domain.

**Required**: prefix or qualify with the feature/section. `_StatisticsShimmer` not `_Skeleton`. `_TripOrdersList` not `_Content`. `_DaySectionHeader` not `_Header`. `_TripOrderCard` not `_Card`.

Full rule and examples: [ui-components-decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc) → "Naming Private Widgets".

### Mock Data Stays in the Mock Repository

When the `gen-repository` brick scaffolds a repository that will be filled with fixture data, **all** mock entities, seed lists, and helper builder records live inside the `Mock{Name}Repository` class (`apps/main/lib/feature/<f>/data/repository/mock_<n>_repository.dart`).

Mock data must **never** be hardcoded inside:
- BLoC (`*_bloc.dart`, `*_event.dart`, `*_state.dart`)
- ViewModel / View / Widget files
- Assembly files
- Any other `presentation/` code

If a screen needs sample state to render under design, extend the mock repository — do not inline an `Entity` literal in the Bloc or stash a `static const _samples` list inside the View.

Full rule and examples: [repository](mdc:.cursor/rules/repository.mdc) → "Mock Repositories".

## Troubleshooting

If `mason make` fails with "Could not find a brick", run:
```bash
make init-mason
```