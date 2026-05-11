# Handbook for Valorant

![Version](https://img.shields.io/badge/version-2.1.1-FF4655?style=flat-square)
[![Codemagic build status](https://api.codemagic.io/apps/6a021af32b4197a14d08e2b1/6a021af32b4197a14d08e2b0/status_badge.svg)](https://codemagic.io/app/6a021af32b4197a14d08e2b1/6a021af32b4197a14d08e2b0/latest_build)

A community-built Flutter handbook for Valorant — browse agents, maps, weapons, weapon skins (with video previews), and competitive ranks. Powered by the public [valorant-api.com](https://valorant-api.com).

> **Disclaimer:** This is an **unofficial fan-made application**. It is not affiliated with, endorsed by, sponsored by, or in any way officially connected to **Riot Games, Inc.**. "Valorant" and all associated trademarks, logos, characters, and assets are the property of Riot Games, Inc. All game data is sourced from the public, community-maintained [valorant-api.com](https://valorant-api.com).

## Screenshots

| Agents | Maps | Weapons | Ranks |
|---|---|---|---|
| _coming soon_ | _coming soon_ | _coming soon_ | _coming soon_ |

## Features

- **Agents** — Browse agents with role-based filtering, view abilities and background art
- **Maps** — Explore maps with callouts and tactical layouts
- **Weapons** — Detailed weapon stats, damage tables, and full skin galleries with video previews
- **Ranks** — Browse the competitive tier ladder
- **Dual language** — English and Turkish, switchable at runtime
- **Offline-friendly** — Local cache layer (cache-first with API fallback)
- **Adaptive theming** — Light / dark mode with the Valorant brand palette

## Tech Stack

| Layer | Choice |
|---|---|
| Framework | Flutter 3.41+ / Dart 3.11+ |
| State management | [flutter_bloc](https://pub.dev/packages/flutter_bloc) (Cubit + Freezed union states) |
| Models | [freezed](https://pub.dev/packages/freezed) + [json_serializable](https://pub.dev/packages/json_serializable) |
| Routing | [auto_route](https://pub.dev/packages/auto_route) |
| DI | [get_it](https://pub.dev/packages/get_it) |
| HTTP | [dio](https://pub.dev/packages/dio) |
| Local cache | [objectbox](https://pub.dev/packages/objectbox) |
| Localization | [easy_localization](https://pub.dev/packages/easy_localization) |
| Image cache | [cached_network_image](https://pub.dev/packages/cached_network_image) |
| Video | [better_player_plus](https://pub.dev/packages/better_player_plus) |

## Architecture

Feature-first layered architecture: **View → Cubit → Service → Repository / Network**.

```
lib/
├── features/          # Self-contained feature modules
│   ├── agents/
│   ├── maps/
│   ├── weapons/
│   ├── ranks/
│   └── profile/
├── product/           # Cross-feature shared code
└── main.dart

modules/               # Reusable packages
├── core/              # Dimensions, gaps, durations, extensions
├── theme_module/      # Colors, text themes, dark/light mode
├── gen/               # Generated assets + localizations
└── lint_rules/        # Custom analyzer rules
```

## Getting Started

### Prerequisites

- Flutter `3.41.5`+
- Dart `^3.11.0`
- CocoaPods (iOS builds)

### Setup

```bash
git clone https://github.com/yagizdo/handbook-for-valorant-mobile.git
cd handbook-for-valorant-mobile

flutter pub get
bash scripts/app/build.sh   # code generation (Freezed, auto_route, ObjectBox)
flutter run
```

### Firebase (optional)

Firebase config files are not committed. If you want analytics:

1. Create a project in [Firebase Console](https://console.firebase.google.com/)
2. Add Android/iOS apps and download config files
3. Run `flutterfire configure`

Skip Firebase? Remove `Firebase.initializeApp(...)` from `lib/main.dart`.

## Scripts

| Script | Purpose |
|---|---|
| `scripts/app/build.sh` | Run `build_runner` for all packages |
| `scripts/app/lang.sh` | Regenerate `LocaleKeys` from translation JSONs |
| `scripts/ci/format_check.sh` | Verify formatting (line length 120) |
| `scripts/ci/code_analyze.sh` | Run analyzer + custom lints |

## Contributing

PRs welcome — target the `develop` branch.

```bash
bash scripts/ci/format_check.sh
bash scripts/ci/code_analyze.sh
```

Both must pass before merging.

## License

[MIT](LICENSE) © 2026 Yilmaz Yagiz Dokumaci

## Acknowledgments

- [Riot Games](https://www.riotgames.com/) — for creating Valorant
- [valorant-api.com](https://valorant-api.com) — for the free public API
