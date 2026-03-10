# ESP32-S3 GPIO Constraints for ESPHome Displays

**Date**: 2026-01-14
**Context**: Creating WT32-SC01 v3.2 config, hit GPIO validation errors

## The Pattern

ESP32-S3 has **restricted GPIO range** compared to original ESP32:
- **Valid**: GPIO 0-21, 35-48
- **Invalid**: GPIO 22-34 (not exposed on ESP32-S3)

## ESPHome 2024.9.0+ Breaking Change

The `invert_colors` parameter is now **required** for ili9xxx displays:

```yaml
display:
  - platform: ili9xxx
    model: ST7796
    invert_colors: false  # REQUIRED - was optional before
```

## Strapping Pins Warning

GPIO45, GPIO46 are strapping pins - ESPHome warns but they work for:
- Backlight PWM (GPIO45)
- Other outputs after boot

## Quick Reference

| Use Case | Safe GPIOs |
|----------|------------|
| SPI CLK/MOSI | 12, 13, 14 |
| Display CS/DC | 10, 11, 15, 21 |
| Reset | 4, 9 |
| Backlight | 45, 46 (strapping - OK for output) |
| I2C | 5 (SCL), 6 (SDA) |
| Touch INT | 7 |

## Command Pattern

```bash
# Compile and check for errors
uvx esphome compile config.yml

# Run (compile + upload + logs)
uvx esphome run config.yml
```

---

**Lesson**: Always check chip variant GPIO availability before porting configs between ESP32 variants.
