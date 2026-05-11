## 8. Constants & Values

- No hardcoded strings, matchers, or magic numbers.
- Use constant classes: private constructor `ClassName._()` + all `static` members.
- Cross-cutting (used by multiple modules/features): `modules/core/lib/constants/`. App-global: `lib/product/constants/`. Feature-specific: `lib/features/{name}/constants/`.

### Dimensions & Sizing (`modules/core/lib/constants/dimensions.dart`)

All numeric size values (spacing, padding, margins, border radii, widget sizes) must come from this file — **never** use hardcoded numeric literals like `120`, `40`, `16.0` etc.

| Class | Purpose | Example |
|---|---|---|
| **`Dimensions`** | Generic spacing, padding, margin, border radius — layout concepts **not** tied to a specific widget. If the scale is missing a value, add it. Named `k{value}` for spacing (e.g. `k16` = 16.0) so adding new values needs no bikeshedding. Border radii keep semantic names. | `Dimensions.k16` (16), `Dimensions.k10` (10), `Dimensions.borderRadius` (12) |
| **`Gaps`** | Pre-built `Gap` widgets matching the `Dimensions` spacing scale. Use instead of `const Gap(Dimensions.X)`. Named `g{value}` (e.g. `g16` = Gap of 16). | `Gaps.g16`, `Gaps.g12`, `Gaps.g24` |
| **`CustomWidgetDimensions`** | Widget-specific sizes **only**: height, width, icon size, border width, maxLines — **always** named per widget. **Never** put padding, gap, or border radius here. | `CustomWidgetDimensions.backButtonSize` (36) |

**Rules:**
- Proportional/responsive sizes use `context.width`, `context.height` from `modules/core/lib/utility/extension/context_extension.dart` — **never** raw `MediaQuery.of(context)`. If a feature needs its own responsive helpers, create a separate extension for that feature. `Dimensions` is for fixed numeric values only.
- **Never reuse a `CustomWidgetDimensions` value for a different widget** even if the numeric value is the same. Create a new constant with a descriptive name for each widget.
- If a suitable constant doesn't exist in either class, **add one** with a clear, descriptive name before using it.
- **Use `Gaps` for all gap widgets** — Use `Gaps.gX` for fixed gaps (e.g. `Gaps.g12`), `Gaps.custom(value)` for dynamic/computed gaps (e.g. `Gaps.custom(MediaQuery.of(context).padding.top + Dimensions.k10)`). Never import `package:gap/gap.dart` directly — always go through `Gaps`. **Never use `SizedBox` as a spacer** — `SizedBox(height: X)` / `SizedBox(width: X)` for spacing must use `Gaps` instead. `SizedBox` is for sizing constraints only.
- **Use `AppDurations` for all animation/transition durations** (`modules/core/lib/constants/durations.dart`) — **never** use hardcoded `Duration(milliseconds: X)`. Constants are named by their millisecond value for instant readability: `AppDurations.ms200`, `AppDurations.ms300`, etc. If the scale is missing a value you need, add it following the `msX` naming pattern.
- **Doc comments on constants** — Every `static const` field in `Dimensions`, `CustomWidgetDimensions`, `Gaps`, and `AppDurations` must have a `/// Value is [X]` doc comment showing its numeric value. This makes values instantly readable without navigating to the definition.
- Import via direct path: `package:core/constants/dimensions.dart`, `package:core/constants/gaps.dart`, `package:core/constants/durations.dart` (not the barrel `package:core/core.dart`).
