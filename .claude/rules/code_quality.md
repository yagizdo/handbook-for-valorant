## 11. Lint Ignore Comments

- **Never add `// ignore:` or `// ignore_for_file:` without explicit user approval.** Refactor the code, use a different API, or fix the root cause first. Lint rules are **never** to be silently suppressed.
- If suppression seems truly unavoidable (e.g. a third-party API forces usage of a deprecated member with no replacement), you **must**:
  1. **Ask the user first** — "Should I ignore this rule?" with a clear explanation of why. **Do not write the ignore line without approval.**
  2. If approved: add a comment directly above the ignore explaining **why** it's necessary and **what** would need to change to remove it.
- This rule always applies unless the user explicitly says otherwise.

---

## 12. Formatting

- **Line length is 120 characters** — enforced by `dart format --line-length=120`.
- Run `bash scripts/ci/format_check.sh` before committing to verify formatting.
- GitHub Actions CI will reject PRs with formatting violations.
- VS Code settings (`.vscode/settings.json`) are committed to the repo — `dart.lineLength: 120` is pre-configured.
- **Never** override the line length locally or per-file. If a line genuinely needs to be longer than 120 chars (rare), restructure the code.
