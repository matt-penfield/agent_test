# Data Sources Reference

Open APIs, boundary datasets, and conversion patterns for sourcing geographic data in standalone HTML map prototypes. All sources listed here are free, require no API key, and support cross-origin requests from the browser.

## Boundary GeoJSON APIs

### Natural Earth / World Boundaries

| Dataset | URL | Notes |
|---------|-----|-------|
| World countries | `https://raw.githubusercontent.com/datasets/geo-countries/master/data/countries.geojson` | ~23 MB — filter to needed countries |
| World countries (simplified) | `https://cdn.jsdelivr.net/npm/world-atlas@2/countries-110m.json` | TopoJSON, ~240 KB — use with `topojson-client` |
| World countries (medium detail) | `https://cdn.jsdelivr.net/npm/world-atlas@2/countries-50m.json` | TopoJSON, ~1 MB |

### US Boundaries

| Dataset | URL | Notes |
|---------|-----|-------|
| US states | `https://raw.githubusercontent.com/PublicaMundi/MappingAPI/master/data/geojson/us-states.json` | Simplified, ~80 KB, includes `name` and `density` props |
| US states (detailed) | `https://cdn.jsdelivr.net/npm/us-atlas@3/states-10m.json` | TopoJSON — use with `topojson-client` |
| US counties | `https://cdn.jsdelivr.net/npm/us-atlas@3/counties-10m.json` | TopoJSON, ~700 KB — needs TopoJSON client |

### Converting TopoJSON to GeoJSON in the Browser

When a source provides TopoJSON (`.json` ending in `-Xm.json`), convert it:

```html
<script src="https://unpkg.com/topojson-client@3/dist/topojson-client.min.js"></script>
<script>
  fetch('https://cdn.jsdelivr.net/npm/us-atlas@3/states-10m.json')
    .then(r => r.json())
    .then(topology => {
      const geojson = topojson.feature(topology, topology.objects.states);
      L.geoJSON(geojson).addTo(map);
    });
</script>
```

The `topology.objects` keys vary by file — common keys: `states`, `counties`, `countries`, `land`.

## Point Data Sources

### Geocoding (Address → Coordinates)

**Nominatim (OpenStreetMap)** — Free, no key, rate-limited to 1 req/sec:
```javascript
async function geocode(query) {
  const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(query)}&limit=1`;
  const res = await fetch(url, {
    headers: { 'User-Agent': 'MapPrototype/1.0' }  // Required by Nominatim TOS
  });
  const data = await res.json();
  if (data.length) return [parseFloat(data[0].lat), parseFloat(data[0].lon)];
  return null;
}
```

**Rate limit:** Batch geocoding should add a delay between requests (`setTimeout` with 1100ms).

### Place / POI Data

| Source | URL Pattern | Returns |
|--------|-------------|---------|
| Overpass API (OSM) | `https://overpass-api.de/api/interpreter?data=...` | Restaurants, parks, hospitals, etc. from OSM |
| GeoNames | `http://api.geonames.org/searchJSON?q=...&username=demo` | Cities, landmarks (free tier, demo user for prototypes) |

**Overpass API example — get all hospitals in a bounding box:**
```javascript
const bbox = '40.7,-74.1,40.8,-73.9'; // south,west,north,east
const query = `[out:json];node["amenity"="hospital"](${bbox});out body;`;
const url = `https://overpass-api.de/api/interpreter?data=${encodeURIComponent(query)}`;
```

Convert Overpass results to GeoJSON:
```javascript
function overpassToGeoJSON(data) {
  return {
    type: 'FeatureCollection',
    features: data.elements
      .filter(el => el.lat && el.lon)
      .map(el => ({
        type: 'Feature',
        geometry: { type: 'Point', coordinates: [el.lon, el.lat] },
        properties: el.tags || {}
      }))
  };
}
```

## Statistical / Demographic Data

### US Census API (no key needed for basic endpoints)

| Dataset | URL | Notes |
|---------|-----|-------|
| ACS 5-year (state-level) | `https://api.census.gov/data/2022/acs/acs5?get=NAME,B01003_001E&for=state:*` | Population by state |
| ACS 5-year (county-level) | `https://api.census.gov/data/2022/acs/acs5?get=NAME,B01003_001E&for=county:*&in=state:*` | Population by county |

Join census data to boundary GeoJSON by FIPS code (`feature.properties.STATE` or `feature.id`).

## CSV to GeoJSON Conversion

When the user provides CSV with latitude/longitude columns:

```javascript
function csvToGeoJSON(csvText, latCol = 'latitude', lngCol = 'longitude') {
  const lines = csvText.trim().split('\n');
  const headers = lines[0].split(',').map(h => h.trim());
  const latIdx = headers.indexOf(latCol);
  const lngIdx = headers.indexOf(lngCol);

  const features = lines.slice(1).map(line => {
    const cols = line.split(',').map(c => c.trim());
    const props = {};
    headers.forEach((h, i) => { if (i !== latIdx && i !== lngIdx) props[h] = cols[i]; });
    return {
      type: 'Feature',
      geometry: {
        type: 'Point',
        coordinates: [parseFloat(cols[lngIdx]), parseFloat(cols[latIdx])]
      },
      properties: props
    };
  }).filter(f => !isNaN(f.geometry.coordinates[0]) && !isNaN(f.geometry.coordinates[1]));

  return { type: 'FeatureCollection', features };
}
```

## Common Coordinate Reference Points

For quickly centering maps during prototyping:

| Location | Lat, Lng | Zoom |
|----------|----------|------|
| Continental US | 39.8, -98.6 | 4 |
| New York City | 40.7128, -74.0060 | 12 |
| Los Angeles | 34.0522, -118.2437 | 11 |
| Chicago | 41.8781, -87.6298 | 11 |
| London | 51.5074, -0.1278 | 12 |
| Tokyo | 35.6762, 139.6503 | 11 |
| Sydney | -33.8688, 151.2093 | 12 |
| São Paulo | -23.5505, -46.6333 | 11 |
| World (centered) | 20, 0 | 2 |
| Europe | 50, 10 | 4 |
| Southeast Asia | 5, 110 | 5 |
