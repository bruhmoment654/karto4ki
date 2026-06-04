---
name: implement-design
description: Translates Figma designs into production-ready code with 1:1 visual fidelity. Use when implementing UI from Figma files, when user mentions "implement design", "generate code", "implement component", "build Figma design", provides Figma URLs, or asks to build components matching Figma specs. Requires Figma MCP server connection.
---

# Implement Design

## Overview

This skill provides a structured workflow for translating Figma designs into production-ready Flutter code with pixel-perfect accuracy. It ensures consistent integration with the Figma MCP server, proper use of design tokens, and 1:1 visual parity with designs.

## Prerequisites

- Figma MCP server must be connected and accessible
- User must provide a Figma URL in the format: `https://figma.com/design/:fileKey/:fileName?node-id=1-2`
 - `:fileKey` is the file key
 - `1-2` is the node ID (the specific component or frame to implement)
- **OR** when using `figma-desktop` MCP: User can select a node directly in the Figma desktop app (no URL required)
- Project should have an established design system (see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc) rule)

## Required Rules

Before implementing any Figma design, read the applicable project rules. These rules define the conventions for all UI code in this project:

- [View](mdc:.cursor/rules/view.mdc) — View architecture: pure UI driven by ViewModel state
- [ViewModel](mdc:.cursor/rules/view-model.mdc) — ViewModel bridge between Bloc and View
- [Flow](mdc:.cursor/rules/flow.mdc) — Route entry point and DI boundary
- [Widget](mdc:.cursor/rules/widget.mdc) — Reusable UI element conventions and constructor constraints
- [UI Components Decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc) — How to split large Views into private widget classes
- [UI Implementation Conventions](mdc:.cursor/rules/ui-impl-conventions.mdc) — Pressable, spacing, callback naming, image handling
- [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc) — Theme system, color scheme, typography, asset handling, localization
- [Screen Structure](mdc:.cursor/rules/screen-structure.mdc) — 3-file scaffolding pattern (Flow/ViewModel/View)

These rules are the source of truth. When this skill says "follow project conventions," it means these rules.

## Required Workflow

**Follow these steps in order. Do not skip steps.**

### Step 1: Get Node ID

#### Option A: Parse from Figma URL

When the user provides a Figma URL, extract the file key and node ID to pass as arguments to MCP tools.

**URL format:** `https://figma.com/design/:fileKey/:fileName?node-id=1-2`

**Extract:**

- **File key:** `:fileKey` (the segment after `/design/`)
- **Node ID:** `1-2` (the value of the `node-id` query parameter)

**Note:** When using the local desktop MCP (`figma-desktop`), `fileKey` is not passed as a parameter to tool calls. The server automatically uses the currently open file, so only `nodeId` is needed.

**Example:**

- URL: `https://figma.com/design/kL9xQn2VwM8pYrTb4ZcHjF/DesignSystem?node-id=42-15`
- File key: `kL9xQn2VwM8pYrTb4ZcHjF`
- Node ID: `42-15`

#### Option B: Use Current Selection from Figma Desktop App (figma-desktop MCP only)

When using the `figma-desktop` MCP and the user has NOT provided a URL, the tools automatically use the currently selected node from the open Figma file in the desktop app.

**Note:** Selection-based prompting only works with the `figma-desktop` MCP server. The remote server requires a link to a frame or layer to extract context. The user must have the Figma desktop app open with a node selected.

### Step 2: Fetch Design Context

Run `get_design_context` with the extracted file key and node ID.

```
get_design_context(fileKey=":fileKey", nodeId="1-2")
```

This provides the structured data including:

- Layout properties (Auto Layout, constraints, sizing)
- Typography specifications
- Color values and design tokens
- Component structure and variants
- Spacing and padding values

**If the response is too large or truncated:**

1. Run `get_metadata(fileKey=":fileKey", nodeId="1-2")` to get the high-level node map
2. Identify the specific child nodes needed from the metadata
3. Fetch individual child nodes with `get_design_context(fileKey=":fileKey", nodeId=":childNodeId")`

### Step 3: Capture Visual Reference

Run `get_screenshot` with the same file key and node ID for a visual reference.

```
get_screenshot(fileKey=":fileKey", nodeId="1-2")
```

