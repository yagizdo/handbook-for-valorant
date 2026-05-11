## 14. PR Target Branch, Issue Linking & Release Notes

**All pull requests must target `develop`** unless the user explicitly specifies a different base branch. Never open a PR against `master` by default. `master` is the stable/release branch — changes reach it only through a deliberate `develop → master` PR when a release is ready.

**If a PR resolves a GitHub issue, always link it in the PR body.** Use `Closes #<issue-number>` so GitHub auto-closes the issue on merge. Before opening a PR, run `gh issue list` to check for a matching issue. If one exists, include the closing keyword in the Summary section of the PR body.

**Before running `gh pr create`, always complete this sequence in order:**
1. **Update `release_notes.json`** — open it, verify all locales are updated for this branch's changes. If not, update and commit first. Do not create the PR until this is done.
2. **Check for related issue** — run `gh issue list` and link with `Closes #N` if found.
3. **Verify target branch is `develop`** (unless user specified otherwise).

This sequence is mandatory. The PR creation command is the last step, not the first.

---

## 16. PR Test Plan Execution

When a PR description includes a test plan checklist, **execute as many items as possible** before considering the PR done — don't just write the checklist and leave it.

**What to execute automatically:**
- Build verification (`flutter build` or running the analyzer)
- Static checks that don't require a running device (key references, localization fallbacks)
- Any test that can run via `flutter test` or `bash scripts/`

### Marionette MCP for UI verification

Many test plan items that previously required manual device/simulator testing can now be executed automatically via **Marionette MCP**. Before classifying a UI test as "requires manual verification," ask: "Can I interact with this screen and verify the result programmatically through Marionette?"

**How to connect:**
1. Check if a Flutter app is already running in debug mode — look for an active VM service URI (e.g. `ws://127.0.0.1:XXXX/ws`).
2. If no app is running, launch one with `flutter run` and capture the VM service URI from the output.
3. Use the Marionette `connect` tool with the VM service URI.

**What Marionette can verify:**
- Screen navigation and element presence (`get_interactive_elements`, `tap`)
- Image loading success/failure (take a `take_screenshots` and inspect visually)
- Error states and fallback UI (navigate to a screen, verify expected widgets appear)
- Text content and labels (`get_interactive_elements` returns element text)
- Tap flows and user interactions (`tap`, `enter_text`, `scroll_to`)
- Hot reload after code changes (`hot_reload`)

**When Marionette is NOT sufficient** — report these to the user for manual verification:
- Network-dependent behavior that requires specific server conditions (e.g. testing with airplane mode, slow connections)
- Platform-specific behavior that differs between iOS/Android
- Performance/animation smoothness that requires human perception
- Accessibility features (VoiceOver, TalkBack) that need real assistive technology

**Format for reporting results:**
After creating the PR, explicitly list: (1) items executed via analyzer/tests + result, (2) items verified via Marionette + result, (3) items that genuinely require manual verification and why.

This rule always applies unless the user says otherwise.
