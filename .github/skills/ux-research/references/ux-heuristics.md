# UX Heuristics Checklist

Evaluate each HTML prototype against these heuristics. For every violation, record the heuristic code, severity, element, location, problem, and recommendation.

## Severity Scale

| Level | Definition |
|-------|-----------|
| **Critical** | Prevents task completion or causes data loss. Must fix before shipping. |
| **Major** | Significant friction that makes the UI hard to use. Should fix. |
| **Minor** | Small usability annoyance; users can work around it. Nice to fix. |
| **Cosmetic** | Visual inconsistency with no functional impact. Fix if time allows. |

---

## H1: Visibility of System Status

The system should keep users informed about what is going on through timely feedback.

Check for:
- [ ] Interactive elements have hover/focus/active states
- [ ] Loading states are communicated (spinners, skeletons, progress bars)
- [ ] Selected/active states are visually distinct (tabs, nav items, filters)
- [ ] Form submission provides confirmation or error feedback
- [ ] Current page/section is indicated in navigation
- [ ] Toggle states (switches, checkboxes) are clearly on vs. off

---

## H2: Match Between System and Real World

Use language and concepts familiar to the user, not system-oriented jargon.

Check for:
- [ ] Button labels describe the action outcome (not "Submit" → "Create Account")
- [ ] Section headings are descriptive and meaningful
- [ ] Icons are universally recognizable or paired with labels
- [ ] Data is displayed in natural formats (dates, currency, units)
- [ ] Terminology is consistent with the target audience's vocabulary
- [ ] Information is ordered logically (most important first)

---

## H3: User Control and Freedom

Users need a clear emergency exit — undo, cancel, back.

Check for:
- [ ] Modals/dialogs have a close button and can be dismissed
- [ ] Multi-step flows have a back/cancel option
- [ ] Destructive actions have a confirmation or undo
- [ ] Navigation allows returning to previous states
- [ ] Filters and selections can be cleared/reset

---

## H4: Consistency and Standards

Follow platform conventions. Same action = same label/icon/placement.

Check for:
- [ ] Typography scale is used consistently (headings, body, labels)
- [ ] Color tokens are applied uniformly (primary, surface, error)
- [ ] Spacing and padding follow a consistent system
- [ ] Button styles are consistent for the same action type
- [ ] Icon sizes and weights are uniform throughout the page
- [ ] Component patterns repeat predictably (cards, list items, chips)
- [ ] Alignment and grid baseline are maintained

---

## H5: Error Prevention

Prevent errors before they happen through design.

Check for:
- [ ] Required form fields are marked
- [ ] Input constraints are communicated (max length, format)
- [ ] Disabled states prevent invalid actions
- [ ] Destructive buttons are visually distinct from safe ones
- [ ] Date/number inputs use appropriate input types

---

## H6: Recognition Rather Than Recall

Minimize memory load — make objects, actions, options visible.

Check for:
- [ ] Navigation labels are always visible (not hidden until hover)
- [ ] Form fields have persistent labels (not placeholder-only)
- [ ] Action buttons are visible without scrolling for key tasks
- [ ] Related information is grouped together
- [ ] Search/filter state is visible (applied filters shown as chips)

---

## H7: Flexibility and Efficiency of Use

Accelerators for expert users that don't impede beginners.

Check for:
- [ ] Touch targets are at least 48×48px (mobile) or 44×44px
- [ ] Clickable areas are large enough (entire card clickable, not just title)
- [ ] Keyboard navigation is supported for main actions
- [ ] Primary action is visually prominent (FAB, filled button)
- [ ] Secondary actions are less prominent (outlined, text buttons)

---

## H8: Aesthetic and Minimalist Design

Every element should serve a purpose. Remove the unnecessary.

Check for:
- [ ] Content has clear visual hierarchy (headings > body > captions)
- [ ] White space is used effectively to separate groups
- [ ] No decorative-only elements that compete with content
- [ ] Text density is manageable (not walls of text)
- [ ] Color is used meaningfully (status, emphasis, grouping — not randomly)
- [ ] Layout is balanced and not overcrowded

---

## H9: Help Users Recognize, Diagnose, and Recover from Errors

Error messages should be clear, specific, and suggest a solution.

Check for:
- [ ] Error states are visually distinct (red/error token, icon)
- [ ] Error messages explain what went wrong and how to fix it
- [ ] Inline validation shows errors near the relevant field
- [ ] Empty states provide guidance (not just blank space)

---

## H10: Help and Documentation

Even if the system is usable without docs, help should be available.

Check for:
- [ ] Tooltips or helper text for complex controls
- [ ] Labels are descriptive enough to not need external help
- [ ] Onboarding hints for first-time flows (if applicable)
- [ ] Information architecture makes content findable

---

## Additional UX Checks

Beyond heuristics, also evaluate:

### Visual Hierarchy
- [ ] The most important element on the page draws the eye first
- [ ] There is a clear reading flow (F-pattern or Z-pattern)
- [ ] CTAs stand out from surrounding content

### Layout & Spacing
- [ ] Content is within a reasonable max-width (readable line length ~60-80 chars)
- [ ] Sections have consistent vertical rhythm
- [ ] Grid alignment is maintained across breakpoints

### Responsive Behavior
- [ ] Layout adapts meaningfully at compact (<600px), medium (600-839px), and expanded (840px+) breakpoints
- [ ] Touch targets don't overlap on small screens
- [ ] Content doesn't overflow or get clipped
- [ ] Navigation pattern is appropriate for the viewport size

### Interaction Design
- [ ] Clickable elements look clickable (cursor, elevation, color)
- [ ] Hover states feel responsive (not delayed)
- [ ] Scroll behavior is smooth and predictable
- [ ] Transitions are fast enough (150-300ms) and purposeful
