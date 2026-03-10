---
title: GPS Power ALWAYS_ON + TX/RX Swap Pattern
tags: [esphome, gps, uart, hardware, pattern, power]
created: 2026-01-12
source: ESPHome GPS test session
---

# GPS Power ALWAYS_ON + TX/RX Swap Pattern

## THE KEY FIX: Power restore_mode: ALWAYS_ON

```yaml
switch:
  - platform: gpio
    id: gps_power
    pin: 47
    restore_mode: ALWAYS_ON  # ← THIS IS THE KEY!
```

GPS modules need **continuous power** to maintain satellite lock. Without ALWAYS_ON, power cycles on reboot lose all satellite data.

## Secondary Fix: TX/RX Swap

When connecting GPS module to ESP32, TX/RX pins must be SWAPPED from board labels.

Board labels say:
- TX = GPIO 41
- RX = GPIO 42

But GPS module output `\x00` only - no NMEA data.

## The Fix

**Swap TX/RX in ESPHome config:**

```yaml
uart:
  tx_pin: 42   # ESP TX → GPS RX (board says RX)
  rx_pin: 41   # ESP RX ← GPS TX (board says TX)
  baud_rate: 9600
```

## Why?

UART is a **cross-connection**:
- GPS TX (sends data) → ESP RX (receives data)
- GPS RX (receives data) ← ESP TX (sends data)

When board labels say "TX 41", that's the **GPS TX** which should connect to **ESP's RX** function.

## Working GPS Config

```yaml
# Power: ALWAYS_ON
switch:
  - platform: gpio
    id: gps_power
    pin: 47
    restore_mode: ALWAYS_ON

# UART: SWAPPED pins
uart:
  tx_pin: 42  # NOT 41
  rx_pin: 41  # NOT 42
  baud_rate: 9600

# GPS component
gps:
  uart_id: gps_uart
  latitude:
    name: "Latitude"
  # ...
```

## Symptoms of Wrong Config

- Only `\x00` received on UART
- 0 satellites forever
- No NMEA sentences

## Symptoms of Correct Config

- NMEA sentences: `$GNGGA`, `$GNRMC`, `$GPGSV`
- `$GPTXT,01,01,01,ANTENNA OK*35`
- Satellites count increasing (outdoors)

---

*Discovered 2026-01-12 during ESPHome GPS testing on ESP32-S3*
