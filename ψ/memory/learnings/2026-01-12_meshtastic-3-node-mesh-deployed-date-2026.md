---
title: ## Meshtastic 3-Node Mesh Deployed
tags: [meshtastic, mesh-network, laris, gps-tracker, 3-node, deployed]
created: 2026-01-12
source: 3-node mesh deployment 2026-01-12
---

# ## Meshtastic 3-Node Mesh Deployed

## Meshtastic 3-Node Mesh Deployed

**Date**: 2026-01-12

### Devices
| Name | Short | Hardware |
|------|-------|----------|
| Laris-1 | L1 | ESP32-S3 + SX1280 |
| Laris-2 | L2 | ESP32-S3 + SX1280 |
| Laris-3 | L3 | ESP32-S3 + SX1280 |

### Configuration (All Nodes)
- GPS: 5s update, 15s broadcast
- Position flags: 8191 (all data)
- Telemetry: 15s interval
- Region: LORA_24 (2.4GHz)
- Timezone: GMT+7
- Power saving: OFF

### Quick Commands
```bash
# Flash
./flash.sh white.local

# Configure
./configure.sh white.local

# Set name
meshtastic --set-owner 'Laris-N' --set-owner-short 'LN'
```

### Private Repo
github.com/laris-co/laris-meshtastic

### Status
All 3 nodes: GPS working, BLE working, LoRa meshing

---
*Added via Oracle Learn*
