<!-- markdownlint-disable -->

# Hardening Report: reviewdog--action-vint/v1.16.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **reviewdog--action-vint/v1.16.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

All workflow files use mutable tag-based refs (e.g. @v1, @v4, @v6) instead of immutable 40-character SHA commit hashes. This exposes the action to supply-chain attacks if any referenced action's tag is moved to a malicious commit.

Affected references:
- depup.yml: actions/checkout@v4, haya14busa/action-depup@v1, peter-evans/create-pull-request@v6
- dockerimage.yml: actions/checkout@v4
- release.yml: actions/checkout@v4, haya14busa/action-bumpr@v1, haya14busa/action-update-semver@v1, haya14busa/action-cond@v1, shogo82148/actions-create-release@v1, actions/checkout@v4, haya14busa/action-bumpr@v1
- reviewdog.yml: actions/checkout@v4
- update_semver.yml: actions/checkout@v4, haya14busa/action-update-semver@v1

Locations:

- `.github/workflows/depup.yml:13`
- `.github/workflows/depup.yml:14`
- `.github/workflows/depup.yml:20`
- `.github/workflows/dockerimage.yml:10`
- `.github/workflows/release.yml:15`
- `.github/workflows/release.yml:21`
- `.github/workflows/release.yml:27`
- `.github/workflows/release.yml:33`
- `.github/workflows/release.yml:40`
- `.github/workflows/release.yml:47`
- `.github/workflows/release.yml:48`
- `.github/workflows/reviewdog.yml:8`
- `.github/workflows/update_semver.yml:12`
- `.github/workflows/update_semver.yml:13`

### missing-permissions (severity: medium)

None of the workflow files define a top-level `permissions:` block, and no individual job within any workflow defines job-level permissions. Without explicit permissions, workflows run with the default (often write-all) token permissions, violating the principle of least privilege.

Locations:

- `.github/workflows/depup.yml:1`
- `.github/workflows/dockerimage.yml:1`
- `.github/workflows/release.yml:1`
- `.github/workflows/reviewdog.yml:1`
- `.github/workflows/update_semver.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 5 workflow files:

1. **unpinned-uses**: Replaced all 14 mutable tag-based action references with immutable 40-char SHA hashes (original tags preserved as comments):
   - actions/checkout@v4 → @34e114876b0b11c390a56381ad16ebd13914f8d5
   - haya14busa/action-depup@v1 → @99f7aecf3e4d06d5a3faf190dae5dc79ac530b5a
   - peter-evans/create-pull-request@v6 → @c5a7806660adbe173f04e3e038b0ccdcd758773c
   - haya14busa/action-bumpr@v1 → @faf6f474bcb6174125cfc569f0b2e24cbf03d496
   - haya14busa/action-update-semver@v1 → @7d2c558640ea49e798d46539536190aff8c18715
   - haya14busa/action-cond@v1 → @94f77f7a80cd666cb3155084e428254fea4281fd
   - shogo82148/actions-create-release@v1 → @6a396031bc74c57403da1018fec74d24c6aa03cd

2. **missing-permissions**: Added minimal top-level permissions blocks to all 5 workflows:
   - depup.yml: contents:write + pull-requests:write (creates PRs)
   - dockerimage.yml: contents:read (only builds Docker image)
   - release.yml: contents:write at top level; release-check job overrides with contents:read + pull-requests:write
   - reviewdog.yml: contents:read + pull-requests:write (posts PR review comments)
   - update_semver.yml: contents:write (creates/updates semver tags)

