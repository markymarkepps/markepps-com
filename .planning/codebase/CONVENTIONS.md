# CONVENTIONS.md — Code Conventions & Standards

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

## Hugo Build

- Build output goes to `public/`
- Custom build logic in `build.sh` (review before running `hugo` directly)
