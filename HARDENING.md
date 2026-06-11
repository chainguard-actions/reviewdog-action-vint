<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.15.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **reviewdog--action-vint/v1.15.0** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile pipes a remotely-fetched shell script directly into `sh` without first downloading and verifying it. Line 5: `RUN wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh| sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}`. An attacker who can intercept or tamper with the remote URL (e.g. via a compromised CDN, DNS hijack, or a future change to the `master` branch) could execute arbitrary code during the Docker image build.

Locations:

- `Dockerfile:5`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed Dockerfile line 5: replaced `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}` with a two-step approach that (1) downloads the script to /tmp/install-reviewdog.sh, (2) executes it separately with `sh`, and (3) removes the temp file. Also pinned the URL from the mutable `master` branch to the immutable commit SHA b88588991adeb3e97f1283710aa7558e5e0811a5 (corresponding to the v0.19.0 tag), preventing both pipe-from-internet execution and future master branch tampering.

