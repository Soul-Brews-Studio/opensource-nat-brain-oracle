# Meshtastic SX1280 2.4GHz Custom Build Report

**Date**: 2026-01-12
**Author**: Nat (via Claude)
**Location**: `/home/floodboy/meshtastic-firmware` on white.local
**Branch**: `feat/custom-sx1280-board`

---

## Overview

A custom Meshtastic firmware build for 2.4GHz LoRa using the SX1280 chip instead of the typical 900MHz SX1276/SX1262.

**Why 2.4GHz?**
- 2.4GHz LoRa (LORA_24) operates in 2400-2483.5 MHz ISM band
- Globally license-free (unlike 900MHz which varies by region)
- Higher data rates possible
- Smaller antennas
- Trade-off: shorter range than sub-GHz

---

## Hardware Specifications

### MCU: ESP32-S3

| Spec | Value |
|------|-------|
| Module | ESP32-S3-DevKitC-1 |
| USB | Native USB CDC |
| Upload Port | `/dev/ttyACM0` |
| Upload Speed | 921600 baud |

### Radio: SX1280

| Spec | Value |
|------|-------|
| Chip | Semtech SX1280 |
| Frequency | 2400-2483.5 MHz |
| Max Power | 10 dBm |
| Modulation | LoRa 2.4GHz |

### Pin Mapping

#### SPI (HSPI/SPI2)
| Function | GPIO |
|----------|------|
| SCK | 12 |
| MISO | 13 |
| MOSI | 11 |
| CS/NSS | 10 |

#### SX1280 Control
| Function | GPIO |
|----------|------|
| DIO1/IRQ | 18 |
| BUSY | 17 |
| RESET | 16 |
| RXEN (RF Switch) | 14 |
| TXEN (RF Switch) | 15 |

#### LEDs (5 total)
| LED | GPIO |
|-----|------|
| Primary | 35 |
| LED 2 | 36 |
| LED 3 | 37 |
| LED 4 | 38 |
| LED 5 | 7 |

#### Button
| Function | GPIO |
|----------|------|
| Boot/User Button | 0 (needs pullup) |

---

## Software Setup

### Prerequisites

```bash
# Install PlatformIO
pip install platformio

# Clone Meshtastic firmware
git clone https://github.com/meshtastic/firmware.git meshtastic-firmware
cd meshtastic-firmware

# Create custom branch
git checkout -b feat/custom-sx1280-board
```

### Create Custom Variant

#### 1. Create directory structure
```bash
mkdir -p variants/esp32s3/diy/custom_sx1280_board
```

#### 2. Create `variant.h`

```cpp
// variants/esp32s3/diy/custom_sx1280_board/variant.h

// Custom SX1280 2.4GHz Board Variant for ESP32-S3

// Disable GPS and screen
#define HAS_GPS 0
#define HAS_SCREEN 0
#define HAS_WIRE 0

// LED configuration
#define LED_PIN 35
#define LED_PIN_2 36
#define LED_PIN_3 37
#define LED_PIN_4 38
#define LED_PIN_5 7

// Button
#define BUTTON_PIN 0
#define BUTTON_NEED_PULLUP

// SX1280 2.4GHz LoRa
#define USE_SX1280

// SPI pins
#define LORA_SCK 12
#define LORA_MISO 13
#define LORA_MOSI 11
#define LORA_CS 10

// SX1280 control pins
#define SX128X_CS 10
#define SX128X_DIO1 18
#define SX128X_BUSY 17
#define SX128X_RESET 16
#define SX128X_RXEN 14
#define SX128X_TXEN 15
#define SX128X_MAX_POWER 10

// USB CDC
#define USE_USB_CDC
#define ARDUINO_USB_MODE 1
#define ARDUINO_USB_CDC_ON_BOOT 1
```

#### 3. Create `platformio.ini` entry

```ini
; variants/esp32s3/diy/custom_sx1280_board/platformio.ini

[env:custom_sx1280_board_s3]
extends = esp32s3_base
board = esp32-s3-devkitc-1
board_level = extra
upload_protocol = esptool
upload_port = /dev/ttyACM0
upload_speed = 921600
monitor_speed = 115200
monitor_port = /dev/ttyACM0

build_flags =
  ${esp32s3_base.build_flags}
  -D PRIVATE_HW
  -D CUSTOM_SX1280_BOARD_S3
  -I variants/esp32s3/diy/custom_sx1280_board
  -D ARDUINO_USB_MODE=1
  -D ARDUINO_USB_CDC_ON_BOOT=1
  -O2

lib_deps =
  ${esp32s3_base.lib_deps}
```

---

## Build & Flash

### Option 1: Using flash script

