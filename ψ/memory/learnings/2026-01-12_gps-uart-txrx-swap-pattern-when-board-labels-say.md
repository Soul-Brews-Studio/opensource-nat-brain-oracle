---
title: GPS UART TX/RX Swap Pattern: When board labels say TX=41, RX=42, configure ESPHo
tags: [gps, uart, esphome, hardware, esp32, pattern]
created: 2026-01-12
source: ESPHome GPS test session 2026-01-12
---

# GPS UART TX/RX Swap Pattern: When board labels say TX=41, RX=42, configure ESPHo

GPS UART TX/RX Swap Pattern: When board labels say TX=41, RX=42, configure ESPHome as tx_pin: 42, rx_pin: 41 (SWAPPED). UART is cross-connection: GPS TX → ESP RX. Symptoms of wrong config: only \x00, 0 satellites. Symptoms of correct: NMEA sentences, ANTENNA OK. Power should be restore_mode: ALWAYS_ON.

---
*Added via Oracle Learn*
