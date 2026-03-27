# STACK.md — Technology Stack

## Core Framework
- **Hugo** — static site generator (version pinned via `.hugo_build.lock`)
- **Theme**: [LoveIt](https://github.com/dillonzq/LoveIt) v0.3.0 (installed as git submodule at `themes/LoveIt/`)

## Languages
| Layer | Language |
|-------|----------|
| Templates | Go HTML templates (`layouts/`) |
| Styles | SCSS (compiled by Hugo pipes from `assets/css/`) |
| Config | YAML (`hugo.yaml`) |
| Content | Markdown with YAML frontmatter |

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
