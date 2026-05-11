## 7. Dependency Injection

- Inject all dependencies via constructor — never instantiate services/repos directly.
- Register in `BaseContainer.setup()` in order: **repositories → network → services → cubits**.
- Singleton cubits must have `dispose: (cubit) => cubit.close()` callback.
- Access shared deps via base mixins: `BaseCubit`, `BaseStateless`, `BaseStateful`.
- Expose cubits as getters on `BaseContainer`, provide via `BlocProvider.value`.
- `BaseCubit<T>` mixin exposes shared dep getters (`networkModel`). Access cross-cutting deps via BaseCubit getters; keep primary service deps constructor-injected.
- `ThemeCubit` is excluded from `BaseCubit` — it lives in `modules/theme_module/` and cannot import from `lib/product/locator/` without circular dependency.

**Reference:** `lib/product/locator/base_container.dart`.
