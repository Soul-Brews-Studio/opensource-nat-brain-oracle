---
title: ## ESP32-S3 4MB Flash Build Fix
tags: [esp32-s3, platformio, flash-size, bootloader, meshtastic, 4mb]
created: 2026-01-12
source: Meshtastic GPS rebuild session 2026-01-12
---

# ## ESP32-S3 4MB Flash Build Fix

## ESP32-S3 4MB Flash Build Fix

**Problem**: Firmware boot loops with "Detected size(4096k) smaller than the size in the binary image header(8192k)"

**Root Cause**: Board definition `esp32-s3-devkitc-1` has 8MB flash. Setting `board_build.flash_size = 4MB` alone doesn't fix it - the bootloader embeds flash size from board JSON.

**Solution**: Use a 4MB board definition:
```ini
board = adafruit_feather_esp32s3  # Has 4MB flash
board_build.flash_size = 4MB
board_build.partitions = partition-table.csv
```

**Key Insight**: The bootloader binary itself contains the flash size. You must use a board JSON that matches your actual hardware flash size.

---
*Added via Oracle Learn*
