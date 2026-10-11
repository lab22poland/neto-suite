# Test baseline

Known test failures used by `/verify` to separate regressions from pre-existing problems. Update it when a fix lands or the baseline is re-recorded.

Recorded 2026-10-11 on neto branch `refactor-ping-simpleping`, after the ping fix (PR #3). Environment: Xcode 27.0, macOS 26.7.1 host, simulators iPhone 17 and iPad Pro 11-inch (M5) on iOS 26.5. Commands as in `/verify`.

| Platform | Unit (`netoTests`) | UI (`netoUITests`) |
|---|---|---|
| macOS | 66/73 | 13/13 |
| iPhone 17 | 66/73 | 10/13 |
| iPad Pro 11-inch (M5) | 66/73 | 13/13 |

## Unit tests – same 7 failures on all platforms

Stale tests (planned for the WHOIS PR):
- `netoTests/networkToolCaseCount()` – expects 4 tools, there are 5 (ARP was added)
- `netoTests/whoisViewModelDomainValidation()` – `invalid_domain` is a valid person/org handle by design
- `WhoisManagerIntegrationTests/whoisManagerCountryCodeTLDs()` – IANA no longer refers `.uk` to Nominet; `.fr` resolves to `whois.nic.fr`
- `WhoisManagerIntegrationTests/whoisManagerDifferentTLDs()` – IANA refers `.org` to `whois.publicinterestregistry.org`, not `pir.org`
- `WhoisManagerIntegrationTests/whoisManagerInvalidDomains()` – IANA's "returned 0 objects" reply is missing from the accepted phrases

Code bugs (planned for the WHOIS PR):
- `netoTests/whoisDomainValidation()` – domain regex allows a single dot, so `site.co.uk` is rejected (and cannot be queried in the UI)
- `WhoisManagerIntegrationTests/whoisManagerMalformedInputs()` – an empty query is sent to IANA instead of failing as in FreeBSD `whois.c`

## UI tests – iPhone only

`testAppLaunch`, `testMemoryUsage` and `testNavigationBetweenTools` fail on iPhone: `NavigationSplitView` collapses to a stack, so the sidebar and the detail are never visible at the same time. `testAppLaunch` expects the detail placeholder next to the sidebar; the other two cannot find "About" after a tool is opened. Also present before the ping change. Planned for the test audit.
