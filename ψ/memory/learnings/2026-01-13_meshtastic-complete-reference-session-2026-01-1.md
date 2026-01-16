---
title: # Meshtastic Complete Reference (Session 2026-01-13)
tags: [meshtastic, esp32-s3, sx1280, lora, gps, flash, esptool, white.local, ssh, position, logging, reference]
created: 2026-01-13
source: Session 2026-01-13: Complete Meshtastic exploration
---

# # Meshtastic Complete Reference (Session 2026-01-13)

# Meshtastic Complete Reference (Session 2026-01-13)

## SSH to white.local

```bash
# Local LAN
ssh nat@white.local

# Remote (Cloudflare Tunnel)
ssh nat@floodboy-white4.alchemycat.org

# Tailscale
ssh nat@white
```

## Build & Flash Workflow

```bash
# Clone repo
ghq get laris-co/laris-meshtastic
cd /Users/nat/Code/github.com/laris-co/laris-meshtastic

# Build on white.local (remote)
./build.sh white.local

# Check USB device
ssh nat@white.local "lsusb | grep -i esp; ls /dev/ttyACM*"

# Flash
./flash.sh white.local

# Configure GPS + MQTT
./configure.sh white.local
```

## Manual Flash (esptool)

```bash
ssh nat@white.local
cd ~/laris-meshtastic-build

~/.local/bin/esptool.py --chip esp32s3 -p /dev/ttyACM0 -b 921600 \
  write_flash 0x0 .pio/build/custom_sx1280_board_s3/firmware-*.factory.bin
```

## Device Configuration

```bash
# Set name + max power
~/.local/bin/uvx meshtastic --port /dev/ttyACM0 \
  --set-owner 'Laris-N' --set-owner-short 'LN' \
  --set lora.tx_power 13

# GPS pins (already in configure.sh)
meshtastic --set position.rx_gpio 41 \
  --set position.tx_gpio 42 \
  --set position.gps_en_gpio 47 \
  --set position.gps_mode ENABLED
```

## Get Position Data

```bash
# List all nodes with positions
meshtastic --nodes

# Full device info with position JSON
meshtastic --info

# Request position from specific node
meshtastic --request-position --dest '!e28a5c54'

# Export full config
meshtastic --export-config
```

## Position Logging (No WiFi)

```bash
# USB serial logger to CSV
uv run position-logger.py --port /dev/ttyACM0 --output positions.csv
```

## Debugging

```bash
# Check device MAC before flash
~/.local/bin/esptool.py --port /dev/ttyACM0 chip_id

# Serial log
meshtastic --seriallog stdout

# Kill locked port
fuser -k /dev/ttyACM0
```

## Paths

| Location | Path |
|----------|------|
| Local repo | `/Users/nat/Code/github.com/laris-co/laris-meshtastic` |
| Build dir (white) | `~/laris-meshtastic-build/` |
| Binaries | `.pio/build/custom_sx1280_board_s3/` |
| Factory bin | `firmware-custom_sx1280_board_s3-2.7.18.factory.bin` |

## Hardware Specs

- MCU: ESP32-S3 (4MB flash, 2MB PSRAM)
- Board: adafruit_feather_esp32s3
- Radio: SX1280 (2.4GHz LoRa)
- GPS: UART (RX=41, TX=42, EN=47)
- LoRa SPI: SCK=12, MISO=13, MOSI=11, CS=10
- LoRa Ctrl: DIO1=18, BUSY=17, RST=16, RXEN=14, TXEN=15

## Device Fleet (Jan 2026)

| Name | MAC | Status |
|------|-----|--------|
| Laris-1 | - | Active |
| Laris-2 | - | Active |
| Laris-3 | - | Active |
| Laris-4 | 48:27:e2:8a:5b:ec | Active |
| Laris-5 | 48:27:e2:8a:5c:88 | Active |

---
*Added via Oracle Learn*
