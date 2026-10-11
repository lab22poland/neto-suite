# Test baseline

Known test failures used by `/verify` to separate regressions from pre-existing problems. Update it when a fix lands or the baseline is re-recorded.

Recorded 2026-10-11 on neto `main` after PR #3 (ICMP ping) and PR #5 (new UI suite); unit results are from the PR #3 run, UI results from the PR #5 runs. Environment: Xcode 27.0, macOS 26.7.1 host, simulators iPhone 17 and iPad Pro 11-inch (M5) on iOS 26.5. Commands as in `/verify`.

| Platform | Unit (`netoTests`) | UI (`netoUITests`) |
|---|---|---|
| macOS | 66/73 | 5/5 |
| iPhone 17 | 66/73 | 5/5 |
| iPad Pro 11-inch (M5) | 66/73 | 5/5 |

## Unit tests – same 7 failures on all platforms

Stale tests (fixed in neto PR #4, not merged yet):
- `netoTests/networkToolCaseCount()` – expects 4 tools, there are 5 (ARP was added)
- `netoTests/whoisViewModelDomainValidation()` – `invalid_domain` is a valid person/org handle by design
- `WhoisManagerIntegrationTests/whoisManagerCountryCodeTLDs()` – IANA no longer refers `.uk` to Nominet; `.fr` resolves to `whois.nic.fr`
- `WhoisManagerIntegrationTests/whoisManagerDifferentTLDs()` – IANA refers `.org` to `whois.publicinterestregistry.org`, not `pir.org`
- `WhoisManagerIntegrationTests/whoisManagerInvalidDomains()` – IANA's "returned 0 objects" reply is missing from the accepted phrases

Code bugs (fixed in neto PR #4, not merged yet):
- `netoTests/whoisDomainValidation()` – domain regex allows a single dot, so `site.co.uk` is rejected (and cannot be queried in the UI)
- `WhoisManagerIntegrationTests/whoisManagerMalformedInputs()` – an empty query is sent to IANA instead of failing as in FreeBSD `whois.c`

## UI tests

No known failures.
