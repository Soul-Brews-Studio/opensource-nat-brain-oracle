---
title: # Meshtastic Device Fleet (Jan 2026)
tags: [meshtastic, laris, device-fleet, esp32-s3, sx1280, mqtt, gps]
created: 2026-01-13
source: Session 2026-01-13: Flash Laris-4 and Laris-5
---

# # Meshtastic Device Fleet (Jan 2026)

# Meshtastic Device Fleet (Jan 2026)

## Deployed Devices

| Name | MAC | Date | Status |
|------|-----|------|--------|
| Laris-1 | - | Jan 12 | ✅ Active |
| Laris-2 | - | Jan 12 | ✅ Active |
| Laris-3 | - | Jan 12 | ✅ Active |
| Laris-4 | 48:27:e2:8a:5b:ec | Jan 13 | ✅ Active |
| Laris-5 | 48:27:e2:8a:5c:88 | Jan 13 | ✅ Active |

## Standard Configuration

- **GPS**: RX=41, TX=42, EN=47
- **LoRa**: Region LORA_24 (2.4GHz), tx_power=13 (max)
- **MQTT**: mqtt.laris.co (enabled, JSON, map report)
- **Power**: Always-on (no sleep)
- **Telemetry**: 30s device + environment updates
- **Position**: 15s GPS update, 30s broadcast

## Flash Commands

```bash
# From local
cd /Users/nat/Code/github.com/laris-co/laris-meshtastic
./flash.sh white.local
./configure.sh white.local

# Set name + max power
ssh nat@white.local "~/.local/bin/uvx meshtastic --port /dev/ttyACM0 \
  --set-owner 'Laris-N' --set-owner-short 'LN' \
  --set lora.tx_power 13"
```

---
*Added via Oracle Learn*
