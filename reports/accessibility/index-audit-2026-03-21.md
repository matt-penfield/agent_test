# Accessibility Audit Report

**File:** `index.html`
**Date:** 2026-03-21
**Standard:** WCAG 2.1 Level A + AA
**Auditor:** GitHub Copilot (automated)

> **Note:** This report identifies accessibility issues only. No source files were modified.

---

## Summary

| Severity | Count |
|----------|-------|
| Critical | 1 |
| Major | 4 |
| Minor | 6 |
| Informational | 2 |
| **Total** | **13** |

**Compliance Estimate:** 16 of 26 applicable criteria passed (62%)

---

## Issues

### Critical

| # | WCAG | Criterion | Element | Issue | Suggestion |
|---|------|-----------|---------|-------|------------|
| 1 | 1.4.3 | Contrast (Minimum) | `.featured-price .original` at line 416 | Strikethrough price text (`$449`) uses `opacity: 0.5` on `#002117` over `#a4f3d4`, producing an effective contrast ratio of ~3.1:1. Normal text requires 4.5:1. | Remove opacity or increase it to at least 0.75. Alternatively, use a darker explicit color (e.g., `#2a5040`) instead of opacity. |

### Major

| # | WCAG | Criterion | Element | Issue | Suggestion |
|---|------|-----------|---------|-------|------------|
| 2 | 2.4.1 | Bypass Blocks | `<body>` (line 383) | No skip-to-main-content link is present. Screen reader and keyboard users must tab through the entire header and app bar to reach content. | Add a visually hidden skip link as the first child of `<body>`: `<a href="#main" class="skip-link">Skip to main content</a>` |
| 3 | 1.3.1 | Info and Relationships | `<body>` (line 383) | No `<main>` landmark element exists. The page uses `<header>`, `<section>`, and `<footer>` but lacks `<main>`, making landmark navigation incomplete. | Wrap the primary content sections (featured + products) in `<main id="main">`. |
| 4 | 1.1.1 | Non-text Content | Multiple icon `<span>` elements | 30+ decorative icon font elements (`<span class="material-symbols-outlined">`) lack `aria-hidden="true"`. Screen readers will announce the icon text content (e.g., "headphones", "earbuds", "star") as literal words. | Add `aria-hidden="true"` to all decorative icons. For icons that convey meaning (e.g., the star in the featured badge), keep them hidden but ensure adjacent text conveys the information. |
| 5 | 1.4.11 | Non-text Contrast | `.card-rating .material-symbols-outlined` (star icons) | Amber star icon `#f59e0b` on white `#ffffff` has a contrast ratio of ~2.1:1. Non-text graphical objects need 3:1. Impact is mitigated by adjacent numeric rating text. | Use a darker amber (e.g., `#b45309` at ~4.5:1) or add a visible text label like "Rating:" before the number. |

### Minor

| # | WCAG | Criterion | Element | Issue | Suggestion |
|---|------|-----------|---------|-------|------------|
| 6 | 2.4.7 | Focus Visible | All interactive elements | No custom focus styles are defined. Browser defaults are used, which may be invisible on some browsers/themes especially against the light background. | Add explicit `:focus-visible` styles with at least 2px outline in a contrasting color. |
| 7 | 1.4.4 | Resize Text | All typography classes | All font sizes use `px` units. Text won't scale with the user's browser font-size preference (text-only zoom). | Use `rem` units for font sizes (e.g., `font-size: 1rem` instead of `16px`). |
| 8 | 2.4.4 | Link Purpose | `<md-text-button>` "View All" at line 437 | Button text "View All" is generic with no programmatic context for its destination. | Add `aria-label="View all related products"` to the button. |
| 9 | 2.1.1 | Keyboard | `<md-icon-button>`, `<md-filled-button>`, `<md-filter-chip>` | All interactive elements are Material Web Components that require JS to load for keyboard support. If the CDN fails, buttons and chips become inert custom elements with no keyboard handler. | Add `role="button"` and `tabindex="0"` as fallback attributes, or replace with native `<button>` elements for guaranteed keyboard support. |
| 10 | 4.1.2 | Name, Role, Value | `.card-rating` divs in all 12 cards | Star ratings lack semantic markup. There is no `role`, `aria-label`, or structured data indicating these are ratings. | Add `role="img"` and `aria-label="Rating: 4.8 out of 5"` (using actual value) to each `.card-rating` container. |
| 11 | 1.4.12 | Text Spacing | `.card-desc` elements | Card descriptions use `-webkit-line-clamp: 2` with `overflow: hidden`, which will clip text when users apply WCAG-required text spacing adjustments (line-height 1.5×, letter-spacing 0.12em). | Allow flexible height or increase the clamp to accommodate expanded spacing. |

### Informational

| # | Note |
|---|------|
| 1 | Material Web component imports (`@material/web/*`) load from CDN via ES module import maps. If the CDN is unavailable, all interactive elements (buttons, icon buttons, chips) become non-functional custom elements. Consider adding native HTML fallbacks. |
| 2 | This is a single-page prototype. Multi-page criteria (2.4.5 Multiple Ways, 3.2.3 Consistent Navigation, 3.2.4 Consistent Identification) are not applicable and were excluded from scoring. |

---

## Color Contrast Results