This screenshot serves as the source of truth for visual validation. Keep it accessible throughout implementation.

### Step 4: Download Required Assets

Download any assets (images, icons, SVGs) returned by the Figma MCP server.

**IMPORTANT:** Follow these asset rules:

- If the Figma MCP server returns a `localhost` source for an image or SVG, use that source directly
- DO NOT import or add new icon packages - all assets should come from the Figma payload
- DO NOT use or create placeholders if a `localhost` source is provided
- Assets are served through the Figma MCP server's built-in assets endpoint

### Step 5: Translate to Project Conventions

Translate the Figma output into Flutter code following this project's conventions.

**Key principles:**

- Treat the Figma MCP output as a representation of layout, dimensions, colors, and behavior — not as implementation code. Translate to Flutter widgets.
- **Layout mapping**: Translate Figma Auto Layout to Flutter layout widgets (`Row`, `Column`, `Expanded`, `Flexible`, `Stack`, `SizedBox`). For scrollable layouts, use `SliverPadding`/`SliverToBoxAdapter` — see [UI Implementation Conventions](mdc:.cursor/rules/ui-impl-conventions.mdc).
- **Theme tokens**: Map Figma colors and typography to the project's theme system. Never hardcode color values or font family strings — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc) for the theme API.
- **UIKit-first**: Before creating any component, check for existing UIKit components. Use UIKit for interactive elements, icons, and images — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc) and [UI Implementation Conventions](mdc:.cursor/rules/ui-impl-conventions.mdc).
- **Assets and localization**: Use generated asset constants and localization — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc) for asset and l10n conventions.
- **Component type decisions**: Determine whether the Figma output maps to a **View** (screen-level, receives ViewModel), a **Widget** (reusable, typed constructor), or a **private widget** inside a View. See [View](mdc:.cursor/rules/view.mdc), [Widget](mdc:.cursor/rules/widget.mdc), and [UI Components Decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc).
- **Screen scaffolding**: For full screens, follow the 3-file pattern — see [Screen Structure](mdc:.cursor/rules/screen-structure.mdc).

### Step 6: Achieve 1:1 Visual Parity

Strive for pixel-perfect visual parity with the Figma design.

**Guidelines:**

- Prioritize Figma fidelity to match designs exactly.
- **Colors and typography**: Use the project's theme token system. If a Figma value has no matching token, extend the theme — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc). After theme changes, run `make gen-ui`.
- **Spacing**: Use `SizedBox` and `EdgeInsets` to match Figma spacing values exactly.
- **Decorations**: Use `BorderRadius`, `BoxDecoration`, and `Opacity` to match Figma layer properties.
- When conflicts arise between existing theme tokens and Figma specs, prefer existing tokens but adjust spacing or sizes minimally to match visuals.
- Follow [Dart Code Style](mdc:.cursor/rules/dart-code-style.mdc) for doc comments on new public classes.

### Step 7: Validate Against Figma

Before marking complete, validate the final UI against the Figma screenshot.

**Validation checklist:**

- [ ] Layout matches Figma (spacing, alignment, sizing)
- [ ] Colors use theme tokens — no hardcoded color values
- [ ] Typography uses theme tokens — no hardcoded font families
- [ ] All user-facing strings use localization — no hardcoded strings
- [ ] Interactive elements follow [UI Implementation Conventions](mdc:.cursor/rules/ui-impl-conventions.mdc)
- [ ] Icons and images follow [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc) conventions
- [ ] Assets use generated constants — no hardcoded paths
- [ ] UI decomposition follows [UI Components Decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc) — private widget classes, not `_build*()` methods
- [ ] Callback naming follows [UI Implementation Conventions](mdc:.cursor/rules/ui-impl-conventions.mdc)
- [ ] Widgets follow [Widget](mdc:.cursor/rules/widget.mdc) constructor constraints
- [ ] `const` constructors used where possible

## Implementation Rules

### Component Organization

- **Screen-level components**: Follow the 3-file pattern (Flow/ViewModel/View) per [Screen Structure](mdc:.cursor/rules/screen-structure.mdc).
- **Reusable widgets**: Follow [Widget](mdc:.cursor/rules/widget.mdc) conventions for constructor constraints and architecture boundaries. Check UIKit first per [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc).
- **Sub-components within a View**: Extract as private widget classes per [UI Components Decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc).
- **Styling**: Access theme values via extensions — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc). Never define custom inline styles.

