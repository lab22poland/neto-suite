# Test baseline

Known test failures used by `/verify` to separate regressions from pre-existing problems. Update it when a fix lands or the baseline is re-recorded.

Recorded 2026-10-12 on neto `main` `0730b28` (after PR #6). Environment: Xcode 27.0, macOS 26.7.1 host, simulators iPhone 17 and iPad Pro 11-inch (M5) on iOS 26.5. Commands as in `/verify`.

| Platform | Unit passed | Unit skipped (network) | Unit known issues | UI |
|---|---|---|---|---|
| macOS | 42 | 3 | 6 | 5/5 |
| iPhone 17 | 42 | 3 | 5 | 5/5 (run on PR #5, before the `SimplePing` refactor in #6) |
| iPad Pro 11-inch (M5) | 42 | 3 | 5 | 5/5 (run on PR #5, before the `SimplePing` refactor in #6) |

With `TEST_RUNNER_NETO_NETWORK_TESTS=1` on macOS: 45 passed, 0 skipped.

## Known issues (pinned with `withKnownIssue` / `XCTExpectFailure`)

A pinned test counts as passing while the bug exists. When a fix lands, the test fails with "known issue was not recorded" – remove the wrapper and the entry here.

- `TracerouteManagerLogicTests/resolvesDomainNames()` – every host with a dot and no colon is validated as IPv4, so domain names are rejected
- `TracerouteManagerLogicTests/errorMessageReachesUser()` – `TracerouteError` is not a `LocalizedError`
- `ArpLinkLayerParsingTests/macAddressIsReadAtLLADDR()` (macOS only) – MAC read at `sizeof(sockaddr_dl) + nlen` instead of `LLADDR`
- `ArpResultTests/outputIsSortedNumerically()` – IPs sorted as strings
- `WhoisQueryValidationTests/malformedASNumber(_:)` – `as`, `AS`, `as1as2` accepted
- `PingStatisticsTests/testStopMarkerDoesNotCountAsLostPacket` – stop row counted as a lost packet

No other failures are known.
