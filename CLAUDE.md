# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository layout

This root repo (neto-suite) is only an orchestration hub. Real work happens in three **git submodules**, each an independent GitHub repo with its own `CLAUDE.md`:

- `neto/` (`lab22poland/neto`) – the multiplatform SwiftUI app. Practically all code lives here; see `neto/CLAUDE.md`.
- `netolib/` (`lab22poland/netolib`) – planned core library, currently only a README.
- `netoman/` (`lab22poland/netoman`) – planned documentation repo, currently only a README.

Watch the "double neto" layout: the Xcode project is `neto/neto.xcodeproj`, app sources are in `neto/neto/`, tests are in `neto/netoTests/` and `neto/netoUITests/`.

Project-level Claude Code config (permissions, the `/verify` skill) lives in this root's `.claude/`, so launch Claude Code from the workspace root.

## Git workflow (submodules)

- Run git commands for app changes inside `neto/` (its own history, branches and remote). Run them in the root only to update submodule pointers.
- Order: commit (and push) in the submodule first, then in the root `git add neto` and commit (existing root commits look like `Update neto submodule: <summary>`).
- PRs in `neto` are squash-merged, so the branch commit the root points to never reaches neto `main`. After each such merge, point the root at the squash commit on neto `main` (same content, verify with `git diff <branch-commit> <squash-commit>`) and commit that to root `main`. Only then delete the feature branches; otherwise fresh clones fail `git submodule update`.
- Every repo uses `main` as its default branch, never `master`. `./validate-branches.sh` checks this, and it reports a failure whenever a feature branch is checked out. `.gitconfig-neto` holds the shared git settings.
- Do not run `setup-submodules.sh`: it was a one-time bootstrap script and it runs `rm -rf` on the submodule directories.

## Shared conventions

- Copyright: `© 2025 Lab22 Poland Sp. z o.o.` (author Sergii Solianyk, sergii.solianyk@lab22.pl) in source and documentation files. The app is BSD 3-Clause licensed (`neto/LICENSE`).
- Documentation and code comments are in English.
