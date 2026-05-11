## 2. Models, Entities & Mappers

Every data type that comes from the API needs three pieces:

| Piece | Location | Purpose |
|---|---|---|
| **Model** (`@freezed`) | `model/{name}_model.dart` | Immutable domain object, JSON serializable |
| **Entity** (`@Entity()`) | `model/{name}_entity.dart` | ObjectBox storage, flat fields only |
| **Mapper** (extensions) | `model/{name}_mapper.dart` | Bidirectional `toEntity()` / `toModel()` conversion |

**All models use Freezed** — API models, domain models, success models, state classes. One pattern everywhere: `@freezed abstract class`. This gives automatic `==` equality, `copyWith`, `fromJson`/`toJson`, and prevents the bug where you add a field but forget to update the `props` list (Equatable's weakness). The only exception is ObjectBox entities which use `@Entity()` because ObjectBox requires mutable classes.

**Freezed model rules:**
- Always `@freezed abstract class XModel with _$XModel` — the `abstract` keyword is mandatory (Freezed 3.x).
- Include `factory XModel.fromJson(...)` and part files (`.freezed.dart`, `.g.dart`).
- Use `@Default([])` for list fields, not nullable lists.
- Nested data → separate `@freezed` model classes.
- **No Equatable for models** — Freezed handles equality. Don't mix `extends Equatable` with Freezed. If you see existing models using Equatable + JsonSerializable, migrate them to Freezed.

**ObjectBox entity rules:**
- ObjectBox does NOT support nested objects. Flatten all fields.
- Store complex nested data as JSON strings (e.g. `String? abilitiesJson`).
- Always include `@Id() int id = 0;`.
