## 15. Release Notes

- `release_notes.json` in the project root must be updated **before every commit or PR**.
- The file is consumed by Codemagic for App Store submissions and is read by **QA testers and end users** — write entries they can actually understand and act on.
- Each locale's `text` field should list changes in bullet format (`- Change description`).
- **Never use generic placeholder text** — entries like "General improvements and bug fixes" are banned. Every entry must describe something concrete.

**Include:** New features, UI changes, bug fixes users can observe, performance improvements users can feel, new screens/flows. Even internal refactors should be described in terms of their visible effect (e.g. "Images load faster" instead of "Optimized image cache").

**Exclude:** Linting rules, code formatting, CI/CD pipeline changes, dependency updates with no visible effect, developer tooling, static analysis changes.

### How to write the content

**Step 1 — Check the branch name for an issue ID.**

Run `git rev-parse --abbrev-ref HEAD` to get the current branch name. Extract any numeric ID from it (e.g. `Feature/fix-agent-list-123` → issue `#123`, `bugfix/123-crash-on-launch` → issue `#123`).

If an issue ID is found:
- Fetch the issue title from GitHub using `gh issue view {id} --repo yagizdo/handbook-for-valorant-mobile --json title -q .title`.
- Write a single precise bullet based on the title and the nature of the change:
  - Bug fix → `- Fixed: {issue title in user-facing terms}`
  - Feature → `- Added: {issue title in user-facing terms}`
  - Improvement → `- Improved: {issue title in user-facing terms}`

**Step 2 — If no issue ID found, analyze the diff.**

Run `git diff master...HEAD --stat` and `git log master...HEAD --oneline` to understand what changed. Read the changed files if needed. Then write 2–3 bullets (up to 4–5 if the change is large) that describe the visible effect in plain language a tester can act on.

Good examples:
- `- Fixed: Agent detail screen crashed when scrolling quickly`
- `- Added: Weapon skin preview images in the store tab`
- `- Improved: App startup time reduced significantly`
- `- Fixed: Map images failed to load on slow connections`

Bad examples (never write these):
- `- General improvements and bug fixes`
- `- Refactored ProductImage widget`
- `- Code cleanup`
- `- Updated dependencies`

**Step 3 — Write in both locales.**

Always update both `en-US` and `tr-TR` entries. Translate the English bullets to Turkish naturally — don't machine-translate word for word.

- Forgetting release notes before commit/PR is a rule violation — treat it like forgetting to run the analyzer.
