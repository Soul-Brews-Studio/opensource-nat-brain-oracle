---
title: ## Laris Meshtastic GPS Tracker - Full Configuration
tags: [meshtastic, esp32-s3, sx1280, gps-tracker, lora, mqtt, configuration, laris]
created: 2026-01-12
source: GPS Tracker setup session 2026-01-12
---

# ## Laris Meshtastic GPS Tracker - Full Configuration

## Laris Meshtastic GPS Tracker - Full Configuration

### Hardware
- ESP32-S3 + SX1280 (2.4GHz LoRa)
- 4MB flash + 2MB PSRAM
- Board: `adafruit_feather_esp32s3`

### Pin Mapping
| Function | GPIO |
|----------|------|
| GPS RX | 41 |
| GPS TX | 42 |
| GPS Enable | 47 |
| LoRa SCK | 12 |
| LoRa MISO | 13 |
| LoRa MOSI | 11 |
| LoRa CS | 10 |
| LoRa DIO1 | 18 |
| LoRa BUSY | 17 |
| LoRa RESET | 16 |
| LoRa RXEN | 14 |
| LoRa TXEN | 15 |

### Configuration (Always-On Tracker)
```bash
# GPS
position.rx_gpio=41
position.tx_gpio=42
position.gps_en_gpio=47
position.gps_mode=ENABLED
position.gps_update_interval=15
position.position_broadcast_secs=30
position.position_flags=8191  # All flags

# Power (no sleep - powered device)
power.is_power_saving=false
power.wait_bluetooth_secs=0
power.ls_secs=0

# MQTT
mqtt.enabled=true
mqtt.address=mqtt.laris.co
mqtt.username=nat
mqtt.json_enabled=true
mqtt.map_report_enabled=true

# Device
device.tzdef=GMT-7
lora.region=LORA_24
telemetry.device_update_interval=30
```

### Private Repo
https://github.com/laris-co/laris-meshtastic

### Key Files
- `variants/custom_sx1280_board/variant.h`
- `variants/custom_sx1280_board/platformio.ini`
- `configure.sh` - Apply all settings
- `build.sh` - Build firmware
- `flash.sh` - Flash to device

---
*Added via Oracle Learn*
