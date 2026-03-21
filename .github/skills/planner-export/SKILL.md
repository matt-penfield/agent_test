---
name: planner-export
description: '**WORKFLOW SKILL** — Export tasks from PRD files into a CSV that can be imported directly into Microsoft Teams Planner. USE FOR: planner export; task export; CSV task list; Microsoft Planner import; Teams Planner; project tasks; work breakdown; PRD to tasks; task cards; sprint planning; backlog generation. DO NOT USE FOR: creating PRDs (use prd skill); building prototypes (use material-design-prototyping skill); real-time Planner sync or API integration.'
argument-hint: 'Path to a PRD file or folder to export tasks from'
---

# Planner Export

Parse PRD markdown files and generate a CSV file that Microsoft Teams Planner can import to automatically create task cards.

## When to Use

- Converting a completed PRD into actionable Planner tasks
- Building a project task board from prototype requirements
- Generating a work breakdown structure from PRD sections
- Exporting tasks for sprint planning or backlog grooming

## Prerequisites

Microsoft Teams Planner CSV import requires these exact column headers. See the [CSV format reference](./references/planner-csv-format.md) for details.

## Procedure

### Step 1 — Locate the PRD File

If the user provides a path, use it. Otherwise:
1. Check the `prd/` folder in the workspace root for `*-prd.md` files
2. If multiple PRDs exist, list them and ask the user which one to export
3. Read the full PRD file

### Step 2 — Extract Tasks from the PRD

Parse the PRD and create tasks from these sections:

**From Section 2 (Pages & Screens):**
- One task per page/screen/step: "Build [Step Name] — [Purpose]"
- Set bucket to **"Build"**

**From Section 4 (Content & Components):**
- One task per content section that needs implementation
- One task for each complex component (e.g., session grid, payment form, ticket selector)
- Set bucket to **"Build"**

**From Section 5 (Visual Design):**
- One task for color theme setup
- One task for typography setup (if non-default)
- Set bucket to **"Design"**

**From Section 6 (Interactions & Behavior):**
- One task per interactive element listed
- One task for animations if specified
- Set bucket to **"Build"**

**From Section 7 (Responsive Requirements):**
- One task for responsive implementation
- Set bucket to **"QA"**

**From Section 8 (References & Constraints):**
- One task for constraint validation if constraints exist
- One task for feedback modal injection if requested
- Set bucket to **"QA"**

**Always add these standard tasks:**
- "Set up HTML file with M3 design tokens" — bucket: **"Setup"**
- "Final review and browser testing" — bucket: **"QA"**
- "Accessibility check" — bucket: **"QA"**

### Step 3 — Assign Task Attributes

For each task, determine:

| Field | How to Set |
|-------|-----------|
| **Task Name** | Short, imperative action (max 255 chars) |
| **Bucket Name** | One of: Setup, Design, Build, QA |
| **Progress** | Always `Not started` |
| **Priority** | `Urgent` for primary page tasks, `Important` for standard tasks, `Medium` for nice-to-haves, `Low` for optional items |
| **Assigned To** | Leave blank (user assigns in Planner) |
| **Start Date** | Leave blank |
| **Due Date** | Leave blank |
| **Notes** | Brief context from the PRD (which section, what specifically) |
| **Checklist Items** | Sub-steps separated by semicolons (e.g., for "Build Payment Form": "Card number field; Expiry field; CVC field; Billing address; Order summary") |

### Step 4 — Generate the CSV

1. Load the [CSV format reference](./references/planner-csv-format.md) for exact column headers
2. Build the CSV with headers on row 1
3. Add one row per task
4. Ensure proper CSV escaping: wrap fields containing commas, newlines, or double quotes in double quotes; escape internal double quotes by doubling them (`""`)
5. Use UTF-8 encoding with BOM (`\uFEFF` prefix) for Excel/Planner compatibility

### Step 5 — Save and Deliver

1. Save the CSV to `exports/<product-name-slug>-planner-tasks.csv` in the workspace root
2. Display a summary: total task count, breakdown by bucket, and priority distribution
3. Provide import instructions:

> **To import into Microsoft Teams Planner:**
> 1. Open your Planner board in Microsoft Teams
> 2. Click the **"..."** (more options) menu at the top of the board
> 3. Select **"Import plan from spreadsheet"** (or **"Import"** depending on your version)
> 4. Upload the CSV file
> 5. Map the columns if prompted (they should auto-map with the correct headers)
> 6. Review and confirm the import

### Step 6 — Optional: Export from Other Sources

If the user asks to export tasks from sources other than PRDs:

- **Accessibility audit reports** (`reports/accessibility/`): Parse issue rows into tasks with severity as priority
- **Feedback files** (`feedback/`): Parse action items (`- [ ]` lines) into tasks

Use the same CSV format and bucket naming.

## References

- [Planner CSV Format](./references/planner-csv-format.md) — Exact column headers and value formats for Microsoft Planner import
