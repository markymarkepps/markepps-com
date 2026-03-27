# TESTING.md — Testing Approach

## Current State

**No automated testing infrastructure exists.** This is a static Hugo site — there is no test runner, no test files, and no CI/CD pipeline configured in the repository.

## Manual Testing Process

All validation is manual and visual:

### Local Development Server

```bash
hugo server -D          # Serve with drafts
hugo server             # Serve published content only
```

Runs at `http://localhost:1313` by default with live reload.

### Build Validation

```bash
./build.sh              # Project's custom build script
hugo --minify           # Standard Hugo build
```

A clean build with no errors = passing.

### Visual Checks to Perform After Changes

- [ ] Home page: Hello sticker renders correctly (dark + light mode)
- [ ] Home page: TypeIt animation plays on subtitle
- [ ] Home page: Social icons display and link correctly
- [ ] Header: Home icon shows, no unwanted text beside it
- [ ] Navigation: All 4 menu items show with correct icons
- [ ] Dark/light toggle works and accent colors switch correctly
- [ ] Posts: `new-site` and `new-training-plan` render correctly
- [ ] Section pages: Projects, Hobbies, Experience, Contact load without error
- [ ] Responsive layout: mobile/tablet breakpoints

## Known Issue Under Investigation

**Branch `fix-header`** — header rendering issue being debugged. Header title config:

```yaml
header:
  title:
    name: # empty = no text
    pre: '<i class="fas fa-home"></i>'
```

## Hugo Build Warnings to Watch

- Missing translation strings (LoveIt i18n)
- Deprecated Hugo functions (theme may use older Hugo APIs)
- SCSS variable reference errors if theme variables change

## Recommended Future Testing

- **HTMLProofer** — validate links and HTML structure in `public/`
- **Lighthouse CI** — performance/accessibility scoring
- **Percy / Chromatic** — visual regression for UI components
