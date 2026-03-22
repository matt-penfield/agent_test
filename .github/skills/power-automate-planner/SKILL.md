---
name: power-automate-planner
description: '**WORKFLOW SKILL** — Generate a Power Automate cloud flow and JSON task payload to create Microsoft Teams Planner tasks from PRD files. USE FOR: Power Automate; Planner tasks; Teams Planner; PRD to tasks; task automation; cloud flow; Graph API; sprint board; project planning; work breakdown; backlog; task cards; no CSV import. DO NOT USE FOR: creating PRDs (use prd skill); building prototypes (use material-design-prototyping skill); manual CSV export; feedback collection.'
argument-hint: 'Path to a PRD file, or "setup" to build the Power Automate flow'
---

# Power Automate Planner

Generate a Power Automate cloud flow and a JSON task payload that creates Planner tasks directly from PRD files — no CSV import required.

## When to Use

- Pushing PRD tasks into Microsoft Teams Planner automatically
- The CSV import option is unavailable in your Teams or Planner version
- Setting up a repeatable flow for converting PRDs into Planner boards
- You want tasks created via the Planner Graph API connector, not file upload

## How It Works

This skill produces two things:

1. **Flow definition** — Step-by-step instructions to build a Power Automate cloud flow (one-time setup)
2. **JSON payload** — A task list generated from the PRD, formatted for the flow's input

Once the flow exists, you generate a payload from any PRD and run the flow to push tasks into Planner.

## Procedure

### Step 1 — Determine the Mode

If the user says **"setup"** or this is the first run:
→ Go to **Step 2** (build the flow)

If the user provides a **PRD file path**:
→ Go to **Step 4** (generate the payload)

If unclear, ask:
> "Do you need to set up the Power Automate flow first, or generate a task payload from a PRD?"

### Step 2 — Guide Flow Creation

Walk the user through building the cloud flow. Load the [flow schema reference](./references/flow-schema.md) for the JSON structure and field mappings.

**Give the user these instructions:**

1. Open [Power Automate](https://make.powerautomate.com) → **+ Create** → **Instant cloud flow**
2. Name it **"PRD to Planner Tasks"**
3. Trigger: **Manually trigger a flow** with one Text input named `taskPayload`

**Actions to add in order:**

4. **Parse JSON** — Content: `@triggerBody()['text']`, Schema: from [flow-schema.md](./references/flow-schema.md)
5. **Initialize variable** — Name: `bucketMap`, Type: Object, Value: `{}`
6. **Apply to each** — Over: `@body('Parse_JSON')?['tasks']`

   Inside the loop:

   a. **Condition** — bucket name exists in `bucketMap`?
   b. **If no** → **Planner: Create a bucket** (Plan ID from payload, Name from current task)
   b2. **Compose** (`Compose_NewBucketMap`) — Expression: `addProperty(variables('bucketMap'), items('Apply_to_each')?['bucketName'], outputs('Create_a_bucket')?['body/id'])`
   b3. **Set variable** `bucketMap` → value: output of Compose above
   c. **Planner: Create a task** — Plan ID, Bucket ID (from `bucketMap`), Title, Priority
   d. **Planner: Update task details** — Task ID from step c, Description from `notes`
   e. **Apply to each (nested)** over `checklistItems` → **Update task details** to add each checklist entry

7. **Save** the flow

Reference the [flow template](./assets/flow-template.json) for the complete action structure.

### Step 3 — Collect Planner IDs

Ask the user for their Plan ID:

> **To find your Plan ID:**
> 1. Open your Planner board in Teams or at [tasks.office.com](https://tasks.office.com)
> 2. Look at the URL — the Plan ID is the value after `planId=`
> 3. Copy and paste it here

Store the Plan ID for the payload.

### Step 4 — Locate and Parse the PRD

1. If the user provides a path, read that file
2. Otherwise check `prd/` for `*-prd.md` files
3. If multiple exist, list them and ask which one
4. Read the full PRD

### Step 5 — Extract Tasks from the PRD

Parse each PRD section into tasks:

| PRD Section | Task Type | Bucket |
|-------------|-----------|--------|
| Section 2 — Pages & Screens | One task per page/screen/step | Build |
| Section 4 — Content & Components | One task per content section or complex component | Build |
| Section 5 — Visual Design | Color theme setup, typography setup | Design |
| Section 6 — Interactions | One task per interactive element | Build |
| Section 7 — Responsive | Responsive implementation | QA |
| Section 8 — Constraints | Constraint validation, feedback modal | QA |

**Always add these standard tasks:**
- "Set up HTML file with M3 design tokens" → **Setup**
- "Final review and browser testing" → **QA**
- "Accessibility check" → **QA**

**Priority mapping** (Graph API integers):
- `5` = Urgent — primary page tasks
- `3` = Important — standard tasks
- `2` = Medium — nice-to-haves
- `1` = Low — optional items

### Step 6 — Generate the JSON Payload

Build a JSON object matching the [flow schema](./references/flow-schema.md):

```json
{
  "planId": "<user's plan ID>",
  "tasks": [
    {
      "title": "Task name",
      "bucketName": "Build",
      "priority": 3,
      "notes": "Context from the PRD",
      "checklistItems": ["Sub-step 1", "Sub-step 2"]
    }
  ]
}
```

Save to: `exports/<product-name-slug>-planner-payload.json`

If no Plan ID was provided, use a placeholder and note it:
```json
"planId": "REPLACE_WITH_YOUR_PLAN_ID"
```

### Step 7 — Deliver

Present a summary:
- Total task count and breakdown by bucket
- Priority distribution
- File location

Provide run instructions:

> **To push tasks to Planner:**
> 1. Open [Power Automate](https://make.powerautomate.com)
> 2. Find **"PRD to Planner Tasks"** and click **Run**
> 3. Paste the contents of the JSON file into the `taskPayload` input
> 4. Click **Run flow**
> 5. Tasks will appear in your Planner board within seconds

## References

- [Flow Schema](./references/flow-schema.md) — JSON payload schema and Planner Graph API field mappings
- [Flow Template](./assets/flow-template.json) — Power Automate action structure for reference
