---
name: architectural-typography
description: '**WORKFLOW SKILL** — Create brutalist editorial HTML prototypes with architectural typography, deconstructed grids, industrial palettes, and tactile surfaces. USE FOR: editorial page; magazine layout; brutalist design; architectural typography; extreme type scale; deconstructed grid; asymmetric layout; industrial palette; signal red; neon accent; high-contrast black and white; tactile surfaces; grain texture; geometric cut-outs; abstract iconography; glyph symbols; marquee text; text as graphic; poster layout; print-inspired web; zine page; lookbook; avant-garde layout. DO NOT USE FOR: standard Material Design prototypes (use material-design-prototyping skill); dashboards; forms; conventional UI with rounded corners; production apps.'
argument-hint: 'Describe the editorial page, article, or layout to prototype'
---

# Architectural Typography Prototyper

Create self-contained HTML pages that treat typography as architecture — massive headline-driven layouts with deconstructed grids, industrial color palettes, tactile surfaces, and abstract iconography inspired by high-end print editorial and street poster design.

## When to Use

- Building editorial, magazine, or article layouts
- Creating poster-style landing pages or hero sections
- Designing lookbooks, zines, or avant-garde portfolio pages
- Prototyping layouts where type is the primary visual element
- Any page that needs to feel like high-end print, not software UI

## Procedure

### Step 1 — Clarify Requirements

Determine from the user's request:
- **Page type**: editorial article, poster, lookbook, landing page, portfolio, zine spread
- **Content**: placeholder text or specific content the user provides
- **Accent color**: default is signal red (`#FF2D20`) + neon green (`#00FF87`), but can be swapped for any single industrial accent (cyan, orange, magenta)
- **Mood**: aggressive/loud, clinical/minimal, or mixed tension

If unclear, ask one clarifying question before proceeding.

### Step 2 — Set Up the HTML File

Start from the [prototype template](./assets/template.html) which includes:
- Heavy sans-serif fonts via Google Fonts (Anton, Bebas Neue, Inter, Space Mono)
- Material Web Components import map (minimal — divider only)
- Full custom token system overriding M3 defaults
- SVG grain texture overlay
- 0dp corner radius on all M3 shape tokens

### Step 3 — Apply the Design System

Load the full [design system reference](./references/design-system.md) and apply these five pillars:

1. **Typography as architecture** — Massive headlines (`clamp(6rem, 14vw, 18rem)`), tiny monospace metadata (`0.7rem`), outline-stroke text, drop caps, text bleeding off-canvas
2. **Deconstructed grids** — Intentional asymmetry, off-axis elements, active whitespace, non-standard column splits (2fr/3fr, 4/6-column)
3. **Industrial palette** — Stark black + clinical white + one or two accent colors. No gradients, no pastels
4. **Tactile surfaces** — SVG noise grain overlay, hard-edged geometric cut-outs for depth instead of box-shadows, flat layered shapes
5. **Abstract iconography** — Geometric Unicode glyphs (`▲`, `◆`, `█`, `◎`) in bordered squares instead of standard icons

### Step 4 — Build the Layout Sections

Compose the page from these editorial building blocks (use what fits the content):

| Section | Purpose | Key Pattern |
|---------|---------|-------------|
| **Hero** | Full-viewport opener with massive headline | Bleed-off-canvas title, ghost watermark text, kicker tag, meta row |
| **Statement block** | Big typographic assertion | Asymmetric grid, accent underline/color on key words |
| **Cut-out section** | Two-panel contrast layout | Black/white split with geometric colored shapes overlapping the seam |
| **Marquee divider** | Scrolling text-as-graphic strip | CSS-animated horizontal scroll, accent background |
| **Feature strip** | 3-column numbered cards | Outlined ghost numbers, abstract glyph icons, border-separated columns |
| **Editorial body** | Long-form article | Sidebar with pull quote + vertical tag, body with drop cap, inline pull quotes |
| **Stats row** | Numeric highlights | Large counter numbers, tiny monospace labels, border-separated cells |
| **Colophon** | Footer / credits | Multi-column grid, brand mark, link lists, endmark row |

See the [design system reference](./references/design-system.md) for CSS patterns and code snippets for each section.

### Step 5 — Implement the Custom Type Scale

Override standard M3 typography with the extreme editorial scale:

| Token | Size | Use For |
|-------|------|---------|
| `--type-massive` | `clamp(6rem, 14vw, 18rem)` | Hero headlines |
| `--type-headline` | `clamp(3rem, 6vw, 7rem)` | Section statements |
| `--type-sub` | `clamp(1.4rem, 2.5vw, 2.2rem)` | Subheadings (Bebas Neue) |
| `--type-body` | `1rem` | Body text (Inter) |
| `--type-meta` | `0.7rem` | Metadata, labels (Space Mono) |
| `--type-micro` | `0.6rem` | Endmarks, fine print |

Font assignments:
- **Anton** — Hero headlines, massive display text, ghost watermarks
- **Bebas Neue** — Subheadings, section labels, brand marks
- **Inter** — Body text, paragraphs, quotes
- **Space Mono** — Metadata, dates, categories, navigation labels

### Step 6 — Apply Hard-Edge Depth (No Shadows)

Replace all M3 elevation with flat geometric depth:
- Colored rectangles overlapping section seams (e.g., red square at a black/white boundary)
- Vertical or horizontal accent bars positioned with `position: absolute`
- Ghost outline numbers behind content (`-webkit-text-stroke`, transparent fill)
- SVG noise grain fixed overlay on `body::after`

Never use `box-shadow`. Depth is communicated through layered flat shapes.

### Step 7 — Make It Responsive

Breakpoints:
- **Compact** (`< 600px`) — Single column, reduced type scale, hide secondary nav/sidebars
- **Medium** (`600–839px`) — Two column where appropriate, scaled type
- **Expanded** (`840px+`) — Full deconstructed grid

All `font-size` values use `clamp()` for fluid scaling. Geometric cut-outs hide on compact via `display: none`.

### Step 8 — Deliver

- Save as a single `.html` file with all CSS inline
- Ensure it opens in any browser with no build step
- Components via CDN (only `md-divider` typically needed)

## References

- [Design System Reference](./references/design-system.md) — Full token definitions, CSS patterns, and code snippets for every section type
- [Prototype Template](./assets/template.html) — Starter HTML with fonts, tokens, grain overlay, and 0dp shape overrides
