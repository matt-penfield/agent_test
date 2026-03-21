# WCAG 2.1 Level A & AA Audit Checklist

Use this checklist to evaluate HTML files. For each criterion, determine Pass / Fail / Warning / N/A.

---

## 1. Perceivable

### 1.1 Text Alternatives

#### 1.1.1 Non-text Content (Level A)
- [ ] All `<img>` elements have meaningful `alt` attributes
- [ ] Decorative images use `alt=""` or `role="presentation"`
- [ ] `<svg>` elements have `<title>` or `aria-label`
- [ ] Icon fonts or icon components have accessible text (visually hidden text or `aria-label`)
- [ ] `<input type="image">` has `alt` attribute
- [ ] `<area>` elements in image maps have `alt` attributes
- [ ] `<canvas>` has fallback text content
- [ ] Background images conveying meaning have text alternatives

**How to test:** Search for all `<img>`, `<svg>`, `<canvas>`, icon elements. Verify each has a text alternative or is marked decorative.

### 1.2 Time-based Media

#### 1.2.1 Audio-only and Video-only (Level A)
- [ ] Pre-recorded audio has a text transcript
- [ ] Pre-recorded video-only has a text or audio alternative

#### 1.2.2 Captions (Level A)
- [ ] Pre-recorded video with audio has captions

#### 1.2.5 Audio Description (Level AA)
- [ ] Pre-recorded video has audio description

**How to test:** Search for `<audio>`, `<video>`, `<iframe>` (embedded media). Verify captions/transcripts exist.

### 1.3 Adaptable

#### 1.3.1 Info and Relationships (Level A)
- [ ] Headings use proper `<h1>`–`<h6>` tags (not styled `<div>`/`<p>`)
- [ ] Lists use `<ul>`, `<ol>`, `<dl>` (not plain text with dashes)
- [ ] Tables have `<th>` with `scope` attributes
- [ ] Form inputs have associated `<label>` elements (via `for`/`id` or wrapping)
- [ ] Landmark regions use `<header>`, `<nav>`, `<main>`, `<footer>`, `<aside>`, or ARIA landmarks
- [ ] Related form fields use `<fieldset>` and `<legend>`

**How to test:** Check that visual structure matches semantic markup. Look for headings, lists, tables, and forms.

#### 1.3.2 Meaningful Sequence (Level A)
- [ ] DOM order matches visual reading order
- [ ] CSS does not reorder content in a way that changes meaning

#### 1.3.3 Sensory Characteristics (Level A)
- [ ] Instructions don't rely solely on shape, size, location, or color ("click the red button")

#### 1.3.4 Orientation (Level AA)
- [ ] Content is not restricted to a single display orientation

#### 1.3.5 Identify Input Purpose (Level AA)
- [ ] Input fields for personal data use `autocomplete` attributes with correct tokens

**How to test:** Check `<input>` fields for name, email, phone, address, etc. Verify `autocomplete` attribute is present.

### 1.4 Distinguishable

#### 1.4.1 Use of Color (Level A)
- [ ] Color is not the only means of conveying information
- [ ] Links in text are distinguishable beyond just color (underline, bold, icon)
- [ ] Form errors are not indicated only by color

**How to test:** Mentally desaturate the page. Can you still understand all information?

#### 1.4.2 Audio Control (Level A)
- [ ] Auto-playing audio lasting > 3 seconds can be paused/stopped or volume controlled

#### 1.4.3 Contrast (Minimum) (Level AA)
- [ ] Normal text: contrast ratio ≥ **4.5:1**
- [ ] Large text (≥ 18pt or ≥ 14pt bold): contrast ratio ≥ **3:1**
- [ ] Disabled and decorative text are exempt

<a name="color-contrast-calculation"></a>
**Color Contrast Calculation:**

1. Convert hex/RGB to sRGB (divide by 255)
2. Apply linearization: if C ≤ 0.04045 → C/12.92; else → ((C + 0.055)/1.055)^2.4
3. Relative luminance: L = 0.2126 × R + 0.7152 × G + 0.0722 × B
4. Contrast ratio = (L_lighter + 0.05) / (L_darker + 0.05)

**Common checks:**
| Text Color | Background | Ratio | Pass (Normal) | Pass (Large) |
|------------|------------|-------|---------------|--------------|
| Compute from CSS | Compute from CSS | Calculate | ≥ 4.5:1 | ≥ 3:1 |

#### 1.4.4 Resize Text (Level AA)
- [ ] Text can be resized up to 200% without loss of content or functionality

#### 1.4.5 Images of Text (Level AA)
- [ ] Text is rendered as actual text, not images of text (except logos)

#### 1.4.10 Reflow (Level AA)
- [ ] Content reflows at 320px width without horizontal scrolling
- [ ] No two-dimensional scrolling for vertical content

#### 1.4.11 Non-text Contrast (Level AA)
- [ ] UI components (borders, focus indicators) have ≥ **3:1** contrast against adjacent colors
- [ ] Graphical objects needed to understand content have ≥ **3:1** contrast

#### 1.4.12 Text Spacing (Level AA)
- [ ] No content loss when: line-height 1.5×, paragraph spacing 2×, letter-spacing 0.12em, word-spacing 0.16em

#### 1.4.13 Content on Hover or Focus (Level AA)
- [ ] Hover/focus-triggered content is dismissible, hoverable, and persistent

---

## 2. Operable

### 2.1 Keyboard Accessible

#### 2.1.1 Keyboard (Level A)
- [ ] All interactive elements are reachable via Tab key
- [ ] All actions can be triggered via Enter or Space
- [ ] Custom controls have appropriate keyboard handlers
- [ ] No functionality requires specific device (mouse-only, touch-only)

