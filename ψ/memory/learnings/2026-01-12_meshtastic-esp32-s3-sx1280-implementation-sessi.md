---
title: ## Meshtastic ESP32-S3 SX1280 Implementation Session (2025-08-25)
tags: [meshtastic, esp32-s3, sx1280, lora, 2.4ghz, firmware, hardware-porting, reunion, white.local]
created: 2026-01-12
source: reunion-data sync from white.local
---

# ## Meshtastic ESP32-S3 SX1280 Implementation Session (2025-08-25)

## Meshtastic ESP32-S3 SX1280 Implementation Session (2025-08-25)

**Source**: Synced from white.local via reunion-data

### Session Summary
50-minute session implementing custom ESP32-S3 board variant with SX1280 2.4GHz LoRa module for Meshtastic firmware.

### Key Challenges & Solutions
1. **Wrong MCU** - Assumed ESP32, was ESP32-S3 with 8MB PSRAM → Used esptool to detect
2. **Serial conflicts** - ESP32-S3 USB CDC doesn't need `#define Serial` → Removed explicit defines
3. **Boot loops** - Watchdog resets from peripheral conflicts → Progressive simplification
4. **Partition mismatch** - 16MB flash wrong scheme → Erased flash, correct partition

### Hardware Config
- MCU: ESP32-S3-DevKitC-1 (8MB PSRAM, 16MB Flash)
- Radio: SX1280 2.4GHz LoRa (10 dBm max)
- SPI: SCK=12, MISO=13, MOSI=11, CS=10
- SX1280: DIO1=18, BUSY=17, RESET=16, RXEN=14, TXEN=15

### Key Insight
No radio driver changes needed - Meshtastic's SX128xInterface template handles SX1280. Just set `USE_SX1280` and configure pins.

### Reunion Data
- Synced: 2026-01-12
- Location: reunion-data/projects/meshtastic-firmware/retrospectives/

---
*Added via Oracle Learn*