```bash
# Create flash script
cat > flash_custom_board.sh << 'EOF'
#!/bin/bash
echo "🔧 Custom SX1280 Board Flash Tool"

# Find device
DEVICE=$(ls /dev/ttyACM* 2>/dev/null | head -1)
if [ -z "$DEVICE" ]; then
    echo "❌ No device found. Connect ESP32-S3 and try again."
    exit 1
fi

echo "📤 Flashing to $DEVICE..."
~/.local/bin/platformio run -e custom_sx1280_board_s3 --target upload --upload-port "$DEVICE"

if [ $? -eq 0 ]; then
    echo "✅ Flash successful!"
    read -p "Monitor serial? (y/n): " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] && ~/.local/bin/platformio device monitor --port "$DEVICE" --baud 115200
fi
EOF

chmod +x flash_custom_board.sh
./flash_custom_board.sh
```

### Option 2: Manual PlatformIO

```bash
# Build
platformio run -e custom_sx1280_board_s3

# Flash
platformio run -e custom_sx1280_board_s3 --target upload

# Monitor
platformio device monitor --baud 115200
```

### USB Permissions (Linux)

```bash
# Create udev rules
sudo tee /etc/udev/rules.d/99-esp32-custom.rules << 'EOF'
# ESP32-S3 USB JTAG/serial debug
SUBSYSTEM=="tty", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1001", MODE="0666", GROUP="plugdev"
# ESP32-S3 USB CDC
SUBSYSTEM=="tty", ATTRS{idVendor}=="303a", ATTRS{idProduct}=="1002", MODE="0666", GROUP="plugdev"
EOF

# Reload rules
sudo udevadm control --reload-rules
sudo udevadm trigger

# Add user to plugdev
sudo usermod -a -G plugdev $USER
# Logout/login for group change
```

---

## Git Commits

| Hash | Description |
|------|-------------|
| `aab8f70` | Complete custom SX1280 board implementation |
| `f721b7c` | Add full LED support and button configuration |
| `ccb6982` | Add session retrospective documentation |
| `a38b8d0` | Add custom SX1280 2.4GHz board variant |

---

## Testing

1. **Flash firmware** using script or platformio
2. **Monitor serial** - should see Meshtastic boot messages
3. **Use Meshtastic app** to connect via Bluetooth (if enabled) or USB serial
4. **Set region** to `LORA_24` in app settings

---

## Notes

- No GPS, screen, or I2C on this minimal build
- RF switch control (RXEN/TXEN) required for some SX1280 modules
- 10 dBm max power per LORA_24 specification
- 5 LEDs available for custom status indication

---

## Discovery Story (from Thread #19 & Retrospective)

### Why 2.4GHz?
- User already had SX1280 hardware (the chip choice drove the project)
- 2.4GHz ISM band is globally available (unlike 900MHz regional restrictions)
- Higher bandwidth potential for shorter range mesh networking

### Key Challenges Overcome

| Challenge | What Happened | Solution |
|-----------|---------------|----------|
| Wrong MCU | Assumed ESP32, was ESP32-S3 with 8MB PSRAM | Used `esptool` to detect actual hardware |
| Serial conflicts | ESP32-S3 USB CDC conflicts with `#define Serial` | Removed explicit Serial defines |
| Boot loops | Watchdog resets, NodeDB init failing | Progressive simplification - "less is more" |
| Partition mismatch | 16MB flash with wrong partition scheme | Erased flash completely, correct partition |

### Session Timeline (2025-08-25, ~50 minutes)
```
22:30 - Started with Arduino test code showing pin mappings
22:40 - Analyzed Meshtastic firmware structure
22:50 - Created initial ESP32 variant (WRONG!)
22:53 - esptool revealed ESP32-S3 with 8MB PSRAM
22:55 - Migrated to ESP32-S3 variant structure
23:08 - Build OK but boot loops
23:10 - Simplified variant.h, removed I2C/button conflicts
23:20 - SUCCESS! Device booted and transmitted on LORA_24
```

### Key Insight
> **No radio driver changes needed!** Meshtastic's existing `SX128xInterface` template handles the SX1280. Just set `USE_SX1280` and configure pins.

---

## Lessons Learned (from original session)

1. **Always verify hardware with esptool** before creating variants
2. **Start minimal** - add features incrementally, not all at once
3. **ESP32-S3 USB CDC** doesn't need Serial redefinition - conflicts with built-in handling
4. **Boot loops** often indicate peripheral conflicts - simplify to isolate

---

## Source Documents

- **Original retrospective**: `/home/floodboy/meshtastic-firmware/retrospectives/2025/08/2025-08-25_16-20_retrospective.md`
- **Thread #19** in Oracle - multi-AI conversation about this project
- **Git branch**: `feat/custom-sx1280-board`

---

*Report compiled from multiple sources including Oracle Thread #19, session retrospective, and direct code analysis.*
*2026-01-12*
