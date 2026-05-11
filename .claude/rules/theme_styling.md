## 6. Theme & Styling

- **All theme work lives in `modules/theme_module/`** — colors, text themes, dark/light mode, custom extensions. **Never** create theme-related files, color definitions, or text style definitions inside `lib/`. Always consume what the theme module exposes.
- Colors: only `context.colorScheme.*` — **never** `Theme.of(context).colorScheme`, `Colors.*`, `Color(0xFF...)`, or inline values. Use the `theme_module` extension shorthand (`import 'package:theme_module/theme_module.dart'`), not the verbose `Theme.of(context)` form.
- Text styles: only `context.textTheme.*` — **never** `Theme.of(context).textTheme` or inline `TextStyle()`. Same rule: use the `theme_module` extension shorthand.
- **Import split:** Theme extensions (`colorScheme`, `textTheme`, `isDarkMode`) → `package:theme_module/theme_module.dart`. Layout helpers (`width`, `height`) → `package:core/utility/extension/context_extension.dart`.
- Need a new color or text style? Add it in `modules/theme_module/` (e.g. via `ThemeExtension<T>` for custom semantic colors), then use it in `lib/` through `context`.
- Dark/light mode support belongs entirely in the theme module — `lib/` code must be theme-agnostic and adapt automatically via the color scheme.
- Deprecated M3 roles: use `surface` (not `background`), `onSurface` (not `onBackground`), `surfaceContainerHighest` (not `surfaceVariant`).
- **Never use `ColorScheme.fromSeed()`** — it tints all unoverridden M3 roles with the seed hue, breaking neutral surfaces and nav colors. Always use explicit `ColorScheme.dark()` / `ColorScheme.light()` constructors with the Valorant brand palette below.

### Valorant Brand Palette (canonical values)

| Token | Dark | Light |
|---|---|---|
| `primary` | `#FF4655` | `#FF4655` |
| `onPrimary` | `#FFFFFF` | `#FFFFFF` |
| `secondary` | `#BD3944` | `#BD3944` |
| `onSecondary` | `#FFFFFF` | `#FFFFFF` |
| `surface` | `#101823` | `#F5F0EB` |
| `onSurface` | `#E5E0D9` | `#101823` |
| `surfaceContainerHighest` | `#1A2636` | `#E5E0D9` |
| `outline` | `#787878` | `#787878` |
| `error` | `#CF6679` | `#B00020` |
| `shadow` / `scrim` | `#000000` | `#000000` |
