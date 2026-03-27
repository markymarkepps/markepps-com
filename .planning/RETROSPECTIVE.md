# Project Retrospective

_A living document updated after each milestone. Lessons feed forward into future planning._

## Milestone: v1.0 — Bug Fixes & Technical Debt

**Shipped:** 2026-03-28
**Phases:** 2 | **Plans:** 4 | **Commits:** 9

### What Was Built

- Client-side relative dates via `data-publish-date` ISO attribute + `gsdRelativeDate()` JS (BUG-01)
- Self-hosted Permanent Marker font — woff2 in `static/fonts/`, CDN removed from SCSS (DEBT-04)
- `build.sh` fully documented with header block, flag/env reference, POSIX compliance fix (DEBT-02)
- LoveIt submodule pinned to `branch = v0.3.0` in `.gitmodules`, SHA policy in `copilot-instructions.md` (DEBT-03)
- `public/` gitignore verified correct — no change needed (DEBT-01)

### What Worked

- Coarse granularity kept plans tight — 1 plan for Phase 1, 3 plans for Phase 2 with no bloat
- Inline `<script>` in `summary.html` was the right call: self-contained, no theme edits required
- Codebase map caught the Google Fonts dependency and submodule gap before planning

### What Was Inefficient

- Font download required a manual curl step — no tool can automate binary fetches yet
- `replace_string_in_file` failed on `.gitmodules` due to tab/space indentation mismatch; required a corrective second call
- CLI `milestone complete` extracted wrong "accomplishments" (pulled partial text rather than human-readable bullets) — required manual fix

### Patterns Established

- `data-*` attributes as the bridge between Hugo template and client-side JS for any SSG dynamic data
- `window.__relDateInit` dedup guard pattern for inline scripts in repeating template partials
- SHA + branch policy documented in `copilot-instructions.md` for any git submodule

### Key Lessons

1. Always verify `replace_string_in_file` old strings include correct whitespace (especially mixed tab/space files like `.gitmodules`)
2. Post summaries render on `public/index.html` (home page), not `public/posts/` — grep accordingly
3. DEBT verification items (DEBT-01) are valid phases — confirming no-change-needed is a deliverable

---

## Cross-Milestone Trends

### Process Evolution

| Milestone | Sessions | Phases | Key Change                                |
| --------- | -------- | ------ | ----------------------------------------- |
| v1.0      | 1        | 2      | First GSD milestone — process established |

### Cumulative Quality

| Milestone | Manual Tests | Notes                  |
| --------- | ------------ | ---------------------- |
| v1.0      | All pass     | No automated tests yet |

### Top Lessons (Verified Across Milestones)

1. Whitespace precision is critical in file-editing tools — always include 3+ lines of context
2. Static site "dynamic" features need a clear SSG→browser handoff strategy (`data-*` attributes work well)
