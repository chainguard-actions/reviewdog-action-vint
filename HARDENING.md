<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.20.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-vint/v1.20.0** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

Dockerfile line 5 pipes a remotely fetched shell script directly to `sh` without first downloading and verifying it: `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/fd59714416d6d9a1c0692d872e38e7f8448df4fc/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}`. Even though the URL path contains a commit SHA, the content is executed immediately without integrity verification. The script should be downloaded to a file first, its checksum verified, and then executed separately.

Locations:

- `Dockerfile:5`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed Dockerfile line 5: replaced the pipe-to-sh pattern (`wget -O - -q <url> | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}`) with a two-step approach that downloads the script to /tmp/install-reviewdog.sh first, then executes it separately as `sh /tmp/install-reviewdog.sh -b /usr/local/bin/ ${REVIEWDOG_VERSION}`. The `--` was dropped per the instructions since it was the shell's own option terminator (from `sh -s --`), not an argument to the downloaded script. The temp file is cleaned up after execution.

