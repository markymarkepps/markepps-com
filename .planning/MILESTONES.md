# Milestones

## v1.0 Bug Fixes & Technical Debt (Shipped: 2026-03-27)

**Phases completed:** 2 phases, 4 plans, 0 tasks

**Key accomplishments:**

- Fixed frozen "X days ago" dates — replaced Hugo build-time calc with client-side JS using `data-publish-date` ISO attribute (BUG-01)
- Removed Google Fonts CDN dependency — Permanent Marker font self-hosted at `/fonts/` (DEBT-04)
- Documented `build.sh` with full header block and fixed POSIX compliance (DEBT-02)
- Pinned LoveIt submodule to `branch = v0.3.0` in `.gitmodules` and documented SHA policy (DEBT-03)
- Verified `public/` correctly gitignored — no code change needed (DEBT-01)

---
