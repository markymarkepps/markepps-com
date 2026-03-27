---
gsd_state_version: 1.0
milestone: v0.3.0
milestone_name: milestone
status: unknown
last_updated: "2026-03-27T13:20:08.270Z"
progress:
  total_phases: 2
  completed_phases: 2
  total_plans: 4
  completed_plans: 4
---

# STATE — Project Memory

**Project:** markepps.com
**Milestone:** 1 — Bug fixes & technical debt
**Initialized:** 2026-03-27
**Last updated:** 2026-03-28

## Current Status

**Active phase:** None — v1.0 shipped ✅
**Next action:** `/gsd-new-milestone` to plan v1.1

## Project Reference

See: .planning/PROJECT.md (updated 2026-03-28)

**Core value:** A fast, polished personal site that's technically correct and doesn't embarrass its author.
**Current focus:** Planning next milestone (v1.1)

## Phase Progress

| Phase | Name                   | Status                |
| ----- | ---------------------- | --------------------- |
| 1     | Dynamic Relative Dates | ✅ Complete (416f6c4) |
| 2     | Technical Debt Cleanup | ✅ Complete (02904dd) |

## Key Context

- Site is live at markepps.com on Cloudflare
- Hugo SSG + LoveIt theme (submodule at `themes/LoveIt/`)
- Template overrides in `layouts/` — never edit `themes/LoveIt/` directly
- SCSS in `assets/css/` — dark mode via `[theme="dark"]` attribute selectors
- `fix-header` branch was merged — header is now correct on `main`
- Running `hugo server` serves at localhost:1313

## Decisions Log

| Date       | Decision                           | Outcome           |
| ---------- | ---------------------------------- | ----------------- |
| 2026-03-27 | Fix time-ago client-side (JS)      | ✅ Done — Phase 1 |
| 2026-03-28 | Self-host Permanent Marker font    | ✅ Done — Phase 2 |
| 2026-03-28 | Pin LoveIt submodule to commit SHA | ✅ Done — Phase 2 |

## Completed Phases

| Phase | Name                   | Commit  | Notes                                                                  |
| ----- | ---------------------- | ------- | ---------------------------------------------------------------------- |
| 1     | Dynamic Relative Dates | 416f6c4 | BUG-01: `data-publish-date` + client-side JS                           |
| 2     | Technical Debt Cleanup | 02904dd | DEBT-01–04: gitignore ✅, build.sh docs, submodule pin, font self-host |
