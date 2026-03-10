# Settings Local vs Settings

**Date**: 2025-12-28

## The Pattern

| File | Tracked | Syncs | Use For |
|------|---------|-------|---------|
| `.claude/settings.json` | Yes | Yes | Hooks, permissions, config that all agents need |
| `.claude/settings.local.json` | No | No | Machine-specific overrides, personal preferences |

## What Happened

Hooks were in `settings.local.json`. Agents didn't get them because `.local` is gitignored.

```
main:     settings.local.json ✅ Has hooks
agent/1:  settings.local.json ❌ Missing (never synced)
agent/2:  settings.local.json ❌ Missing
...
```

## The Fix

Move hooks from `settings.local.json` to `settings.json`.

Now:
```
main:     settings.json ✅ Has hooks
agent/1:  settings.json ✅ Has hooks (synced via git)
agent/2:  settings.json ✅ Has hooks
...
```

## Key Insight

The `.local` suffix is a **naming convention** that means "gitignored / machine-specific".

| Suffix | Convention |
|--------|------------|
| `.local` | Gitignored, machine-specific |
| `.example` | Template, tracked |
| (none) | Normal tracked file |

## When to Use Each

**settings.json** (tracked):
- Hooks (SessionStart, PreToolUse, etc.)
- Permissions
- Enabled plugins
- Any config that should be consistent across agents

**settings.local.json** (gitignored):
- Machine-specific paths
- Personal preferences
- API keys (NEVER commit these)
- Overrides for local testing

## Verification

Always test that config actually works in target environment, not just that files exist:

```bash
# Wrong: verify file exists
ls agents/1/.claude/settings.json  # ✅ exists

# Right: verify behavior works
# Restart session, see if hooks fire
```

## Tags

`maw` `settings` `hooks` `gitignore` `sync`
