<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.17.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-vint/v1.17.0** was hardened automatically. 3 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile (used as the Docker action image in action.yml) pipes a remote install script directly to `sh` without first downloading and verifying it: `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- ...`. This allows a compromised or man-in-the-middle remote server to execute arbitrary code during the Docker image build.

Locations:

- `Dockerfile:5`

### unpinned-uses (severity: high)

All `uses:` references across every workflow file use mutable tag refs (e.g., @v4, @v1, @v6) instead of immutable 40-character SHA commit hashes. This exposes the action to supply-chain attacks if any referenced action's tag is moved or compromised. Affected refs include: actions/checkout@v4, haya14busa/action-depup@v1, peter-evans/create-pull-request@v6, haya14busa/action-bumpr@v1, haya14busa/action-update-semver@v1, haya14busa/action-cond@v1, shogo82148/actions-create-release@v1.

Locations:

- `.github/workflows/depup.yml:13`
- `.github/workflows/depup.yml:14`
- `.github/workflows/depup.yml:21`
- `.github/workflows/dockerimage.yml:10`
- `.github/workflows/release.yml:14`
- `.github/workflows/release.yml:19`
- `.github/workflows/release.yml:24`
- `.github/workflows/release.yml:29`
- `.github/workflows/release.yml:36`
- `.github/workflows/release.yml:42`
- `.github/workflows/release.yml:43`
- `.github/workflows/reviewdog.yml:8`
- `.github/workflows/update_semver.yml:11`
- `.github/workflows/update_semver.yml:12`

### missing-permissions (severity: medium)

None of the workflow files define a top-level `permissions:` block, and no job within any workflow defines job-level `permissions:`. Without explicit permission scoping, workflows run with the default (often broad) GITHUB_TOKEN permissions, violating the principle of least privilege. Affected files: depup.yml, dockerimage.yml, release.yml, reviewdog.yml, update_semver.yml.

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

Fixed all three findings: (1) Dockerfile: replaced `wget ... | sh` pipe with download-then-execute pattern to prevent MITM code execution; (2) All workflow files: pinned every `uses:` reference from mutable tags to full 40-char commit SHAs using lookup_action_sha; (3) All five workflow files: added top-level `permissions:` blocks with minimal required permissions (contents:read for checkout-only workflows, contents:write for release/semver workflows, pull-requests:write where PRs are created, checks:write for reviewdog check reporter).

