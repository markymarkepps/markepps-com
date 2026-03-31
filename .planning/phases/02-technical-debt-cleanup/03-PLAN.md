---
plan: "03"
phase: 2
wave: 1
depends_on: []
requirements: [DEBT-04]
files_modified:
  - assets/css/_custom.scss
  - static/fonts/PermanentMarker-Regular.woff2
autonomous: true
---

# Plan 03 — Self-Host Permanent Marker Font (DEBT-04)

## Objective

Remove the runtime Google Fonts CDN dependency for `Permanent Marker` and serve the font from `static/fonts/` locally. This eliminates the external network request, removes the Google Fonts privacy concern (no third-party requests on page load), and makes the site fully self-contained.

## Background

`assets/css/_custom.scss` line 1 currently imports:

```scss
@import url("https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap");
```

The font is used in `.tag-bottom` (the "Hello my name is" sticker name area):

```scss
font-family: "Permanent Marker", cursive;
```

The woff2 file URL (from Google Fonts API v16): `https://fonts.gstatic.com/s/permanentmarker/v16/Fh4uPib9Iyv2ucM6pGQMWimMp004La2Cfw.woff2`

Hugo serves everything in `static/` at the site root — `static/fonts/PermanentMarker-Regular.woff2` becomes `/fonts/PermanentMarker-Regular.woff2`.

## must_haves

- No `fonts.googleapis.com` request on page load
- `Permanent Marker` font still renders correctly in the name sticker
- Font file is committed to the repo in `static/fonts/`

---

## Task 3.1 — Download Font File to `static/fonts/`

<wave>1</wave>

<read_first>

- static/ directory listing (confirm fonts/ subdirectory doesn't already exist)
- Run: ls static/ (check current contents)
  </read_first>

<action>
Download the woff2 font file from Google Fonts CDN and place it in `static/fonts/`:

```bash
mkdir -p static/fonts
curl -L "https://fonts.gstatic.com/s/permanentmarker/v16/Fh4uPib9Iyv2ucM6pGQMWimMp004La2Cfw.woff2" \
     -o static/fonts/PermanentMarker-Regular.woff2
```

Verify the file is a valid woff2:

```bash
file static/fonts/PermanentMarker-Regular.woff2
# Expected: "Web Open Font Format (Version 2), TrueType, ..." or similar woff2 description
ls -lh static/fonts/PermanentMarker-Regular.woff2
# Expected: file size ~30-60KB
```

</action>

<acceptance_criteria>

- `static/fonts/PermanentMarker-Regular.woff2` exists
- `ls static/fonts/PermanentMarker-Regular.woff2` exits 0
- File size is between 20KB and 100KB: `stat -c %s static/fonts/PermanentMarker-Regular.woff2` returns a value between 20000 and 100000
  </acceptance_criteria>

---

## Task 3.2 — Update `_custom.scss` to Use Local Font

<wave>1</wave>

<read_first>

- assets/css/\_custom.scss (full file — especially line 1 and the .tag-bottom block)
  </read_first>

<action>
Make two changes to `assets/css/_custom.scss`:

**Change 1 — Remove Google Fonts import (line 1):**
Remove this line entirely:

```scss
@import url("https://fonts.googleapis.com/css2?family=Permanent+Marker&display=swap");
```

**Change 2 — Add `@font-face` declaration at the top of the file:**
Add the following block as the new first content in the file (before any `.hello-tag` or other rules), with a section header:

```scss
/* =========================================
   0. SELF-HOSTED FONTS
   ========================================= */
@font-face {
  font-family: "Permanent Marker";
  font-style: normal;
  font-weight: 400;
  font-display: swap;
  src: url("/fonts/PermanentMarker-Regular.woff2") format("woff2");
  unicode-range:
    U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA, U+02DC,
    U+0304, U+0308, U+0329, U+2000-206F, U+20AC, U+2122, U+2191, U+2193, U+2212,
    U+2215, U+FEFF, U+FFFD;
}
```

The final top of `_custom.scss` should start with the `@font-face` block (the Google `@import` line is gone).

The `.tag-bottom` block's `font-family: "Permanent Marker", cursive;` line is **unchanged** — it still works because the `@font-face` declaration registers the same font family name.
</action>

<acceptance_criteria>

- `grep "googleapis.com" assets/css/_custom.scss` returns no matches (exit code 1)
- `grep "@font-face" assets/css/_custom.scss` exits 0
- `grep "PermanentMarker-Regular.woff2" assets/css/_custom.scss` exits 0
- `grep "font-display: swap" assets/css/_custom.scss` exits 0
- `grep '"Permanent Marker", cursive' assets/css/_custom.scss` still exits 0 (usage unchanged)
  </acceptance_criteria>

---

## Task 3.3 — Verify Build Passes with Local Font

<wave>1</wave>

<read_first>

- assets/css/\_custom.scss (after Task 3.2 changes)
- hugo.yaml (confirm minify/build settings)
  </read_first>

<action>
Run the Hugo build and verify it completes without errors:

```bash
hugo --quiet
```

Expected: no output (clean build). Any SCSS compilation error or missing font reference will produce output.

Also spot-check that the generated CSS no longer contains the Google Fonts import:

```bash
grep -r "googleapis.com" public/css/ 2>/dev/null | head -5
```

Expected: no matches (or empty output).

And confirm the font-face is in the minified CSS:

```bash
grep -o "PermanentMarker" public/css/style.min.css | head -3
```

Expected: `PermanentMarker` appears at least once.
</action>

<acceptance_criteria>

- `hugo --quiet` exits 0 with no output
- `grep "googleapis.com" public/css/style.min.css` returns no matches
- `grep "PermanentMarker" public/css/style.min.css` exits 0
  </acceptance_criteria>
