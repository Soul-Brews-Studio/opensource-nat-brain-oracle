# Learning: Plugin Local vs Marketplace Configuration

**Date**: 2025-12-13
**Context**: voice-notify plugin ไม่ทำงาน หลังจาก restart

---

## How I Learned This

| Source | Method |
|--------|--------|
| **User report** | "เสียงไม่ดังแล้ว" หลัง restart |
| **Debug** | เช็ค `~/.claude/plugins/` + `/plugin` command |
| **Trial & error** | ลอง local-voice marketplace → conflict |
| **Solution** | ใช้ marketplace ที่ installed อยู่แล้ว |

---

## Problem

Plugin `claude-voice-notify` ไม่ทำงานใน project นี้

### Symptoms
- `/plugin` แสดง error: "Plugin not found in marketplace"
- เสียง start/stop ของ subagent ไม่ดัง

### Root Cause
1. Plugin installed ที่ **user level** เป็น marketplace `claude-voice-notify`
2. เราพยายามสร้าง **project level** marketplace ใหม่ชื่อ `local-voice`
3. **Conflict!** — ชื่อ plugin ซ้ำกัน แต่คนละ marketplace

---

## Solution

### ❌ Wrong: สร้าง marketplace ใหม่
```json
{
  "extraKnownMarketplaces": {
    "local-voice": {
      "source": { "source": "directory", "path": "/path/to/plugin" }
    }
  },
  "enabledPlugins": {
    "claude-voice-notify@local-voice": true  // ❌ ไม่เจอ
  }
}
```

### ✅ Correct: ใช้ marketplace ที่มีอยู่
```json
{
  "extraKnownMarketplaces": {},
  "enabledPlugins": {
    "claude-voice-notify@claude-voice-notify": true  // ✅ เจอ!
  }
}
```

---

## Key Insight

### Plugin Format
```
plugin-name@marketplace-name
```

### Check Installed Marketplaces
```bash
cat ~/.claude/plugins/known_marketplaces.json
```

### Check Installed Plugins
```bash
cat ~/.claude/plugins/installed_plugins.json
```

---

## Plugin Levels

| Level | File | Scope |
|-------|------|-------|
| User | `~/.claude/settings.json` | All projects |
| Project (shared) | `.claude/settings.json` | This project, committed |
| Project (local) | `.claude/settings.local.json` | This project, gitignored |

**Project settings override user settings** (higher priority)

---

## Debug Commands

```bash
# Check what marketplaces exist
cat ~/.claude/plugins/known_marketplaces.json

# Check what plugins installed
cat ~/.claude/plugins/installed_plugins.json

# See plugin errors
/plugin  # in Claude Code
```

---

## Takeaway

1. **Check existing marketplaces** ก่อนสร้างใหม่
2. **Plugin name format**: `name@marketplace`
3. **Don't duplicate** — ถ้า marketplace มีอยู่แล้ว ใช้อันนั้น
4. **Project-level enable** — ใช้ `.claude/settings.json` ใน project

---

*Fixed voice-notify plugin by using existing marketplace instead of creating new one*
