# Plugin Version Bump = Force Reload

**Date**: 2025-12-23
**Context**: Adding new command to plugin, not showing in autocomplete

## Problem

เพิ่ม command ใหม่ (`soul-lite.md`) ใน plugin folder แต่ไม่ขึ้นใน autocomplete แม้ restart Claude Code แล้ว

## Solution

Bump version ใน `.claude-plugin/plugin.json`:
```json
"version": "1.0.1" → "1.0.2"
```

Then restart Claude Code.

## Why It Works

Claude Code caches plugin commands at startup. Version change triggers re-index.

## Pattern

```bash
# When adding new command to plugin:
1. Create command file in commands/
2. Bump version in .claude-plugin/plugin.json
3. Restart Claude Code
4. Command appears in autocomplete
```

---

**Tags**: #plugin #claude-code #reload #version
