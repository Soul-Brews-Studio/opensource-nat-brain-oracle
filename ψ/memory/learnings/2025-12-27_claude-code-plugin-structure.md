# Claude Code Plugin Structure

**Date**: 2025-12-27

## What We Learned

### Plugin vs Project Structure

| Location | Project Config | Plugin |
|----------|---------------|--------|
| Commands | `.claude/commands/` | `commands/` (at root) |
| Skills | `.claude/skills/` | `skills/` (at root) |
| Manifest | N/A | `.claude-plugin/marketplace.json` |

### marketplace.json Schema

```json
{
  "name": "plugin-name",
  "owner": {
    "name": "Org Name"    // MUST be object, not string!
  },
  "metadata": {
    "version": "1.0.0"
  },
  "plugins": [{
    "name": "feature-name",
    "source": "./",       // MUST have ./
    "version": "1.0.0"
  }]
}
```

### Two-Step Update Pattern

```
GitHub repo → Marketplace cache → Plugin install
              ↑                    ↑
         "Update Marketplace"  "Update Plugin"
         (fetches fresh)        (uses cache)
```

**Always**: Update marketplace FIRST, then plugin sees new version.

## How Things Connect

- **Publishing flow**: Create repo → add marketplace.json → push → add marketplace → install plugin
- **Update flow**: Push changes → bump version → update marketplace → update plugin
- **Silent failures**: If commands don't load, check path structure (commands/ at root)

## Common Gotchas

| Error | Cause | Fix |
|-------|-------|-----|
| `owner: Expected object` | `"owner": "string"` | `"owner": { "name": "..." }` |
| Commands not appearing | `.claude/commands/` | Move to `commands/` |
| Plugin not updating | Cache stale | Update marketplace first |

## Tags

`claude-code` `plugins` `marketplace` `structure` `schema`
