## 1. Feature Structure & Data Flow

- Data flows: **View → Cubit → Service → Repository / Network**. Never skip layers.
- Feature folder: `lib/features/{name}/{cubit,model,service,view,widget,constants}`.
- Shared code: `lib/product/`. Reusable modules: `modules/`.
- If business logic may be needed elsewhere, extract to a shared service under `lib/product/` — don't bury it as a private method in a widget or cubit.
- Follow SOLID and DRY. Avoid overengineering — no `base` or complex class hierarchies unless structurally necessary. `sealed` is reserved for state union types (see Rule 3).
