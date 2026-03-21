# Material Web Components Reference

Detailed usage for Material Web (`@material/web`) components in HTML prototypes.

> Import via CDN in your HTML: `<script type="importmap">` with `@material/web` pointing to a CDN URL, then `<script type="module">` to import individual components.

## Setup

```html
<script type="importmap">
{
  "imports": {
    "@material/web/": "https://esm.run/@anthropic-ai/sdk/@material/web/"
  }
}
</script>
```

> **Note:** For prototyping, you can use the bundled approach with a single script tag:
```html
<script src="https://unpkg.com/@anthropic-ai/sdk/dist/web-bundle.js"></script>
```

**Recommended approach** — use individual imports for only the components you need:

```html
<script type="module">
  import '@material/web/button/filled-button.js';
  import '@material/web/button/outlined-button.js';
  import '@material/web/textfield/filled-text-field.js';
  // ... add only what you use
</script>
```

---

## Buttons

### Filled Button
```html
<script type="module">import '@material/web/button/filled-button.js';</script>
<md-filled-button>Label</md-filled-button>
<md-filled-button disabled>Disabled</md-filled-button>
<md-filled-button href="/link">Link Button</md-filled-button>
```

### Outlined Button
```html
<script type="module">import '@material/web/button/outlined-button.js';</script>
<md-outlined-button>Label</md-outlined-button>
```

### Text Button
```html
<script type="module">import '@material/web/button/text-button.js';</script>
<md-text-button>Label</md-text-button>
```

### Tonal Button
```html
<script type="module">import '@material/web/button/tonal-button.js';</script>
<md-tonal-button>Label</md-tonal-button>
```

### Elevated Button
```html
<script type="module">import '@material/web/button/elevated-button.js';</script>
<md-elevated-button>Label</md-elevated-button>
```

**With icon:**
```html
<md-filled-button>
  <md-icon slot="icon">send</md-icon>
  Send
</md-filled-button>
```

---

## FAB (Floating Action Button)

```html
<script type="module">import '@material/web/fab/fab.js';</script>
<md-fab aria-label="Add">
  <md-icon slot="icon">add</md-icon>
</md-fab>
<md-fab label="Create" variant="primary">
  <md-icon slot="icon">add</md-icon>
</md-fab>
<md-fab size="small" aria-label="Edit">
  <md-icon slot="icon">edit</md-icon>
</md-fab>
```

---

## Icon Buttons

```html
<script type="module">import '@material/web/iconbutton/icon-button.js';</script>
<md-icon-button aria-label="Settings">
  <md-icon>settings</md-icon>
</md-icon-button>
<md-icon-button toggle aria-label="Favorite">
  <md-icon>favorite_border</md-icon>
  <md-icon slot="selected">favorite</md-icon>
</md-icon-button>
```

### Filled Icon Button
```html
<script type="module">import '@material/web/iconbutton/filled-icon-button.js';</script>
<md-filled-icon-button aria-label="Delete">
  <md-icon>delete</md-icon>
</md-filled-icon-button>
```

---

## Text Fields

### Filled Text Field
```html
<script type="module">import '@material/web/textfield/filled-text-field.js';</script>
<md-filled-text-field label="Name" value=""></md-filled-text-field>
<md-filled-text-field label="Email" type="email" required></md-filled-text-field>
<md-filled-text-field label="Bio" type="textarea" rows="3"></md-filled-text-field>
```

### Outlined Text Field
```html
<script type="module">import '@material/web/textfield/outlined-text-field.js';</script>
<md-outlined-text-field label="Search" placeholder="Type to search...">
  <md-icon slot="leading-icon">search</md-icon>
</md-outlined-text-field>
```

**Attributes:** `label`, `value`, `placeholder`, `type` (text, email, password, number, textarea), `required`, `disabled`, `error`, `error-text`, `supporting-text`, `prefix-text`, `suffix-text`, `rows` (textarea), `max-length`.

---

## Chips

