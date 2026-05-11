# Workflow & Process Lessons

Learned tips for git workflow, release notes, testing, and localization, supplementing rules in `pr_workflow.md`, `release_notes.md`, and `localization.md`.

---

## Git

- **Branch naming** — Use dash separator for sub-branches, not slash. Example: `Feature/valorant-v2-data-layer` (not `Feature/valorant-v2/data-layer`).

## Release Notes

- **Release notes BEFORE opening a PR — no exceptions** — When the user says "open a PR" / "create a PR" / "ship this", the very first thing to do is check `release_notes.json`. If it has not been updated for this branch's changes, **STOP and update it before running `gh pr create`**. This is not a post-PR cleanup task — it must happen before the PR exists. The failure mode is: PR is open, CI starts, reviewer picks it up, and `release_notes.json` is stale. That forces an extra commit to fix it or a missed release entry.
- **Internal-only PRs get a generic entry** — If a PR has zero user-visible changes, use a generic `- General improvements and bug fixes` entry. Reusing the same generic message across consecutive internal PRs is fine — the goal is that the file is always kept up to date. Forgetting release notes for user-visible changes delays releases. Including invisible internal changes creates noise for QA.

## Marionette Testing

- **Don't default to "requires manual verification" for UI checks** — Before classifying a test plan item as manual-only, ask: "Can Marionette MCP interact with this screen and verify the result?" Many items that seem to need a human (image loading, screen navigation, element presence, tap flows) can be verified by connecting to the running Flutter app via Marionette. The decision criterion is whether the verification requires human judgment (animation smoothness, visual polish) or just confirming that the right widgets appear with the right content — the latter is automatable.

## Localization

- **Avoid easy_localization reserved keys** — `other`, `one`, `two`, `few`, `many`, `zero` are reserved for plurals in easy_localization codegen. Never use them as standalone JSON keys — the generator silently skips them. Use descriptive alternatives (e.g. `otherRegion` instead of `other`).

## Meta

- **When analysis contradicts a rule, surface it** — If an audit, refactor, or new feature reveals that an existing rule is too broad, too narrow, or doesn't apply to a valid case, don't just silently adapt the plan. Ask the user: "This case suggests the rule may need refinement — should I update rules/lessons?" Rules that don't match reality create confusion for future work. The insight and the follow-through must happen together.
