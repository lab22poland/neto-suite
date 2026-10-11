---
name: verify
description: Build the NETo app and run its tests on macOS, an iPhone simulator and an iPad simulator, then compare failures against the baseline. Use after changing code in neto/ or when asked to verify, build or test the app.
argument-hint: "[ui]  (also run UI tests, ~1-1.5 min per platform)"
---

Verify the NETo app in `neto/` (relative to the workspace root). Run every command from `neto/`, use `-derivedDataPath /tmp/neto-dd` everywhere, and write full logs to `/tmp/neto-verify-*.log` so that only summaries end up in context. Tests launch the app (macOS windows, Simulator), so tell the user before starting.

1. Pick simulators: run `xcrun simctl list devices available`. Prefer `iPhone 17` and `iPad Pro 11-inch (M5)`; otherwise use the newest iPhone and the newest iPad Pro 11-inch available.
2. Unit tests on all three platforms. Running the tests also builds the app; stop and report on the first compile error. Remove old result bundles first.
   ```bash
   xcodebuild -project neto.xcodeproj -scheme neto -destination 'platform=macOS,arch=arm64' -derivedDataPath /tmp/neto-dd -resultBundlePath /tmp/neto-unit-mac.xcresult test -only-testing:netoTests CODE_SIGN_IDENTITY=- CODE_SIGN_STYLE=Manual DEVELOPMENT_TEAM= PROVISIONING_PROFILE_SPECIFIER=
   xcodebuild -project neto.xcodeproj -scheme neto -destination 'platform=iOS Simulator,name=<iPhone>' -derivedDataPath /tmp/neto-dd -parallel-testing-enabled NO -resultBundlePath /tmp/neto-unit-iphone.xcresult test -only-testing:netoTests
   xcodebuild -project neto.xcodeproj -scheme neto -destination 'platform=iOS Simulator,name=<iPad>' -derivedDataPath /tmp/neto-dd -parallel-testing-enabled NO -resultBundlePath /tmp/neto-unit-ipad.xcresult test -only-testing:netoTests
   xcrun xcresulttool get test-results summary --path <bundle> --compact
   ```
   - Never drop `-parallel-testing-enabled NO` on simulators: parallel clones fail to launch the app and add up to 10 minutes of timeouts.
   - Before each simulator run, boot the device and uninstall stale builds: `xcrun simctl boot <udid>; xcrun simctl uninstall <udid> pl.lab22.neto; xcrun simctl uninstall <udid> pl.lab22.netoUITests.xctrunner`. Otherwise launches regularly fail with `Busy ("Application failed preflight checks")`.
   - Report new compiler warnings in files touched by the current change.
3. If `$ARGUMENTS` contains `ui`: run `-only-testing:netoUITests` the same way on each platform (result bundles `/tmp/neto-ui-<platform>.xcresult`).
4. Compare the failing tests with `.claude/test-baseline.md` (workspace root). Classify each failure as **new** (regression), **known** (listed in the baseline), or **fixed** (listed in the baseline, now passing). Many tests use the real network (ICMP, live WHOIS servers), so mark failures that look environmental as such instead of treating them as code bugs.
5. Reply with a short table (platform × unit/UI → passed/total), followed by the lists of new, known and fixed failures. Do not modify the baseline file unless asked.
