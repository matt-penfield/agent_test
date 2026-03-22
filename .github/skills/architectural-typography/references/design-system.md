# Design System Reference — Architectural Typography

Detailed token definitions, CSS patterns, and code snippets for every section type in the brutalist editorial system.

---

## 1. Color Tokens

The palette is always high-contrast: stark black, clinical white, and one or two industrial accent colors.

### Default Palette

```css
:root {
  --clr-black: #0A0A0A;
  --clr-white: #F5F5F0;
  --clr-accent: #FF2D20;       /* signal red */
  --clr-accent-alt: #00FF87;   /* neon green */
  --clr-mid: #3A3A3A;          /* dark gray for secondary text */
  --clr-meta: #8A8A8A;         /* light gray for metadata */
}
```

### Alternate Accent Options

| Mood | `--clr-accent` | `--clr-accent-alt` |
|------|----------------|---------------------|
| Industrial (default) | `#FF2D20` signal red | `#00FF87` neon green |
| Clinical | `#00D4FF` cyan | `#FF2D20` signal red |
| Hazard | `#FFB800` amber | `#0A0A0A` black |
| Neon | `#E040FB` magenta | `#00FF87` neon green |
| Monochrome | `#F5F5F0` white | `#8A8A8A` gray |

### M3 Token Overrides

These map the custom palette onto M3 tokens so any `md-*` components pick up the brutalist theme:

```css
:root {
  --md-sys-color-primary: var(--clr-accent);
  --md-sys-color-on-primary: var(--clr-white);
  --md-sys-color-surface: var(--clr-white);
  --md-sys-color-on-surface: var(--clr-black);
  --md-sys-color-outline: var(--clr-black);
  --md-sys-color-outline-variant: var(--clr-mid);
}
```

### Shape Override — 0dp All Corners

```css
:root {
  --md-sys-shape-corner-extra-small: 0px;
  --md-sys-shape-corner-small: 0px;
  --md-sys-shape-corner-medium: 0px;
  --md-sys-shape-corner-large: 0px;
  --md-sys-shape-corner-extra-large: 0px;
}
```

---

## 2. Typography System

### Font Stack

```html
<link href="https://fonts.googleapis.com/css2?family=Anton&family=Bebas+Neue&family=Inter:wght@300;400;500;700;900&family=Space+Mono:wght@400;700&display=swap" rel="stylesheet">
```

| Font | Role | Usage |
|------|------|-------|
| **Anton** | Display / Massive | Hero headlines, ghost watermarks, pull quotes, outline text |
| **Bebas Neue** | Subheading / Label | Section titles, brand marks, sidebar headings, card headings |
| **Inter** | Body / Reading | Paragraphs, block quotes, descriptive text |
| **Space Mono** | Metadata / Technical | Dates, categories, navigation, fine print, counters |

### Custom Type Scale Tokens

```css
:root {
  --type-massive: clamp(6rem, 14vw, 18rem);   /* hero headlines */
  --type-headline: clamp(3rem, 6vw, 7rem);     /* section statements */
  --type-sub: clamp(1.4rem, 2.5vw, 2.2rem);    /* subheadings */
  --type-body: 1rem;                            /* body text */
  --type-meta: 0.7rem;                          /* metadata */
  --type-micro: 0.6rem;                         /* fine print */
}
```

### Metadata Style

Tiny, uppercase, monospace, tracked out — used for dates, categories, bylines:

```css
.meta {
  font-size: var(--type-meta);
  letter-spacing: 0.18em;
  text-transform: uppercase;
  color: var(--clr-meta);
  font-family: 'Space Mono', monospace;
}
```

### Drop Cap

First letter of lead paragraphs rendered as a large graphic letter:

```css
.drop-cap::first-letter {
  font-family: 'Anton', sans-serif;
  font-size: 4.5rem;
  float: left;
  line-height: 0.8;
  margin-right: 12px;
  margin-top: 6px;
  color: var(--clr-accent);
}
```

### Outline / Stroke Text

Text with a visible stroke and transparent fill — used for visual layering:

```css
.outline-text {
  -webkit-text-stroke: 2px var(--clr-white);  /* or var(--clr-black) on light bg */
  color: transparent;
}
```

---

## 3. Grain Texture Overlay

A fixed SVG noise pattern applied to the entire viewport. Creates a tactile, print-like feel:

```css
:root {
  --clr-grain: url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.85' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='0.04'/%3E%3C/svg%3E");
}

body::after {
  content: '';
  position: fixed;
  inset: 0;
  background: var(--clr-grain);
  pointer-events: none;
  z-index: 9999;
}
```

Adjust `opacity` in the SVG (default `0.04`) to increase/decrease grain intensity. Range: `0.02` (subtle) to `0.08` (heavy).

---

## 4. Abstract Glyph Icons

Replace standard Material Symbols with geometric Unicode glyphs in bordered squares:

