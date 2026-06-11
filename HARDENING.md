<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.17.1

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **reviewdog--action-vint/v1.17.1** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile (a supporting script referenced by action.yml via `image: 'Dockerfile'`) pipes a remotely fetched install script directly to `sh` without first downloading and verifying it. Line 5: `RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}`. This allows a compromised or man-in-the-middle response to execute arbitrary code during the Docker image build.

Locations:

- `Dockerfile:5`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed the Dockerfile's unsafe pipe-to-shell pattern on line 5. Replaced `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}` with a safe alternative that: (1) downloads the pre-built reviewdog binary tarball directly from GitHub releases, (2) downloads the official checksums file, (3) verifies the SHA-256 checksum before use, (4) extracts only the reviewdog binary, and (5) cleans up temporary files. This eliminates the remote script execution entirely and adds integrity verification.

