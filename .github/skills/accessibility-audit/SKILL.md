---
name: accessibility-audit
description: '**REPORTING SKILL** — Audit HTML files against WCAG 2.1 Level A and AA success criteria and generate a detailed accessibility compliance report. USE FOR: WCAG compliance checks; accessibility audits; a11y testing; screen reader readiness; color contrast checking; keyboard navigation review; ARIA attribute validation; alt text review; form label checks; heading structure analysis; focus management review. DO NOT USE FOR: automatically fixing issues (report only); WCAG Level AAA audits; PDF or native app accessibility; performance testing.'
argument-hint: 'Specify the HTML file(s) to audit, or say "all" for the full project'
---

# Accessibility Audit

Audit HTML files against WCAG 2.1 Level A and AA standards and produce a detailed compliance report. This skill is **read-only** — it identifies and reports issues but does **NOT** make any changes to your code.

## When to Use

- Before shipping a page or prototype to stakeholders
- After building or modifying any HTML page
- During code review to catch accessibility gaps
- When preparing for an accessibility compliance review
- To verify ARIA usage, color contrast, keyboard navigation, and semantic structure

## Critical Rule

**DO NOT modify any source files.** This skill produces a report only. If asked to fix issues, decline and point the user to the report for manual remediation.

## Procedure

### Step 1 — Identify Files to Audit

Determine which files to audit:
- If the user specifies a file, audit that file
- If the user says "all", find all `.html` files in the project
- If unclear, audit the currently open file

Read the full content of each target HTML file.

### Step 2 — Run the Audit Checklist

For each HTML file, evaluate against every criterion in the [WCAG Audit Checklist](./references/wcag-checklist.md). The checklist covers these categories:

1. **Perceivable**
   - Text alternatives (images, icons, media)
   - Color contrast ratios (4.5:1 normal text, 3:1 large text)
   - Content structure and semantics
   - Responsive/reflow behavior

2. **Operable**
   - Keyboard accessibility
   - Focus visibility and order
   - Skip navigation / bypass blocks
   - Timing and motion

3. **Understandable**
   - Language attributes
   - Consistent navigation
   - Form labels and error handling
   - Predictable behavior

4. **Robust**
   - Valid HTML
   - ARIA roles, states, and properties
   - Name, role, value for custom controls

For each criterion, record:
- **Status**: Pass, Fail, Warning, or N/A
- **Location**: The specific element(s) or line(s) affected
- **Issue**: What's wrong
- **WCAG Reference**: The specific success criterion (e.g., 1.1.1, 1.4.3)
- **Suggestion**: How to fix it

### Step 3 — Check Color Contrast

For every text color + background color pair found in the CSS:

1. Extract the computed color values (resolve CSS variables)
2. Calculate the contrast ratio using the [relative luminance formula](./references/wcag-checklist.md#color-contrast-calculation)
3. Compare against thresholds:
   - **Normal text** (< 18pt or < 14pt bold): minimum **4.5:1**
   - **Large text** (≥ 18pt or ≥ 14pt bold): minimum **3:1**
   - **UI components and graphical objects**: minimum **3:1**
4. Report any pairs that fail

### Step 4 — Validate ARIA Usage

Check all ARIA attributes against these rules:
- Every `role` value is a valid WAI-ARIA role
- Required ARIA attributes are present for each role (e.g., `role="slider"` needs `aria-valuenow`)
- No ARIA attribute conflicts with native HTML semantics (e.g., `<button role="link">`)
- `aria-label` or `aria-labelledby` is present where needed
- `aria-hidden="true"` is not on focusable elements
- IDs referenced by `aria-labelledby`, `aria-describedby`, etc. actually exist in the DOM

### Step 5 — Generate the Report

Create the report as a markdown file in `reports/accessibility/` using the [report template](./assets/report-template.md).

**Report filename**: `reports/accessibility/{filename}-audit-{YYYY-MM-DD}.md`

The report must include:
1. **Header** — File audited, date, WCAG version/level targeted
2. **Summary** — Total issues by severity, overall compliance score
3. **Issues Table** — Every finding with severity, WCAG criterion, element, description, and fix suggestion
4. **Color Contrast Results** — Table of color pairs with computed ratios and pass/fail
5. **Checklist Summary** — Full checklist with pass/fail/warning/N/A per criterion
6. **Recommendations** — Prioritized list of fixes (Critical → Major → Minor)

### Step 6 — Present Results

After saving the report file, present a brief summary to the user:
- Total issues found (Critical / Major / Minor / Informational)
- Top 3 most impactful issues to address first
- Path to the full report file
- Remind the user that no changes were made — the report is for review only

## References

- [WCAG Audit Checklist](./references/wcag-checklist.md) — Full list of WCAG 2.1 A/AA criteria with testing procedures
- [Report Template](./assets/report-template.md) — Markdown template for audit reports
