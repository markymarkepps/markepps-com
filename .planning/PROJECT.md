# markepps.com

## What This Is

A personal Hugo static site for Mark Epps, deployed at markepps.com. It hosts a blog, and stub sections for Projects, Hobbies, Experience, and Contact. The homepage features a custom "Hello my name is" sticker with a TypeIt animated subtitle and social profile links.

## Core Value

A fast, polished personal site that's technically correct and doesn't embarrass its author.

## Requirements

### Validated

- ✓ Site deployed and accessible at markepps.com — existing
- ✓ Hugo + LoveIt theme rendering correctly — existing
- ✓ Dark mode default with light/dark toggle — existing
- ✓ Custom "Hello my name is" sticker on homepage — existing
- ✓ TypeIt animated subtitle — existing
- ✓ Social links (GitHub, Instagram, Strava, LinkedIn) — existing
- ✓ Navigation menu with 4 section links and Font Awesome icons — existing
- ✓ Custom SCSS hover effects with accent colors — existing
- ✓ Header shows home icon only (no text) — existing (fix-header merged)
- ✓ Posts render with summary, categories, and relative date — existing
- ✓ Relative "time ago" on post summaries is dynamic (client-side) — v1.0
- ✓ `public/` is excluded from git tracking — v1.0 (already correct)
- ✓ `build.sh` is documented and its purpose is understood — v1.0
- ✓ LoveIt git submodule is pinned to `branch = v0.3.0` with SHA documented — v1.0
- ✓ Google Fonts `Permanent Marker` is self-hosted — v1.0

### Active

(None — planning next milestone)

### Out of Scope

- Content for Projects, Hobbies, Experience, Contact sections — not this milestone
- Analytics — not planned
- Search / comments — not planned
- Major theme changes or migrations — not this milestone

## Context

- Stack: Hugo SSG + LoveIt theme (git submodule, v0.3.0 branch, SHA `f59fb4ec`), SCSS via Hugo Pipes, deployed via Cloudflare Pages
- ~432 LOC across layouts, SCSS, and build scripts (excluding theme)
- Codebase map exists at `.planning/codebase/`
- No automated tests — all validation is manual + visual
- v1.0 shipped: 2 phases, 4 plans, 9 commits (2026-03-27 to 2026-03-28)

## Constraints

- **Theme**: Do not edit files inside `themes/LoveIt/` — override via `layouts/` and `assets/css/` only
- **Static site**: No server-side logic — dynamic behaviour requires client-side JS or scheduled rebuilds
- **Hugo Pipes**: SCSS compiled by Hugo, no separate build tool for styles

## Key Decisions

| Decision                              | Rationale                                                          | Outcome                                                                              |
| ------------------------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| Fix time-ago client-side (JS)         | SSG can't compute dynamic time; JS on page load is the right layer | ✓ Good — `data-publish-date` + `gsdRelativeDate()` inline in summary.html            |
| Self-host Permanent Marker font       | Remove Google Fonts runtime dependency and privacy leak            | ✓ Good — woff2 in `static/fonts/`, `@font-face` in `_custom.scss`                    |
| Pin LoveIt submodule to commit SHA    | Prevent accidental theme drift from branch tip changes             | ✓ Good — `branch = v0.3.0` in `.gitmodules`, SHA policy in `copilot-instructions.md` |
| Inline `<script>` vs external JS file | LoveIt has no clean hook for custom JS without editing theme       | ✓ Good — self-contained in one template override                                     |

## Evolution

This document evolves at phase transitions and milestone boundaries.

**After each phase transition** (via `/gsd-transition`):

1. Requirements invalidated? → Move to Out of Scope with reason
2. Requirements validated? → Move to Validated with phase reference
3. New requirements emerged? → Add to Active
4. Decisions to log? → Add to Key Decisions
5. "What This Is" still accurate? → Update if drifted

**After each milestone** (via `/gsd-complete-milestone`):

1. Full review of all sections
2. Core Value check — still the right priority?
3. Audit Out of Scope — reasons still valid?
4. Update Context with current state

---

_Last updated: 2026-03-28 after v1.0 milestone_
