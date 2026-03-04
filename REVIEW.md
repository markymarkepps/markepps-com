# Code Review: fix-link-descriptions (PR #16)

This document captures the findings from a review of the solution introduced in
[PR #16 ("fix: fixed link descriptions for SEO")](https://github.com/markymarkepps/markepps-com/pull/16)
and the surrounding custom template files.

---

## Bugs Fixed

### 1. Typo in `rel` attribute — `layouts/partials/home/profile.html`

**Was:** `rel="noopener noreffer"`  
**Fixed to:** `rel="noopener noreferrer"`

`noreffer` is not a valid link relationship type. The correct token is
`noreferrer`, which instructs the browser not to send the `Referer` header when
the external link is followed. Without it, the referrer header leaks to external
sites even though `noopener` (which only prevents the opened tab from accessing
`window.opener`) is present.

---

### 2. Unsafe JavaScript template interpolation — `layouts/partials/home/profile.html`

**Was:** `strings: ["{{ . }}"]`  
**Fixed to:** `strings: [{{ . | jsonify }}]`

The subtitle value was inserted into the inline `<script>` block as a bare
template string with manual quote wrapping. If the subtitle ever contains a
double-quote, backslash, or newline, the generated JavaScript would be
syntactically invalid and the TypeIt animation would silently fail. Hugo's
`jsonify` function serialises the value as a properly escaped JSON string
(including the surrounding quotes), making this injection safe.

---

### 3. `<h1>` used for post titles in list/summary view — `layouts/_default/summary.html`

**Was:** `<h1 class="single-title" …>`  
**Fixed to:** `<h2 class="single-title" …>`

Each post card on the home / list page rendered its title inside an `<h1>`
element. A page should contain exactly one `<h1>` (the page-level heading).
Multiple `<h1>` elements per page confuse assistive technologies and can dilute
SEO signals. Post titles in a list context belong in `<h2>` (or lower). The CSS
class `single-title` was likely copied from the single-post template where `<h1>`
is correct; keeping the class name while changing the element preserves styling.

---

### 4. README references the wrong theme — `README.md`

**Was:** "the [PaperMod theme](https://github.com/adityatelange/hugo-PaperMod)"  
**Fixed to:** "the [LoveIt theme](https://github.com/dillonzq/LoveIt)"

The site was migrated to the LoveIt theme but the README still credited
PaperMod. This was a documentation inconsistency that could cause confusion for
anyone looking to contribute or set up the project locally.

---

## Concerns / Non-blocking Notes

### 5. `title: ""` is redundant — `hugo.yaml`

The empty `title: ""` key was added to the `home.profile` block in PR #16. Hugo
treats a missing key and an empty string key identically in most template
contexts, so this has no functional effect. It can be removed to keep the
configuration tidy, but it does not cause any harm.

### 6. `defaultTheme: dark` overrides user preference — `hugo.yaml`

PR #16 changed `defaultTheme` from `auto` to `dark`. The `auto` setting
respects the user's OS-level light/dark preference (via the
`prefers-color-scheme` media query). Forcing `dark` means users who prefer a
light interface will see a dark site with no way to switch (unless the theme
provides an in-page toggle). This is a deliberate aesthetic choice, but it is
worth noting that `auto` is generally more accessible and aligns with WCAG 2.1
guidance on supporting user preferences.

### 7. Strava social link may not resolve correctly — `hugo.yaml`

```yaml
strava: markymarkepps
```

Strava profile URLs are based on a numeric athlete ID
(`https://www.strava.com/athletes/<id>`), not a username slug. Depending on
whether the LoveIt theme's `social.yml` builds a username-based URL for Strava,
the generated link may lead to a 404. Verify the rendered link by inspecting the
live site's social icon for Strava and confirm it navigates to the correct
athlete profile.
