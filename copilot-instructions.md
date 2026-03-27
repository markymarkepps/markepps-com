<!-- GSD:project-start source:PROJECT.md -->
## Project

**markepps.com**

A personal Hugo static site for Mark Epps, deployed at markepps.com. It hosts a blog, and stub sections for Projects, Hobbies, Experience, and Contact. The homepage features a custom "Hello my name is" sticker with a TypeIt animated subtitle and social profile links.

**Core Value:** A fast, polished personal site that's technically correct and doesn't embarrass its author.

### Constraints

- **Theme**: Do not edit files inside `themes/LoveIt/` — override via `layouts/` and `assets/css/` only
- **Static site**: No server-side logic — dynamic behaviour requires client-side JS or scheduled rebuilds
- **Hugo Pipes**: SCSS compiled by Hugo, no separate build tool for styles
<!-- GSD:project-end -->

<!-- GSD:stack-start source:codebase/STACK.md -->
## Technology Stack

## Core Framework
- **Hugo** — static site generator (version pinned via `.hugo_build.lock`)
- **Theme**: [LoveIt](https://github.com/dillonzq/LoveIt) v0.3.0 (installed as git submodule at `themes/LoveIt/`)
## Languages
| Layer     | Language                                         |
| --------- | ------------------------------------------------ |
| Templates | Go HTML templates (`layouts/`)                   |
| Styles    | SCSS (compiled by Hugo pipes from `assets/css/`) |
| Config    | YAML (`hugo.yaml`)                               |
| Content   | Markdown with YAML frontmatter                   |
## Frontend Libraries (bundled in theme)
- **TypeIt** — typewriter animation for home subtitle (`themes/LoveIt/static/lib/typeit/`)
- **Font Awesome Free** — icon set used in nav menu items and header
- **Simple Icons** — social link icons (GitHub, LinkedIn, Instagram, Strava)
- **Animate.css** — page title entrance animations
- **KaTeX** — math rendering support (available, not currently used in content)
- **lightgallery** — image gallery support (available, not currently used)
- **lazysizes** — lazy image loading
- **clipboard.js** — code block copy buttons
- **Sharer.js** — social sharing buttons
## Fonts
- **Google Fonts**: `Permanent Marker` (cursive) — loaded via `@import` in `_custom.scss`, used for the "Hello my name is" sticker bottom panel
- **System fonts** for body/headings via theme defaults
## Build & Deploy
- **Build script**: `build.sh` (custom shell script)
- **Output**: `public/` directory (static HTML/CSS/JS)
- Deployed to **markepps.com** (baseURL: `https://markepps.com/`)
## Dev Tooling
- **VS Code** with `.vscode/settings.json`
- **Front Matter CMS** VS Code extension (`frontmatter.json`, `.frontmatter/`) — manages content/media metadata
- **Git submodules** for theme (`.gitmodules`)
## Package Management
- No Node.js dependency management in project root (theme has its own `package.json` but is consumed as-is)
- Hugo handles SCSS compilation natively via Hugo Pipes
<!-- GSD:stack-end -->

<!-- GSD:conventions-start source:CONVENTIONS.md -->
## Conventions

## Hugo Config Conventions
- Config format: **YAML** (not TOML or JSON)
- All site-level params live in `hugo.yaml` under `params:`
- LoveIt uses `params.author` (not top-level `author`) for SEO/footer
- Both `author.name` (top-level) and `params.author.name` are set for compatibility
- Menu items use Font Awesome `pre:` HTML for icons, no `post:` used
## Template Conventions
- Go HTML templates following Hugo's standard `define`/`partial` pattern
- `{{- -}}` whitespace trimming used throughout
- Theme partials called via `partial "plugin/*.html"` (LoveIt plugin pattern)
- Section templates use `.Pages.GroupByDate "2006"` for year grouping
- Safe HTML output via `| safeHTML` for HTML in content/params
## SCSS Conventions
- Theme SCSS variables used directly (no redeclaration): `$accent-light`, `$accent-dark`, `$global-font-secondary-color`
- Dark mode selectors: `[theme="dark"] .selector { }` (LoveIt's HTML attr pattern, NOT CSS `prefers-color-scheme`)
- Light/dark transitions: `transition: color 0.4s ease` and `transition: all 0.2s ease-in-out`
- Comments use section headers: `/* ========= N. SECTION NAME ========= */`
- `!important` used selectively to override theme specificity (social icon hover, header hover)
## Accent Color System
| Mode  | Color                           | Usage                             |
| ----- | ------------------------------- | --------------------------------- |
| Light | `$accent-light` (blue)          | Hover states, sticker top, cursor |
| Dark  | `$accent-dark` (red, `#d32f2f`) | Hover states, sticker top, cursor |
## Content Conventions
- Frontmatter format: YAML
- Posts go in `content/posts/`
- Section landing pages use `_index.md`
- No individual pages under Projects/Hobbies/Experience/Contact yet
## Naming Conventions
- Content files: `kebab-case.md`
- Layout files: `lowercase.html` matching Hugo's lookup order names
- SCSS files: `_kebab-case.scss` (underscore prefix = partial)
## Git Conventions
- Branch naming: `kebab-case` descriptor (e.g., `fix-header`)
- Theme is a **git submodule** — do not edit files inside `themes/LoveIt/` directly
- `.frontmatter/database/` and `public/` should be gitignored (verify `.gitignore`)

### LoveIt Submodule Policy

The `themes/LoveIt` git submodule is pinned to commit SHA `f59fb4ecc2ce6c95e0b3395e3d3da9637d5581cd` (branch `v0.3.0`, ~v0.2.11+169).

**Rules:**
- **Never run `git submodule update --remote`** — this pulls the branch tip and can silently change the theme version, breaking the site
- To initialize after a fresh clone: `git submodule update --init --recursive`
- To intentionally upgrade: check out a new SHA, test locally, then commit the change explicitly
- Theme files are in `themes/LoveIt/` — **never edit them directly** — use `layouts/` and `assets/css/` overrides
## Hugo Build
- Build output goes to `public/`
- Custom build logic in `build.sh` (review before running `hugo` directly)
<!-- GSD:conventions-end -->

<!-- GSD:architecture-start source:ARCHITECTURE.md -->
## Architecture

## Pattern
## Hugo Template Hierarchy
```
```
## Layout Override Strategy
| Override File                        | Overrides Theme            | Purpose                              |
| ------------------------------------ | -------------------------- | ------------------------------------ |
| `layouts/_default/section.html`      | Theme section template     | Custom archive-style section listing |
| `layouts/_default/summary.html`      | Theme summary template     | Custom post card/summary display     |
| `layouts/partials/home/profile.html` | Theme home profile partial | Custom "Hello my name is" sticker UI |
## Styling Architecture
```
```
## Theme Configuration (hugo.yaml params)
- `params.home.profile.typeit: true` — enables TypeIt animation on subtitle
- `params.defaultTheme: dark` — site loads in dark mode by default
- `params.header.title.name: ""` — header shows icon only (no text)
- `params.home.profile.social: true` — shows social links on home profile
## Content Model
```
```
## Dark/Light Mode
<!-- GSD:architecture-end -->

<!-- GSD:workflow-start source:GSD defaults -->
## GSD Workflow Enforcement

Before using Edit, Write, or other file-changing tools, start work through a GSD command so planning artifacts and execution context stay in sync.

Use these entry points:
- `/gsd-quick` for small fixes, doc updates, and ad-hoc tasks
- `/gsd-debug` for investigation and bug fixing
- `/gsd-execute-phase` for planned phase work

Do not make direct repo edits outside a GSD workflow unless the user explicitly asks to bypass it.
<!-- GSD:workflow-end -->



<!-- GSD:profile-start -->
## Developer Profile

> Profile not yet configured. Run `/gsd-profile-user` to generate your developer profile.
> This section is managed by `generate-claude-profile` -- do not edit manually.
<!-- GSD:profile-end -->
