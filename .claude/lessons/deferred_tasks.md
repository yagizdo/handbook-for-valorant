# Deferred Cleanup Tasks

Pending cleanup items to address when revisiting related code.

---

- Add `@Deprecated('Use Dimensions.kX instead')` / `@Deprecated('Use Gaps.gX instead')` annotations to old t-shirt aliases in `Dimensions` and `Gaps` once all features are migrated to new conventions.
- Remove duplicate `gap` dependency from root `pubspec.yaml` once all features use the `Gaps` class from `core`.
- Add missing `xlg` alias in `Gaps` for symmetry with `Dimensions.xlg` (or remove `Dimensions.xlg` if unused after migration).
- Migrate remaining features still using old single-class state pattern — evaluate each against the "match state complexity to page lifecycle" principle before converting. Features with a data-loading lifecycle get union states; features that are always visible keep simple state.
