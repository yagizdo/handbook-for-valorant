## 10. Localization

- Use `easy_localization` with the generated `LocaleKeys` class.
- **Always** use `LocaleKeys.key_name.tr()` — **never** `'key.name'.tr()`.
- Import: `package:gen/src/language/locale_keys.g.dart` (also re-exported via `package:gen/gen.dart`).
- Translation files: `modules/gen/assets/translations/{locale}.json` (currently `en-US.json`, `tr-TR.json`).
- Adding new keys: add to all JSON files → run `bash scripts/app/lang.sh` → use via `LocaleKeys`.
- **No uppercase values in translation JSONs** — Store all translations in natural case (e.g. `"Abilities"`, not `"ABILITIES"`). If the UI needs uppercase, apply `.toUpperCase()` at the call site (e.g. `LocaleKeys.agents_section_abilities.tr().toUpperCase()`). Text casing is a presentation concern, not a translation concern.
- Never hand-edit `locale_keys.g.dart` — it's generated.
- **Never commit generated files to git** — `*.g.dart`, `*.freezed.dart`, `*.gen.dart`, `*.gr.dart` must stay untracked. Never add `.gitignore` negation rules (`!`) or `git add -f` for generated files. Run generation scripts locally; output is reproducible.

### JSON Key Structure — Feature-First Nesting

The translation JSONs use a **feature-first nested structure**. Every key belongs to the feature that owns it. This prevents cross-cutting groups that mix keys from multiple features and makes it immediately obvious where a new key belongs.

**Top-level groups:**

| Group | What goes here |
|---|---|
| `app` | App-wide metadata (e.g. `app.title`) |
| `common` | Truly shared keys used by multiple features: `common.action.*`, `common.filter.*`, `common.error.*` |
| `nav` | Bottom navigation bar labels: `nav.agents`, `nav.maps`, etc. |
| `{feature}` | Everything owned by that feature — see structure below |

**Per-feature structure:**

```json
"{feature}": {
  "title": "Screen title shown in the header",
  "empty": "Shown when the list/detail has no data (covers not-found cases too)",
  "section": {
    "{sectionName}": "Section header label"
  },
  "{subgroup}": {
    "{key}": "Specific label within that subgroup"
  }
}
```

**Structural rules:**

- **No per-feature error keys.** `{feature}.empty` covers both the empty state and not-found cases — don't add `{feature}.error.notFound` or similar.
- **No cross-cutting groups.** Never create a top-level `empty`, `error`, `section`, or `settings` group that mixes keys from different features. Each feature owns its own `empty`, `section`, and sub-group keys.
- **`common` is for genuinely shared keys only.** A key belongs in `common` only if it is used by two or more features verbatim. If only one feature uses it, it belongs under that feature.
- **Section headers go under `{feature}.section.{name}`.** Never use a flat `section_*` pattern.
- **Feature-specific sub-data goes under `{feature}.{subgroup}.{key}`.** For example, weapon stat labels go under `weapons.stats.*` and damage column headers under `weapons.damage.*`.

**When adding a new key, ask:**
1. Is this key used by more than one feature? → `common.*`
2. Is this a nav bar label? → `nav.*`
3. Is this a section header for feature X? → `{x}.section.{name}`
4. Is this a data label within a sub-group of feature X? → `{x}.{subgroup}.{name}`
5. Otherwise → `{x}.{name}` directly under the feature
