#!/bin/sh
# Exit immediately if a command exits with a non-zero status.
set -e

# Informative log of which branch is being built
echo "Building for branch: $CF_PAGES_BRANCH"

if [ "$CF_PAGES_BRANCH" == "main" ]; then
  # Production build
  echo "Building for production (main branch)..."
  hugo --gc --minify -b https://markepps.com

elif [ "$CF_PAGES_BRANCH" == "staging" ]; then
  # Staging build
  echo "Building for staging..."
  hugo --gc --minify -b https://staging.markepps-com.pages.dev

else
  # Preview build (for all other branches)
  echo "Building for preview..."
  hugo --gc --minify -b $CF_PAGES_URL
fi