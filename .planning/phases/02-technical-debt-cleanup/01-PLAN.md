---
plan: "01"
phase: 2
wave: 1
depends_on: []
requirements: [DEBT-01, DEBT-02]
files_modified:
  - .gitignore
  - build.sh
autonomous: true
---

# Plan 01 — GitIgnore Audit + Build Script Documentation

## Objective

Verify `public/` is correctly excluded from git (DEBT-01) and add clear inline documentation to `build.sh` explaining every flag and use-case (DEBT-02).

## must_haves

- DEBT-01: `public/` cannot appear in `git status` or `git ls-files` output — generated files never enter git history
- DEBT-02: A developer unfamiliar with the project must be able to read `build.sh` and understand what each flag does and when to use each build command instead of plain `hugo`

---

## Task 1.1 — Verify and Harden `.gitignore` for DEBT-01

<wave>1</wave>

<read_first>
- .gitignore (current state — verify /public/ entry exists)
- Run: git ls-files public/ (should return empty — no tracked files under public/)
- Run: git status --short (confirm public/ does not appear as untracked)
</read_first>

<action>
1. Open `.gitignore` and confirm the line `/public/` is present.
2. Run `git ls-files public/` — expected: empty output. If any files appear, they are tracked and must be removed with `git rm -r --cached public/` then committed.
3. Run `git status --short` — confirm `public/` is not listed as an untracked directory.
4. No file content change to `.gitignore` is needed IF `/public/` is already present (it's on line 2).
5. IF `/public/` is missing: add it to the `## Hugo` section, immediately after `/resources/_gen/`.

The current `.gitignore` has:
```
## Hugo
/public/
/resources/_gen/
/resources/_gen_old/
/.hugo_build.lock
```
This is already correct — the task is to VERIFY it and confirm no tracked files slip through.
</action>

<acceptance_criteria>
- `git ls-files public/` returns empty output (no files)
- `.gitignore` contains the line `/public/`
- `git status --short` does not list any path starting with `public/`
</acceptance_criteria>

---

## Task 1.2 — Document `build.sh` for DEBT-02

<wave>1</wave>

<read_first>
- build.sh (current state — existing comments and flag usage)
</read_first>

<action>
Replace the existing `build.sh` content with a fully documented version. Keep all existing logic exactly as-is — only add explanatory comments.

The new `build.sh` should look like:

```sh
#!/bin/sh
# build.sh — Cloudflare Pages build script
#
# This script is executed by Cloudflare Pages on every deployment.
# It is NOT used for local development — use `hugo server` locally instead.
#
# Hugo flag reference:
#   --gc          Run cleanup tasks (remove unused cache files) after build
#   --minify      Minify HTML, CSS, JS, JSON, SVG, XML output for production
#   -b <url>      Set the base URL — overrides baseURL in hugo.yaml
#
# Cloudflare Pages environment variables used:
#   CF_PAGES_BRANCH   The git branch being built (e.g. "main", "staging", "fix-header")
#   CF_PAGES_URL      The deployment preview URL for non-main branches
#
# When to use this script vs plain hugo:
#   - This script: Cloudflare Pages CI builds only
#   - `hugo server`: local development (live reload, draft posts visible with -D flag)
#   - `hugo --gc --minify`: one-off local production build to inspect minified output

# Exit immediately if a command exits with a non-zero status.
set -e

# Informative log of which branch is being built
echo "Building for branch: $CF_PAGES_BRANCH"

if [ "$CF_PAGES_BRANCH" = "main" ]; then
  # Production build — canonical URL is markepps.com
  echo "Building for production (main branch)..."
  hugo --gc --minify -b https://markepps.com

elif [ "$CF_PAGES_BRANCH" = "staging" ]; then
  # Staging build — deployed to the staging subdomain for pre-merge review
  echo "Building for staging..."
  hugo --gc --minify -b https://staging.markepps-com.pages.dev

else
  # Preview build — Cloudflare auto-assigns a unique URL per branch/PR
  echo "Building for preview..."
  hugo --gc --minify -b $CF_PAGES_URL
fi
```

Key changes vs original:
- Added header block explaining purpose, flags, env vars, and when to use vs plain `hugo`
- Changed `==` to `=` in if/elif conditions (POSIX `sh` compatibility — `==` works in bash but not guaranteed in `/bin/sh`)
- All existing Hugo commands unchanged (same flags, same branch logic)
</action>

<acceptance_criteria>
- `build.sh` contains `--gc` flag explanation in a comment
- `build.sh` contains `--minify` flag explanation in a comment
- `build.sh` contains `-b` flag explanation in a comment
- `build.sh` contains `CF_PAGES_BRANCH` explanation
- `build.sh` contains `CF_PAGES_URL` explanation
- `build.sh` contains "when to use" guidance
- `build.sh` is executable: `test -x build.sh` exits 0
- `sh -n build.sh` exits 0 (syntax check passes)
- Hugo commands unchanged: `grep "hugo --gc --minify" build.sh` returns 3 matches
</acceptance_criteria>
