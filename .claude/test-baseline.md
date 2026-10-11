# Test baseline

Known test failures used by `/verify` to separate regressions from pre-existing problems. Update it when a fix lands or the baseline is re-recorded.

Recorded 2026-10-12 on neto `main` `e078b3b` (after PRs #3, #4, #5). Environment: Xcode 27.0, macOS 26.7.1 host, simulators iPhone 17 and iPad Pro 11-inch (M5) on iOS 26.5. Commands as in `/verify`.

| Platform | Unit (`netoTests`) | UI (`netoUITests`) |
|---|---|---|
| macOS | 73/73 | 5/5 |
| iPhone 17 | 73/73 | 5/5 |
| iPad Pro 11-inch (M5) | 73/73 | 5/5 |

No known failures. Note: `WhoisManagerIntegrationTests` and the ping tests to 8.8.8.8 depend on the internet and on live WHOIS data, so a failure there may be environmental.
