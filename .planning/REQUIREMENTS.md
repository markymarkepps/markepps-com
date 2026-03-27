# Requirements: markepps.com — Milestone 1

**Defined:** 2026-03-27
**Core Value:** A fast, polished personal site that's technically correct and doesn't embarrass its author.

## v1 Requirements

### Bug Fixes

- [x] **BUG-01**: Relative "time ago" on post summaries updates dynamically (not frozen at build time)
  - Currently: `now.Unix` in `summary.html` is evaluated at build time — dates are stale until next deploy
  - Fix: Client-side JS reads a `data-publish-date` attribute and computes relative time on page load

### Technical Debt

- [x] **DEBT-01**: `public/` directory is excluded from git (verify or add to `.gitignore`)
- [x] **DEBT-02**: `build.sh` is documented — its steps and purpose are understood
- [x] **DEBT-03**: LoveIt git submodule is pinned to a specific commit SHA instead of just the `v0.3.0` branch tip
- [x] **DEBT-04**: `Permanent Marker` Google Font is self-hosted — removed Google Fonts `@import` runtime dependency

## v2 Requirements

### Content

- Add real content pages to Projects, Hobbies, Experience, Contact sections

### Enhancements

- Analytics (Cloudflare Web Analytics or similar, privacy-friendly)
- Automated rebuild schedule (so SSG-rendered content stays fresh)

## Out of Scope

| Feature | Reason |
|---------|--------|
| Section content pages | Not this milestone — bugs only |
| Search / comments | Not planned |
| Theme migration | Too disruptive for a bug-fix milestone |
| New design features | Scope locked to fixes |

## Traceability

| Requirement | Phase | Status |
|-------------|-------|--------|
| BUG-01 | Phase 1 | Pending |
| DEBT-01 | Phase 2 | Pending |
| DEBT-02 | Phase 2 | Pending |
| DEBT-03 | Phase 2 | Pending |
| DEBT-04 | Phase 2 | Pending |

**Coverage:**
- v1 requirements: 5 total
- Mapped to phases: 5
- Unmapped: 0 ✓

---
*Requirements defined: 2026-03-27*
*Last updated: 2026-03-27 after initialization*
