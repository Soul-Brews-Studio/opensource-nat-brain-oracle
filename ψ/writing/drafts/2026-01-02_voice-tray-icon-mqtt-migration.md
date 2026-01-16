# Voice Tray v2: Icons, MQTT, and 4 Bugs in One Night

**Created**: 2026-01-02 23:14 GMT+7
**Status**: 📝 Draft
**Author**: Human + AI collaboration

---

## 📚 Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Retrospective | ψ/memory/retrospectives/2026-01/02/23.12_voice-tray-v2-complete.md | Full summary |
| Retrospective | ψ/memory/retrospectives/2026-01/02/22.55_voice-tray-bell-icon.md | Bell icon swap |
| Retrospective | ψ/memory/retrospectives/2026-01/02/22.48_voice-tray-v2-logo-complete.md | Duplicate tray fix |
| Learning | ψ/memory/learnings/2026-01-02_tauri-icon-format-must-be-rgba-png-when-build.md | RGBA requirement |

---

## 🎯 TL;DR

Building a menu bar app sounds simple until you hit icon formats, framework quirks, and PATH issues. This is the story of building Voice Tray v2 — a central voice notification system — and squashing 4 bugs in one debugging session.

---

## 🔥 The Problem

I wanted a central voice system for my AI agents. Instead of each notification script calling `say` directly with file locks, I wanted:

- One app managing the voice queue
- A timeline showing what was spoken
- MQTT for decoupled messaging

Simple, right?

### The Stack
- **Tauri 2.0** - Rust backend, web frontend
- **rumqttc** - MQTT client for Rust
- **mosquitto** - Local MQTT broker
- **ImageMagick** - Icon conversion

---

## 🛤️ The Journey

### Bug 1: Icons Not RGBA

**Symptom**: Build failed with "icon is not RGBA"

```
error: proc macro panicked
message: icon icons/32x32.png is not RGBA
```

**What I tried**:
```bash
# This looks right but doesn't always work
convert source.png -resize 32x32 -alpha set output.png
```

**The Fix**:
```bash
# Force RGBA output with PNG32: prefix
magick source.png -resize 32x32 -alpha on PNG32:output.png
```

**Lesson**: ImageMagick's `-alpha set` doesn't guarantee RGBA output. The `PNG32:` prefix forces 8-bit RGBA explicitly.

---

### Bug 2: Duplicate Tray Icons

**Symptom**: Two tray icons appeared in menu bar

**The Investigation**:
Used `/trace` command to search Oracle (my knowledge base):
```
/trace duplicate tray icon
```

Found Issue #74 from December — same bug, same fix.

**Root Cause**: Tauri 2.0 creates a tray icon from BOTH:
1. `tauri.conf.json` → `trayIcon` config
2. `lib.rs` → `TrayIconBuilder::new()`

Having both = two icons.

**The Fix**: Remove config, keep code only.

```diff
// tauri.conf.json
  "app": {
    "withGlobalTauri": true,
-   "trayIcon": {
-     "iconPath": "icons/32x32.png",
-     "iconAsTemplate": false
-   },
    "windows": [
```

**Lesson**: Tauri tray — config OR code, never both.

---

### Bug 3: MQTT Not Reaching App

**Symptom**: Voice spoke but didn't show in timeline

**The Investigation**:
```bash
# Terminal test worked
mosquitto_pub -t "voice/speak" -m '{"text":"test"}'

# But hooks weren't working...
```

**Root Cause**: Hook scripts run in minimal environment without `/opt/homebrew/bin` in PATH.

**The Fix**:
```bash
# Before (broken)
mosquitto_pub -h 127.0.0.1 -t "voice/speak" -m "$PAYLOAD"

# After (works)
/opt/homebrew/bin/mosquitto_pub -h 127.0.0.1 -t "voice/speak" -m "$PAYLOAD"
```

**Lesson**: Hooks need full paths. Don't assume PATH.

