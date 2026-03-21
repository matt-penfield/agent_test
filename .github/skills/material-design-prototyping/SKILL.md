---
name: material-design-prototyping
description: '**WORKFLOW SKILL** — Create UI prototypes using Material Design 3 (Material You) with HTML, CSS, and the Material Web Components library. USE FOR: rapid prototyping; wireframes; mockups; landing pages; dashboards; forms; Material Design components; Material You theming; responsive layouts; design tokens; typography scale; elevation system; color schemes. DO NOT USE FOR: production-ready apps (use a framework like Angular Material or MUI); backend logic; API development.'
argument-hint: 'Describe the screen, page, or component to prototype'
---

# Material Design Prototyping

Create self-contained HTML prototypes that follow Material Design 3 guidelines using Google's Material Web Components and design tokens.

## When to Use

- Rapid prototyping of pages, screens, or UI flows
- Building clickable mockups for stakeholder review
- Creating landing pages, dashboards, forms, or card layouts with Material Design
- Exploring Material You color theming and typography
- Generating standalone HTML files that can be opened in any browser

## Procedure

### Step 1 — Clarify the Prototype Requirements

Determine from the user's request:
- **What type of page/screen**: landing page, dashboard, form, settings, profile, list/detail, etc.
- **Key components needed**: app bar, navigation, cards, buttons, dialogs, tables, FABs, etc.
- **Content**: placeholder text and data, or specific content the user provides
- **Color scheme**: use Material You defaults, or derive a custom theme from a brand color

If unclear, ask one clarifying question before proceeding.

### Step 2 — Set Up the HTML File

Start from the [prototype template](./assets/prototype-template.html) which includes:
- Material Web Components via CDN (`@material/web`)
- Google Fonts (Roboto)
- Material Symbols icon font
- CSS custom properties for the M3 design token system
- Responsive viewport meta tag

### Step 3 — Apply the M3 Color System

Material Design 3 uses a token-based color system. Set these CSS custom properties on `:root`:

**Core surface colors:**
- `--md-sys-color-primary` — Primary brand color
- `--md-sys-color-on-primary` — Text/icons on primary
- `--md-sys-color-primary-container` — Lighter primary for containers
- `--md-sys-color-surface` — Default background
- `--md-sys-color-on-surface` — Default text color
- `--md-sys-color-surface-container-low` — Slightly elevated surface
- `--md-sys-color-outline` — Borders and dividers

If the user provides a brand color, derive a tonal palette from it. Otherwise use the defaults in the template.

### Step 4 — Build the Layout

Use M3 layout patterns from the [component reference](./references/components.md):

**Common page structures:**
- **Top app bar + body**: For most pages
- **Navigation rail + body**: For desktop dashboards
- **Navigation drawer + body**: For complex apps with many destinations
- **Bottom navigation + body**: For mobile-first designs

Use CSS Grid or Flexbox for layout. Apply M3 spacing tokens:
- Compact: `16px` padding
- Medium: `24px` padding
- Expanded: `32px` padding

### Step 5 — Add Components

Use Material Web Components (`<md-*>` elements) wherever possible. Key components:

| Component | Element | Use For |
|-----------|---------|---------|
| Buttons | `<md-filled-button>`, `<md-outlined-button>`, `<md-text-button>` | Actions |
| FAB | `<md-fab>` | Primary screen action |
| Cards | CSS with M3 tokens (no native `<md-card>`) | Content containers |
| Text fields | `<md-filled-text-field>`, `<md-outlined-text-field>` | Form inputs |
| Chips | `<md-chip-set>`, `<md-filter-chip>` | Filters, selections |
| Lists | `<md-list>`, `<md-list-item>` | Vertical content lists |
| Navigation | `<md-navigation-bar>`, `<md-navigation-tab>` | Bottom navigation |
| Dialogs | `<md-dialog>` | Confirmations, alerts |
| Icon buttons | `<md-icon-button>` | Toolbar actions |
| Tabs | `<md-tabs>`, `<md-primary-tab>` | Content switching |
| Checkboxes | `<md-checkbox>` | Multi-select |
| Switches | `<md-switch>` | Toggles |
| Dividers | `<md-divider>` | Section separators |

For icons, use Material Symbols: `<md-icon>icon_name</md-icon>` or `<span class="material-symbols-outlined">icon_name</span>`.

See the full [component reference](./references/components.md) for detailed usage, attributes, and examples.

### Step 6 — Apply Typography

Use the M3 type scale via CSS classes or custom properties:

| Role | Size | Weight | Use For |
|------|------|--------|---------|
| Display Large | 57px | 400 | Hero text |
| Headline Large | 32px | 400 | Page titles |
| Headline Medium | 28px | 400 | Section headers |
| Title Large | 22px | 400 | Card titles |
| Title Medium | 16px | 500 | Subtitles |
| Body Large | 16px | 400 | Body text |
| Body Medium | 14px | 400 | Secondary text |
| Label Large | 14px | 500 | Button text |
| Label Medium | 12px | 500 | Captions |

Font family: `'Roboto', sans-serif` for body, `'Roboto Flex'` or `'Google Sans'` for display if available.

### Step 7 — Add Elevation and Shape

**Elevation levels** (use box-shadow or surface tint):
- Level 0: Flat (no shadow)
- Level 1: `0 1px 2px rgba(0,0,0,0.3), 0 1px 3px 1px rgba(0,0,0,0.15)` — Cards
- Level 2: `0 1px 2px rgba(0,0,0,0.3), 0 2px 6px 2px rgba(0,0,0,0.15)` — Raised cards, FABs
- Level 3: `0 4px 8px 3px rgba(0,0,0,0.15), 0 1px 3px rgba(0,0,0,0.3)` — Dialogs

**Shape** — M3 uses rounded corners:
- Extra small: `4px` (chips, small components)
- Small: `8px` (cards, text fields)
- Medium: `12px` (larger cards)
- Large: `16px` (FABs, dialogs)
- Extra large: `28px` (large sheets, containers)

### Step 8 — Make It Responsive

Apply responsive breakpoints:
- Compact: `< 600px` (phones)
- Medium: `600px – 839px` (tablets)
- Expanded: `840px+` (desktop)

Use CSS media queries:
```css
@media (max-width: 599px) { /* compact */ }
@media (min-width: 600px) and (max-width: 839px) { /* medium */ }
@media (min-width: 840px) { /* expanded */ }
```

### Step 9 — Deliver the Prototype

- Save as a single `.html` file (all CSS inline, components via CDN)
- Ensure it opens correctly in a browser with no build step
- If the user wants multiple screens, create separate HTML files and link between them

## References

- [Component Reference](./references/components.md) — Detailed M3 web component usage and examples
- [Prototype Template](./assets/prototype-template.html) — Starter HTML file with M3 setup