```html
<script type="module">
  import '@material/web/chips/chip-set.js';
  import '@material/web/chips/filter-chip.js';
  import '@material/web/chips/assist-chip.js';
  import '@material/web/chips/input-chip.js';
  import '@material/web/chips/suggestion-chip.js';
</script>

<md-chip-set>
  <md-filter-chip label="Vegetarian"></md-filter-chip>
  <md-filter-chip label="Vegan" selected></md-filter-chip>
  <md-filter-chip label="Gluten-Free"></md-filter-chip>
</md-chip-set>

<md-chip-set>
  <md-assist-chip label="Add to calendar">
    <md-icon slot="icon">event</md-icon>
  </md-assist-chip>
</md-chip-set>
```

---

## Lists

```html
<script type="module">
  import '@material/web/list/list.js';
  import '@material/web/list/list-item.js';
</script>

<md-list>
  <md-list-item headline="Item 1" supporting-text="Description"></md-list-item>
  <md-list-item headline="Item 2" supporting-text="Description">
    <md-icon slot="start">person</md-icon>
    <md-icon slot="end">chevron_right</md-icon>
  </md-list-item>
  <md-divider></md-divider>
  <md-list-item headline="Item 3"></md-list-item>
</md-list>
```

**Attributes:** `headline`, `supporting-text`, `trailing-supporting-text`, `type` ("button" | "link"), `href`, `disabled`.

---

## Navigation Bar (Bottom)

```html
<script type="module">
  import '@material/web/navigationbar/navigation-bar.js';
  import '@material/web/navigationtab/navigation-tab.js';
</script>

<md-navigation-bar active-index="0">
  <md-navigation-tab label="Home">
    <md-icon slot="active-icon">home</md-icon>
    <md-icon slot="inactive-icon">home</md-icon>
  </md-navigation-tab>
  <md-navigation-tab label="Explore">
    <md-icon slot="active-icon">explore</md-icon>
    <md-icon slot="inactive-icon">explore</md-icon>
  </md-navigation-tab>
  <md-navigation-tab label="Profile">
    <md-icon slot="active-icon">person</md-icon>
    <md-icon slot="inactive-icon">person</md-icon>
  </md-navigation-tab>
</md-navigation-bar>
```

---

## Tabs

```html
<script type="module">
  import '@material/web/tabs/tabs.js';
  import '@material/web/tabs/primary-tab.js';
  import '@material/web/tabs/secondary-tab.js';
</script>

<md-tabs>
  <md-primary-tab>Overview</md-primary-tab>
  <md-primary-tab>Details</md-primary-tab>
  <md-primary-tab>Reviews</md-primary-tab>
</md-tabs>
```

**With icons:**
```html
<md-primary-tab>
  <md-icon slot="icon">home</md-icon>
  Home
</md-primary-tab>
```

---

## Dialogs

```html
<script type="module">import '@material/web/dialog/dialog.js';</script>

<md-dialog id="my-dialog">
  <div slot="headline">Confirm Action</div>
  <div slot="content">Are you sure you want to proceed?</div>
  <div slot="actions">
    <md-text-button form="dialog" value="cancel">Cancel</md-text-button>
    <md-filled-button form="dialog" value="confirm">Confirm</md-filled-button>
  </div>
</md-dialog>

<!-- Open with: document.getElementById('my-dialog').open = true; -->
```

---

## Checkboxes

```html
<script type="module">import '@material/web/checkbox/checkbox.js';</script>
<label>
  <md-checkbox></md-checkbox>
  Accept terms
</label>
<label>
  <md-checkbox checked></md-checkbox>
  Already checked
</label>
```

---

## Switches

```html
<script type="module">import '@material/web/switch/switch.js';</script>
<md-switch></md-switch>
<md-switch selected></md-switch>
<md-switch icons></md-switch>
```

---

## Radio Buttons

```html
<script type="module">import '@material/web/radio/radio.js';</script>
<md-radio name="group" value="a" checked></md-radio>
<md-radio name="group" value="b"></md-radio>
```

---

## Sliders

```html
<script type="module">import '@material/web/slider/slider.js';</script>
<md-slider min="0" max="100" value="50"></md-slider>
<md-slider range value-start="25" value-end="75"></md-slider>
```

---

## Progress Indicators

```html
<script type="module">
  import '@material/web/progress/circular-progress.js';
  import '@material/web/progress/linear-progress.js';
</script>

<md-circular-progress indeterminate></md-circular-progress>
<md-circular-progress value="0.7"></md-circular-progress>

<md-linear-progress indeterminate></md-linear-progress>
<md-linear-progress value="0.5" buffer="0.8"></md-linear-progress>
```

