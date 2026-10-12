# Test baseline

Known test failures used by `/verify` to separate regressions from pre-existing problems. Update it when a fix lands or the baseline is re-recorded.

Recorded 2026-10-12 on neto `main` after PR #18 (audit fixes #15–#18). Environment: Xcode 27.0, macOS 26.7.1 host, simulators iPhone 17 and iPad Pro 11-inch (M5) on iOS 26.5. Commands as in `/verify`.

| Platform | Unit passed | Unit skipped (network) | Unit known issues | UI |
|---|---|---|---|---|
| macOS | 160 | 9 | 0 | 7/7 |
| iPhone 17 | 152 | 9 | 0 | 7/7 |
| iPad Pro 11-inch (M5) | 152 | 9 | 0 | 7/7 |

With `TEST_RUNNER_NETO_NETWORK_TESTS=1`: macOS 169 passed, 0 skipped (network tests run serialized; whois.markmonitor.com throttles by IP – after a few queries it closes connections with 0 bytes for ~5 min; since PR #18 the app reports that as an incomplete result instead of stopping the chain).

## Known issues (pinned with `withKnownIssue` / `XCTExpectFailure`)

None pinned at the moment. A pinned test counts as passing while the bug exists. When a fix lands, the test fails with "known issue was not recorded" – remove the wrapper and the entry here.


No other failures are known.

## Observed flakes

- 2026-10-12, macOS UI: `testArpTableLoadsWithoutError` once failed with "arp did not open" (header not shown within 5 s after tapping the sidebar row); the immediate reruns passed (1/1, then 6/6). Investigate if it happens again.
- 2026-10-12, macOS UI: `testPingLocalhostReportsReplies` failed twice (once "All 5 echo requests … must be answered", once "Start must be disabled for a whitespace-only host") while two macOS UI test runs were going at the same time (they compete for keyboard focus). Run alone it passed 3/3. Do not run macOS UI tests concurrently.
