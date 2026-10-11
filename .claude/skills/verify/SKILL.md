---
name: verify
description: Build the NETo app for macOS, iPhone and iPad simulators and run its tests, then compare failures against the baseline. Use after changing code in neto/ or when asked to verify, build or test the app.
argument-hint: "[ui]  (add UI tests on macOS, ~4 min)"
---

Verify the NETo app in `neto/` (relative to the workspace root). Run every command from `neto/`, use `-derivedDataPath /tmp/neto-dd` everywhere, and keep the full logs in `/tmp/neto-verify-*.log` so that only the summary ends up in context.

1. Pick simulators: run `xcrun simctl list devices available`. Prefer `iPhone 17` and `iPad Pro 11-inch (M5)`; otherwise take the newest iPhone and the newest iPad Pro 11-inch available.
2. Build all platforms (stop and report on the first compile error):
   ```bash
   xcodebuild -project neto.xcodeproj -scheme neto -destination 'platform=macOS,arch=arm64' -derivedDataPath /tmp/neto-dd build CODE_SIGN_IDENTITY=- CODE_SIGN_STYLE=Manual DEVELOPMENT_TEAM= PROVISIONING_PROFILE_SPECIFIER= MACOSX_DEPLOYMENT_TARGET=14.0
   xcodebuild -project neto.xcodeproj -scheme neto -destination 'platform=iOS Simulator,name=<iPhone>' -derivedDataPath /tmp/neto-dd build
   xcodebuild -project neto.xcodeproj -scheme neto -destination 'platform=iOS Simulator,name=<iPad>' -derivedDataPath /tmp/neto-dd build
   ```
   Report new compiler warnings in files touched by the current change.
3. Unit tests on macOS, with a result bundle:
   ```bash
   rm -rf /tmp/neto-unit.xcresult
   xcodebuild -project neto.xcodeproj -scheme neto -destination 'platform=macOS,arch=arm64' -derivedDataPath /tmp/neto-dd -resultBundlePath /tmp/neto-unit.xcresult test -only-testing:netoTests CODE_SIGN_IDENTITY=- CODE_SIGN_STYLE=Manual DEVELOPMENT_TEAM= PROVISIONING_PROFILE_SPECIFIER= MACOSX_DEPLOYMENT_TARGET=14.0
   xcrun xcresulttool get test-results summary --path /tmp/neto-unit.xcresult --compact
   ```
   Do not run tests on the simulators: the host app currently fails to launch there (see `.claude/test-baseline.md`). Once that is fixed, add `test -only-testing:netoTests` for both simulators and update this step.
4. If `$ARGUMENTS` contains `ui`: run `-only-testing:netoUITests` on macOS the same way (result bundle `/tmp/neto-ui.xcresult`).
5. Compare the failing tests with the baseline in `.claude/test-baseline.md` (workspace root). Classify each failure as **new** (regression), **known** (in the baseline), or **fixed** (in the baseline, now passing). Many tests use the real network (ICMP, live WHOIS servers), so mark failures that look environmental as such instead of treating them as code bugs.
6. Reply with a short table: platform/step → result, followed by the lists of new, known and fixed failures. Do not modify the baseline file unless asked.
