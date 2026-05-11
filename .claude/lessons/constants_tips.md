# Constants & Dimensions Lessons

Learned patterns for using the constants system, supplementing rules in `constants_values.md`.

---

- **`AppDurations` naming rationale** — Named `AppDurations` (not `Durations`) to avoid conflict with Flutter's built-in `Durations` class. Constants are named `msX` so the value is immediately readable without looking up a mapping.
- **Widget-specific sizes always go in `CustomWidgetDimensions`** — Don't create feature-scoped dimension files (e.g. `ProfileDimensions`, `MapsDimensions`). `CustomWidgetDimensions` is the single location for all widget-specific sizes across all features. Feature-scoped `constants/` folders are for non-dimension values only (string matchers, enum maps, config values, etc.). If a widget needs a named size constant, add it to `CustomWidgetDimensions` with a descriptive widget-prefixed name.
- **Think before you hardcode — extract, classify, place** — When you encounter any inline value, don't just use it directly. Ask: (1) Is this value reusable or meaningful enough to name? → Extract to a constant. (2) Is it generic or context-specific? → Choose the right constants class. (3) Does the right class/file already exist, or do I need to create one? → Place it at the correct scope (cross-cutting, app-global, or feature-scoped).
