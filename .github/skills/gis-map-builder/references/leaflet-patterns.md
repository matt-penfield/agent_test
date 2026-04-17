# Leaflet Patterns Reference

Advanced layer techniques, plugin usage, and UX patterns for building interactive map prototypes with Leaflet.js.

## Custom Markers

### SVG Circle Markers (Recommended for Data Points)

Circle markers render as SVG, scale well, and are more performant than icon markers for large datasets:

```javascript
L.geoJSON(data, {
  pointToLayer: (feature, latlng) => L.circleMarker(latlng, {
    radius: 8,
    fillColor: getColor(feature.properties.category),
    color: '#fff',
    weight: 2,
    fillOpacity: 0.85
  })
}).addTo(map);
```

### Proportional / Scaled Markers

Scale marker radius by a data value:

```javascript
function getRadius(value) {
  return Math.sqrt(value / Math.PI) * scaleFactor;
}

L.geoJSON(data, {
  pointToLayer: (feature, latlng) => L.circleMarker(latlng, {
    radius: getRadius(feature.properties.population),
    fillColor: '#6750A4',
    color: '#fff',
    weight: 1,
    fillOpacity: 0.7
  })
}).addTo(map);
```

### Custom HTML / Div Markers

For rich marker content (icons, badges, numbers):

```javascript
const icon = L.divIcon({
  className: 'custom-marker',
  html: `<div class="marker-pin" style="background:${color}">${label}</div>`,
  iconSize: [30, 42],
  iconAnchor: [15, 42]
});
L.marker(latlng, { icon }).addTo(map);
```

CSS for a pin-shaped marker:
```css
.custom-marker { background: none; border: none; }
.marker-pin {
  width: 30px; height: 30px;
  border-radius: 50% 50% 50% 0;
  transform: rotate(-45deg);
  display: flex; align-items: center; justify-content: center;
  color: #fff; font-weight: 600; font-size: 12px;
}
.marker-pin > * { transform: rotate(45deg); }
```

## Marker Clustering

When displaying > 50 points, use clustering to avoid visual overload:

```javascript
const markers = L.markerClusterGroup({
  maxClusterRadius: 50,
  spiderfyOnMaxZoom: true,
  showCoverageOnHover: false,
  iconCreateFunction: cluster => {
    const count = cluster.getChildCount();
    let size = 'small';
    if (count > 100) size = 'large';
    else if (count > 10) size = 'medium';
    return L.divIcon({
      html: `<div><span>${count}</span></div>`,
      className: `marker-cluster marker-cluster-${size}`,
      iconSize: L.point(40, 40)
    });
  }
});

data.features.forEach(f => {
  const marker = L.marker([f.geometry.coordinates[1], f.geometry.coordinates[0]]);
  marker.bindPopup(f.properties.name);
  markers.addLayer(marker);
});
map.addLayer(markers);
```

## Choropleth Patterns

### Quantile Breaks

Divide data into equal-count bins:

```javascript
function getQuantileBreaks(values, numClasses) {
  const sorted = [...values].sort((a, b) => a - b);
  const breaks = [];
  for (let i = 1; i < numClasses; i++) {
    const idx = Math.floor((i / numClasses) * sorted.length);
    breaks.push(sorted[idx]);
  }
  return breaks;
}
```

### Natural Breaks (Jenks-like Simplification)

For cleaner break points, use rounded thresholds based on data distribution:

```javascript
function getNaturalBreaks(values, numClasses) {
  const sorted = [...values].sort((a, b) => a - b);
  const min = sorted[0];
  const max = sorted[sorted.length - 1];
  const step = (max - min) / numClasses;
  return Array.from({ length: numClasses - 1 }, (_, i) =>
    Math.round((min + step * (i + 1)) / 10) * 10
  );
}
```

### Color Scale Function

```javascript
function getColor(value, breaks, colors) {
  for (let i = 0; i < breaks.length; i++) {
    if (value <= breaks[i]) return colors[i];
  }
  return colors[colors.length - 1];
}
```

## Interactive Polygon Highlighting

Standard pattern for hover-to-highlight with info panel:

```javascript
let geojsonLayer;
const info = L.control({ position: 'topright' });

info.onAdd = function() {
  this._div = L.DomUtil.create('div', 'info-panel');
  this.update();
  return this._div;
};

info.update = function(props) {
  this._div.innerHTML = props
    ? `<h4>${props.name}</h4><p>Value: ${props.value.toLocaleString()}</p>`
    : '<h4>Hover over a region</h4>';
};

info.addTo(map);

function highlightFeature(e) {
  const layer = e.target;
  layer.setStyle({ weight: 3, color: '#333', fillOpacity: 0.85 });
  layer.bringToFront();
  info.update(layer.feature.properties);
}

function resetHighlight(e) {
  geojsonLayer.resetStyle(e.target);
  info.update();
}

function zoomToFeature(e) {
  map.fitBounds(e.target.getBounds());
}

geojsonLayer = L.geoJSON(data, {
  style: feature => ({ /* choropleth style */ }),
  onEachFeature: (feature, layer) => {
    layer.on({
      mouseover: highlightFeature,
      mouseout: resetHighlight,
      click: zoomToFeature
    });
  }
}).addTo(map);
```

