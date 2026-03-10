---
title: ## CCDC DustBoy API Endpoints
tags: [ccdc, dustboy, api, json, sensors, phd]
created: 2026-01-03
source: CCDC fullmap.php source code analysis 2026-01-03
---

# ## CCDC DustBoy API Endpoints

## CCDC DustBoy API Endpoints

**Public JSON APIs (sensor locations):**
- `https://cmu.cmuccdc.org/assets/js/fullmap/ccdc_phase1.json` - 100 sensors
- `https://cmu.cmuccdc.org/assets/js/fullmap/ccdc_phase2.json` - 120 sensors
- `https://cmu.cmuccdc.org/assets/js/fullmap/ccdc_phase3.json` - 200 sensors
- `https://cmu.cmuccdc.org/assets/js/fullmap/ccdc_phase42.json` - 500 sensors

**Schema:**
```json
{
  "dustboy_name": "โรงพยาบาล...",
  "dustboy_lat": "19.168",
  "dustboy_lon": "99.987",
  "phase": "1",
  "area": "เหนือ"
}
```

**Other APIs:**
- `https://api.anurakplatform.com/pm25/request/` - Satellite PM2.5
- `https://www.cmuccdc.org/open-api` - Official API docs

**Real-time data:** MQTT subscription → InfluxDB (not public)

---
*Added via Oracle Learn*
