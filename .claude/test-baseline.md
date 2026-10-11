# Test baseline

Known test failures used by `/verify` to separate regressions from pre-existing problems. Update it when a fix lands or the baseline is re-recorded.

Recorded 2026-10-11 on neto `7888bb1` (branch `refactor-ping-simpleping`), Xcode 27.0, macOS 26.7.1 host, with the macOS overrides from `neto/CLAUDE.md`.

## macOS unit tests (`netoTests`): 57/73 passed

Stale tests or logic bugs:
- `netoTests/networkToolCaseCount()` – expects 4 tools, there are 5 (ARP was added)
- `netoTests/whoisDomainValidation()` – `site.co.uk` rejected as invalid
- `netoTests/whoisViewModelDomainValidation()` – `invalid_domain` accepted as valid
- `WhoisManagerIntegrationTests/whoisManagerMalformedInputs()` – empty input reports success
- `WhoisManagerIntegrationTests/whoisManagerCountryCodeTLDs()` – UK domain not routed to the Nominet server
- `WhoisManagerIntegrationTests/whoisManagerDifferentTLDs()` – .org not routed to the PIR server
- `PingManagerV2Tests/testPingStopMethod` – result callback fires after stop
- `PingManagerV2Tests/testPingWithZeroCount` – results delivered with count 0

ICMP ping (host `ping` to 127.0.0.1 and 8.8.8.8 works, so most likely logic or socket handling in the test process):
- `PingManagerV2Tests/testPingLocalhost` – 1 result instead of 5
- `PingManagerV2Tests/testPingGoogleDNS` – 1 result instead of 3
- `PingManagerV2Tests/testPingOperationCancellation` – times out after 1 s
- `PingManagerV2Tests/testPingWithVeryShortTimeout` – assertion fails (probably the message lacks "timeout")
- `SimplePingTests/testPingLocalhost`, `SimplePingTests/testPingGoogleDNS`, `SimplePingTests/testDelegateCallbacks` – no delegate callbacks within 5 s

Depends on an external WHOIS server response:
- `WhoisManagerIntegrationTests/whoisManagerInvalidDomains()`

## macOS UI tests (`netoUITests`): 13/13 passed (~4 min)

## iOS Simulator unit tests: cannot run

`test -only-testing:netoTests` on `iPhone 17` (iOS 26.5): the host app `pl.lab22.neto` fails to launch (`FBSOpenApplicationServiceErrorDomain Code=1`, `RequestDenied`, `RBSRequestErrorDomain Code=5 "Launch failed."`), so the run ends with TEST FAILED and no test executes. Cause not investigated yet. Simulator **builds** succeed.
