<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.16.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **reviewdog--action-vint/v1.16.0** was hardened automatically. 0 finding(s) were identified and resolved across 1 iteration(s).

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed the unsafe pipe-to-shell pattern in the Dockerfile. Changed from `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}` to a two-step approach: (1) download the script to `/tmp/install-reviewdog.sh` first, (2) execute it separately with `sh`. Also pinned the URL from the mutable `master` branch to the specific version tag `${REVIEWDOG_VERSION}` (v0.20.1), so the URL is now `https://raw.githubusercontent.com/reviewdog/reviewdog/v0.20.1/install.sh`. The temporary file is cleaned up after execution.