---

### Bug 4: Plugin Cache Stale

**Symptom**: Still hearing old `say` command, not MQTT

**The Investigation**:
```bash
# Source was updated
grep "mosquitto" scripts/agent-start-notify.sh  # ✓ Has it

# But Claude Code uses cache!
grep "say " ~/.claude/plugins/cache/.../agent-start-notify.sh  # Still has old code
```

**Root Cause**: Claude Code plugins are cached at install time. Updating source repo doesn't update cache.

**The Fix**:
```bash
cp scripts/*.sh ~/.claude/plugins/cache/claude-voice-notify/.../scripts/
```

**Lesson**: Plugin cache ≠ source repo. Classic cache invalidation.

---

## ✅ The Solution

### Architecture Before
```
Hook → Script → say command (with file locks)
           ↓
    Speech overlaps, no queue, no visibility
```

### Architecture After
```
Hook → Script → MQTT → Voice Tray v2 → say command
                          ↓
                    Central queue
                    Timeline UI
                    Agent attribution
```

### The Minimal Hook Script
```bash
#!/bin/bash
# 80 lines instead of 190

# Parse JSON input
AGENT_NAME=$(echo "$INPUT" | jq -r '...')

# Build payload
PAYLOAD=$(jq -n --arg text "$MESSAGE" --arg voice "$VOICE" \
    '{text: $text, voice: $voice, rate: 220}')

# Send to Voice Tray (full path!)
/opt/homebrew/bin/mosquitto_pub -h 127.0.0.1 -t "voice/speak" -m "$PAYLOAD"
```

---

## 🧠 The Pattern

### Debug Chain Reaction

Each fix revealed the next bug:
1. Can't build → RGBA icons
2. Built but two icons → config/code duality
3. One icon but no MQTT → PATH in hooks
4. MQTT works manually but not in hooks → plugin cache

### Tools That Helped

| Tool | Used For |
|------|----------|
| `/trace` + Oracle | Found Issue #74 fix in 20 seconds |
| `curl` + `jq` | Tested HTTP endpoints |
| `mosquitto_pub` | Tested MQTT directly |
| `file` + `identify` | Verified RGBA format |

### Key Takeaways

1. **PNG32: for RGBA** — More reliable than `-alpha set`
2. **Config OR code** — Framework quirk, not obvious
3. **Full paths in hooks** — Minimal environment
4. **Cache ≠ source** — Classic problem, easy to forget

---

## 📖 Full Context

### Commits (claude-voice-notify)
| Hash | Message |
|------|---------|
| edba3f5 | fix: use full path for mosquitto_pub |
| 83c670e | chore: bump to v2.0.0 |
| 1413185 | refactor: minimal MQTT-only hooks |
| f85bd0a | feat: migrate to MQTT voice |

### Files Changed
- `scripts/agent-start-notify.sh` — 190 → 80 lines
- `scripts/agent-complete-notify.sh` — 190 → 97 lines
- `tauri.conf.json` — removed trayIcon section
- `src-tauri/icons/*.png` — all regenerated as RGBA

---

## 🏷️ Tags

`tauri` `mqtt` `debugging` `icons` `imagemagick` `claude-code` `plugins`

---

## 📝 Writing Notes

### Tone
- Technical but story-driven
- "I hit this bug, here's what I learned"

### Target Audience
- Developers building menu bar apps
- Tauri users
- Anyone dealing with icon formats

### Suggested Titles
1. "4 Bugs in One Night: Building Voice Tray v2"
2. "From `say` to MQTT: Centralizing Voice Notifications"
3. "Tauri Tray Icons: Config OR Code, Never Both"

### Next Steps
- [ ] Add screenshots of Voice Tray UI
- [ ] Add diagram of MQTT flow
- [ ] Polish code examples
- [ ] Publish

---

*Draft generated from session knowledge — 2026-01-02*
