<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.15.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-vint/v1.15.0** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile pipes a remote install script directly to `sh` without first downloading and verifying it. The command `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}` fetches content from a mutable `master` branch URL and executes it immediately, allowing a compromised or tampered remote script to execute arbitrary code during image builds.

Locations:

- `Dockerfile:5`

### unpinned-uses (severity: high)

All `uses:` references across every workflow file use mutable tag or branch refs instead of pinned 40-character commit SHAs, making the action vulnerable to supply-chain attacks if any referenced action is compromised or its tag is moved. Failing references include: depup.yml — `actions/checkout@v4`, `haya14busa/action-depup@v1`, `peter-evans/create-pull-request@v6`; dockerimage.yml — `actions/checkout@v4`; release.yml — `actions/checkout@v4`, `haya14busa/action-bumpr@v1`, `haya14busa/action-update-semver@v1`, `haya14busa/action-cond@v1`, `shogo82148/actions-create-release@v1` (×2), `actions/checkout@v4`, `haya14busa/action-bumpr@v1`; reviewdog.yml — `actions/checkout@v4`; update_semver.yml — `actions/checkout@v4`, `haya14busa/action-update-semver@v1`.

Locations:

- `.github/workflows/depup.yml:13`
- `.github/workflows/depup.yml:14`
- `.github/workflows/depup.yml:20`
- `.github/workflows/dockerimage.yml:11`
- `.github/workflows/release.yml:16`
- `.github/workflows/release.yml:21`
- `.github/workflows/release.yml:27`
- `.github/workflows/release.yml:32`
- `.github/workflows/release.yml:38`
- `.github/workflows/release.yml:46`
- `.github/workflows/release.yml:48`
- `.github/workflows/reviewdog.yml:7`
- `.github/workflows/update_semver.yml:12`
- `.github/workflows/update_semver.yml:13`

### missing-permissions (severity: medium)

None of the 5 workflow files define a `permissions:` key at the top level or at the job level. Without explicit permissions, workflows run with the default (often broad) token permissions, violating the principle of least privilege. Affected files: depup.yml, dockerimage.yml, release.yml, reviewdog.yml, update_semver.yml.

Locations:

- `.github/workflows/depup.yml:1`
- `.github/workflows/dockerimage.yml:1`
- `.github/workflows/release.yml:1`
- `.github/workflows/reviewdog.yml:1`
- `.github/workflows/update_semver.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell, unpinned-uses, missing-permissions

**Notes:**

Fixed all three findings:

1. **unsafe-shell (Dockerfile line 5)**: Replaced `wget ... | sh` pipe pattern with a two-step approach: download the install script to `/tmp/install-reviewdog.sh` using a pinned commit SHA (`b88588991adeb3e97f1283710aa7558e5e0811a5` = reviewdog v0.19.0) instead of the mutable `master` branch URL, then execute it separately and clean up.

2. **unpinned-uses**: Pinned all `uses:` references across all 5 workflow files to full 40-character commit SHAs with original tags preserved as comments: actions/checkout@v4→11d5960a, haya14busa/action-depup@v1→99f7aecf, peter-evans/create-pull-request@v6→c5a7806, haya14busa/action-bumpr@v1→faf6f474, haya14busa/action-update-semver@v1→7d2c5586, haya14busa/action-cond@v1→94f77f7a, shogo82148/actions-create-release@v1→6a396031.

3. **missing-permissions**: Added minimal `permissions:` blocks to all 5 workflow files: depup.yml (contents:write, pull-requests:write), dockerimage.yml (contents:read), release.yml (contents:write, pull-requests:write), reviewdog.yml (contents:read, pull-requests:write, checks:write), update_semver.yml (contents:write).

