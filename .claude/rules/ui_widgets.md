## 5. UI & Widgets

### Product Widget Principle: Single Point of Control

Any widget type used across multiple features **must** have a `Product`-prefixed base widget in `lib/product/widgets/`. The goal is **single-point control** — cross-cutting behavior changes (haptic feedback, dismiss behavior, animation curves, accessibility defaults) are applied once in the product widget and take effect everywhere. Without this, adding haptic feedback to all buttons means hunting down every inline `ElevatedButton` in the codebase.

**How to decide if something needs a product widget:**
1. **Will this widget type appear in 2+ features?** → Create a product widget.
2. **Might a cross-cutting behavior (haptic, animation, dismiss-on-tap-outside, loading state) ever need to be toggled app-wide?** → Create a product widget.
3. **Is it a one-off, feature-specific visual element?** → Feature widget is fine, but it should still compose a product widget if a relevant one exists.

**Product widget design rules:**
- Sensible defaults that match app-wide behavior (e.g. `ProductBottomSheet` defaults to dismiss-on-tap-outside = true).
- Expose parameters to let features **opt out** of defaults when needed (e.g. `dismissOnTapOutside: false` for a confirmation sheet).
- Feature-specific widgets **compose** product widgets — they don't rewrite them. E.g. a "Clear Cache" button wraps `ProductButton` with specific label/icon/callback, not a raw `ElevatedButton`.
- Naming: `Product{WidgetType}` (e.g. `ProductButton`, `ProductBottomSheet`, `ProductCard`).
- Location: `lib/product/widgets/` organized by category subdirectory (`buttons/`, `sheet/`, `gradient/`, etc.).

**Current product widgets** (check `lib/product/widgets/` for the up-to-date list — don't rely on this table alone):

| Product Widget | What it centralizes |
|---|---|
| `ProductScaffold` | App-wide scaffold defaults |
| `ProductCachedImage` | Image caching, placeholder, error handling |
| `ProductError` | Error state presentation + retry |
| `ProductLoading` | Loading indicator style |
| `ProductNotFoundView` | Empty/404 state |
| `ProductBackButton` / `ProductBackButtonOverlay` | Back navigation behavior |

**When a needed product widget doesn't exist yet:** Create it in `lib/product/widgets/` **before** using the vanilla Flutter equivalent in features. This is an investment — the second feature that needs it will already benefit.
- **Never** define `Widget _buildX()` private methods — always extract to `StatelessWidget` or `StatefulWidget` classes.
- Preserve `const` constructors wherever possible (mandatory in `BlocBuilder`, list builders).
- **Widget extraction strategy (readability-driven):**
  - **Small page / small widget:** define private `_MyWidget` classes (`StatelessWidget` or `StatefulWidget`) in the **same file**. No need for `part`/`part of`.
  - **Large page / readability suffers:** split private sub-widgets into separate files using `part`/`part of`.
  - **Public + reusable:** always its own file.
- **Extract repeated widget patterns.** If the same visual element appears in 2+ places (e.g. gradient overlays, back buttons, bottom sheets), extract it into a shared widget under `lib/product/widgets/` organized by category subdirectory:
  - `lib/product/widgets/buttons/` — reusable button widgets
  - `lib/product/widgets/gradient/` — gradient overlays, decorations
  - `lib/product/widgets/sheet/` — bottom sheets, modal sheets
  - Add new subdirectories as needed by widget type.
- Feature-scoped widgets go in `features/{name}/widget/`.
- Annotate all views with `@RoutePage()` for auto_route generation.
- Navigate via `context.router.push(XRoute(...))` / `context.router.maybePop()`.
