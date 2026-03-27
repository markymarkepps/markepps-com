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