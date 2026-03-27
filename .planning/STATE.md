# STATE — Project Memory

**Project:** markepps.com
**Milestone:** 1 — Bug fixes & technical debt
**Initialized:** 2026-03-27
**Last updated:** 2026-03-30

## Current Status

**Active phase:** None — Phase 1 complete
**Next action:** `/gsd-plan-phase 2`

## Phase Progress

| Phase | Name | Status |
|-------|------|--------|
| 1 | Dynamic Relative Dates | ✅ Complete (416f6c4) |
| 2 | Technical Debt Cleanup | Not started |

## Key Context

- Site is live at markepps.com on Cloudflare
- Hugo SSG + LoveIt theme (submodule at `themes/LoveIt/`)
- Template overrides in `layouts/` — never edit `themes/LoveIt/` directly
- SCSS in `assets/css/` — dark mode via `[theme="dark"]` attribute selectors
- `fix-header` branch was merged — header is now correct on `main`
- Running `hugo server` serves at localhost:1313

## Decisions Log

| Date | Decision | Outcome |
|------|----------|---------|
| 2026-03-27 | Fix time-ago client-side (JS) | ✅ Done — Phase 1 |
| 2026-03-27 | Self-host Permanent Marker font | Pending — Phase 2 |
| 2026-03-27 | Pin LoveIt submodule to commit SHA | Pending — Phase 2 |

## Completed Phases

| Phase | Name | Commit | Notes |
|-------|------|--------|-------|
| 1 | Dynamic Relative Dates | 416f6c4 | BUG-01: `data-publish-date` + client-side JS |
