# Lesson: Claude Code Plugin Registry Silent Failures

**Date**: 2025-12-28
**Context**: Plugin debugging session
**Category**: claude-code, plugins, debugging

---

## Problem

`/plugin` shows "(no content)" but marketplace shows plugins available.
`/plugin install` says "already installed".
Errors tab is empty.

---

## Root Cause

`~/.claude/plugins/installed_plugins.json` contains stale entries pointing to non-existent version paths.

```json
{
  "nat-agents-core@nat-plugins": [{
    "installPath": "/cache/nat-plugins/nat-agents-core/1.0.0",  // ← doesn't exist
    "version": "1.0.0"
  }]
}
```

But cache only has:
```
/cache/nat-plugins/nat-agents-core/1.5.0
/cache/nat-plugins/nat-agents-core/1.6.0
/cache/nat-plugins/nat-agents-core/1.7.0
```

**Result**: Claude Code tries to load from non-existent path → fails silently → no plugin loaded.

---

## Why It Happens

1. Plugin updated in marketplace (1.0.0 → 1.7.0)
2. Cache updated with new versions
3. Old version (1.0.0) removed from cache
4. Registry still points to 1.0.0
5. Path doesn't exist → silent failure

---

## Detection

Check for version mismatch:

```bash
# Registry version
cat ~/.claude/plugins/installed_plugins.json | jq '.plugins | to_entries[] | {key: .key, version: .value[0].version}'

# Cache versions
ls ~/.claude/plugins/cache/*/*/
```

---

## Fix

### Option 1: Nuclear (Recommended)

```bash
# Clear registry
echo '{"version": 2, "plugins": {}}' > ~/.claude/plugins/installed_plugins.json

# Restart Claude Code
# Reinstall: /plugin install nat-agents-core
```

### Option 2: Manual Fix

Update registry paths to match existing cache versions.

---

## Prevention

- Check plugin health after updates
- Consider cleanup script for orphaned registry entries
- Request: Claude Code should log path-not-found errors

---

## Related

- `ψ/memory/retrospectives/2025-12/28/18.11_plugin-debugging-incubate-script.md`
- `~/.claude/plugins/installed_plugins.json`
- `~/.claude/plugins/known_marketplaces.json`

---

## Key Insight

> **Silent failures are the hardest to debug.**
>
> The plugin system doesn't error when paths don't exist - it just doesn't load the plugin.
> The Errors tab stays empty. The only clue is "No plugins installed" when you know they should be there.

---

*Pattern: registry-cache-version-mismatch*
