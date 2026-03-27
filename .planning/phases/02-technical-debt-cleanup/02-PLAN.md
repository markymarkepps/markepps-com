---
plan: "02"
phase: 2
wave: 1
depends_on: []
requirements: [DEBT-03]
files_modified:
  - .gitmodules
  - copilot-instructions.md
autonomous: true
---

# Plan 02 — Submodule Documentation (DEBT-03)

## Objective

Harden the LoveIt submodule reference by adding an explicit `branch` entry to `.gitmodules` and documenting the pinned SHA in `copilot-instructions.md` so future maintainers understand the submodule policy.

## Background

Git submodules are inherently SHA-pinned — `git submodule update` always checks out exactly the SHA committed in the parent repo. The risk is `git submodule update --remote`, which pulls the branch tip and can silently change the SHA. DEBT-03 addresses this by:

1. Making the intended branch explicit in `.gitmodules` (currently no `branch` entry)
2. Documenting the pinned SHA and "do not use --remote" policy in project docs

**Current state:**
- Submodule SHA: `f59fb4ecc2ce6c95e0b3395e3d3da9637d5581cd`
- Git describe: `v0.2.11-169-gf59fb4ec` (169 commits ahead of v0.2.11 tag on v0.3.0 branch)
- `.gitmodules`: no `branch` entry — just `path` and `url`

## must_haves

- `.gitmodules` has explicit `branch = v0.3.0`
- `copilot-instructions.md` warns against `git submodule update --remote` and documents the pinned SHA

---

## Task 2.1 — Add `branch` Entry to `.gitmodules`

<wave>1</wave>

<read_first>
- .gitmodules (current state)
- Run: git submodule status (confirm current SHA before touching anything)
</read_first>

<action>
Add `branch = v0.3.0` to the `[submodule "themes/LoveIt"]` block in `.gitmodules`.

The updated `.gitmodules` should be:

```
[submodule "themes/LoveIt"]
        path = themes/LoveIt
        url = https://github.com/dillonzq/LoveIt.git
        branch = v0.3.0
```

This documents intent without changing the checked-out SHA (which remains `f59fb4ecc2ce6c95e0b3395e3d3da9637d5581cd`).
</action>

<acceptance_criteria>
- `.gitmodules` contains `branch = v0.3.0`
- `git submodule status` still shows SHA `f59fb4ecc2ce6c95e0b3395e3d3da9637d5581cd` (unchanged)
- `grep "branch = v0.3.0" .gitmodules` exits 0
</acceptance_criteria>

---

## Task 2.2 — Document Submodule Policy in `copilot-instructions.md`

<wave>1</wave>

<read_first>
- copilot-instructions.md (current content — find the Architecture or Conventions section to insert into)
</read_first>

<action>
Locate the `## Conventions` or `## Architecture` section in `copilot-instructions.md` and add a `### LoveIt Submodule Policy` subsection with the following content:

```markdown
### LoveIt Submodule Policy

The `themes/LoveIt` git submodule is pinned to commit SHA `f59fb4ecc2ce6c95e0b3395e3d3da9637d5581cd` (branch `v0.3.0`, ~v0.2.11+169).

**Rules:**
- **Never run `git submodule update --remote`** — this pulls the branch tip and can silently change the theme version, breaking the site
- To initialize after a fresh clone: `git submodule update --init --recursive`
- To intentionally upgrade: check out a new SHA, test locally, then commit the change explicitly
- Theme files are in `themes/LoveIt/` — **never edit them directly** — use `layouts/` and `assets/css/` overrides
```

Insert this subsection under the existing "Conventions" or "Stack" section (whichever contains the project rules). If a "Submodule" or "Theme" section already exists, merge the content.
</action>

<acceptance_criteria>
- `grep "git submodule update --remote" copilot-instructions.md` exits 0
- `grep "f59fb4ecc2ce6c95e0b3395e3d3da9637d5581cd" copilot-instructions.md` exits 0
- `grep "v0.3.0" copilot-instructions.md` exits 0
</acceptance_criteria>
