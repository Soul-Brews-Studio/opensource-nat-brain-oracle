---
title: GPS Power ALWAYS_ON is THE KEY: GPS modules need `restore_mode: ALWAYS_ON` for c
tags: [gps, power, esphome, restore_mode, always_on, key_fix]
created: 2026-01-12
source: ESPHome GPS test session 2026-01-12
---

# GPS Power ALWAYS_ON is THE KEY: GPS modules need `restore_mode: ALWAYS_ON` for c

GPS Power ALWAYS_ON is THE KEY: GPS modules need `restore_mode: ALWAYS_ON` for continuous power. Without it, power cycles on reboot and GPS loses all satellite data, outputting only \x00. Secondary fix: TX/RX pins swapped (board TX→ESP RX, board RX→ESP TX).

---
*Added via Oracle Learn*
