yap # Handbook for Valorant

A community-built Flutter handbook for Valorant — browse agents, maps, weapons, weapon skins (with video previews), and competitive ranks. Powered by the public [valorant-api.com](https://valorant-api.com).

> **Disclaimer:** This is an **unofficial fan-made application**. It is not affiliated with, endorsed by, sponsored by, or in any way officially connected to **Riot Games, Inc.**. "Valorant" and all associated trademarks, logos, characters, and assets are the property of Riot Games, Inc. All game data is sourced from the public, community-maintained [valorant-api.com](https://valorant-api.com).

---

## Screenshots

| Agents | Maps | Weapons | Ranks |
|---|---|---|---|
| _coming soon_ | _coming soon_ | _coming soon_ | _coming soon_ |

---

## Features

- **Agents** — Browse agents with role-based filtering, view abilities and background art
- **Maps** — Explore maps with callouts and tactical layouts
- **Weapons** — Detailed weapon stats, damage tables, and full skin galleries with video previews
- **Ranks** — Browse the competitive tier ladder
- **Dual language** — English and Turkish, switchable at runtime
- **Offline-friendly** — Local cache layer (cache-first with API fallback)
- **Adaptive theming** — Light / dark mode with the Valorant brand palette

---

## Tech Stack

| Layer | Choice |
|---|---|
| **Framework** | Flutter `>=3.41.0` / Dart `^3.11.0` |
| **State management** | [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) (Cubit + Freezed union states) |
| **Models** | [`freezed`](https://pub.dev/packages/freezed) + [`json_serializable`](https://pub.dev/packages/json_serializable) |
| **Routing** | [`auto_route`](https://pub.dev/packages/auto_route) |
| **Dependency injection** | [`get_it`](https://pub.dev/packages/get_it) |
| **HTTP** | [`dio`](https://pub.dev/packages/dio) |
| **Local cache** | [`objectbox`](https://pub.dev/packages/objectbox) |
| **Localization** | [`easy_localization`](https://pub.dev/packages/easy_localization) |
| **Image cache** | [`cached_network_image`](https://pub.dev/packages/cached_network_image) |
| **Video** | [`better_player_plus`](https://pub.dev/packages/better_player_plus) |
| **Analytics** | [`firebase_analytics`](https://pub.dev/packages/firebase_analytics) (optional) |

---

## Architecture

Feature-first layered architecture: **View → Cubit → Service → Repository / Network**.

```
lib/
├── features/              # Each feature is self-contained
│   ├── agents/
│   │   ├── cubit/         # State management (BlocBuilder)
│   │   ├── model/         # Freezed models + ObjectBox entities + mappers
│   │   ├── service/       # Business logic + cache-first orchestration
│   │   ├── view/          # @RoutePage screens
│   │   ├── widget/        # Feature-scoped widgets
│   │   └── constants/
│   ├── maps/
│   ├── weapons/
│   ├── ranks/
│   └── profile/
├── product/               # Cross-feature, app-global code
│   ├── widgets/           # Product* shared widgets
│   ├── constants/
│   ├── locator/           # DI container
│   ├── router/            # auto_route config
│   └── network/
└── main.dart

modules/                   # Reusable, version-agnostic packages
├── core/                  # Dimensions, gaps, durations, extensions
├── theme_module/          # Colors, text themes, dark/light mode
├── gen/                   # Generated assets + localizations
└── lint_rules/            # Custom analyzer rules
```

State follows a **Freezed sealed union** pattern (`initial / loading / empty / success / error`) consumed via Dart 3 exhaustive `switch`. Detailed conventions live in `.claude/rules/project_rules.md`.

---

## Getting Started

### Prerequisites

- **Flutter `3.41.5`** (the version CI builds against — newer minor versions should also work)
- **Dart `^3.11.0`**
- **CocoaPods** (for iOS builds)
- A **Firebase project** if you want analytics; otherwise the Firebase initialization can be stripped from `lib/main.dart`

> Optional: this project was originally developed with [FVM](https://fvm.app/) for Flutter version pinning. If you prefer FVM: `fvm install 3.41.5 && fvm use 3.41.5`. Not required — system Flutter works just as well.

### 1. Clone and install dependencies

```bash
git clone https://github.com/<your-username>/<repo-name>.git
cd <repo-name>

flutter pub get
```

### 2. Set up Firebase (optional, only if you want analytics)

Firebase config files are intentionally **not committed** — each contributor must create their own Firebase project so usage stats don't pollute the original maintainer's dashboard.

1. Go to [Firebase Console](https://console.firebase.google.com/) and create a new project
2. Add an **Android app** with package name `com.<your-namespace>.<your-app-id>` and download `google-services.json` → place it at `android/app/google-services.json`
3. Add an **iOS app** with your bundle identifier and download `GoogleService-Info.plist` → place it at `ios/Runner/GoogleService-Info.plist`
4. Install the [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup) and run:

   ```bash
   flutterfire configure
   ```

   This generates `lib/firebase_options.dart` and `firebase.json`.

If you **don't** want to use Firebase, remove the `Firebase.initializeApp(...)` call from `lib/main.dart` and drop `firebase_core` / `firebase_analytics` from `pubspec.yaml`.

### 3. Generate code

Freezed, JSON, auto_route, and ObjectBox all use build_runner:

```bash
bash scripts/app/build.sh
```

### 4. Run

```bash
flutter run
```

---

## Scripts

Reusable scripts live in `scripts/` (organized by purpose):

| Script | Purpose |
|---|---|
| `scripts/app/build.sh` | Run `build_runner` for all packages |
| `scripts/app/lang.sh` | Regenerate `LocaleKeys` from translation JSONs |
| `scripts/ci/format_check.sh` | Verify `dart format` (line length 120) |
| `scripts/ci/code_analyze.sh` | Run analyzer + custom lints |

---

## Data Source

All Valorant content (agents, maps, weapons, skins, ranks) is fetched from **[valorant-api.com](https://valorant-api.com)** — a free, public, community-maintained API. No authentication required, no API key needed.

---

## Project Conventions

Detailed coding conventions, architectural rules, and design system docs live in:

- [`.claude/rules/project_rules.md`](.claude/rules/project_rules.md) — Architecture, state management, theming, localization
- [`.claude/rules/text_design_system.md`](.claude/rules/text_design_system.md) — Typography rules (dual-font: Valorant + Inter)
- [`.claude/learning_lessons.md`](.claude/learning_lessons.md) — Distilled lessons from iterative development

These rules are followed by both human contributors and AI coding agents that work on this project.

---

## Contributing

Pull requests are welcome. Please target the `develop` branch (never `master`).

Before opening a PR:

```bash
bash scripts/ci/format_check.sh
bash scripts/ci/code_analyze.sh
```

Both must pass. CI will reject otherwise.

---

## License

[MIT](LICENSE) © 2026 Yılmaz Yağız Dokumacı

---

## Acknowledgments

- [Riot Games](https://www.riotgames.com/) — for creating Valorant. This project exists because of the game.
- [valorant-api.com](https://valorant-api.com) — for maintaining the free public API that powers this app.
- The Flutter community.
