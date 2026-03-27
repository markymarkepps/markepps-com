# CONCERNS.md — Technical Concerns & Risks

## Active Issues

### 🔴 Header Rendering Bug (Branch: `fix-header`)
- **Issue**: Header title/icon not rendering as expected
- **Config**: `params.header.title.name` is empty string, `pre` is set to home icon HTML
- **Risk**: Affects every page — most visible part of the site
- **Status**: Under active investigation on `fix-header` branch

## Theme Concerns

### ⚠️ LoveIt Theme — Maintenance Status
- LoveIt (dillonzq/LoveIt) is the **v0.3.0 branch** — not the default `master` branch
- Original repo appears **unmaintained** (last commits ~2022)
- **Risk**: Hugo API deprecations will accumulate over time; theme may break with future Hugo versions
- **Mitigation**: Project-level overrides in `layouts/` minimize direct theme dependency

### ⚠️ Git Submodule Complexity
- Theme installed as git submodule at `themes/LoveIt/`
- Submodule pinned to a specific branch (`v0.3.0`), not a commit hash
- **Risk**: Accidental `git submodule update` could change theme version
- **Mitigation**: Pin to a specific commit SHA in `.gitmodules`

### ⚠️ SCSS Variable Coupling
- `_custom.scss` directly references theme SCSS variables (`$accent-light`, `$accent-dark`, etc.)
- These variables are defined inside the theme, not the project
- **Risk**: If theme variables are renamed/removed in an update, custom SCSS breaks silently
- **Mitigation**: Document which variables are relied upon (done in CONVENTIONS.md)

## Content Concerns

### ℹ️ Thin Content Sections
- Projects, Hobbies, Experience, Contact are **stub sections** — only `_index.md`, no child pages
- The section template (`section.html`) handles empty `.Pages` gracefully, but sections appear sparse
- **Action needed**: Add content pages to each section as the site grows

### ℹ️ External Font Dependency
- `Permanent Marker` font loaded from Google Fonts at runtime
- **Risk**: Font load failure makes sticker bottom panel fall back to system fonts (layout shift)
- **Mitigation**: Consider self-hosting the font in `static/`

## Performance Concerns

### ℹ️ No Analytics / Monitoring
- No visibility into real user performance or errors
- Recommend: Cloudflare Web Analytics (privacy-friendly, already on Cloudflare)

## Security / Privacy

### ℹ️ Google Fonts Privacy
- CSS `@import` from `fonts.googleapis.com` sends user IP to Google
- GDPR consideration if targeting EU users
- **Mitigation**: Self-host the font or use `font-display: swap` with local fallback

## Build Concerns

### ℹ️ `build.sh` is Opaque
- Custom build script exists but its contents weren't inspected
- **Risk**: Running `hugo` directly instead of `build.sh` may miss steps (minification, cache busting, deployment)
- **Action**: Review `build.sh` and document what it does vs plain `hugo`

### ℹ️ `public/` in Repo
- `public/` directory appears to be present in the workspace
- If committed to git, generates large diffs; should be gitignored
- **Action**: Verify `.gitignore` excludes `public/`