```css
.glyph {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 48px;
  height: 48px;
  border: 2px solid var(--clr-black);
  font-family: 'Anton', sans-serif;
  font-size: 1.6rem;
  line-height: 1;
}

/* Variants */
.glyph--filled { background: var(--clr-accent); border-color: var(--clr-accent); color: var(--clr-white); }
.glyph--stroke { background: transparent; color: var(--clr-black); }
.glyph--neon   { background: var(--clr-accent-alt); border-color: var(--clr-accent-alt); color: var(--clr-black); }
```

### Recommended Glyphs

| Symbol | Unicode | Suggested Use |
|--------|---------|---------------|
| ▲ | `&#x25B2;` | Upward / growth / primary |
| ◆ | `&#x25C6;` | Diamond / feature / highlight |
| █ | `&#x2588;` | Block / solid / weight |
| ◎ | `&#x25CE;` | Target / focus / precision |
| ✦ | `&#x2726;` | Star / quality / editorial pick |
| ↗ | `&#x2197;` | External link / share |
| ∎ | `&#x220E;` | End of proof / completion |

---

## 5. Section Patterns

### 5.1 Hero

Full-viewport, black background, headline pinned to bottom, ghost watermark text bleeding off-canvas.

```css
.hero {
  position: relative;
  min-height: 100vh;
  background: var(--clr-black);
  color: var(--clr-white);
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  padding: 0 clamp(24px, 5vw, 80px) 80px;
  overflow: hidden;
}

/* Ghost watermark — massive, translucent, bleeds off canvas */
.hero::before {
  content: 'VOL.09';  /* customize per project */
  position: absolute;
  top: -6vw;
  right: -3vw;
  font-family: 'Anton', sans-serif;
  font-size: clamp(18rem, 40vw, 55rem);
  line-height: 0.85;
  color: var(--clr-mid);
  opacity: 0.12;
  pointer-events: none;
  white-space: nowrap;
}

.hero__title {
  font-family: 'Anton', sans-serif;
  font-size: var(--type-massive);
  line-height: 0.88;
  text-transform: uppercase;
  letter-spacing: -0.03em;
  margin-left: -0.04em;  /* optical alignment */
}
```

**Kicker tag** — small colored label above headline:

```css
.hero__kicker {
  display: inline-block;
  background: var(--clr-accent);
  color: var(--clr-white);
  padding: 4px 16px;
  font-family: 'Space Mono', monospace;
  font-size: var(--type-meta);
  letter-spacing: 0.2em;
  text-transform: uppercase;
  margin-bottom: 24px;
}
```

**Accent stripe** — hard geometric line across hero bottom:

```css
.hero__stripe {
  position: absolute;
  bottom: 0; left: 0;
  width: 100%;
  height: 6px;
  background: linear-gradient(90deg, var(--clr-accent) 60%, var(--clr-accent-alt) 60%);
}
```

### 5.2 Deconstructed Statement Block

Asymmetric grid: main statement occupies 4 of 6 columns, metadata sits in remaining 2.

```css
.decon {
  display: grid;
  grid-template-columns: 1fr 1fr 1fr 1fr 1fr 1fr;
  padding: clamp(60px, 10vw, 160px) 0;
}

.decon__statement {
  grid-column: 1 / 5;
  padding: 0 clamp(24px, 5vw, 80px);
}

.decon__statement h2 {
  font-family: 'Anton', sans-serif;
  font-size: var(--type-headline);
  line-height: 0.92;
  text-transform: uppercase;
}

.decon__meta {
  grid-column: 5 / 7;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
  gap: 12px;
}
```

### 5.3 Cut-Out Section

Two-panel split (black/white) with hard-edged geometric shapes overlapping the seam:

```css
.cutout-section {
  display: grid;
  grid-template-columns: 1fr 1fr;
  min-height: 80vh;
}

.cutout-left {
  background: var(--clr-black);
  color: var(--clr-white);
  padding: clamp(40px, 8vw, 120px) clamp(24px, 5vw, 80px);
  position: relative;
}

/* Red square overlapping the seam */
.cutout-left::after {
  content: '';
  position: absolute;
  top: 10%;
  right: -40px;
  width: 80px;
  height: 80px;
  background: var(--clr-accent);
  z-index: 2;
}

/* Green bar on the other side */
.cutout-right::before {
  content: '';
  position: absolute;
  bottom: 12%;
  left: -24px;
  width: 48px;
  height: 200px;
  background: var(--clr-accent-alt);
  z-index: 2;
}
```

### 5.4 Marquee Divider

Infinitely scrolling text strip — treats typography as a graphic element:

```css
.marquee-wrap {
  overflow: hidden;
  background: var(--clr-accent);
  padding: 12px 0;
}

.marquee {
  display: flex;
  white-space: nowrap;
  animation: marquee 18s linear infinite;
}

.marquee span {
  font-family: 'Anton', sans-serif;
  font-size: clamp(2rem, 4vw, 4rem);
  text-transform: uppercase;
  color: var(--clr-white);
  padding: 0 48px;
  letter-spacing: 0.15em;
}

@keyframes marquee {
  from { transform: translateX(0); }
  to   { transform: translateX(-50%); }
}
```

**Important:** Duplicate the content inside `.marquee` so the animation loops seamlessly. Use `&#x25CF;` (●) as separators.

