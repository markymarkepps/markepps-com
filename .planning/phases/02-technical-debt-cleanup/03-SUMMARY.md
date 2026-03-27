---
plan: "03"
phase: 2
status: complete
commit: 02904dd
requirements: [DEBT-04]
files_modified:
  - assets/css/_custom.scss
  - static/fonts/PermanentMarker-Regular.woff2
---

# Plan 03 Summary — Self-Host Permanent Marker Font (DEBT-04)

## What Was Built

Removed the runtime Google Fonts CDN dependency for `Permanent Marker` and replaced it with a locally served font from `static/fonts/`.

**Font download:** `PermanentMarker-Regular.woff2` fetched from `fonts.gstatic.com` (v16, 29KB) and placed in `static/fonts/`. Hugo serves `static/` at site root so the font is available at `/fonts/PermanentMarker-Regular.woff2`.

**`_custom.scss` changes:**
- Removed: `@import url("https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap");`
- Added: `@font-face` block with local woff2 path, `font-display: swap`, and unicode-range
- Usage unchanged: `.tag-bottom { font-family: "Permanent Marker", cursive; }` still works identically

## Deviations from Plan

None — plan executed exactly as written.

## Self-Check: PASSED

| Criterion | Result |
|-----------|--------|
| `static/fonts/PermanentMarker-Regular.woff2` exists | ✅ |
| File size 20–100KB | ✅ 29,564 bytes |
| `grep "googleapis.com" assets/css/_custom.scss` returns no matches | ✅ |
| `grep "@font-face" assets/css/_custom.scss` | ✅ |
| `grep "PermanentMarker-Regular.woff2" assets/css/_custom.scss` | ✅ |
| `grep "font-display: swap" assets/css/_custom.scss` | ✅ |
| `grep '"Permanent Marker", cursive' assets/css/_custom.scss` | ✅ usage unchanged |
| `hugo --quiet` exits 0 | ✅ clean build |
| `grep "googleapis.com" public/css/style.min.css` returns no matches | ✅ |
| `grep "PermanentMarker" public/css/style.min.css` | ✅ |
