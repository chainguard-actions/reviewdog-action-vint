<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.18.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-vint/v1.18.0** was hardened automatically. 5 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### missing-permissions (severity: medium)

Workflow file 'depup.yml' has no top-level 'permissions:' key and no job-level 'permissions:' key on any of its jobs. Without explicit permissions, the GITHUB_TOKEN is granted default (potentially broad) permissions.

Locations:

- `.github/workflows/depup.yml:1`

### missing-permissions (severity: medium)

Workflow file 'dockerimage.yml' has no top-level 'permissions:' key and no job-level 'permissions:' key on any of its jobs. Without explicit permissions, the GITHUB_TOKEN is granted default (potentially broad) permissions.

Locations:

- `.github/workflows/dockerimage.yml:1`

### missing-permissions (severity: medium)

Workflow file 'release.yml' has no top-level 'permissions:' key and no job-level 'permissions:' key on any of its jobs. Without explicit permissions, the GITHUB_TOKEN is granted default (potentially broad) permissions.

Locations:

- `.github/workflows/release.yml:1`

### missing-permissions (severity: medium)

Workflow file 'reviewdog.yml' has no top-level 'permissions:' key and no job-level 'permissions:' key on any of its jobs. Without explicit permissions, the GITHUB_TOKEN is granted default (potentially broad) permissions.

Locations:

- `.github/workflows/reviewdog.yml:1`

### missing-permissions (severity: medium)

Workflow file 'update_semver.yml' has no top-level 'permissions:' key and no job-level 'permissions:' key on any of its jobs. Without explicit permissions, the GITHUB_TOKEN is granted default (potentially broad) permissions.

Locations:

- `.github/workflows/update_semver.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** missing-permissions

**Notes:**

Added top-level 'permissions:' blocks to all five workflow files with least-privilege scopes: depup.yml (contents:write, pull-requests:write), dockerimage.yml (contents:read), release.yml (contents:write), reviewdog.yml (contents:read, pull-requests:write, checks:write), update_semver.yml (contents:write).

