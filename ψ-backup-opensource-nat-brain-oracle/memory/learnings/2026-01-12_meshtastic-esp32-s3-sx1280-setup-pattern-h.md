---
title: # Meshtastic ESP32-S3 + SX1280 Setup Pattern
tags: [meshtastic, esp32-s3, sx1280, lora, 2.4ghz, esptool, gps, firmware]
created: 2026-01-12
source: Session 2026-01-12: Meshtastic SX1280 flash success
---

# # Meshtastic ESP32-S3 + SX1280 Setup Pattern

# Meshtastic ESP32-S3 + SX1280 Setup Pattern

## Hardware Discovery
- Board: ESP32-S3 with **4MB flash + 2MB PSRAM** (not 4MB/0 as initially assumed)
- esptool auto-detects: `Auto-detected Flash size: 4MB`, `Embedded PSRAM 2MB (AP_3v3)`
- SX1280 is 2.4GHz LoRa (LORA_24 region)

## Key Configuration (variant.h)
```c
#define USE_SX1280
#define LORA_SCK 12
#define LORA_MISO 13
#define LORA_MOSI 11
#define LORA_CS 10
#define SX128X_DIO1 18
#define SX128X_BUSY 17
#define SX128X_RESET 16
#define SX128X_RXEN 14
#define SX128X_TXEN 15
```

## USB Mode Fix
- Use `ARDUINO_USB_MODE=1` (not 0)
- Use `ARDUINO_USB_CDC_ON_BOOT=1`
- Without this, device freezes on serial connect

## Flash Method
When pio upload freezes, use esptool directly:
```bash
esptool.py --chip esp32s3 -p /dev/ttyACM0 -b 921600 \
  --before=default_reset --after=hard_reset \
  write_flash --flash_mode dio --flash_freq 80m --flash_size detect \
  0x0 bootloader.bin 0x8000 partitions.bin \
  0xe000 boot_app0.bin 0x10000 firmware.bin
```

## GPS Configuration via CLI
```bash
meshtastic --set position.rx_gpio 41 \
  --set position.tx_gpio 42 \
  --set position.gps_en_gpio 47 \
  --set position.gps_mode ENABLED \
  --set power.is_power_saving false
```

## Working Variant Location
`~/meshtastic-firmware/variants/esp32s3/diy/custom_sx1280_board/`

---
*Added via Oracle Learn*
