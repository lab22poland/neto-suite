# Test baseline

Known test failures used by `/verify` to separate regressions from pre-existing problems. Update it when a fix lands or the baseline is re-recorded.

Recorded 2026-10-12 on neto `main` after PR #10 (ARP follow-up). Environment: Xcode 27.0, macOS 26.7.1 host, simulators iPhone 17 and iPad Pro 11-inch (M5) on iOS 26.5. Commands as in `/verify`.

| Platform | Unit passed | Unit skipped (network) | Unit known issues | UI |
|---|---|---|---|---|
| macOS | 68 | 5 | 1 | 6/6 |
| iPhone 17 | 60 | 5 | 1 | 6/6 |
| iPad Pro 11-inch (M5) | 60 | 5 | 1 | 6/6 |

With `TEST_RUNNER_NETO_NETWORK_TESTS=1` on macOS (measured on PR #7): all network tests pass.

## Known issues (pinned with `withKnownIssue` / `XCTExpectFailure`)

A pinned test counts as passing while the bug exists. When a fix lands, the test fails with "known issue was not recorded" – remove the wrapper and the entry here.

- `WhoisQueryValidationTests/malformedASNumber(_:)` – `as`, `AS`, `as1as2` accepted

No other failures are known.
