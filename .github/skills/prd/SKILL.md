---
name: prd
description: '**WORKFLOW SKILL** — Interview the user to gather product requirements and generate a structured PRD markdown file for UI prototyping. USE FOR: product requirements document; PRD; requirements gathering; design brief; prototype requirements; interview; stakeholder requirements; project kickoff; screen definition; page spec; feature spec; prototyping input; material design requirements. DO NOT USE FOR: building prototypes (use material-design-prototyping skill); accessibility auditing; feedback collection.'
argument-hint: 'Name or brief description of the product/screen to define requirements for'
---

# Product Requirements Document

Conduct a structured interview to collect all information needed to generate a complete PRD markdown file. The PRD output is designed to feed directly into the material-design-prototyping skill as a prompt.

## When to Use

- Kicking off a new prototype and need to gather requirements first
- Defining a screen, page, or multi-page product before prototyping
- Translating a rough idea into a structured design brief
- Generating a reusable requirements doc that multiple prototypes can reference

## Procedure

### Step 1 — Start the Interview

Greet the user and explain the process:
> "I'll walk you through a series of questions to build a complete product requirements document. This PRD will contain everything needed to generate prototyping prompts. Let's start."

If the user provided a product name or description in their argument, use it as context and skip questions already answered.

### Step 2 — Product Overview (ask all at once)

Ask these questions as a numbered group. The user can answer inline or skip items:

1. **Product name** — What is the product or project called?
2. **One-line description** — What does this product do in one sentence?
3. **Target users** — Who are the primary users? (e.g., consumers, admins, enterprise, internal team)
4. **Industry / domain** — What category? (e.g., e-commerce, SaaS dashboard, healthcare portal, media)
5. **Brand personality** — Pick 2-3 adjectives (e.g., modern, playful, professional, bold, minimal)

Wait for answers before proceeding.

### Step 3 — Pages & Screens

Ask:

1. **What pages or screens are needed?** List them (e.g., homepage, product detail, checkout, dashboard, settings, login).
2. **Which is the primary page?** The one to prototype first.
3. **Are there flows between pages?** (e.g., homepage → product → cart → checkout)

If the user only needs a single page, note that and skip flow questions.

### Step 4 — Layout & Navigation

For each page (or the primary page), ask:

1. **Layout pattern** — Which fits best?
   - Top app bar + scrolling body (most common)
   - Navigation rail + body (desktop dashboard)
   - Navigation drawer + body (complex multi-section app)
   - Bottom navigation + body (mobile-first)
   - Full-width hero + content sections (landing page)
2. **Navigation items** — What are the main navigation destinations? (e.g., Home, Products, About, Cart, Account)
3. **Do you need a search bar?** (yes / no / prominent)

### Step 5 — Content & Components

For each page, ask:

1. **Hero / featured section** — Is there a hero area? What content? (headline, description, CTA, image placeholder)
2. **Content sections** — List the sections on the page (e.g., featured products, testimonials, pricing table, form, stats)
3. **Key components** — Which M3 components do you need?
   - Cards, Buttons, FAB, Text fields, Chips, Lists, Tabs, Dialogs, Tables, Switches, Checkboxes, Menus, Bottom sheets
4. **Data / content** — Should I use placeholder data or do you have specific content? (product names, prices, descriptions, etc.)
5. **Icons** — Any specific icons needed? (Material Symbols will be used by default)

### Step 6 — Visual Design

Ask:

1. **Brand color** — Do you have a primary brand color? (hex code, color name, or "pick one for me")
2. **Color mood** — Warm, cool, neutral, vibrant, muted?
3. **Light / dark / both** — Which theme mode?
4. **Typography preference** — Default Roboto, or a specific Google Font?
5. **Density** — Spacious (more padding, larger elements) or compact (dense, data-heavy)?
6. **Shape preference** — Rounded (M3 default), sharp corners, or pill-shaped?

### Step 7 — Interactions & Behavior

Ask:

1. **Interactive elements** — What should be clickable or functional? (e.g., filter chips toggle, dialog opens on button click, tabs switch content)
2. **Animations** — Any hover effects, transitions, or scroll animations?
3. **State variations** — Do you need empty states, loading states, or error states?

### Step 8 — Responsive Requirements

Ask:

1. **Target devices** — Desktop-first, mobile-first, or both equally?
2. **Breakpoint behavior** — What changes at smaller sizes? (e.g., grid goes from 4 columns to 2, nav collapses to hamburger)
3. **Must any content hide on mobile?** (e.g., sidebar, secondary actions)

### Step 9 — Additional Context

Ask:

1. **Inspiration or reference** — Any existing sites, apps, or screenshots to reference?
2. **Constraints** — Anything to avoid? (e.g., no carousels, no dark patterns, must match existing brand guide)
3. **Delivery notes** — Single HTML file? Multiple linked pages? Should the feedback modal be included?

### Step 10 — Generate the PRD

Once all questions are answered:

1. Load the [PRD template](./assets/prd-template.md)
2. Fill in every section with the user's answers
3. For any unanswered questions, insert sensible defaults and mark them with `<!-- DEFAULT — confirm with stakeholder -->`
4. Save the PRD as `prd/<product-name-slug>-prd.md` in the workspace root
5. Present a summary of the PRD to the user and ask for any final changes
6. After approval, tell the user they can invoke the material-design-prototyping skill with the PRD file as context:
   > "To prototype from this PRD, use: `/material-design-prototyping` and reference the PRD file."

## Interview Tips

- **Batch questions** — Ask a full step's questions at once, don't drip-feed one at a time
- **Use their context** — If the user already described things in their argument or earlier messages, pre-fill and confirm rather than re-asking
- **Offer examples** — When a user seems unsure, provide 2-3 concrete options to choose from
- **Keep it moving** — If the user says "you decide" or "default", pick a reasonable option and note it
- **Summarize before generating** — Before Step 10, give a quick recap of key decisions

## References

- [PRD Template](./assets/prd-template.md) — Structured markdown template for the output document
