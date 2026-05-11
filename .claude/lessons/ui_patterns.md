# UI & Widget Lessons

Learned patterns and pitfalls for UI layer code, supplementing rules in `ui_widgets.md` and `theme_styling.md`.

---

## Context-Accessible Values

- **Never pass context-accessible values as widget constructor parameters** — If a value is reachable through `BuildContext`, don't pass it as a constructor param — every widget has its own `context`. If a value is needed in many widgets but not yet in context, write a context extension — don't prop-drill. Constructor params are only for values that genuinely vary per usage site and aren't available through the widget tree.

## Widget Naming

- **Widget naming** — Shared widgets use `Product*` prefix (e.g. `ProductBackButton`), descriptive suffixes. Never use `Valorant*` prefix.

## View Behavior

- **Views don't think — they render** — If you're writing logic in a view that isn't about *how* something looks, it probably belongs in the cubit or the success model. Views consume state, they don't compute it.
- **Keep concerns self-contained** — A skeleton widget owns its own placeholder data. A success widget owns its own refresh logic. Each piece works independently without leaking into other concerns.

## Dimensions Migration

- **Use `k`-prefixed Dimensions, not old aliases** — `Dimensions.k16` not `Dimensions.lg`. Old t-shirt aliases still compile but must not appear in new or refactored code.

## Code Hygiene

- **Never silently remove TODO/FIXME comments** — TODO and FIXME comments represent deferred decisions, known issues, or open questions. They belong to the developer, not to the implementation task. When rewriting or refactoring a method, preserve every existing comment verbatim — including `// TODO:`, `// FIXME:`, `// NOTE:` — unless the user explicitly asks to remove them. Silently dropping a TODO loses institutional knowledge and hides work that still needs to be done. If a TODO becomes irrelevant after your change, surface it to the user ("this TODO may no longer apply after removing X — should I remove it?") rather than deciding for them.
- **Every deletion requires an outward audit** — Code exists in context. When you remove something, walk outward from the deletion point and ask at each level: "does this still earn its place, or did it only exist to support what I just removed?" Keep going until you reach something that has independent reason to exist. No exceptions — if it compiles but lost its purpose, remove it.
- **Every rename requires a ripple audit** — Renaming a field, parameter, or class isn't done when the declaration changes. Search for all references (cubit, views, widgets, tests) and update them in the same change. A rename that doesn't compile everywhere is worse than no rename at all.
