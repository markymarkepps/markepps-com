# ROADMAP — markepps.com Milestone 1

**Milestone goal:** Fix active bugs and technical debt with no new features.
**Phases:** 2 | **Requirements:** 5 | **Granularity:** Coarse

---

## Phase 1: Dynamic Relative Dates

**Goal:** Replace build-time static "X days ago" with client-side dynamic calculation so post ages are always accurate without rebuilding the site.

**Requirements:** BUG-01

**Why first:** It's the only user-visible bug — visitors see wrong ages on every post card.

**Success criteria:**
1. Post summary cards show correct relative time on every page load without a site rebuild
2. The `summary.html` template embeds the publish date as a `data-*` attribute for JS to read
3. Client-side script is small, inline or minimal, and doesn't cause layout shift
4. Works correctly in both light and dark mode (display only, not theme-dependent)
5. Falls back gracefully if JS is disabled (shows publish date)

**Requirements mapped:** BUG-01

---

## Phase 2: Technical Debt Cleanup

**Goal:** Address the actionable technical concerns identified in the codebase map — gitignore hygiene, build documentation, submodule pinning, and font self-hosting.

**Requirements:** DEBT-01, DEBT-02, DEBT-03, DEBT-04

**Why second:** Lower risk, no user-visible impact, but reduces ongoing maintenance friction.

**Success criteria:**
1. `public/` directory is confirmed gitignored (or added) — no generated files in git history going forward
2. `build.sh` has inline comments or a header block explaining what each step does and when to use it vs plain `hugo`
3. LoveIt submodule in `.gitmodules` references a specific commit SHA, not just the `v0.3.0` branch
4. `Permanent Marker` font files are present in `static/fonts/` and served locally — no `@import` from `fonts.googleapis.com`
5. Site builds and renders correctly after all changes (`hugo server` shows no errors)

**Requirements mapped:** DEBT-01, DEBT-02, DEBT-03, DEBT-04

---

## Backlog (v2)

- Add real content pages to Projects, Hobbies, Experience, Contact sections
- Cloudflare Web Analytics integration
- Automated rebuild schedule for SSG freshness

---

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| BUG-01 | Phase 1 | Pending |
| DEBT-01 | Phase 2 | Pending |
| DEBT-02 | Phase 2 | Pending |
| DEBT-03 | Phase 2 | Pending |
| DEBT-04 | Phase 2 | Pending |

**Coverage:** 5/5 v1 requirements mapped ✓

---
*Created: 2026-03-27*
