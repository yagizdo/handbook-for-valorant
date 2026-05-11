## 3. State Management

### Why union states instead of boolean flags

The old pattern used a single Freezed class with `isLoading`, `errorMessage`, and data fields coexisting. This created **impossible state combinations** — for example `isLoading: true` with `errorMessage != null` at the same time — and forced views to decode state with brittle boolean chains like `if (state.errorMessage != null && !state.isLoading)`. Adding a new state meant touching every `if/else` in every view, and the compiler couldn't warn you if you missed one.

Union states (Freezed sealed classes) solve this: each state is a **distinct type** that carries only its own data. `XState.loading()` can't have an error message. `XState.success(data)` can't be loading. Dart 3's exhaustive `switch` forces the compiler to verify every state is handled — if you add a new variant and forget a view, you get a compile error, not a runtime bug.

**Use union states when the state is truly mutually exclusive** (loading/success/error/empty — you're never in two at once). If you genuinely need state that overlaps (e.g. "loading more items while showing existing ones"), that belongs as a field inside the success model, not as a separate union variant.

**Match state complexity to page lifecycle** — Not every page has a data-loading lifecycle. Before choosing a state pattern, ask: "Does this page have phases where the user sees fundamentally different UI — a blank loading screen, an error screen, an empty state — while waiting for data?" If yes, union states prevent impossible combinations and let the compiler enforce exhaustiveness. If no — the page is always visible and only manages local/trivial state — a simple single-class Freezed state with descriptive fields avoids unnecessary ceremony. The pattern should serve the page's actual behavior, not a one-size-fits-all template.

### Cubit + State pattern

- Use **Cubit** (from `flutter_bloc`) for all feature-level state.
- **All Cubits must use `with BaseCubit<T>`. Use `safeEmit()` after async gaps — never manual `if (isClosed) return; emit(...)`.**
- Provide cubits via `MultiBlocProvider` with `.value` constructors at app root.
- Use `InheritedWidget` only for static, non-reactive config — never mix with Cubit for the same data.

### State class structure

State classes use **Freezed union sealed classes** with distinct variants for each mutually exclusive state:

```dart
@freezed
sealed class XState with _$XState {
  const factory XState.initial() = XStateInitial;
  const factory XState.loading() = XStateLoading;
  const factory XState.empty() = XStateEmpty;
  const factory XState.success(XSuccessModel data) = XStateSuccess;
  const factory XState.error(String errorMessage) = XStateError;
}
```

**Rules:**
- `@freezed sealed class` — the `sealed` keyword enables exhaustive pattern matching, `@freezed` provides immutability and equality.
- **5 standard variants:** `initial`, `loading`, `empty`, `success`, `error`. Add more only if the feature genuinely requires a distinct UI state (rare).
- Each variant carries **only its own data** — error carries the message, success carries the success model, loading carries nothing. No shared fields across variants.
- Factory constructor names produce **public concrete classes** (e.g. `XStateSuccess`) — these are the types you pattern-match against in views.
- **Success variant parameter is always `data`** — Use `XSuccessModel data` as the parameter name (not `xSuccessModel` or feature-specific names). This ensures consistent destructuring: `XStateSuccess(:final data)` across all features.

### Success model pattern

Features that use union states have a dedicated `XSuccessModel` that holds the success state's data and any feature-specific UI state (selected index, filter, sort order). Features that use a simple single-class state (because they don't have a data-loading lifecycle — see above) do not need a SuccessModel — their fields live directly on the state class.

```dart
@freezed
abstract class XSuccessModel with _$XSuccessModel {
  const factory XSuccessModel({
    required List<XModel> allItems,
    @Default(0) int selectedFilterIndex,
  }) = _XSuccessModel;
  const XSuccessModel._();

  /// Computed getter — derived data lives here, not in the cubit.
  List<XModel> get items { /* filter logic */ }
}
```

**Why a separate success model instead of putting fields directly in the state variant?**
- Keeps the state union clean — union variants define *which* state, the success model defines *what's in* that state.
- Computed getters (filtering, sorting) live on the model, keeping the cubit thin.
- `copyWith` works naturally — `state.data.copyWith(selectedFilterIndex: 2)` updates one field without rebuilding the whole state.
- When a feature needs more success-state fields (pagination, selection, sort), you only touch the success model — no changes to the union or other variants.

### View consumption — exhaustive pattern matching

Views consume state with Dart 3 **switch expressions**, not `if/else` chains:

```dart
BlocBuilder<XCubit, XState>(
  builder: (context, state) {
    return switch (state) {
      XStateInitial() => const SizedBox.shrink(),
      XStateLoading() => const _SkeletonList(),
      XStateEmpty() => const _EmptyView(),
      XStateSuccess(:final data) => _SuccessList(data: data),
      XStateError(:final errorMessage) => ProductError(message: errorMessage),
    };
  },
);
```

**Why switch over if/else?** The compiler enforces exhaustiveness — if a new state variant is added, every `switch` that doesn't handle it becomes a compile error. With `if/else`, missing a state is a silent runtime bug.

- **Destructure data inline** — `XStateSuccess(:final data)` extracts the success model directly.
- **Use `buildWhen` for selective rebuilds** — especially for sub-widgets that only care about specific changes within the success state (e.g. filter index change).

### Cubit state transitions

```dart
// Loading → try → success/empty/error
Future<void> loadItems({bool forceRefresh = false}) async {
  emit(const XState.loading());
  try {
    final items = await _service.getItems(forceRefresh: forceRefresh);
    if (items.isEmpty) {
      safeEmit(const XState.empty());
      return;
    }
    safeEmit(XState.success(XSuccessModel(allItems: items)));
  } on Exception catch (e) {
    ProductLogger.e(e.toString(), tag: _logTag);
    safeEmit(XState.error(LocaleKeys.empty_x.tr()));
  }
}
```

- **Don't duplicate framework guarantees** — Cubit already skips emissions when new state `==` current state (Freezed provides this equality). Adding `state.maybeWhen(orElse: XState.loading, loading: XState.loading)` purely for idempotency is redundant. Use `maybeWhen` only when the emission logic genuinely varies by current state (e.g. preserving a previous error message vs using a default). Ask: "Does my behavior change depending on current state, or am I just preventing a same-value re-emit?" If the latter, the framework already handles it.
- **`safeEmit` after all async gaps** — never bare `emit()` after `await`.
- **Mutations on success state** (filter, selection) use `copyWith` on the success model and re-wrap: `safeEmit(XState.success(currentData.copyWith(selectedFilterIndex: index)))`.

### Detail navigation — pass the object, not the ID

When navigating to a detail page, pass the **full model object** via the route, not a UUID that requires a second fetch:

```dart
// ✅ Do this
context.router.push(XDetailRoute(item: item));

// ❌ Not this
context.router.push(XDetailRoute(uuid: item.uuid));
```

**Why?** The list already has the data. Passing the object avoids a redundant API call, works offline, and makes the detail page instantly available. If the detail page needs *additional* data not in the list model, it can fetch that separately while showing what it already has.

**Views must handle all 5 states:**
1. **Initial** — typically `SizedBox.shrink()` (brief, before load triggers)
2. **Loading** — show skeleton/shimmer
3. **Empty** — show empty state message
4. **Success** — show data
5. **Error** — show error with retry action