## Legend Control

Reusable legend for choropleth or categorical maps:

```javascript
function addLegend(map, breaks, colors, title = '') {
  const legend = L.control({ position: 'bottomright' });
  legend.onAdd = function() {
    const div = L.DomUtil.create('div', 'legend');
    let html = title ? `<h4>${title}</h4>` : '';
    for (let i = 0; i < colors.length; i++) {
      const from = i === 0 ? 0 : breaks[i - 1];
      const to = breaks[i] || '+';
      html += `<div class="legend-item">
        <span class="legend-swatch" style="background:${colors[i]}"></span>
        ${from.toLocaleString()}${to !== '+' ? ' – ' + to.toLocaleString() : '+'}</div>`;
    }
    div.innerHTML = html;
    return div;
  };
  legend.addTo(map);
}
```

Legend CSS:
```css
.legend {
  background: white;
  padding: 10px 14px;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0,0,0,0.2);
  font: 13px/1.6 'Inter', 'Roboto', system-ui, sans-serif;
  max-width: 200px;
}
.legend h4 { margin: 0 0 8px; font-size: 14px; }
.legend-item { display: flex; align-items: center; gap: 8px; }
.legend-swatch {
  width: 18px; height: 18px;
  border-radius: 3px;
  flex-shrink: 0;
  border: 1px solid rgba(0,0,0,0.1);
}
```

## Layer Switching UX

### Base Map Switcher

```javascript
const baseMaps = {
  'Street': L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
    attribution: '&copy; OpenStreetMap contributors'
  }),
  'Light': L.tileLayer('https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png', {
    attribution: '&copy; CARTO'
  }),
  'Satellite': L.tileLayer('https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}', {
    attribution: '&copy; Esri'
  })
};

baseMaps['Street'].addTo(map);  // Default
L.control.layers(baseMaps, null, { collapsed: false }).addTo(map);
```

### Overlay Toggles with Custom Panel

For more control than the default Leaflet layer control:

```html
<div id="layer-panel">
  <label><input type="checkbox" checked data-layer="points"> Show Points</label>
  <label><input type="checkbox" checked data-layer="zones"> Show Zones</label>
</div>
```

```javascript
const layers = { points: pointLayer, zones: zoneLayer };
document.querySelectorAll('#layer-panel input').forEach(input => {
  input.addEventListener('change', () => {
    const layer = layers[input.dataset.layer];
    input.checked ? map.addLayer(layer) : map.removeLayer(layer);
  });
});
```

## Sidebar / Split-View Pattern

Map with adjacent detail panel:

```css
.map-layout {
  display: flex;
  height: 100vh;
}
.sidebar {
  width: 360px;
  overflow-y: auto;
  background: #fff;
  border-right: 1px solid #e0e0e0;
  padding: 16px;
}
#map {
  flex: 1;
}
```

Sync sidebar with map interactions:
```javascript
layer.on('click', e => {
  document.getElementById('sidebar-content').innerHTML =
    renderDetail(e.target.feature.properties);
  map.flyTo(e.latlng, 14);
});
```

## Loading States and Error Handling

For data fetched at runtime:

```javascript
const loadingControl = L.control({ position: 'topleft' });
loadingControl.onAdd = function() {
  const div = L.DomUtil.create('div', 'loading-indicator');
  div.innerHTML = 'Loading data…';
  return div;
};
loadingControl.addTo(map);

fetch(dataUrl)
  .then(r => {
    if (!r.ok) throw new Error(`HTTP ${r.status}`);
    return r.json();
  })
  .then(data => {
    map.removeControl(loadingControl);
    L.geoJSON(data).addTo(map);
  })
  .catch(err => {
    loadingControl.getContainer().innerHTML = `Failed to load data`;
    console.error(err);
  });
```

## Responsive Map Behavior

Handle window resize and mobile:

```javascript
// Invalidate map size after container resize
window.addEventListener('resize', () => map.invalidateSize());

// Disable scroll zoom on mobile (prevents accidental zoom while scrolling page)
if (window.innerWidth < 600) {
  map.scrollWheelZoom.disable();
}
```

For sidebar collapse on mobile:
```css
@media (max-width: 768px) {
  .map-layout { flex-direction: column; }
  .sidebar { width: 100%; height: 40vh; border-right: none; border-bottom: 1px solid #e0e0e0; }
  #map { height: 60vh; }
}
```