### Design System Integration

- **ALWAYS check UIKit first** before creating new components — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc).
- **Map Figma design tokens** (colors, typography, assets) to the project's theme system — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc) for the complete token mapping guide.
- When a matching UIKit component exists, use or extend it rather than creating a new one.
- When adding new reusable components, follow [Widget](mdc:.cursor/rules/widget.mdc) architecture rules.
- Document new public components with `{@template}`/`{@macro}` per [Dart Code Style](mdc:.cursor/rules/dart-code-style.mdc).

### Code Quality

- Avoid hardcoded values — use theme tokens, generated asset constants, and localization. See [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc).
- Follow [Widget](mdc:.cursor/rules/widget.mdc) constructor constraints — widgets accept only Dart/Flutter/Entity types.
- Follow [Dart Code Style](mdc:.cursor/rules/dart-code-style.mdc) for typing, `final`/`const` usage, trailing commas, guard patterns, pattern matching, and doc comments.
- Follow [UI Implementation Conventions](mdc:.cursor/rules/ui-impl-conventions.mdc) for callback naming, interactive elements, spacing, and image handling.

## Examples

### Example 1: Implementing a Button Component

User says: "Implement this Figma button component: https://figma.com/design/kL9xQn2VwM8pYrTb4ZcHjF/DesignSystem?node-id=42-15"

**Actions:**

1. Parse URL to extract fileKey=`kL9xQn2VwM8pYrTb4ZcHjF` and nodeId=`42-15`
2. Run `get_design_context(fileKey="kL9xQn2VwM8pYrTb4ZcHjF", nodeId="42-15")`
3. Run `get_screenshot(fileKey="kL9xQn2VwM8pYrTb4ZcHjF", nodeId="42-15")` for visual reference
4. Download any button icons from the assets endpoint
5. Check UIKit for an existing button component (see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc))
6. If exists, extend it. If not, create a new widget following [Widget](mdc:.cursor/rules/widget.mdc) rules and [UI Implementation Conventions](mdc:.cursor/rules/ui-impl-conventions.mdc) for interactive elements
7. Map Figma colors and typography to theme tokens per [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc)
8. Validate against screenshot for padding, border radius, typography

**Result:** Button widget matching Figma design, following project Widget and UIKit conventions.

### Example 2: Building a Dashboard Screen

User says: "Build this dashboard: https://figma.com/design/pR8mNv5KqXzGwY2JtCfL4D/Dashboard?node-id=10-5"

**Actions:**

1. Parse URL to extract fileKey=`pR8mNv5KqXzGwY2JtCfL4D` and nodeId=`10-5`
2. Run `get_metadata(fileKey="pR8mNv5KqXzGwY2JtCfL4D", nodeId="10-5")` to understand the page structure
3. Identify main sections from metadata (header, sidebar, content area, cards) and their child node IDs
4. Run `get_design_context(fileKey="pR8mNv5KqXzGwY2JtCfL4D", nodeId=":childNodeId")` for each major section
5. Run `get_screenshot(fileKey="pR8mNv5KqXzGwY2JtCfL4D", nodeId="10-5")` for the full page
6. Download all assets (logos, icons, charts)
7. Create the screen using the 3-file pattern per [Screen Structure](mdc:.cursor/rules/screen-structure.mdc). Use the mason-gen skill.
8. Build the View following [View](mdc:.cursor/rules/view.mdc) rules. Decompose into private widget classes per [UI Components Decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc).
9. Apply theme tokens, asset conventions, and localization per [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc).
10. Validate against Figma screenshot.

**Result:** Complete dashboard following the Screen Structure pattern, with private widget decomposition and theme integration.

## Best Practices

### Always Start with Context

Never implement based on assumptions. Always fetch `get_design_context` and `get_screenshot` first.

### Incremental Validation

Validate frequently during implementation, not just at the end. This catches issues early.

### Document Deviations

If you must deviate from the Figma design (e.g., for accessibility or technical constraints), document why. Keep comments minimal — only when something is not obvious.

### Reuse Over Recreation

Always check UIKit for existing components before creating new ones — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc). Consistency across the codebase is more important than exact Figma replication.

