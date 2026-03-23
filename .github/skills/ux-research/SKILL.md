---
name: ux-research
description: '**WORKFLOW SKILL** — Run UX and usability tests on HTML prototypes, inject floating issue indicators next to problems, and generate fix plans the prototyping skill can consume. USE FOR: UX audit; usability testing; heuristic evaluation; Nielsen heuristics; user flow analysis; affordance check; cognitive walkthrough; interaction review; click target size; visual hierarchy; layout consistency; information architecture; navigation clarity; error prevention; UX issues; usability report; Plan Fix. DO NOT USE FOR: WCAG accessibility audits (use accessibility-audit skill); building prototypes (use material-design-prototyping skill); stakeholder feedback collection (use feedback-approval skill).'
argument-hint: 'Specify which HTML page(s) to test, or say "all"'
---

# UX Research

Run usability and UX heuristic tests on HTML prototype pages, then inject floating issue indicators directly into the page next to each problem. Each indicator includes a **Plan Fix** form that downloads a structured markdown file the `material-design-prototyping` skill can consume to implement the fix.

## When to Use

- After building a prototype and before sharing with stakeholders
- To identify usability problems in a page's layout, hierarchy, or interaction design
- When you want actionable fix plans that feed directly into the prototyping skill
- Running a quick heuristic evaluation against Nielsen's 10 usability heuristics

## Procedure

### Step 1 — Identify Pages to Test

Ask the user which HTML files to test:
- _"Which pages should I run UX tests on? You can name specific files or say 'all'."_
- If the user says "all", find every `.html` file in the project root (skip files inside `.github/`, `feedback/`, and backup files like `*-original.html`)
- If the user names specific files, use those
- Confirm the file list before proceeding

### Step 2 — Read and Analyze Each Page

For each target HTML file:
1. Read the full file contents
2. Evaluate against every heuristic in the [UX Heuristics Checklist](./references/ux-heuristics.md)
3. Record each issue found with:
   - **Heuristic violated** (e.g., H3: User Control)
   - **Severity** — Critical / Major / Minor / Cosmetic
   - **Element** — CSS selector or description of the element
   - **Location hint** — Where in the page the issue appears (e.g., "hero section", "nav bar", "card grid row 2")
   - **Problem** — What's wrong in one sentence
   - **Recommendation** — How to fix it in one sentence

### Step 3 — Inject Issue Indicators

For each page that has issues, inject the [UX issue indicator snippet](./assets/ux-indicators.html) immediately before the closing `</body>` tag. The snippet provides:

- A floating **"UX Issues"** pill button (bottom-left corner) showing the issue count
- Numbered floating indicator badges positioned near each issue's location
- Clicking a badge opens an inline popover with:
  - The heuristic name, severity, and problem description
  - A **"Plan Fix"** text area (pre-filled with the recommendation)
  - A **Submit** button that downloads a structured `.md` fix-plan file

**Building the indicator data:**
After the injectable HTML/CSS/JS from the snippet, add a `<script>` block that calls `window.__uxInjectIssues(issues)` with an array of issue objects. Each object has these fields:

```js
{
  id: 1,
  heuristic: "H4: Consistency & Standards",
  severity: "Major",
  selector: ".card-title",          // CSS selector to anchor near
  locationHint: "Product card grid", // Fallback human description
  problem: "Card titles use inconsistent font sizes across the grid.",
  recommendation: "Set all .card-title elements to Title Medium (16px/500)."
}
```

The snippet will:
1. For each issue, try `document.querySelector(selector)` to find the element
2. Position a numbered badge near that element using `getBoundingClientRect()`
3. If the selector doesn't match, fall back to appending the badge to the page footer with the `locationHint` as context
4. Reposition badges on window resize

### Step 4 — Report Summary to User

After injection, present a summary table in chat:

```
## UX Test Results — <filename>

| # | Heuristic | Severity | Problem | Location |
|---|-----------|----------|---------|----------|
| 1 | H4: Consistency | Major | Inconsistent card title sizes | Card grid |
| 2 | H7: Flexibility | Minor | No keyboard shortcut for search | Top bar |

**X issues found** — indicators injected into <filename>.
Open the page in a browser and click any numbered badge to review or plan a fix.
```

### Step 5 — Handle Plan Fix Submissions

When the user provides a fix-plan `.md` file (from the `ux-fixes/` directory), or asks to process a fix plan:

1. Read the fix-plan file
2. Parse the **File**, **Issue**, and **Planned Fix** sections
3. Summarize the planned changes
4. Instruct the user to invoke the prototyping skill:

> Fix plan ready for `checklist.html` — 2 changes planned. Invoke:
> `/material-design-prototyping apply UX fixes from ux-fixes/checklist-ux-fix-2026-03-23.md`

The fix-plan file follows the [fix-plan template](./assets/fix-plan-template.md).

### Step 6 — Clean Up

After fixes are applied:
- Remove the UX indicator injection from the HTML file (delete everything between `<!-- UX INDICATORS START -->` and `<!-- UX INDICATORS END -->`)
- Move processed fix-plan files to `ux-fixes/archive/`

## References

- [UX Heuristics Checklist](./references/ux-heuristics.md) — Full evaluation criteria
- [UX Indicators Snippet](./assets/ux-indicators.html) — Injectable HTML/CSS/JS for issue badges and Plan Fix modals
- [Fix Plan Template](./assets/fix-plan-template.md) — Output format for fix plans