### 5.5 Feature Strip

Three-column border-separated cards with ghost outline numbers and abstract glyphs:

```css
.feature-strip {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  border-top: 2px solid var(--clr-black);
  border-bottom: 2px solid var(--clr-black);
}

.feature-card {
  padding: clamp(32px, 5vw, 64px);
  border-right: 1px solid var(--clr-black);
  position: relative;
}
.feature-card:last-child { border-right: none; }

/* Ghost outline number */
.feature-card__number {
  font-family: 'Anton', sans-serif;
  font-size: clamp(5rem, 8vw, 10rem);
  line-height: 1;
  color: transparent;
  -webkit-text-stroke: 1.5px var(--clr-black);
  position: absolute;
  top: -0.15em;
  right: 16px;
  opacity: 0.2;
}
```

### 5.6 Editorial Body

Asymmetric two-column: narrow dark sidebar with pull quote + wide body with drop cap:

```css
.editorial {
  display: grid;
  grid-template-columns: 2fr 3fr;
  min-height: 80vh;
}

.editorial__sidebar {
  background: var(--clr-black);
  color: var(--clr-white);
  padding: clamp(40px, 6vw, 100px) clamp(24px, 4vw, 64px);
}

/* Vertical tag — writing-mode for rotated text */
.editorial__sidebar-tag {
  writing-mode: vertical-lr;
  font-family: 'Anton', sans-serif;
  font-size: clamp(4rem, 8vw, 8rem);
  text-transform: uppercase;
  color: var(--clr-mid);
  opacity: 0.2;
  position: absolute;
  right: 24px;
  top: 50%;
  transform: translateY(-50%);
}

.editorial__body {
  padding: clamp(40px, 6vw, 100px) clamp(24px, 5vw, 80px);
}

/* Pull quote — large Anton text with accent left border */
.editorial__pull-quote {
  font-family: 'Anton', sans-serif;
  font-size: clamp(1.6rem, 3vw, 2.8rem);
  line-height: 1.15;
  text-transform: uppercase;
  margin: 48px 0;
  padding-left: 24px;
  border-left: 5px solid var(--clr-accent);
  color: var(--clr-black);
  max-width: 480px;
}
```

### 5.7 Stats Row

Numeric counters separated by borders:

```css
.stats {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  border-top: 2px solid var(--clr-black);
  border-bottom: 2px solid var(--clr-black);
}

.stat {
  text-align: center;
  padding: clamp(32px, 5vw, 56px) 16px;
  border-right: 1px solid var(--clr-black);
}
.stat:last-child { border-right: none; }

.stat__value {
  font-family: 'Anton', sans-serif;
  font-size: clamp(3rem, 6vw, 6rem);
  line-height: 1;
}

.stat__label {
  margin-top: 8px;
  font-size: var(--type-meta);
  letter-spacing: 0.2em;
  text-transform: uppercase;
  font-family: 'Space Mono', monospace;
  color: var(--clr-meta);
}
```

### 5.8 Colophon / Footer

Dark footer with multi-column grid:

```css
.colophon {
  background: var(--clr-black);
  color: var(--clr-white);
  padding: clamp(40px, 6vw, 80px) clamp(24px, 5vw, 80px);
  display: grid;
  grid-template-columns: 2fr 1fr 1fr;
  gap: 40px;
}

.colophon__brand {
  font-family: 'Bebas Neue', sans-serif;
  font-size: 2rem;
  letter-spacing: 0.2em;
}

.colophon li {
  font-size: var(--type-meta);
  letter-spacing: 0.15em;
  text-transform: uppercase;
  font-family: 'Space Mono', monospace;
  color: var(--clr-meta);
  padding: 6px 0;
  list-style: none;
  cursor: pointer;
  transition: color 0.2s;
}
.colophon li:hover { color: var(--clr-accent); }
```

---

## 6. Responsive Strategy

```css
@media (max-width: 839px) {
  .decon { grid-template-columns: 1fr; }
  .cutout-section { grid-template-columns: 1fr; }
  .cutout-left::after, .cutout-right::before { display: none; }
  .feature-strip { grid-template-columns: 1fr; }
  .feature-card { border-right: none; border-bottom: 1px solid var(--clr-black); }
  .editorial { grid-template-columns: 1fr; }
  .stats { grid-template-columns: 1fr 1fr; }
  .colophon { grid-template-columns: 1fr; }
}

@media (max-width: 599px) {
  .stats { grid-template-columns: 1fr; }
  .hero__title { font-size: clamp(4rem, 16vw, 8rem); }
}
```

Key rules:
- Multi-column grids collapse to single column
- Geometric cut-out shapes hide on compact (they lose visual impact at small sizes)
- Navigation labels and sidebar issue markers hide on mobile
- Typography fluid-scales via `clamp()` — no breakpoint-specific overrides needed for font sizes

---

## 7. md-divider Override

The only M3 web component typically used. Override to match the industrial style:

```css
md-divider {
  --md-divider-color: var(--clr-black);
  --md-divider-thickness: 2px;
}
```
