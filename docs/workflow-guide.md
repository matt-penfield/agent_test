# Protogen Workflow Guide

A step-by-step guide to running a UI prototyping project from requirements through delivery using the Copilot skills in this workspace.

---

## Overview

This workspace contains a set of Copilot skills that form an end-to-end UI prototyping pipeline. Each skill is invoked by typing its name in Copilot Chat. Together, they cover the full lifecycle of a prototype:

```
  Define           Plan             Build            Ship            Review
┌─────────┐    ┌─────────┐    ┌─────────────┐    ┌──────┐    ┌────────────┐
│   PRD   │ ─► │ Planner │ ─► │ Prototyper  │ ─► │ Git  │ ─► │  Feedback  │
│  Skill  │    │  Export │    │   Skill     │    │ Push │    │   Skill    │
└─────────┘    └─────────┘    └─────────────┘    └──────┘    └────────────┘
                                    ▲                              │
                                    └──────── Revise ──────────────┘
```

| Step | Skill | What It Does |
|------|-------|--------------|
| 1 | `/prd` | Interview → structured requirements document |
| 2 | `/planner-export` | PRD → importable CSV for Microsoft Teams Planner |
| 3 | `/material-design-prototyping` | PRD (or freeform prompt) → interactive HTML prototype |
| 4 | Git push | Push changes to deploy a live preview |
| 5 | `/feedback-approval` | Inject review modal → collect approve/reject/feedback |
| 6 | `/material-design-prototyping` | Feed the feedback file back in → apply revisions |

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

This file is the input for both the planner export skill and the prototyping skill.

---

## 2. Create a Project Plan from the PRD

The planner export skill converts a PRD into a structured CSV that can be imported into Microsoft Teams Planner to auto-create task cards with buckets, priorities, and checklists. Running this right after the PRD gives your team a task board to track progress before building begins.

### How to invoke

```
/planner-export prd/my-product-prd.md
```

### Output

A CSV file saved to:

```
exports/<product-name>-planner-tasks.csv
```

Tasks are organized into **4 buckets**:

| Bucket | What Goes Here |
|--------|---------------|
| **Setup** | Project scaffolding, M3 token configuration |
| **Design** | Color theme, typography, visual design decisions |
| **Build** | Each page/screen, content sections, components, interactions |
| **QA** | Responsive testing, accessibility checks, browser testing, constraint validation |

Each task row includes:
- **Task Name** — short, imperative description
- **Priority** — Urgent / Important / Medium / Low
- **Notes** — context from the PRD
- **Checklist Items** — sub-steps broken out for tracking

### Importing into Microsoft Teams Planner

1. Open your Planner board in Microsoft Teams (or at [tasks.office.com](https://tasks.office.com))
2. Click the **"..."** menu at the top of the board
3. Select **"Import plan"** or **"Import from Excel/CSV"**
   - _If you don't see this option_: try the web version at [tasks.office.com](https://tasks.office.com) — the import feature may not be available in all Teams client versions or license tiers
4. Upload the CSV file from `exports/`
5. Planner will auto-create the buckets and populate all task cards
6. Assign team members and set dates as needed

With the plan in place, your team knows exactly what needs to be built. Now move on to prototyping.

---

## 3. Build a Prototype with the Prototyping Skill

The prototyping skill generates a self-contained HTML file using Material Design 3 and Material Web Components.

### Option A — Prototype from a PRD (recommended)

If you created a PRD in Steps 1–2, reference it:

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

## 4. Push Changes Live with Git

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

## 5. Collect Feedback with the Review Tool

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

## 6. Apply Feedback to the Prototype

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
4. After changes are applied, push again (Step 4) and repeat the review cycle if needed

### The revision loop

```
Prototype → Push → Review → Feedback File → Revise Prototype → Push → Review → ✓ Approved
```

As you complete tasks during revision cycles, update their status in your Planner board from Step 2.

Continue iterating until the reviewer approves. Each revision is a new commit, so you can always roll back.

---

## Quick Reference

| What you want to do | Command |
|---------------------|---------|
| Start a new project with requirements | `/prd <product name>` |
| Export tasks to Planner | `/planner-export prd/<name>-prd.md` |
| Build a prototype from a PRD | `/material-design-prototyping build from prd/<name>-prd.md` |
| Build a prototype from scratch | `/material-design-prototyping <description>` |
| Add review modal to a prototype | `/feedback-approval <file.html>` |
| Apply reviewer feedback | `/material-design-prototyping apply changes from feedback/<file>.md` |
| Run an accessibility audit | `/accessibility-audit <file.html>` |
| Generate a daily report | `/daily-report` |