**How to test:** Tab through the entire page. Verify every interactive element receives focus and can be activated.

#### 2.1.2 No Keyboard Trap (Level A)
- [ ] Focus can be moved away from every component using keyboard alone
- [ ] Modal dialogs trap focus correctly and release on close

#### 2.1.4 Character Key Shortcuts (Level A)
- [ ] Single-character keyboard shortcuts can be turned off or remapped

### 2.4 Navigable

#### 2.4.1 Bypass Blocks (Level A)
- [ ] Skip-to-content link is present (or ARIA landmarks provide equivalent)
- [ ] Repeated navigation blocks can be bypassed

**How to test:** Check for a "skip to main content" link as the first focusable element, or verify landmarks exist.

#### 2.4.2 Page Titled (Level A)
- [ ] `<title>` element exists and is descriptive

#### 2.4.3 Focus Order (Level A)
- [ ] Tab order follows logical reading order
- [ ] `tabindex` values > 0 are not used (disrupts natural order)
- [ ] Dynamically shown content receives focus appropriately

#### 2.4.4 Link Purpose (Level A)
- [ ] Link text describes the destination (no "click here", "read more" without context)
- [ ] If link text is generic, `aria-label` or `aria-labelledby` provides context

#### 2.4.5 Multiple Ways (Level AA)
- [ ] Multiple ways to find pages (navigation, search, sitemap)

#### 2.4.6 Headings and Labels (Level AA)
- [ ] Headings describe the content they introduce
- [ ] Form labels clearly describe expected input

#### 2.4.7 Focus Visible (Level AA)
- [ ] Keyboard focus indicator is visible on all interactive elements
- [ ] `outline: none` or `outline: 0` is not used without a replacement style
- [ ] Focus styles have sufficient contrast

**How to test:** Tab through the page and verify every focused element has a visible indicator.

### 2.5 Input Modalities

#### 2.5.1 Pointer Gestures (Level A)
- [ ] Multi-point or path-based gestures have single-pointer alternatives

#### 2.5.2 Pointer Cancellation (Level A)
- [ ] Actions trigger on `mouseup`/`click`, not `mousedown` (allowing cancellation)

#### 2.5.3 Label in Name (Level A)
- [ ] Visible label text is included in the accessible name
- [ ] `aria-label` starts with or contains the visible text

#### 2.5.4 Motion Actuation (Level A)
- [ ] Device motion actions (shake, tilt) have UI alternatives

---

## 3. Understandable

### 3.1 Readable

#### 3.1.1 Language of Page (Level A)
- [ ] `<html>` element has a valid `lang` attribute (e.g., `lang="en"`)

**How to test:** Check the opening `<html>` tag.

#### 3.1.2 Language of Parts (Level AA)
- [ ] Content in other languages uses `lang` attribute on the containing element

### 3.2 Predictable

#### 3.2.1 On Focus (Level A)
- [ ] Receiving focus does not trigger unexpected context changes

#### 3.2.2 On Input (Level A)
- [ ] Changing a form input does not automatically submit or navigate

#### 3.2.3 Consistent Navigation (Level AA)
- [ ] Navigation menus are in the same order across pages

#### 3.2.4 Consistent Identification (Level AA)
- [ ] Components with the same function have the same label across pages

### 3.3 Input Assistance

#### 3.3.1 Error Identification (Level A)
- [ ] Form errors are identified in text (not just color)
- [ ] Error messages describe what went wrong

#### 3.3.2 Labels or Instructions (Level A)
- [ ] Required fields are indicated (not just by color)
- [ ] Input format hints are provided (e.g., "MM/DD/YYYY")

#### 3.3.3 Error Suggestion (Level AA)
- [ ] Error messages suggest how to fix the problem

#### 3.3.4 Error Prevention — Legal, Financial, Data (Level AA)
- [ ] Submissions are reversible, checked, or confirmed

---

## 4. Robust

### 4.1 Compatible

#### 4.1.1 Parsing (Level A)
- [ ] HTML has no duplicate `id` attributes
- [ ] HTML elements are properly nested and closed
- [ ] No duplicate attributes on the same element

**How to test:** Scan for duplicate `id` values across the document.

#### 4.1.2 Name, Role, Value (Level A)
- [ ] Custom controls have appropriate ARIA roles
- [ ] Interactive elements have accessible names
- [ ] State changes are communicated to assistive technology (e.g., `aria-expanded`, `aria-selected`)
- [ ] Custom widgets follow WAI-ARIA authoring practices

#### 4.1.3 Status Messages (Level AA)
- [ ] Dynamic status messages use `role="status"`, `role="alert"`, or `aria-live` regions
- [ ] Status updates don't steal focus

---

## Quick Reference: Common Issues

| Issue | WCAG | Severity | Where to Look |
|-------|------|----------|---------------|
| Missing alt text | 1.1.1 | Critical | `<img>`, `<svg>`, icons |
| Low color contrast | 1.4.3 | Critical | All text + background pairs |
| Missing form labels | 1.3.1 | Critical | `<input>`, `<select>`, `<textarea>` |
| No lang attribute | 3.1.1 | Major | `<html>` tag |
| No skip navigation | 2.4.1 | Major | First focusable element |
| Missing page title | 2.4.2 | Major | `<title>` |
| Focus not visible | 2.4.7 | Major | Tab through all controls |
| Non-semantic headings | 1.3.1 | Major | Styled divs vs h1-h6 |
| Keyboard trap | 2.1.2 | Critical | Modals, dropdowns, overlays |
| Missing ARIA states | 4.1.2 | Major | Custom interactive components |
| Generic link text | 2.4.4 | Minor | "Click here", "Read more" links |
| Duplicate IDs | 4.1.1 | Major | All `id` attributes |
