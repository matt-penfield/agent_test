# Microsoft Planner CSV Import Format

This reference documents the exact column headers and value formats required for Microsoft Teams Planner CSV import.

## Required Column Headers

The CSV **must** use these exact column headers on row 1. Planner maps columns by name, so spelling and casing matter.

```
Task Name,Bucket Name,Progress,Priority,Assigned To,Start Date,Due Date,Notes,Checklist Items
```

## Column Specifications

| Column | Required | Max Length | Accepted Values |
|--------|----------|-----------|-----------------|
| **Task Name** | Yes | 255 chars | Free text — the task title shown on the card |
| **Bucket Name** | No | 255 chars | Free text — creates bucket if it doesn't exist. Leave blank for default bucket |
| **Progress** | No | — | `Not started`, `In progress`, `Completed` |
| **Priority** | No | — | `Urgent`, `Important`, `Medium`, `Low` |
| **Assigned To** | No | — | Email address(es), semicolon-separated for multiple. Leave blank if unassigned |
| **Start Date** | No | — | `YYYY-MM-DD` format. Leave blank if not set |
| **Due Date** | No | — | `YYYY-MM-DD` format. Leave blank if not set |
| **Notes** | No | 2048 chars | Free text — appears in the task description/notes area |
| **Checklist Items** | No | — | Semicolon-separated items (`;`). Each becomes a checklist item on the card |

## Value Formats

### Priority Values
Planner only accepts these exact strings (case-insensitive):
- `Urgent` — Red indicator
- `Important` — Orange indicator
- `Medium` — Yellow indicator (default if blank)
- `Low` — No indicator

### Progress Values
- `Not started` — Empty circle
- `In progress` — Half circle
- `Completed` — Filled checkmark

### Multiple Assignees
Separate with semicolons (no spaces after):
```
user1@company.com;user2@company.com
```

### Checklist Items
Separate with semicolons. Each item becomes an unchecked checklist entry:
```
"Design mockup;Get approval;Implement;Test"
```

### Dates
ISO format only: `2026-03-21`

## CSV Encoding Rules

1. **UTF-8 with BOM** — Prepend `\uFEFF` byte order mark for Excel/Planner compatibility
2. **Quote fields containing commas** — Wrap in double quotes: `"Task with, comma"`
3. **Escape internal quotes** — Double them: `"Task with ""quotes"""`
4. **Newlines in fields** — Wrap in double quotes: `"Line 1\nLine 2"`
5. **Line endings** — Use `\r\n` (CRLF) for maximum compatibility

## Example CSV

```csv
Task Name,Bucket Name,Progress,Priority,Assigned To,Start Date,Due Date,Notes,Checklist Items
Set up HTML with M3 tokens,Setup,Not started,Important,,,Scaffold the base HTML file with Material Web imports and design tokens,Create HTML file;Add import map;Set color tokens;Add typography classes
Build personal info form,Build,Not started,Urgent,,,Step 1 of registration flow — collect attendee details,Full name field;Email field;Company field;Job title field;Dietary restrictions field;Form validation
Build session grid,Build,Not started,Urgent,,,Step 2 — timeslot selection grid/table,Create grid layout;Add session data;Toggle selection;Session count display
Build ticket selector,Build,Not started,Important,,,Step 3 — ticket tiers and add-ons,Standard tier card;VIP tier card;Student tier card;Add-on checkboxes;Price calculation
```

## Bucket Naming Convention

Use these standard bucket names for prototyping projects:

| Bucket | Contains |
|--------|----------|
| **Setup** | Initial project scaffolding, file creation, token setup |
| **Design** | Color themes, typography, visual design decisions |
| **Build** | Component implementation, page construction, interactions |
| **QA** | Testing, accessibility, responsive checks, browser testing |

## Import Steps

1. Open Planner board in Microsoft Teams
2. Click **"..."** → **"Import plan from spreadsheet"**
3. Upload the CSV file
4. Planner auto-creates buckets that don't exist
5. Review mapped columns and confirm
6. Tasks appear as cards in their assigned buckets

## Limits

- Max **200 tasks** per single CSV import
- Max **20 checklist items** per task
- Max **11 assignees** per task
- Task names over 255 chars are truncated
- Notes over 2048 chars are truncated
