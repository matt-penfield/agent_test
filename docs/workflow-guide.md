# Protogen Workflow Guide

A step-by-step guide to running a UI prototyping project from requirements through delivery using the Copilot skills in this workspace.

---

## Overview

This workspace contains a set of Copilot skills that form an end-to-end UI prototyping pipeline. Each skill is invoked by typing its name in Copilot Chat. Together, they cover the full lifecycle of a prototype:

```
  Define            Build            Ship            Review
┌─────────┐    ┌─────────────┐    ┌──────┐    ┌────────────┐
│   PRD   │ ─► │ Prototyper  │ ─► │ Git  │ ─► │  Feedback  │
│  Skill  │    │   Skill     │    │ Push │    │   Skill    │
└─────────┘    └─────────────┘    └──────┘    └────────────┘
                     ▲                              │
                     └──────── Revise ──────────────┘
```

| Step | Skill | What It Does |
|------|-------|--------------|
| 1 | `/prd` | Interview → structured requirements document |
| 2 | `/material-design-prototyping` | PRD (or freeform prompt) → interactive HTML prototype |
| 3 | Git push | Push changes to deploy a live preview |
| 4 | `/feedback-approval` | Inject review modal → collect approve/reject/feedback |
| 5 | `/material-design-prototyping` | Feed the feedback file back in → apply revisions |

---

## 1. Create a PRD with the PRD Skill

The PRD skill conducts a structured interview to capture everything needed before prototyping begins.

### How to invoke

Type in Copilot Chat:

```
/prd <product or screen name>
```

**Example:**
```
/prd Conference Registration Flow
```

### What happens

Copilot will walk you through **9 groups of questions** covering:

1. **Product overview** — name, description, target users, industry, brand personality
2. **Pages & screens** — what screens are needed and the flow between them
3. **Layout & navigation** — app bar style, nav destinations, search bar
4. **Content & components** — hero sections, content sections, which M3 components to use
5. **Visual design** — brand color, color mood, light/dark mode, typography, density, shape
6. **Interactions** — clickable elements, animations, state variations
7. **Responsive** — target devices and breakpoint behavior
8. **Additional context** — inspiration, constraints, delivery preferences

Answer naturally — you can answer multiple questions at once, say "you decide" for any you're unsure about, or skip items and defaults will be filled in.

### Output

A structured markdown file saved to:

```
prd/<product-name>-prd.md
```

This file is the input for the prototyping skill.

---

## 2. Build a Prototype with the Prototyping Skill

The prototyping skill generates a self-contained HTML file using Material Design 3 and Material Web Components.

### Option A — Prototype from a PRD (recommended)

If you created a PRD in Step 1, reference it:

```
/material-design-prototyping build from prd/my-product-prd.md
```

Copilot will read the PRD and build the prototype with all the requirements already defined — colors, layout, components, interactions, responsive behavior, and content.

### Option B — Prototype without a PRD

You can also describe what you need directly:

```
/material-design-prototyping A dashboard with a sidebar nav, 4 stat cards, and a data table
```

Copilot may ask one clarifying question if details are ambiguous, then proceeds to build.

### Output

A single `.html` file that:
- Opens in any browser with no build step
- Uses Material Web Components via CDN
- Includes M3 color tokens, typography scale, elevation, and shape system
- Is responsive across phone, tablet, and desktop breakpoints
- Contains all CSS inline (no external stylesheets)

---

## 3. Push Changes Live with Git

Once your prototype looks good locally, push to your remote to deploy a live preview (e.g., via Vercel, Netlify, or GitHub Pages).

### First-time setup

If the repo isn't initialized yet:

```bash
git init
git remote add origin <your-repo-url>
```

### Standard push workflow

```bash
git add .
git commit -m "Add conference registration prototype"
git push origin main
```

### If deploying to Vercel

Vercel auto-deploys on every push to `main`. After pushing:
1. Open your Vercel dashboard or check the terminal for the preview URL
2. Share the URL with stakeholders for review

### Tips

- Commit frequently — each prototype version gets its own commit for easy rollback
- Use descriptive commit messages (e.g., "Apply red toolbar from feedback")
- If you have multiple prototypes, push them all — each `.html` file is accessible at its own URL path

---

## 4. Collect Feedback with the Review Tool

The feedback skill injects a floating review modal into any HTML prototype so stakeholders can approve, reject, or leave comments.

### How to invoke

```
/feedback-approval index.html
```

This adds a **"Review"** button to the bottom-right corner of the specified HTML file.

### Reviewer workflow

Share the file (or the deployed URL) with your reviewer and instruct them to:

1. Open the prototype in a browser
2. Click the **"Review"** button (bottom-right corner)
3. Enter their name
4. Choose an action:
   - **Approve** — sign off on the design
   - **Reject** — flag it for rework
   - **Provide Feedback** — type specific comments in the text area
5. Click **Submit** — a `.md` feedback file downloads automatically

Ask the reviewer to place (or send you) the downloaded file. Save it to the `feedback/` folder in the project:

```
feedback/<filename>.md
```

### What the feedback file contains

```markdown
Status: approved | rejected | feedback
File: index.html
Reviewer: Jane Smith
Date: 2026-03-21
Feedback: Change the toolbar color to red. The product cards need more spacing...
```

---

## 5. Apply Feedback to the Prototype

Feedback files are designed to feed directly back into the prototyping skill, creating a revision loop.

### How to invoke

```
/material-design-prototyping apply changes from feedback/index-feedback-2026-03-21.md
```

Or, for a more conversational approach:

```
process feedback from feedback/index-feedback-2026-03-21.md
```

### What happens

1. Copilot reads the feedback file and parses the status, reviewer, and comments
2. If the status is **Approved** — reports approval, no changes needed
3. If the status is **Rejected** or **Feedback** — summarizes the change requests and applies them to the referenced HTML file
4. After changes are applied, push again (Step 3) and repeat the review cycle if needed

### The revision loop

```
Prototype → Push → Review → Feedback File → Revise Prototype → Push → Review → ✓ Approved
```

Continue iterating until the reviewer approves. Each revision is a new commit, so you can always roll back.

---

## Quick Reference

| What you want to do | Command |
|---------------------|---------|
| Start a new project with requirements | `/prd <product name>` |
| Build a prototype from a PRD | `/material-design-prototyping build from prd/<name>-prd.md` |
| Build a prototype from scratch | `/material-design-prototyping <description>` |
| Add review modal to a prototype | `/feedback-approval <file.html>` |
| Apply reviewer feedback | `/material-design-prototyping apply changes from feedback/<file>.md` |
| Run an accessibility audit | `/accessibility-audit <file.html>` |
| Generate a daily report | `/daily-report` |
