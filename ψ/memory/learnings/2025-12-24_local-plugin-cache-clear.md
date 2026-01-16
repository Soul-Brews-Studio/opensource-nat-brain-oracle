# Local Plugin Cache Must Be Cleared Manually

**Date**: 2025-12-24
**Context**: Added soul-init, oracle-init, soul-lite to nat-agents-core but commands didn't show

## Problem

เพิ่ม commands ใหม่ใน local plugin + bump version แล้ว แต่ commands ไม่ขึ้นแม้ restart Claude Code

## Root Cause

Local plugins (`isLocal: true`) ถูก cache ที่:
```
~/.claude/plugins/cache/[marketplace]/[plugin]/[version]/
```

Claude Code ไม่ re-read จาก source folder แม้ version เปลี่ยน — มันใช้ cached copy ตลอด

## Solution

```bash
# Clear cache for specific plugin
rm -rf ~/.claude/plugins/cache/nat-plugins/nat-agents-core

# Then restart Claude Code
```

## How to Check

```bash
# See what version is cached
cat ~/.claude/plugins/installed_plugins.json | jq '.plugins["nat-agents-core@nat-plugins"]'

# If "isLocal": true AND old version → must clear cache
```

## Pattern

| Plugin Type | Add New Command |
|-------------|-----------------|
| Remote (GitHub) | Bump version + restart |
| **Local (isLocal: true)** | **Clear cache** + restart |

## Why This Happens

1. Local plugin installed Dec 10 @ v1.0.0
2. Cache created at `~/.claude/plugins/cache/.../1.0.0/`
3. Added commands to source folder (v1.3.0)
4. Claude Code still reads from cached v1.0.0
5. Version bump doesn't trigger re-cache for local plugins

## Prevention

When developing local plugins:
```bash
# After any change to commands/agents/hooks
rm -rf ~/.claude/plugins/cache/[marketplace]/[plugin]
# Then restart Claude Code
```

---

**Tags**: #plugin #cache #local #claude-code
