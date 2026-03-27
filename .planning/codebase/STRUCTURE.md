# STRUCTURE.md — File & Directory Structure

## Project Root

```
markepps-com/
├── hugo.yaml              # Main Hugo config (site settings, menus, params)
├── frontmatter.json       # Front Matter CMS config
├── build.sh               # Custom build script
├── LICENSE.md             # Project license
├── README.md              # Project README
│
├── content/               # All site content (Markdown)
├── layouts/               # Hugo template overrides (project-level)
├── assets/                # SCSS source files compiled by Hugo Pipes
├── static/                # Static files copied directly to public/
├── themes/LoveIt/         # Theme (git submodule, v0.3.0)
├── public/                # Build output (gitignored, generated)
├── resources/             # Hugo cache (generated)
│
├── .frontmatter/          # Front Matter CMS database
├── .vscode/               # VS Code workspace settings
├── .gitmodules            # Git submodule config (LoveIt theme)
└── .gitignore
```

## Content Directory (`content/`)

```
content/
├── posts/
│   ├── new-site.md               # Post: announcing site launch
│   └── new-training-plan.md      # Post: training plan announcement
├── projects/_index.md            # Projects section landing page
├── hobbies/_index.md             # Hobbies section landing page
├── experience/_index.md          # Experience section landing page
└── contact/_index.md             # Contact section landing page
```

## Layouts Directory (`layouts/`) — Overrides Only

```
layouts/
├── _default/
│   ├── section.html              # Archive-style section listing
│   └── summary.html              # Post summary/card component
└── partials/
    └── home/
        └── profile.html          # Home page profile (sticker + social links)
```

## Assets Directory (`assets/css/`)

```
assets/css/
├── _custom.scss                  # Custom styles: hello-sticker, hover FX, typography
└── _override.scss                # Theme variable overrides
```

## Static Directory (`static/`)

```
static/
├── favicon.svg                   # SVG favicon (also used as SEO og:image)
├── favicon.ico
├── favicon-16x16.png
├── favicon-32x32.png
├── apple-touch-icon.png
├── android-chrome-192x192.png
├── android-chrome-512x512.png
└── site.webmanifest              # PWA manifest
```

## Navigation Menu (from hugo.yaml)

| Weight | Name       | URL          | Icon           |
| ------ | ---------- | ------------ | -------------- |
| 2      | Projects   | /projects/   | fa-code-branch |
| 3      | Hobbies    | /hobbies/    | fa-heart       |
| 4      | Experience | /experience/ | fa-briefcase   |
| 5      | Contact    | /contact/    | fa-envelope    |

Note: Weight 1 is implicitly the Home/header icon (`<i class="fas fa-home">`)