---

## Dividers

```html
<script type="module">import '@material/web/divider/divider.js';</script>
<md-divider></md-divider>
<md-divider inset></md-divider>
```

---

## Select (Menu-based)

```html
<script type="module">
  import '@material/web/select/filled-select.js';
  import '@material/web/select/outlined-select.js';
  import '@material/web/select/select-option.js';
</script>

<md-filled-select label="Country">
  <md-select-option value="us"><div slot="headline">United States</div></md-select-option>
  <md-select-option value="uk"><div slot="headline">United Kingdom</div></md-select-option>
  <md-select-option value="ca"><div slot="headline">Canada</div></md-select-option>
</md-filled-select>
```

---

## Cards (CSS — No Native Component)

Material Web does not include a `<md-card>` element. Build cards with CSS using M3 tokens:

```html
<style>
  .md-card {
    background: var(--md-sys-color-surface-container-low, #f7f2fa);
    border-radius: 12px;
    padding: 16px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.3), 0 1px 3px 1px rgba(0,0,0,0.15);
  }
  .md-card-outlined {
    background: var(--md-sys-color-surface, #fff);
    border: 1px solid var(--md-sys-color-outline-variant, #cac4d0);
    border-radius: 12px;
    padding: 16px;
  }
</style>

<div class="md-card">
  <h3>Card Title</h3>
  <p>Card content goes here.</p>
</div>
```

**Card variants:**
- **Elevated** — `box-shadow` + `surface-container-low` background
- **Filled** — No shadow + `surface-container-highest` background
- **Outlined** — No shadow + 1px `outline-variant` border

---

## Icons

Use Material Symbols (variable font):

```html
<link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet" />
<span class="material-symbols-outlined">home</span>
<span class="material-symbols-outlined">search</span>
<span class="material-symbols-outlined">settings</span>
```

Within Material Web components, use `<md-icon>`:
```html
<script type="module">import '@material/web/icon/icon.js';</script>
<md-icon>favorite</md-icon>
```

Browse icons at: https://fonts.google.com/icons

---

## Top App Bar (CSS — No Native Component)

Build with HTML and M3 tokens:

```html
<style>
  .top-app-bar {
    display: flex;
    align-items: center;
    height: 64px;
    padding: 0 16px;
    background: var(--md-sys-color-surface, #fff);
    color: var(--md-sys-color-on-surface, #1c1b1f);
    gap: 16px;
  }
  .top-app-bar h1 {
    font-size: 22px;
    font-weight: 400;
    flex: 1;
  }
</style>

<header class="top-app-bar">
  <md-icon-button aria-label="Menu"><md-icon>menu</md-icon></md-icon-button>
  <h1>Page Title</h1>
  <md-icon-button aria-label="Search"><md-icon>search</md-icon></md-icon-button>
  <md-icon-button aria-label="More"><md-icon>more_vert</md-icon></md-icon-button>
</header>
```

---

## Navigation Rail (CSS — No Native Component)

```html
<style>
  .nav-rail {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 80px;
    padding: 12px 0;
    background: var(--md-sys-color-surface, #fff);
    gap: 12px;
    height: 100vh;
    position: fixed;
    left: 0;
    top: 0;
  }
  .nav-rail-item {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 4px;
    font-size: 12px;
    color: var(--md-sys-color-on-surface-variant, #49454f);
    cursor: pointer;
    text-decoration: none;
  }
  .nav-rail-item.active {
    color: var(--md-sys-color-on-secondary-container, #1d192b);
  }
  .nav-rail-item.active .nav-indicator {
    background: var(--md-sys-color-secondary-container, #e8def8);
    border-radius: 16px;
    padding: 4px 20px;
  }
</style>

<nav class="nav-rail">
  <md-fab size="small" aria-label="Compose"><md-icon slot="icon">edit</md-icon></md-fab>
  <div style="height: 20px"></div>
  <a class="nav-rail-item active">
    <span class="nav-indicator"><md-icon>home</md-icon></span>
    Home
  </a>
  <a class="nav-rail-item">
    <md-icon>explore</md-icon>
    Explore
  </a>
  <a class="nav-rail-item">
    <md-icon>settings</md-icon>
    Settings
  </a>
</nav>
```
