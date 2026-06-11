<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.17.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `1`

Action **reviewdog--action-vint/v1.17.0** was hardened automatically. 1 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unsafe-shell (severity: high)

The Dockerfile pipes a remotely fetched install script directly to `sh` without first downloading and verifying it. The command `wget -O - -q https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b /usr/local/bin/ ${REVIEWDOG_VERSION}` fetches content from a mutable URL (the `master` branch) and executes it immediately. If the remote URL is compromised or the content is tampered with in transit, arbitrary code will execute during the Docker image build. The script should be downloaded to a file first, its integrity verified (e.g., via a checksum), and only then executed.

Locations:

- `Dockerfile:5`

## Iteration Notes

### Iteration 1

**Fixes applied:** unsafe-shell

**Notes:**

Fixed the Dockerfile's unsafe pipe-to-shell pattern. Replaced `wget ... | sh` with a three-step approach: (1) download the reviewdog binary tarball from the versioned GitHub release URL (not the mutable `master` branch), (2) download the official checksums file from the same release and verify the tarball's integrity with `sha256sum -c`, (3) extract the binary and clean up temporary files. This eliminates both the mutable URL reference and the direct pipe-to-shell execution pattern.

