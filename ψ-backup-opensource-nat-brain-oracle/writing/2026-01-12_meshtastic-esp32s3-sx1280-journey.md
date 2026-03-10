# Flashing Meshtastic to ESP32-S3 + SX1280: A Debugging Journey

**Date**: 2026-01-12
**Status**: Ready

---

## The Goal

Flash Meshtastic firmware to a custom ESP32-S3 board with SX1280 2.4GHz LoRa module. Should be simple, right?

## The Reality

Three hours of boot loops, frozen uploads, and hardware mysteries.

## What Went Wrong (And How We Fixed It)

### 1. The Flash Size Mystery

**Symptom**: Device boot loops with cryptic error:
```
E (346) spi_flash: Detected size(4096k) smaller than the size in the binary image header(8192k)
```

**Assumption**: Board has 4MB flash, no PSRAM.

**Reality**: esptool revealed the truth:
```
Auto-detected Flash size: 4MB
Embedded PSRAM 2MB (AP_3v3)
```

**Lesson**: Don't assume hardware specs. Let tools detect them.

### 2. The Silent USB Freeze

**Symptom**: `pio upload` hangs forever. No error. No output. Just... frozen.

**Root cause**: `ARDUINO_USB_MODE=0` instead of `1`.

**Fix**: One character change in platformio.ini:
```ini
-DARDUINO_USB_MODE=1  # Not 0!
```

**Lesson**: Silent failures are the hardest. When abstractions fail, go direct.

### 3. The Existing Solution

After creating three new variant configs, discovered an existing one:
```
~/meshtastic-firmware/variants/esp32s3/diy/custom_sx1280_board/
```

Already had correct pins, USB mode, everything.

**Lesson**: Search before create. `find` and `grep` are your friends.

### 4. GPS That Won't Power On

Configured GPS pins via CLI:
```bash
meshtastic --set position.gps_en_gpio 47
meshtastic --set position.gps_enabled true
```

GPS power still off. Why?

**Root cause**: variant.h had `#define HAS_GPS 0`

Compile-time config beats runtime config. Always.

**Lesson**: Understand what's baked into firmware vs what's configurable.

## The Working Setup

```c
// variant.h - SX1280 pins
#define USE_SX1280
#define LORA_SCK 12
#define LORA_MISO 13
#define LORA_MOSI 11
#define LORA_CS 10
#define SX128X_DIO1 18
#define SX128X_BUSY 17
#define SX128X_RESET 16
```

```bash
# Flash with esptool (when pio freezes)
esptool.py --chip esp32s3 -p /dev/ttyACM0 \
  write_flash --flash_size detect \
  0x0 bootloader.bin \
  0x10000 firmware.bin
```

## Bonus: tmux Skill Refinement

Along the way, refined a remote session management skill:

**Before** (broken):
```bash
./run.sh host session "command"  # Session dies when command ends
```

**After** (works):
```bash
./run.sh host session            # Persistent bash
./send.sh host session "command" # Send to persistent shell
./send.sh host session "C-c"     # Can interrupt
```

Small pattern change. Big usability improvement.

## Key Takeaways

1. **Tools reveal truth** - esptool > assumptions
2. **Search before create** - existing solutions often exist
3. **Compile-time vs runtime** - know what's baked in
4. **Direct beats abstract** - when wrappers fail, go raw
5. **Silent failures hurt most** - add logging everywhere

## The Result

```
Connected to radio
Owner: Meshtastic 5c4c
Firmware: 2.7.18
LoRa: LORA_24 (2.4GHz)
Status: Working!
```

Next: Rebuild with GPS enabled (`HAS_GPS 1`).

## The Handoff Pattern

Created a handoff file for next session with:
- Exact steps to rebuild with GPS
- Device status table
- Key file locations

This "external brain" pattern works. Write down what your future self needs to know. Nothing more.

---

*Built with Claude Code + tmux skill + lots of patience*