### Design System First

When in doubt, prefer the project's theme system and UIKit conventions over literal Figma translation. The rules define how UI is built — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc).

### Avoid BackdropFilter Without Explicit Approval

`BackdropFilter` is an expensive widget with significant performance impact. **Do not use `BackdropFilter` unless the user explicitly requests it.** If the design includes a background blur effect, ask the user before implementing whether `BackdropFilter` is truly needed, or if an alternative (e.g., semi-transparent background, pre-rendered blurred image) would suffice.

## Common Issues and Solutions

### Issue: Figma output is truncated

**Cause:** The design is too complex or has too many nested layers to return in a single response.
**Solution:** Use `get_metadata` to get the node structure, then fetch specific nodes individually with `get_design_context`.

### Issue: Design doesn't match after implementation

**Cause:** Visual discrepancies between the implemented code and the original Figma design.
**Solution:** Compare side-by-side with the screenshot from Step 3. Check spacing, colors, and typography values in the design context data.

### Issue: Assets not loading

**Cause:** The Figma MCP server's assets endpoint is not accessible or the URLs are being modified.
**Solution:** Verify the Figma MCP server's assets endpoint is accessible. The server serves assets at `localhost` URLs. Use these directly without modification.

### Issue: Design token values differ from Figma

**Cause:** The project's theme tokens have different values than those specified in the Figma design.
**Solution:** When project tokens differ from Figma values, prefer project tokens for consistency but adjust spacing/sizing to maintain visual fidelity. See [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc) for the theme system.

### Issue: Widget tree too deeply nested

**Cause:** All UI was placed in a single `build` method without decomposition.
**Solution:** Extract logical sections into private widget classes. Never use `_build*()` helper methods — see [UI Components Decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc).

### Issue: Colors or fonts hardcoded instead of using theme

**Cause:** Figma MCP output contains raw values that were copied directly.
**Solution:** Map all colors and typography to theme tokens. If a Figma value has no matching token, extend the theme and run `make gen-ui` — see [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc).

### Issue: Strings hardcoded in widgets

**Cause:** Text was copied directly from Figma output without localization.
**Solution:** Add all user-facing strings to the ARB file, run `make gen-l10n`, then access via `context.l10n` — see [Localization Process](mdc:.cursor/rules/localization-process.mdc).

## Understanding Design Implementation

The Figma implementation workflow establishes a reliable process for translating designs to Flutter code:

**For designers:** Confidence that Flutter implementations will match Figma designs with pixel-perfect accuracy, using the project's theme system for consistent token mapping.
**For developers:** A structured approach that maps Figma output directly to Flutter widgets and the project's screen architecture — eliminating guesswork.
**For teams:** Consistent implementations that follow architecture rules, maintain UIKit integrity.

By following this workflow, you ensure that every Figma design is implemented with the same level of care and attention to detail.

## Additional Resources

### Figma

- [Figma MCP Server Documentation](https://developers.figma.com/docs/figma-mcp-server/)
- [Figma MCP Server Tools and Prompts](https://developers.figma.com/docs/figma-mcp-server/tools-and-prompts/)
- [Figma Variables and Design Tokens](https://help.figma.com/hc/en-us/articles/15339657135383-Guide-to-variables-in-Figma)

### Project Rules

- [View](mdc:.cursor/rules/view.mdc), [ViewModel](mdc:.cursor/rules/view-model.mdc), [Flow](mdc:.cursor/rules/flow.mdc) — screen architecture
- [Widget](mdc:.cursor/rules/widget.mdc) — reusable UI element conventions
- [UI Components Decomposition](mdc:.cursor/rules/ui-components-decomposition.mdc) — private widget extraction
- [UI Implementation Conventions](mdc:.cursor/rules/ui-impl-conventions.mdc) — pressable, spacing, callbacks, images
- [UIKit Usage](mdc:.cursor/rules/uikit-usage.mdc) — theme, colors, typography, assets, localization
- [Screen Structure](mdc:.cursor/rules/screen-structure.mdc) — 3-file scaffolding pattern
- [Dart Code Style](mdc:.cursor/rules/dart-code-style.mdc) — typing, naming, doc comments
- [Localization Process](mdc:.cursor/rules/localization-process.mdc) — adding translated strings
