---
name: gis-map-builder
description: '**WORKFLOW SKILL** — Build interactive map prototypes in the browser using Leaflet.js, GeoJSON, and open tile services. USE FOR: interactive maps; GIS visualization; geospatial data; mapping; choropleth; heatmap; marker clusters; route display; polygon overlay; point data; tile layers; OpenStreetMap; geocoding; location picker; spatial analysis; map dashboard; territory map; store locator; delivery zone; service area; census data; zip code map; county map; state map; geofence; lat/lng plotting; coordinate display; custom map pins; layer toggle; map legend; satellite imagery; street map; topographic map. DO NOT USE FOR: production GIS systems (use Mapbox GL JS or ArcGIS SDK); 3D globe rendering; offline maps; native mobile mapping; server-side spatial queries.'
argument-hint: 'Describe the map, data, and interactions you want to prototype'
---

# GIS Map Builder

Create self-contained HTML prototypes with interactive maps, geographic data overlays, and spatial UX patterns using Leaflet.js and open data sources.

## When to Use

- Prototyping an interactive map view for a web application
- Visualizing geographic or location-based data (points, polygons, heatmaps)
- Building a store locator, service area map, or territory dashboard
- Displaying GeoJSON data on a map with popups, tooltips, and legends
- Creating a choropleth map from census, demographic, or statistical data
- Demonstrating route display, delivery zones, or geofenced areas
- Exploring map tile providers and layer switching UX

## Procedure

### Step 1 — Clarify the Map Requirements

Determine from the user's request:

- **Map type**: point map, choropleth, heatmap, cluster map, route map, polygon overlay, or multi-layer dashboard
- **Data**: what geographic data to display — user-provided, sample/mock, or sourced from an open API
- **Interactions**: popups, tooltips, filtering, layer toggles, search/geocoding, click events
- **Base tiles**: street (OpenStreetMap), satellite (Esri), terrain (OpenTopoMap), dark mode (CartoDB Dark Matter), or light (CartoDB Positron)
- **Bounds**: specific region (city, state, country) or world view

If the request is ambiguous, ask one clarifying question before proceeding.

### Step 2 — Source the Geographic Data

Match the user's data needs to the right approach. See the [data sources reference](./references/data-sources.md) for full details.

**Decision tree:**

1. **User provides data** (CSV, GeoJSON, coordinates) → Parse and convert to GeoJSON in-page
2. **Standard boundaries needed** (states, counties, countries) → Fetch GeoJSON from open APIs at runtime
3. **Point data needed** (cities, landmarks, addresses) → Embed coordinates directly or use a geocoding API
4. **Mock/sample data** → Generate realistic GeoJSON inline with plausible coordinates and properties

**Data format:** Always normalize to GeoJSON (`FeatureCollection` with `Feature` objects) for Leaflet consumption. If the user provides CSV with lat/lng columns, convert to GeoJSON point features in JavaScript.

### Step 3 — Set Up the HTML File

Start from the [map template](./assets/map-template.html) which includes:

- Leaflet.js CSS and JS via CDN (`unpkg.com/leaflet`)
- Leaflet plugins via CDN (loaded only when needed):
  - `leaflet.markercluster` — for point clustering
  - `leaflet-heat` — for heatmaps
  - `leaflet-search` — for search/geocode
- A full-viewport map container
- Responsive design with no scroll issues
- A clean control layout

**CDN URLs (pinned versions):**
```
https://unpkg.com/leaflet@1.9.4/dist/leaflet.css
https://unpkg.com/leaflet@1.9.4/dist/leaflet.js
https://unpkg.com/leaflet.markercluster@1.5.3/dist/MarkerCluster.css
https://unpkg.com/leaflet.markercluster@1.5.3/dist/MarkerCluster.Default.css
https://unpkg.com/leaflet.markercluster@1.5.3/dist/leaflet.markercluster.js
https://unpkg.com/leaflet.heat@0.2.0/dist/leaflet-heat.js
```

### Step 4 — Configure the Tile Layer

Choose a base map tile provider based on the use case:

| Provider | URL Template | Best For |
|----------|-------------|----------|
| OpenStreetMap | `https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png` | General purpose, street-level detail |
| CartoDB Positron | `https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png` | Light/minimal background for data overlays |
| CartoDB Dark Matter | `https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png` | Dark mode, heatmaps, glowing overlays |
| Esri World Imagery | `https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}` | Satellite/aerial photography |
| OpenTopoMap | `https://{s}.tile.opentopomap.org/{z}/{x}/{y}.png` | Terrain and elevation |
| Stamen Watercolor | `https://tiles.stadiamaps.com/tiles/stamen_watercolor/{z}/{x}/{y}.jpg` | Artistic/presentation maps |

Always include proper attribution in the tile layer options. For multi-base-layer maps, use `L.control.layers()` to let users switch.

### Step 5 — Add Data Layers

Build the appropriate layer type for the data:

