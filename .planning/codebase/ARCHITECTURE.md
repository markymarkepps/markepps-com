# ARCHITECTURE.md — Site Architecture

## Pattern

**Static Site Generation (SSG)** — Hugo compiles Markdown content + Go templates + SCSS into a fully static `public/` directory. No server-side logic at runtime.

## Hugo Template Hierarchy

LoveIt theme provides the base template layer. This project selectively **overrides** specific theme templates via Hugo's lookup order (project layouts take precedence over theme layouts).

```
Request → Hugo builds → public/ → Cloudflare CDN → Browser
```

## Layout Override Strategy

Only 3 files are overridden in `layouts/`:

| Override File                        | Overrides Theme            | Purpose                              |
| ------------------------------------ | -------------------------- | ------------------------------------ |
| `layouts/_default/section.html`      | Theme section template     | Custom archive-style section listing |
| `layouts/_default/summary.html`      | Theme summary template     | Custom post card/summary display     |
| `layouts/partials/home/profile.html` | Theme home profile partial | Custom "Hello my name is" sticker UI |

All other pages (single posts, list pages, 404, etc.) use unmodified LoveIt templates.

## Styling Architecture

Hugo Pipes compiles SCSS. Two project-level files hook into the theme's SCSS variables:

```
themes/LoveIt/assets/css/
  └── (theme base styles + SCSS variables like $accent-light, $accent-dark)

assets/css/
  ├── _custom.scss   ← Custom component styles (sticker, hover effects, typography)
  └── _override.scss ← Theme variable/default overrides
```

CSS variables referenced: `$accent-light` (blue, light mode), `$accent-dark` (red, dark mode), `$global-font-secondary-color`, `$global-font-secondary-color-dark`

## Theme Configuration (hugo.yaml params)

Key architectural params driving behavior:

- `params.home.profile.typeit: true` — enables TypeIt animation on subtitle
- `params.defaultTheme: dark` — site loads in dark mode by default
- `params.header.title.name: ""` — header shows icon only (no text)
- `params.home.profile.social: true` — shows social links on home profile

## Content Model

```
content/
  posts/         ← Blog posts (Markdown, dated)
  projects/      ← Projects section (_index.md only, no individual pages yet)
  hobbies/       ← Hobbies section (_index.md only)
  experience/    ← Experience section (_index.md only)
  contact/       ← Contact section (_index.md only)
```

Sections other than `posts/` currently only have `_index.md` — they render via the overridden `section.html` but have no child pages.

## Dark/Light Mode

LoveIt implements theme switching via a `[theme]` attribute on `<html>`. SCSS uses `[theme="dark"]` selectors. Default is `dark` (set in `hugo.yaml`), user can toggle.
