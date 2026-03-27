---
id: 01-dynamic-relative-dates
wave: 1
depends_on: []
files_modified:
  - layouts/_default/summary.html
autonomous: true
requirements:
  - BUG-01
---

# Plan: Dynamic Relative Dates

**Phase:** 1 — Dynamic Relative Dates
**Wave:** 1 (standalone, no dependencies)
**Goal:** Replace build-time static "X days ago" with client-side dynamic calculation.

## must_haves

1. Post summary cards show correct relative time on every page load without a site rebuild
2. The publish date is embedded as a machine-readable `data-*` attribute on the span
3. JS is deduplicated — runs exactly once per page even with multiple post cards
4. Falls back to formatted publish date if JS is disabled

## Tasks

<task id="1.1">
<title>Embed publish date as data attribute in summary.html</title>

<read_first>
- `layouts/_default/summary.html` — current implementation (understand the existing static Hugo template date logic before removing it)
</read_first>

<action>
In `layouts/_default/summary.html`, replace the existing static date block (the `$days` variable and conditional display logic) with:

1. A `<span>` that has `class="post-footer-date"` AND a `data-publish-date` attribute containing the ISO 8601 publish date
2. Inner text falls back to the formatted date (shown when JS is disabled via `<noscript>` or when JS hasn't run yet)

Replace this block:
```
{{- /* Relative date */ -}} {{- $days := div (sub now.Unix
.PublishDate.Unix) 86400 -}}
<span class="post-footer-date">
  {{- if ge $days 14 -}} {{- div $days 7 }} weeks ago {{- else if ge $days 7
  -}} 1 week ago {{- else if eq $days 1 -}} 1 day ago {{- else if eq $days 0
  -}} today {{- else -}} {{ $days }} days ago {{- end -}}
</span>
```

With:
```
{{- /* Relative date — computed client-side so it stays accurate after build */ -}}
<span class="post-footer-date" data-publish-date="{{ .PublishDate.Format "2006-01-02T15:04:05Z" }}">
  {{- .PublishDate.Format "2 Jan 2006" -}}
</span>
```

Note: `"2006-01-02T15:04:05Z"` is Hugo's time format reference — this outputs a valid ISO 8601 UTC string like `2026-01-15T00:00:00Z`.
</action>

<acceptance_criteria>
- `layouts/_default/summary.html` contains `data-publish-date=`
- `layouts/_default/summary.html` does NOT contain `$days :=`
- `layouts/_default/summary.html` does NOT contain `now.Unix`
- `layouts/_default/summary.html` does NOT contain `weeks ago` or `days ago` (the static strings are gone)
- `layouts/_default/summary.html` contains `.PublishDate.Format`
- Running `hugo server` produces no build errors
</acceptance_criteria>
</task>

<task id="1.2">
<title>Add client-side relative date script to summary.html</title>

<read_first>
- `layouts/_default/summary.html` — after task 1.1, to append the script at the correct location (end of the file, before the closing `{{- end -}}` if present, or after the last HTML element)
</read_first>

<action>
At the bottom of `layouts/_default/summary.html` (after the closing `</article>` tag), add the following inline script block.

The script uses a deduplication guard (`window.__relDateInit`) so it registers the `DOMContentLoaded` listener exactly once, regardless of how many post cards are on the page.

```html
{{- /* Client-side relative date updater — deduplicated across multiple post cards */ -}}
<script>
if (!window.__relDateInit) {
  window.__relDateInit = true;
  function gsdRelativeDate(iso) {
    var now = Date.now();
    var then = new Date(iso).getTime();
    var diff = Math.floor((now - then) / 1000);
    if (diff < 60)        return 'today';
    if (diff < 3600)      return Math.floor(diff / 60) + ' minutes ago';
    if (diff < 86400)     return Math.floor(diff / 3600) + ' hours ago';
    var days = Math.floor(diff / 86400);
    if (days === 1)       return '1 day ago';
    if (days < 14)        return days + ' days ago';
    var weeks = Math.floor(days / 7);
    if (weeks === 1)      return '1 week ago';
    if (weeks < 52)       return weeks + ' weeks ago';
    var years = Math.floor(days / 365);
    return years === 1 ? '1 year ago' : years + ' years ago';
  }
  document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.post-footer-date[data-publish-date]').forEach(function(el) {
      el.textContent = gsdRelativeDate(el.getAttribute('data-publish-date'));
    });
  });
}
</script>
```
</action>

<acceptance_criteria>
- `layouts/_default/summary.html` contains `window.__relDateInit`
- `layouts/_default/summary.html` contains `gsdRelativeDate`
- `layouts/_default/summary.html` contains `querySelectorAll('.post-footer-date[data-publish-date]')`
- `layouts/_default/summary.html` contains `DOMContentLoaded`
- Script appears after `</article>` (not inside the article element)
- Running `hugo server` produces no build errors
- Opening the home page in a browser shows relative dates (e.g. "X days ago") — not static ISO or formatted dates
</acceptance_criteria>
</task>

## Verification

After both tasks are complete, verify end-to-end:

1. Run `hugo server` — no build errors
2. Navigate to `http://localhost:1313` — post cards show relative dates (not the build-time dates)
3. Disable JS in browser devtools → reload — post cards show formatted dates like `15 Jan 2026` (fallback)
4. Check page source — each `.post-footer-date` span has a `data-publish-date` attribute
5. Check browser console — no JS errors

**UAT pass criteria:** Relative dates on post cards are always accurate to within 1 day of the current date without requiring a site rebuild.
