# Architecture & Data Lessons

Learned patterns for state management, models, and data layer code, supplementing rules in `state_management.md`, `models_entities_mappers.md`, and `services_network.md`.

---

## Models

- **Union sealed for states, plain Freezed for data** — State classes use `@freezed sealed class` (union types with variants). API/domain/success models use plain `@freezed abstract class` (single data class). The `sealed` keyword is specifically for mutually exclusive states, not for every model.

## State Management

- **SuccessModel earns its place through complexity** — Use `XSuccessModel` when the feature manages collections with filtering, sorting, selection, or computed getters that keep the cubit thin. If the state only holds simple scalar values (a version string, a toggle, a flag), those fields live directly on the state class — wrapping them in a SuccessModel adds indirection for no gain.
- **Copy the architecture, not the incidental details** — When reusing a pattern from another feature, understand *why* each piece is the way it is before reproducing it. Names, structures, and conventions exist for reasons tied to that feature's context. Ask: "Does the reason behind this choice apply to my feature too?" If not, adapt. The goal is to carry over the thinking, not the surface-level shape.
- **Don't wrap in BlocBuilder when data comes via constructor** — If the detail view already has all the data it needs via constructor (because the parent list passed the full model object), don't wrap it in a BlocBuilder — it causes unnecessary rebuilds and signals a false dependency on cubit state.

## Services & Data Layer

- **Use response models, not raw JSON parsing** — If a `XResponseModel.fromJson()` exists for an API endpoint, always use it. Don't manually access `data['data']` and cast inline — it bypasses type safety and creates an inconsistency with other services that use the response model pattern.
- **Never silently swallow exceptions** — Every `catch` block must at minimum log the error via `ProductLogger.e()`. A `catch (_) {}` that does nothing hides bugs and makes debugging impossible. Even if the UI gracefully handles the failure (spinner stops, fallback value shown), the error must be recorded.
- **Cross-feature pattern consistency** — When applying a pattern (response model, ProductScaffold, error retry, parameter naming), verify all features follow it. One feature doing `data['data']` while others use response models, or one detail view using raw Scaffold while others use ProductScaffold, signals incomplete work. After implementing a pattern in one feature, grep for the old pattern across the codebase.
