# Product Requirements Document

> **Product:** Apex Connect
> **Date:** 2026-03-21
> **Author:** Matt Penfield
> **Status:** Draft

---

## 1. Product Overview

| Field | Value |
|-------|-------|
| **Product Name** | Apex Connect |
| **Description** | Sign up to attend Apex today |
| **Target Users** | UX research professionals |
| **Industry / Domain** | Tech conference |
| **Brand Personality** | Minimal, bold |

---

## 2. Pages & Screens

### Page Map

| # | Page Name | Priority | Description |
|---|-----------|----------|-------------|
| 1 | Registration Flow | Primary | Single-page multistep registration with 5 steps rendered in one HTML file |

### Steps Within the Flow

| Step | Name | Purpose |
|------|------|---------|
| 1 | Personal Info | Collect attendee name, email, company, job title, dietary restrictions |
| 2 | Session Selection | Timeslot grid/table for choosing conference sessions |
| 3 | Ticket & Add-ons | Select ticket tier and optional add-ons |
| 4 | Payment | Credit card payment form |
| 5 | Confirmation | Success message, registration summary, "Add to Calendar" CTA |

### User Flows

Step 1 → Step 2 → Step 3 → Step 4 → Step 5 (linear, sequential with Next/Back navigation)

No splash page. The flow starts directly at Step 1.

---

## 3. Layout & Navigation

### Primary Layout Pattern

**Pattern:** Minimal top app bar (branding only) + centered content card with horizontal stepper/progress indicator + Next/Back buttons at bottom of each step

### Navigation Destinations

No global navigation destinations. The top app bar contains only the "Apex Connect" brand name.

### Search

**Search bar:** No

---

## 4. Content & Components

### Step 1 — Personal Info

#### Content

| Field | Type | Required |
|-------|------|----------|
| Full Name | Text field | Yes |
| Email | Text field (email) | Yes |
| Company / Organization | Text field | Yes |
| Job Title | Text field | Yes |
| Dietary Restrictions | Text field | No |

#### Components Used

Filled text fields, filled button (Next), dividers

---

### Step 2 — Session Selection

#### Content

Timeslot grid/table showing conference sessions across time slots and tracks. Attendees click cells to select sessions. Use placeholder session data (e.g., "Research Methods Workshop", "Design Systems Deep Dive", "AI in UX Research", "Participant Recruiting Strategies").

#### Components Used

Table/grid (CSS), checkboxes or selectable cells, filled button (Next), outlined button (Back)

---

### Step 3 — Ticket & Add-ons

#### Content

**Ticket Tiers (placeholder):**

| Tier | Price | Includes |
|------|-------|----------|
| Standard | $299 | General admission, all keynotes, lunch |
| VIP | $599 | Standard + front-row seating, networking dinner, speaker meet & greet |
| Student | $99 | General admission, all keynotes |

**Add-ons (placeholder):**

| Add-on | Price |
|--------|-------|
| Workshop Pass | $79 |
| Networking Dinner (extra guest) | $49 |
| Conference T-shirt | $25 |

#### Components Used

Cards (radio-style selection for tiers), checkboxes (add-ons), filled button (Next), outlined button (Back), dividers

---

### Step 4 — Payment

#### Content

Standard credit card payment form:

| Field | Type | Required |
|-------|------|----------|
| Card Number | Text field | Yes |
| Expiration Date | Text field | Yes |
| CVC | Text field | Yes |
| Cardholder Name | Text field | Yes |
| Billing Address | Text field | Yes |
| City | Text field | Yes |
| State | Text field | Yes |
| ZIP Code | Text field | Yes |

Order summary sidebar/section showing selected ticket, add-ons, and total.

#### Components Used

Filled text fields, cards (order summary), filled button ("Pay Now"), outlined button (Back), dividers

---

### Step 5 — Confirmation

#### Content

- Success icon/checkmark
- "Registration Complete!" headline
- Summary of registration details (name, email, ticket tier, selected sessions, total paid)
- "Add to Calendar" button

No other CTAs.

#### Components Used

Cards (summary), filled button ("Add to Calendar"), dividers, icon (check_circle)

---

### Required M3 Components (All Steps)

- [x] Cards
- [x] Filled Button
- [x] Outlined Button
- [ ] Text Button
- [ ] FAB
- [x] Text Fields
- [ ] Filter Chips
- [ ] Lists
- [ ] Tabs
- [ ] Dialogs
- [x] Tables
- [ ] Switches
- [x] Checkboxes
- [x] Icon Buttons
- [ ] Menus
- [ ] Bottom Sheet
- [x] Dividers
- [ ] Navigation Bar

### Data & Content

