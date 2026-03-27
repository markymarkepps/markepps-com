# INTEGRATIONS.md — External Integrations & Services

## Deployment & Hosting
- **Cloudflare** — DNS + CDN (evidenced by Cloudflare tag in built posts)
- **markepps.com** — production domain (`baseURL: https://markepps.com/`)

## Content Management
- **Front Matter CMS** (VS Code extension) — local CMS layer for managing posts, media, and taxonomy
  - Config: `frontmatter.json`
  - Database: `.frontmatter/database/` (mediaDb.json, pinnedItemsDb.json, taxonomyDb.json)
  - Not a deployed service — purely a developer tool

## Social Platforms (linked from profile)
| Platform | Username | Link Pattern |
|----------|----------|-------------|
| GitHub | `markymarkepps` | `https://github.com/markymarkepps` |
| Instagram | `markymarkepps` | `https://instagram.com/markymarkepps` |
| Strava | `markymarkepps` | `https://strava.com/athletes/markymarkepps` |
| LinkedIn | `markepps` | `https://linkedin.com/in/markepps` |

## External Fonts
- **Google Fonts** (`fonts.googleapis.com`) — `Permanent Marker` font loaded at runtime via CSS `@import` in `_custom.scss`

## SEO / Meta
- Open Graph / Twitter card meta via LoveIt theme built-in support
- Default SEO image: `/favicon.svg` (configured in `hugo.yaml`)

## Analytics
- None currently configured

## Comments
- None currently configured

## Search
- None currently configured (LoveIt supports Algolia/Fuse.js but not enabled)

## Content License
- Creative Commons CC BY-SA 4.0 (declared in copyright field of `hugo.yaml`)