**Point data — Markers:**
```javascript
L.geoJSON(pointData, {
  pointToLayer: (feature, latlng) => L.circleMarker(latlng, {
    radius: 8,
    fillColor: '#6750A4',
    color: '#fff',
    weight: 2,
    fillOpacity: 0.8
  })
}).addTo(map);
```

**Point data — Clustered:**
Use `L.markerClusterGroup()` when there are more than ~50 points to avoid visual clutter.

**Polygon data — Choropleth:**
```javascript
L.geoJSON(polygonData, {
  style: feature => ({
    fillColor: getColor(feature.properties.value),
    weight: 1,
    color: '#666',
    fillOpacity: 0.7
  })
}).addTo(map);
```

Define a `getColor()` function using a sequential color scale (see Step 6).

**Heatmap:**
```javascript
const heat = L.heatLayer(latLngArray, {
  radius: 25,
  blur: 15,
  maxZoom: 12,
  gradient: { 0.2: '#ffffb2', 0.4: '#fd8d3c', 0.6: '#f03b20', 0.8: '#bd0026' }
}).addTo(map);
```

**Lines / Routes:**
```javascript
L.polyline(coordinates, {
  color: '#6750A4',
  weight: 4,
  opacity: 0.8
}).addTo(map);
```

See the [Leaflet patterns reference](./references/leaflet-patterns.md) for advanced layer techniques.

### Step 6 — Apply a Color System

Use perceptually uniform color scales appropriate for the data type:

**Sequential (low → high):**
- Blues: `['#eff3ff','#bdd7e7','#6baed6','#3182bd','#08519c']`
- Greens: `['#edf8e9','#bae4b3','#74c476','#31a354','#006d2c']`
- Reds/Oranges: `['#ffffb2','#fecc5c','#fd8d3c','#f03b20','#bd0026']`

**Diverging (low ↔ midpoint ↔ high):**
- Red-Blue: `['#ca0020','#f4a582','#f7f7f7','#92c5de','#0571b0']`

**Categorical (distinct groups):**
- `['#6750A4','#E8175D','#1B9E77','#D95F02','#7570B3','#E7298A','#66A61E','#E6AB02']`

Build a `getColor(value)` function that maps data values to these scales using thresholds or quantile breaks.

### Step 7 — Add Interactivity

**Popups** (click to open):
```javascript
layer.bindPopup(`<strong>${feature.properties.name}</strong><br>Value: ${feature.properties.value}`);
```

**Tooltips** (hover):
```javascript
layer.bindTooltip(feature.properties.name, { sticky: true });
```

**Highlight on hover** (for polygons):
```javascript
function highlightFeature(e) {
  const layer = e.target;
  layer.setStyle({ weight: 3, color: '#666', fillOpacity: 0.9 });
  layer.bringToFront();
}
function resetHighlight(e) {
  geojsonLayer.resetStyle(e.target);
}
```

**Layer toggle control:**
```javascript
const overlays = { 'Points': pointLayer, 'Zones': zoneLayer };
L.control.layers(baseMaps, overlays).addTo(map);
```

**Fit bounds to data:**
```javascript
map.fitBounds(geojsonLayer.getBounds().pad(0.1));
```

### Step 8 — Add Map Controls and Legend

**Legend** (custom Leaflet control):
```javascript
const legend = L.control({ position: 'bottomright' });
legend.onAdd = function() {
  const div = L.DomUtil.create('div', 'legend');
  // Build legend HTML with color swatches and labels
  return div;
};
legend.addTo(map);
```

Style the legend with a white/dark background, border-radius, padding, and a subtle shadow for readability.

**Other useful controls:**
- Scale bar: `L.control.scale().addTo(map)`
- Fullscreen toggle (CSS-based)
- Info panel that updates on hover/click
- Filter controls (buttons, dropdowns, or checkboxes) outside the map that filter layers

### Step 9 — Style the Page

Apply clean styling around the map:

- **Full-viewport map:** `html, body, #map { margin: 0; height: 100%; }`
- **Map + sidebar:** Use flexbox with the sidebar at 300–400px and the map filling the rest
- **Map + header:** Fixed header with the map below using `calc(100vh - header-height)`
- **Dashboard with map:** CSS Grid with the map in one cell and stats/filters in others

Use `font-family: 'Inter', 'Roboto', system-ui, sans-serif` for UI elements overlaying the map.

### Step 10 — Deliver the Prototype

- Save as a single `.html` file — all CSS inline, data embedded or fetched from public APIs
- Ensure it opens correctly in a browser with no build step and no API keys required
- Verify the map renders, data loads, and interactions work
- If displaying runtime-fetched data, add a loading indicator and handle fetch failures gracefully
- If the user wants multiple map views, create separate HTML files or use tab/view switching within one file

## References

- [Data Sources Reference](./references/data-sources.md) — Open APIs, boundary files, and data conversion patterns
- [Leaflet Patterns Reference](./references/leaflet-patterns.md) — Advanced layer techniques, plugin usage, and UX patterns
- [Map Template](./assets/map-template.html) — Starter HTML file with Leaflet setup
