---
title: # Meshtastic Position Logging (No WiFi)
tags: [meshtastic, position, gps, logging, usb-serial, csv, uv, python]
created: 2026-01-13
source: Session 2026-01-13: Position logging exploration
---

# # Meshtastic Position Logging (No WiFi)

# Meshtastic Position Logging (No WiFi)

## Problem
Meshtastic does NOT store position history - only last known position per node.

## Solution: USB Serial Logger

```bash
# Run on white.local (or any machine with USB connection)
uv run position-logger.py --port /dev/ttyACM0 --output positions.csv
```

## Script Location
`/Users/nat/Code/github.com/laris-co/laris-meshtastic/position-logger.py`

## Output CSV
```csv
timestamp,node_id,latitude,longitude,altitude,device_time
2026-01-13T16:05:00,!e28a5c54,18.7973148,99.0729687,306,1768294683
```

## CLI Quick Reference

```bash
# Get all nodes with last position
meshtastic --info

# Get nodes table view
meshtastic --nodes

# Request position from node
meshtastic --request-position --dest '!e28a5c54'
```

## Key Insight
Without WiFi/MQTT, USB serial is the only way to get position data. The script uses pubsub to listen for position packets and node updates.

---
*Added via Oracle Learn*
