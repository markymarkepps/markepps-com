---
phase: 1
plan: "01"
status: complete
commit: 416f6c4
requirement: BUG-01
files_modified:
  - layouts/_default/summary.html
---

# Phase 1 Summary — Dynamic Relative Dates (BUG-01)

## What Was Built

Replaced the Hugo build-time date calculation in `layouts/_default/summary.html` with a
client-side JavaScript approach. Post cards now display accurate relative dates at render
time in the visitor's browser rather than at site build time.

## Root Cause

`now.Unix` in Hugo templates is evaluated **once** during `hugo build`. Every visitor saw
the same stale relative time (e.g. "47 days ago") until the site was redeployed, regardless
of how much time had actually elapsed.

## Solution

| Component      | Detail                                                                                                    |
| -------------- | --------------------------------------------------------------------------------------------------------- |
| Data attribute | `data-publish-date="<ISO 8601>"` added to `.post-footer-date` span                                        |
| Fallback text  | `{{ .PublishDate.Format "2 Jan 2006" }}` rendered server-side for no-JS graceful degradation              |
| JS function    | `gsdRelativeDate(iso)` — pure JS, handles minutes/hours/days/weeks/years                                  |
| Dedup guard    | `window.__relDateInit` prevents re-registering the listener when multiple post cards are on the same page |
| Trigger        | `DOMContentLoaded` — updates all `.post-footer-date[data-publish-date]` spans                             |

## Files Changed

- `layouts/_default/summary.html` — removed 6 lines of Hugo date logic, added `data-publish-date` attribute + 26-line inline `<script>` block

## Verification

| Check                                      | Result       |
| ------------------------------------------ | ------------ |
| `data-publish-date` in template            | ✅ 3 matches |
| `window.__relDateInit` guard               | ✅ 2 matches |
| `gsdRelativeDate` function                 | ✅ 2 matches |
| `DOMContentLoaded` listener                | ✅ 1 match   |
| `querySelectorAll` call                    | ✅ 1 match   |
| `$days :=` removed                         | ✅ 0 matches |
| `now.Unix` removed                         | ✅ 0 matches |
| Hugo build clean                           | ✅ no errors |
| `data-publish-date` in `public/index.html` | ✅ confirmed |

## Key Decisions

- **Inline `<script>` vs separate JS file**: Inline keeps the solution self-contained in one
  template override. LoveIt's asset pipeline has no simple hook for custom JS injection without
  editing theme files.
- **`window.__relDateInit` dedup**: The script block is emitted once per post card; the guard
  ensures the DOMContentLoaded handler registers exactly once regardless of how many cards
  appear on the page.
- **No-JS fallback**: ISO formatted date `2 Jan 2006` is pre-rendered as span text content and
  overwritten by JS. Non-JS visitors see a clean absolute date.

## Self-Check

- BUG-01 acceptance criteria: all PASS ✅
- No regressions to other templates or pages
- Build output clean
