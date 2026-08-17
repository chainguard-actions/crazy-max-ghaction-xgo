<!-- markdownlint-disable -->

# Hardening Report: crazy-max--ghaction-xgo/v2.5.0

> This file was generated automatically by the hardening agent.

**Policy SHA:** `d636be7e43ef829af6e853da6b3c7566db9f72fe`

**Test Policy SHA:** `843adf9e4b8f85d0c08b27b9d0b09dd094b54702`

**Harden Agent Version:** `2`

Action **crazy-max--ghaction-xgo/v2.5.0** was hardened automatically. 2 finding(s) were identified and resolved across 1 iteration(s).

## Findings Fixed

### unpinned-uses (severity: high)

Multiple workflow files reference GitHub Actions using mutable version tags (e.g. @v3, @v4) instead of full 40-character commit SHAs. This exposes the workflow to supply-chain attacks if the tag is moved to a malicious commit. Unpinned references found:
- ci.yml: actions/checkout@v4
- labels.yml: actions/checkout@v4, crazy-max/ghaction-github-labeler@v4
- test.yml: actions/checkout@v4, docker/bake-action@v3 (×2), codecov/codecov-action@v3
- xgo-releases-json.yml: actions/checkout@v4, actions/download-artifact@v3

Locations:

- `.github/workflows/ci.yml:30`
- `.github/workflows/labels.yml:22`
- `.github/workflows/labels.yml:25`
- `.github/workflows/test.yml:18`
- `.github/workflows/test.yml:21`
- `.github/workflows/test.yml:25`
- `.github/workflows/test.yml:29`
- `.github/workflows/xgo-releases-json.yml:27`
- `.github/workflows/xgo-releases-json.yml:30`

### missing-permissions (severity: medium)

None of the four workflow files define a top-level `permissions:` block, and no job in any of these files defines job-level permissions either. Without explicit permissions, GitHub Actions defaults to the repository's default token permissions (which may be `write-all` for older repositories), granting unnecessarily broad access to the GITHUB_TOKEN. Each workflow should declare the minimal permissions required (e.g. `contents: read`).

Locations:

- `.github/workflows/ci.yml:1`
- `.github/workflows/labels.yml:1`
- `.github/workflows/test.yml:1`
- `.github/workflows/xgo-releases-json.yml:1`

## Iteration Notes

### Iteration 1

**Fixes applied:** unpinned-uses, missing-permissions

**Notes:**

Fixed all 4 workflow files:

1. ci.yml: Added `permissions: contents: read` at top level; pinned actions/checkout@v4 → @11d5960a326750d5838078e36cf38b85af677262.

2. labels.yml: Added `permissions: contents: read` at top level; added job-level permissions (contents: read, issues: write, pull-requests: write) for the labeler job; pinned actions/checkout@v4 → @11d5960a326750d5838078e36cf38b85af677262 and crazy-max/ghaction-github-labeler@v4 → @f4f6b96e7e747b5416cd470f3cfecf26abaa811e.

3. test.yml: Added `permissions: contents: read` at top level; pinned actions/checkout@v4 → @11d5960a326750d5838078e36cf38b85af677262, docker/bake-action@v3 → @45c4bed4f4f232fb1466194a6cbdd7a18bcf0639 (×2), and codecov/codecov-action@v3 → @ab904c41d6ece82784817410c45d8b8c02684457.

4. xgo-releases-json.yml: Added `permissions: contents: read` at top level; added job-level permissions (contents: write, pull-requests: write) for the open-pr job that needs to commit and create PRs; pinned actions/checkout@v4 → @11d5960a326750d5838078e36cf38b85af677262 and actions/download-artifact@v3 → @9bc31d5ccc31df68ecc42ccf4149144866c47d8a.

