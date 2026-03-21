# Product Requirements Document

> **Product:** {{PRODUCT_NAME}}
> **Date:** {{DATE}}
> **Author:** {{AUTHOR}}
> **Status:** Draft

---

## 1. Product Overview

| Field | Value |
|-------|-------|
| **Product Name** | {{PRODUCT_NAME}} |
| **Description** | {{ONE_LINE_DESCRIPTION}} |
| **Target Users** | {{TARGET_USERS}} |
| **Industry / Domain** | {{INDUSTRY}} |
| **Brand Personality** | {{BRAND_ADJECTIVES}} |

---

## 2. Pages & Screens

### Page Map

| # | Page Name | Priority | Description |
|---|-----------|----------|-------------|
| 1 | {{PAGE_NAME}} | Primary | {{PAGE_DESCRIPTION}} |

### User Flows

{{FLOW_DESCRIPTION}}

<!-- Example: Homepage → Product Detail → Cart → Checkout -->

---

## 3. Layout & Navigation

### Primary Layout Pattern

**Pattern:** {{LAYOUT_PATTERN}}

<!-- Options: top-app-bar, navigation-rail, navigation-drawer, bottom-navigation, hero-landing -->

### Navigation Destinations

| Label | Icon | Route |
|-------|------|-------|
| {{NAV_LABEL}} | {{ICON_NAME}} | {{PAGE}} |

### Search

**Search bar:** {{SEARCH_PREFERENCE}}

<!-- Options: yes / no / prominent (in app bar) -->

---

## 4. Content & Components

### Page: {{PAGE_NAME}}

#### Hero / Featured Section

- **Headline:** {{HERO_HEADLINE}}
- **Description:** {{HERO_DESCRIPTION}}
- **CTA:** {{CTA_TEXT}}
- **Image:** {{IMAGE_PLACEHOLDER_DESCRIPTION}}

#### Content Sections

| # | Section | Description | Components Used |
|---|---------|-------------|-----------------|
| 1 | {{SECTION_NAME}} | {{SECTION_DESCRIPTION}} | {{COMPONENTS}} |

#### Required M3 Components

- [ ] Cards
- [ ] Filled Button
- [ ] Outlined Button
- [ ] Text Button
- [ ] FAB
- [ ] Text Fields
- [ ] Filter Chips
- [ ] Lists
- [ ] Tabs
- [ ] Dialogs
- [ ] Tables
- [ ] Switches
- [ ] Checkboxes
- [ ] Icon Buttons
- [ ] Menus
- [ ] Bottom Sheet
- [ ] Dividers
- [ ] Navigation Bar

<!-- Check all that apply -->

#### Data & Content

**Content source:** {{CONTENT_SOURCE}}

<!-- Options: placeholder / specific (provide below) -->

{{SPECIFIC_CONTENT}}

#### Icons

**Icon set:** Material Symbols Outlined (default)

**Specific icons needed:**

{{ICON_LIST}}

---

## 5. Visual Design

### Color

| Token | Value | Notes |
|-------|-------|-------|
| **Primary brand color** | {{PRIMARY_COLOR}} | {{COLOR_NOTES}} |
| **Color mood** | {{COLOR_MOOD}} | warm / cool / neutral / vibrant / muted |
| **Theme mode** | {{THEME_MODE}} | light / dark / both |

### Typography

| Setting | Value |
|---------|-------|
| **Primary font** | {{FONT}} |
| **Display font** | {{DISPLAY_FONT}} |

### Density & Shape

| Setting | Value |
|---------|-------|
| **Density** | {{DENSITY}} |
| **Shape** | {{SHAPE}} |

<!-- Density: spacious / default / compact -->
<!-- Shape: rounded (M3 default) / sharp / pill -->

---

## 6. Interactions & Behavior

### Interactive Elements

| Element | Behavior |
|---------|----------|
| {{ELEMENT}} | {{BEHAVIOR}} |

### Animations

{{ANIMATION_NOTES}}

### State Variations

- [ ] Empty state
- [ ] Loading state
- [ ] Error state
- [ ] Success state

<!-- Check all needed -->

---

## 7. Responsive Requirements

| Setting | Value |
|---------|-------|
| **Approach** | {{RESPONSIVE_APPROACH}} |

<!-- Options: desktop-first / mobile-first / both equally -->

### Breakpoint Behavior

| Breakpoint | Grid | Navigation | Notable Changes |
|------------|------|------------|-----------------|
| Desktop (840px+) | {{DESKTOP_GRID}} | {{DESKTOP_NAV}} | |
| Tablet (600-839px) | {{TABLET_GRID}} | {{TABLET_NAV}} | |
| Mobile (<600px) | {{MOBILE_GRID}} | {{MOBILE_NAV}} | |

### Hidden on Mobile

{{HIDDEN_MOBILE_ELEMENTS}}

---

## 8. References & Constraints

### Inspiration

{{INSPIRATION_LINKS}}

### Constraints

{{CONSTRAINTS}}

### Delivery

| Setting | Value |
|---------|-------|
| **Output format** | {{OUTPUT_FORMAT}} |
| **Include feedback modal** | {{INCLUDE_FEEDBACK}} |

<!-- Output: single-html / multi-page-linked -->
<!-- Feedback modal: yes / no -->

---

## Prototyping Prompt

<!-- This section is auto-generated from the requirements above. Copy this to use with /material-design-prototyping -->

> **Prompt:** Create a {{PAGE_TYPE}} for {{PRODUCT_NAME}}. {{ONE_LINE_DESCRIPTION}}.
>
> **Layout:** {{LAYOUT_PATTERN}} with {{NAV_DESTINATIONS}}.
>
> **Hero:** {{HERO_HEADLINE}} — {{HERO_DESCRIPTION}}. CTA: "{{CTA_TEXT}}".
>
> **Sections:** {{SECTION_LIST}}.
>
> **Components:** {{COMPONENT_LIST}}.
>
> **Color:** Primary {{PRIMARY_COLOR}}, {{COLOR_MOOD}} mood, {{THEME_MODE}} theme.
>
> **Typography:** {{FONT}}. Density: {{DENSITY}}. Shape: {{SHAPE}}.
>
> **Responsive:** {{RESPONSIVE_APPROACH}}. {{BREAKPOINT_NOTES}}.
>
> **Content:** {{CONTENT_SOURCE}}.
