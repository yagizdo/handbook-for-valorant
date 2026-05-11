# iOS Distribution & App Store Connect

---

- **`ITSAppUsesNonExemptEncryption` must stay in sync with actual encryption usage** — `ios/Runner/Info.plist` declares `ITSAppUsesNonExemptEncryption = false`, which tells Apple the app only uses standard OS-provided encryption (HTTPS). This bypasses the Export Compliance prompt and allows Codemagic to auto-distribute builds to external TestFlight groups. If a dependency or feature introduces **non-exempt encryption** (custom encryption algorithms, proprietary protocols, non-standard TLS, VPN tunneling, etc.), this flag must be changed to `true` and the appropriate Export Compliance documentation must be provided in App Store Connect. Standard HTTPS via `http` / `dio` / `URLSession` does **not** require changing this flag — Apple considers OS-level HTTPS exempt.
