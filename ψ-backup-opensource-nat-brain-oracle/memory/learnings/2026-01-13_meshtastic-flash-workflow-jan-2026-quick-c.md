---
title: # Meshtastic Flash Workflow (Jan 2026)
tags: [meshtastic, esp32-s3, sx1280, flash, esptool, white.local, laris-meshtastic, firmware, workflow]
created: 2026-01-13
source: Session 2026-01-13: Meshtastic flash workflow with scripts
---

# # Meshtastic Flash Workflow (Jan 2026)

# Meshtastic Flash Workflow (Jan 2026)

## Quick Commands

```bash
# Clone repo
ghq get laris-co/laris-meshtastic

# Build on white.local
cd /Users/nat/Code/github.com/laris-co/laris-meshtastic
./build.sh white.local

# Check USB
ssh nat@white.local "lsusb | grep -i esp; ls /dev/ttyACM*"

# Flash
./flash.sh white.local

# Configure GPS + MQTT
./configure.sh white.local
```

## Full Paths

| Location | Path |
|----------|------|
| Local repo | `/Users/nat/Code/github.com/laris-co/laris-meshtastic` |
| Build dir (white) | `~/laris-meshtastic-build/` |
| Binaries | `~/laris-meshtastic-build/.pio/build/custom_sx1280_board_s3/` |
| Factory bin | `firmware-custom_sx1280_board_s3-2.7.18.factory.bin` |

## SSH Options

```bash
ssh nat@white.local              # LAN
ssh nat@floodboy-white4.alchemycat.org  # Remote (Cloudflare)
ssh nat@white                    # Tailscale
```

## Firmware v2.7.18 Stats

- Flash: 79% (1.9MB / 2.4MB)
- RAM: 28.9% (94KB / 328KB)
- Build time: ~4 min (first), ~40s (incremental)

## Device Naming

Laris-1, Laris-2, Laris-3 deployed (Jan 12)
Laris-4, Laris-5 next

---
*Added via Oracle Learn*
