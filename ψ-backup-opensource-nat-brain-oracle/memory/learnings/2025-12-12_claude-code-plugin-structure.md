# Claude Code Plugin Structure

> เรียนรู้จากการ debug voice-notify plugin หลายชั่วโมง

## Problem

Plugin ติดตั้งไม่ได้ / load ไม่ขึ้น — error วนซ้ำ

## Root Causes

### 1. Plugin Name Mismatch
```
❌ marketplace: "voice-notify" → settings: "claude-voice-notify"
✅ ต้องตรงกันทุกที่
```

### 2. Source Path Wrong
```
❌ source: "../"
✅ source: "./"   (must start with ./)
```

### 3. Old References ค้าง
เมื่อเปลี่ยนชื่อ plugin ต้องลบ reference เก่าจาก **ทุกไฟล์**:
- `~/.claude/settings.json`
- `~/.claude/plugins/installed_plugins.json`
- `~/.claude/plugins/installed_plugins_v2.json`
- `~/.claude/plugins/known_marketplaces.json`
- `.claude/settings.json` (project level)

## Correct Structure

```
my-plugin/
├── .claude-plugin/
│   ├── plugin.json           # metadata (name, version, author)
│   └── marketplace.json      # plugins array with source: "./"
├── commands/                 # /command-name
├── hooks/
│   └── hooks.json           # event hooks
├── skills/
│   └── skill-name/
│       └── SKILL.md         # auto-discovered skills
└── scripts/                 # supporting scripts
```

## marketplace.json

```json
{
  "name": "my-plugin-marketplace",
  "owner": { "name": "Author" },
  "plugins": [
    {
      "name": "my-plugin",        // ← ชื่อ plugin
      "source": "./",             // ← MUST be "./"
      "description": "...",
      "version": "1.0.0"
    }
  ]
}
```

**Key**: `source: "./"` หมายถึง plugin อยู่ที่ repo root (relative to marketplace.json's parent)

## Installation Flow

```bash
# 1. Add marketplace
/plugin marketplace add owner/repo

# 2. Install plugin
/plugin install plugin-name@marketplace-name

# 3. Verify
/plugin
```

## Debugging Commands

```bash
# Check installed plugins
cat ~/.claude/plugins/installed_plugins_v2.json

# Check known marketplaces
cat ~/.claude/plugins/known_marketplaces.json

# Check enabled plugins
cat ~/.claude/settings.json | jq '.enabledPlugins'

# Find old references
grep -r "plugin-name" ~/.claude/
```

## Clean Slate Process

เมื่อ plugin พัง clean ทุกอย่างแล้ว reinstall:

```bash
# 1. Remove from all config files (manually edit)
# 2. Delete cache
rm -rf ~/.claude/plugins/cache/marketplace-name
rm -rf ~/.claude/plugins/marketplaces/marketplace-name

# 3. Restart Claude Code

# 4. Fresh install
/plugin marketplace add owner/repo
/plugin install plugin-name@marketplace-name
```

## Pattern

| Component | Location | Example |
|-----------|----------|---------|
| Marketplace manifest | `.claude-plugin/marketplace.json` | plugins array |
| Plugin metadata | `.claude-plugin/plugin.json` | name, version |
| Commands | `commands/*.md` | `/voice-test` |
| Hooks | `hooks/hooks.json` | SessionStart, Stop |
| Skills | `skills/*/SKILL.md` | Auto-discovered |

---

*Learned: 2025-12-12*
*Source: claude-voice-notify debugging session*
