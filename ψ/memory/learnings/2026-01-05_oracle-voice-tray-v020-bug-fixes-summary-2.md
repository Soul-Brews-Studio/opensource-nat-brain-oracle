---
title: ## Oracle Voice Tray v0.2.0 - Bug Fixes Summary (2026-01-05)
tags: [bug-fix, dmg, mqtt, persistence, voice-tray, oracle-voice-tray]
created: 2026-01-05
source: voice-tray-v2 session 2026-01-05
---

# ## Oracle Voice Tray v0.2.0 - Bug Fixes Summary (2026-01-05)

## Oracle Voice Tray v0.2.0 - Bug Fixes Summary (2026-01-05)

Two bugs fixed in this session:

### Bug 1: DMG .VolumeIcon.icns Visible
**Related**: `2026-01-03_dmg-icon-polish.md`

**Problem**: .VolumeIcon.icns showing as separate file in DMG installer window

**Fix** (from previous learning):
```bash
# 1. Convert DMG to read-write
hdiutil convert app.dmg -format UDRW -o /tmp/app-rw.dmg
hdiutil attach /tmp/app-rw.dmg

# 2. Hide the icon file
SetFile -a V "/Volumes/AppName/.VolumeIcon.icns"
chflags hidden "/Volumes/AppName/.VolumeIcon.icns"

# 3. Convert back to compressed
hdiutil detach "/Volumes/AppName"
hdiutil convert /tmp/app-rw.dmg -format UDZO -o app-fixed.dmg
```

### Bug 2: MQTT Infinite Speech Loop
**Related**: `2026-01-05_mqtt-cleansession-bug.md`

**Problem**: App speaks infinitely when reconnecting - all queued MQTT messages replay

**Fix**: Change `set_clean_session(false)` to `set_clean_session(true)`

### Connection
Both bugs are "persistence" related:
- DMG: Finder persists showing hidden files if .DS_Store cached
- MQTT: Broker persists messages if clean_session=false

**Lesson**: Be explicit about what should persist vs reset on restart/reconnect.

---
*Added via Oracle Learn*