**Content source:** Placeholder throughout

### Icons

**Icon set:** Material Symbols Outlined (default). No specific custom icons beyond defaults (stepper checkmarks, navigation arrows, check_circle for confirmation).

---

## 5. Visual Design

### Color

| Token | Value | Notes |
|-------|-------|-------|
| **Primary brand color** | Blue | Derive M3 tonal palette from a blue base (e.g., `#1565c0` or similar) |
| **Color mood** | Neutral | Clean, professional, not overly saturated |
| **Theme mode** | Light | Light theme only |

### Typography

| Setting | Value |
|---------|-------|
| **Primary font** | Roboto |
| **Display font** | Roboto |

### Density & Shape

| Setting | Value |
|---------|-------|
| **Density** | Spacious — generous padding, breathing room between elements |
| **Shape** | Rounded (M3 default) |

---

## 6. Interactions & Behavior

### Interactive Elements

| Element | Behavior |
|---------|----------|
| Horizontal stepper | Shows current step, completed steps get checkmark, clickable to go back to completed steps |
| Next button | Validates current step, advances to next step with transition |
| Back button | Returns to previous step |
| Session timeslot cells | Clickable to toggle selection (highlighted when selected) |
| Ticket tier cards | Radio-style selection — clicking one deselects others |
| Add-on checkboxes | Toggle on/off independently |
| Form text fields | Accept input, show validation errors on required fields when empty |
| Pay Now button | Validates payment form, advances to confirmation |
| Add to Calendar button | Clickable (prototype — no real calendar integration needed) |

### Animations

- Simple fade/slide transitions between steps
- Hover effects on buttons, cards, and selectable table cells
- Quick transition on stepper state changes

### State Variations

- [ ] Empty state
- [ ] Loading state
- [x] Error state (form validation — red outlines + error text on required fields)
- [x] Success state (Step 5 confirmation)

---

## 7. Responsive Requirements

| Setting | Value |
|---------|-------|
| **Approach** | Both equally (mobile + desktop) |

### Breakpoint Behavior

| Breakpoint | Grid | Navigation | Notable Changes |
|------------|------|------------|-----------------|
| Desktop (840px+) | Centered card, max-width ~720px | Horizontal stepper with labels | Full timeslot grid, side-by-side payment + summary |
| Tablet (600-839px) | Centered card, wider padding | Stepper with abbreviated labels | Timeslot grid may scroll horizontally |
| Mobile (<600px) | Full-width card | Stepper shows step numbers only (no labels) | Timeslot grid stacks or scrolls, payment fields stack vertically, summary above form |

### Hidden on Mobile

Nothing hidden — all content accessible on all breakpoints.

---

## 8. References & Constraints

### Inspiration

Clean M3 conventions — no specific reference sites.

### Constraints

None specified.

### Delivery

| Setting | Value |
|---------|-------|
| **Output format** | Single HTML file |
| **Include feedback modal** | Yes |

---

## Prototyping Prompt

> **Prompt:** Create a multistep conference registration flow for Apex Connect. Sign up to attend Apex today.
>
> **Layout:** Minimal top app bar (branding only) + centered content card with horizontal stepper. 5 steps: Personal Info → Session Selection → Ticket & Add-ons → Payment → Confirmation.
>
> **Step 1 — Personal Info:** Text fields for full name, email, company, job title, dietary restrictions. Validation on required fields.
>
> **Step 2 — Session Selection:** Timeslot grid/table with placeholder sessions (Research Methods Workshop, Design Systems Deep Dive, AI in UX Research, Participant Recruiting Strategies). Clickable cells toggle selection.
>
> **Step 3 — Ticket & Add-ons:** Three ticket tiers (Standard $299, VIP $599, Student $99) as radio-style cards. Add-ons with checkboxes (Workshop Pass $79, Networking Dinner $49, T-shirt $25).
>
> **Step 4 — Payment:** Full card payment form (card number, expiry, CVC, name, billing address). Order summary showing selections and total.
>
> **Step 5 — Confirmation:** Success checkmark, "Registration Complete!" headline, summary of all details, "Add to Calendar" button only.
>
> **Color:** Blue primary, neutral mood, light theme. Derive M3 tonal palette from blue.
>
> **Typography:** Roboto. Density: spacious. Shape: rounded (M3 default).
>
> **Responsive:** Both mobile + desktop equally. Stepper collapses to numbers on mobile, timeslot grid scrolls, fields stack vertically.
>
> **Interactions:** Fully functional stepper navigation, form validation errors, session/ticket selection, simple fade/slide transitions.
>
> **Content:** Placeholder throughout.
>
> **Include feedback review modal.**
