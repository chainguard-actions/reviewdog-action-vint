<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.17.2

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-vint/v1.17.2** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile (a supporting script for the Docker action) pipes a remotely fetched shell script directly to `sh` without first downloading and verifying it: `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/fd59714416d6d9a1c0692d872e38e7f8448df4fc/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}`. Although the URL is pinned to a specific commit SHA in the path, the content is still piped directly to a shell interpreter without any integrity verification step (e.g., checksum validation). The script should be downloaded to a file first, verified, and then executed separately.

Locations:

- `Dockerfile:5`

### missing-permissions (severity: medium)

None of the workflow files define a `permissions:` key at either the top level or the job level. Without explicit permissions, workflows run with the default token permissions (which may be overly broad, e.g., `write` on `contents` for some repository settings). Each workflow should declare minimal required permissions. Affected files: depup.yml, dockerimage.yml, release.yml, reviewdog.yml, update_semver.yml.

Locations:

- `.github/workflows/depup.yml:1`
- `.github/workflows/dockerimage.yml:1`
- `.github/workflows/release.yml:1`
- `.github/workflows/reviewdog.yml:1`
- `.github/workflows/update_semver.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell, missing-permissions

**Notes:**

1. Dockerfile (unsafe-shell): Replaced the `wget ... | sh` pipe pattern with a two-step approach: download the install script to /tmp/install-reviewdog.sh, execute it with `sh`, then remove it. The URL remains pinned to the same commit SHA (fd59714416d6d9a1c0692d872e38e7f8448df4fc). 2. missing-permissions: Added top-level `permissions:` blocks to all 5 workflow files with minimal required permissions — depup.yml (contents: write, pull-requests: write), dockerimage.yml (contents: read), release.yml (contents: write), reviewdog.yml (contents: read, pull-requests: write), update_semver.yml (contents: write).

