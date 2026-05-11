# Pre-commit & Review Checklist

Run EVERY time before commit, PR, or review.

> **When the user says "open a PR" / "create a PR": start from item 1 — do not skip to `gh pr create`.**

1. **Release notes check (FIRST — blocks everything else)** — Open `release_notes.json` and verify it has been updated for all locales. If user-visible changes exist and the file is stale, **STOP, update it, and commit the update before creating the PR**. If the change is purely internal (linting, CI, refactoring with no UI impact), add a generic `- General improvements and bug fixes` entry. **Never skip** — every PR must have a release notes entry. A PR opened with stale release notes is incomplete.
2. **Generated files check** — Run `git diff --cached --name-only | grep -E '\.(g|freezed|gen|gr)\.dart$'` and `git ls-files --cached | grep -E '\.(g|freezed|gen|gr)\.dart$'`. If any match, **STOP and warn the user**. Remove them with `git rm --cached <file>` before proceeding.
3. **Gitignore negation check** — Run `grep -r '^!' --include='.gitignore' modules/ lib/` to find any `!` negation rules for generated files. If found, **STOP and warn the user**.
4. **Dart analyzer check** — Run `flutter analyze` after completing each plan step / logical chunk of work. When errors are found, use judgement: fix immediately if something was unintentionally broken, skip if the error is expected and will be resolved in a later plan step (e.g. referencing a key that will be generated in the next step). **Never leave unexpected analyzer errors behind** — the goal is catching accidental breakage, not busywork.
5. If any check fails, **always alert the user before committing** — don't silently fix or skip.
6. **`code_analyze.sh` mandatory pass** — After completing each step/task, run `bash scripts/ci/code_analyze.sh`. The step is **not considered done** until the script returns success. If there are linter errors, fix them; **never add `// ignore:` lines on your own**. If ignoring a lint rule seems truly unavoidable, ask the user first ("Should I ignore this rule?") and do not write the ignore line without approval. This rule always applies unless the user says otherwise.
7. **`format_check.sh` mandatory pass** — After `code_analyze.sh` passes, run `bash scripts/ci/format_check.sh`. If formatting violations are found, fix with `dart format --line-length=120 .` and re-verify. **Do not move to the next step until both analyzer and formatter pass.** This prevents formatting drift from accumulating across steps.
