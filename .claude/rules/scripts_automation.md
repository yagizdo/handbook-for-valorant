## 13. Scripts & Automation

- **Before running any shell command or writing inline CI steps**, check `scripts/` for an existing script that does the same thing. The directory is organized by purpose:
  - `scripts/app/` — app-level tasks (build, clean, codegen, localization, icons, images)
  - `scripts/ci/` — CI/CD checks (format, coverage)
  - `scripts/cd/` — deployment helpers (build numbers, versions, env)
- **If a matching script exists, use it** — call `bash scripts/{category}/{name}.sh` instead of duplicating its logic inline. This keeps CI, local dev, and automation in sync.
- **If no matching script exists, create one** in the appropriate `scripts/` subdirectory before using it. Name it descriptively (e.g. `scripts/ci/analyze.sh`). Then reference the script from CI workflows, documentation, or other automation.
- **Never duplicate script logic inline** — not in CI workflows, not in Makefiles, not in documentation. A single source of truth prevents drift.
- **`code_analyze.sh` mandatory pass** — After completing each step or task, run `bash scripts/ci/code_analyze.sh`. A step/task is **not considered done** until this script returns success. If there are linter errors, fix them (see Rule 11 — never ignore without user approval). This rule always applies unless the user says otherwise.
- **`format_check.sh` mandatory pass** — After `code_analyze.sh` passes, run `bash scripts/ci/format_check.sh`. If formatting violations are found, fix them with `dart format --line-length=120 .` and re-verify. **Do not move to the next step until both analyzer and formatter pass.** This rule always applies unless the user says otherwise.
