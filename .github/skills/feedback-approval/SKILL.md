---
name: feedback-approval
description: '**WORKFLOW SKILL** — Inject a review modal into HTML prototypes for stakeholder feedback and approval. USE FOR: design review; UI approval workflow; prototype feedback; collecting stakeholder input; approve or reject UI changes; review comments; feedback collection overlay; revision requests. DO NOT USE FOR: accessibility auditing (use accessibility-audit skill); creating prototypes (use material-design-prototyping skill); automated testing.'
argument-hint: 'Specify the HTML file to add the review modal to'
---

# Feedback & Approval

Inject a floating review modal into HTML prototype files so stakeholders can approve, reject, or provide written feedback. Submitted feedback is saved as a structured markdown file that the `material-design-prototyping` skill can reference when making revisions.

## When to Use

- A prototype is ready for stakeholder review
- Collecting approve/reject/feedback on a UI change
- Creating a structured revision request for a previously built prototype
- Adding a review overlay to any HTML file before sharing

## Procedure

### Step 1 — Identify the Target File

Determine which HTML file(s) need the review modal:
- If the user specifies a file, use that file
- If unclear, use the currently open `.html` file
- Verify the file exists and is a valid HTML page

### Step 2 — Inject the Review Modal

Read the [feedback modal snippet](./assets/feedback-modal.html) and inject its contents immediately before the closing `</body>` tag of the target HTML file.

The modal provides:
- A floating **"Review"** button (bottom-right corner)
- A modal dialog with three actions: **Approve**, **Reject**, **Provide Feedback**
- A text area that appears when "Provide Feedback" is selected
- A **Submit** button that downloads a structured `.md` feedback file
- A reviewer name input field for attribution

### Step 3 — Inform the Reviewer

Tell the user:
1. Open the HTML file in a browser
2. Click the **"Review"** button in the bottom-right corner
3. Choose an action: Approve, Reject, or Provide Feedback
4. If providing feedback, type comments in the text area
5. Click **Submit** — a markdown file will download automatically
6. Place the downloaded file in the project's `feedback/` directory

### Step 4 — Process Submitted Feedback

When the user provides a feedback file (from the `feedback/` directory), or asks to process feedback:

1. Read the feedback markdown file from `feedback/`
2. Parse the **Status**, **File**, and **Feedback** sections
3. If status is **Approved** — report approval, no changes needed
4. If status is **Rejected** — report rejection and summarize the feedback
5. If status is **Feedback** — summarize the requested changes

The feedback file follows this format (see [feedback template](./assets/feedback-template.md)):
```
Status: approved | rejected | feedback
File: <path to the reviewed HTML file>
Reviewer: <name>
Date: <YYYY-MM-DD>
Feedback: <text>
```

### Step 5 — Hand Off to Prototyping Skill

If the feedback requests UI changes:
1. Summarize the feedback into actionable items
2. Instruct the user to invoke `/material-design-prototyping` with the feedback summary
3. Reference the feedback file path so the prototyping skill can read it directly

**Example handoff:**
> Feedback received for `index.html` — 3 change requests. Invoke:
> `/material-design-prototyping apply changes from feedback/index-feedback-2026-03-21.md`

### Step 6 — Clean Up (Optional)

After feedback is processed and changes are applied:
- Remove the review modal snippet from the target HTML file (delete everything between `<!-- FEEDBACK MODAL START -->` and `<!-- FEEDBACK MODAL END -->`)
- Move the processed feedback file to `feedback/archive/`

## References

- [Feedback Modal Snippet](./assets/feedback-modal.html) — Injectable HTML/CSS/JS review overlay
- [Feedback File Template](./assets/feedback-template.md) — Markdown format for feedback files