| Text Color | Background | Ratio | Threshold | Result | Location |
|------------|------------|-------|-----------|--------|----------|
| `#171d1a` | `#f5fbf6` | 16.7:1 | 4.5:1 | Pass | Body text on background |
| `#002117` | `#a4f3d4` | 13.5:1 | 4.5:1 | Pass | Featured section heading/price on primary-container |
| `#002117` @ 0.85 | `#a4f3d4` | 8.9:1 | 4.5:1 | Pass | Featured description (opacity 0.85) |
| `#002117` @ 0.50 | `#a4f3d4` | 3.1:1 | 4.5:1 | **Fail** | Featured original price (opacity 0.5) — `.featured-price .original` |
| `#404943` | `#f5fbf6` | 8.9:1 | 4.5:1 | Pass | On-surface-variant text on background |
| `#404943` | `#ffffff` | 9.3:1 | 4.5:1 | Pass | Card body text on surface-container-lowest |
| `#1a6b52` | `#f5fbf6` | 6.1:1 | 4.5:1 | Pass | Primary (category labels, brand) on background |
| `#ffffff` | `#1a6b52` | 6.4:1 | 4.5:1 | Pass | On-primary on primary (featured badge) |
| `#ffffff` | `#3d6373` | 6.5:1 | 4.5:1 | Pass | On-tertiary on tertiary (card badges) |
| `#404943` | `#e9efea` | 8.0:1 | 4.5:1 | Pass | Footer text on surface-container |
| `#f59e0b` | `#ffffff` | 2.1:1 | 3:1 (non-text) | **Fail** | Star rating icon on card background |

---

## Checklist Summary

### 1. Perceivable

| Criterion | Level | Status |
|-----------|-------|--------|
| 1.1.1 Non-text Content | A | **Fail** — Decorative icons lack `aria-hidden="true"` |
| 1.2.1 Audio-only and Video-only | A | N/A |
| 1.2.2 Captions | A | N/A |
| 1.2.5 Audio Description | AA | N/A |
| 1.3.1 Info and Relationships | A | **Fail** — Missing `<main>` landmark |
| 1.3.2 Meaningful Sequence | A | Pass |
| 1.3.3 Sensory Characteristics | A | Pass |
| 1.3.4 Orientation | AA | Pass |
| 1.3.5 Identify Input Purpose | AA | N/A |
| 1.4.1 Use of Color | A | Pass |
| 1.4.2 Audio Control | A | N/A |
| 1.4.3 Contrast (Minimum) | AA | **Fail** — Original price has 3.1:1 ratio |
| 1.4.4 Resize Text | AA | Warning — px units won't scale with browser preferences |
| 1.4.5 Images of Text | AA | Pass |
| 1.4.10 Reflow | AA | Pass |
| 1.4.11 Non-text Contrast | AA | **Fail** — Star rating icon 2.1:1 |
| 1.4.12 Text Spacing | AA | Warning — Line-clamped text may clip |
| 1.4.13 Content on Hover or Focus | AA | Pass |

### 2. Operable

| Criterion | Level | Status |
|-----------|-------|--------|
| 2.1.1 Keyboard | A | Warning — Depends on JS loading |
| 2.1.2 No Keyboard Trap | A | Pass |
| 2.1.4 Character Key Shortcuts | A | N/A |
| 2.4.1 Bypass Blocks | A | **Fail** — No skip link or `<main>` |
| 2.4.2 Page Titled | A | Pass |
| 2.4.3 Focus Order | A | Pass |
| 2.4.4 Link Purpose | A | Warning — "View All" is generic |
| 2.4.5 Multiple Ways | AA | N/A |
| 2.4.6 Headings and Labels | AA | Pass |
| 2.4.7 Focus Visible | AA | Warning — No custom focus styles |
| 2.5.1 Pointer Gestures | A | N/A |
| 2.5.2 Pointer Cancellation | A | Pass |
| 2.5.3 Label in Name | A | Pass |
| 2.5.4 Motion Actuation | A | N/A |

### 3. Understandable

| Criterion | Level | Status |
|-----------|-------|--------|
| 3.1.1 Language of Page | A | Pass |
| 3.1.2 Language of Parts | AA | N/A |
| 3.2.1 On Focus | A | Pass |
| 3.2.2 On Input | A | N/A |
| 3.2.3 Consistent Navigation | AA | N/A |
| 3.2.4 Consistent Identification | AA | N/A |
| 3.3.1 Error Identification | A | N/A |
| 3.3.2 Labels or Instructions | A | N/A |
| 3.3.3 Error Suggestion | AA | N/A |
| 3.3.4 Error Prevention | AA | N/A |

### 4. Robust

| Criterion | Level | Status |
|-----------|-------|--------|
| 4.1.1 Parsing | A | Pass |
| 4.1.2 Name, Role, Value | A | Warning — Star ratings lack semantic roles |
| 4.1.3 Status Messages | AA | N/A |

---

## Recommendations (Priority Order)

1. **[Critical]** Fix the featured original price contrast. Replace `opacity: 0.5` with a darker explicit color or increase opacity to at least 0.75. Current ratio: 3.1:1, required: 4.5:1.

2. **[Major]** Add a `<main id="main">` landmark wrapping the featured-section and products-section. Add a visually hidden skip link (`<a href="#main">Skip to main content</a>`) as the first child of `<body>`. This fixes both 2.4.1 and 1.3.1.

3. **[Major]** Add `aria-hidden="true"` to all decorative `<span class="material-symbols-outlined">` icons (product images, stars in ratings, badge icons). This prevents screen readers from announcing raw icon names.

4. **[Major]** Darken the star rating icon color from `#f59e0b` to at least `#b45309` (or similar) to achieve 3:1 non-text contrast on white. Add `role="img"` and `aria-label="Rating: X out of 5"` to each `.card-rating` container.

5. **[Minor]** Add visible `:focus-visible` styles to ensure keyboard focus is always apparent. Add `aria-label="View all related products"` to the "View All" button. Consider migrating from `px` to `rem` for typography.
