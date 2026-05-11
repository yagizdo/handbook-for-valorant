# Text Design System

The app uses a dual-font strategy: **Valorant** for brand/display text and **Inter** for readable content.

## Core Rule

**Headline styles (`display*`, `headline*`) = Valorant font.** Used for page titles and item names only.

**All other styles (`title*`, `body*`, `label*`) = Inter font.** Used for everything users need to read, scan, or parse.

**Decision criterion:** If the text is a page title or an item name (agent, weapon, map), use a headline style. For everything else — body text, descriptions, section headers, labels, data values, navigation — use a non-headline style.

## Font Mapping Quick Reference

| TextTheme Style | Font | Usage |
|---|---|---|
| `displayLarge/Medium/Small` | Valorant | Reserved |
| `headlineLarge` | Valorant | Page titles (AGENTS, MAPS, WEAPONS, PROFILE) |
| `headlineMedium` | Valorant | Detail page hero names |
| `headlineSmall` | Valorant | Card names on list pages |
| `titleLarge` | Inter | Section headers (ABILITIES, STATS) |
| `titleMedium` | Inter | Sub-section headers, setting labels |
| `titleSmall` | Inter | Stat labels, category labels |
| `bodyLarge/Medium/Small` | Inter | Body text, descriptions, data |
| `labelLarge/Medium/Small` | Inter | Nav labels, chips, badges |

## When You Need Valorant at a Non-Headline Size

Some widgets (e.g. weapon card names) need the Valorant font but at a smaller size than any headline style provides. In these cases, use `copyWith(fontFamily: AppTextTheme.valorantFontFamily)` on the appropriate text style:

```dart
context.textTheme.titleSmall?.copyWith(
  fontFamily: AppTextTheme.valorantFontFamily,
)
```

This should be rare — most item names fit naturally into `headlineSmall` (24px) or `headlineMedium` (28px).

## Configuration

Font families are configured in `modules/theme_module/lib/src/text/app_text_theme.dart`:
- `AppTextTheme.valorantFontFamily` — Valorant font path
- `AppTextTheme.interFontFamily` — Inter font path
- `AppTextTheme.fontFamily` — Default (Inter)

Font assets live in `modules/gen/assets/fonts/` and are registered in `modules/gen/pubspec.yaml`.
