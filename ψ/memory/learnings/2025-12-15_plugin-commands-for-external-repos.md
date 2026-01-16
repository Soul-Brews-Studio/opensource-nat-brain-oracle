# Plugin Commands for External Repos

**Date**: 2025-12-15
**Context**: Building plugin commands so external repos can use Oracle patterns

## What We Learned

### 1. Symlinks Break Command Inheritance
- Claude resolves symlink → looks for parent `.claude/` in wrong tree
- `ψ/incubate/backstage` → `/Users/nat/Code/.../backstage` → no Oracle parent!
- **Solution**: Plugin commands travel with user, not repo

### 2. Plugin = Portable Oracle
Commands in `plugins/nat-data-personal/commands/` are available **everywhere**:
```
/nat-data-personal:oracle-init   # Setup philosophy
/nat-data-personal:soul-init     # Setup ψ/ structure
/nat-data-personal:rrr           # Session retrospective
/nat-data-personal:snapshot      # Capture learnings
/nat-data-personal:trace         # Find lost projects
/nat-data-personal:report        # Report status back
```

### 3. /report Pattern
- External repo runs `/report` → generates status
- Copy output back to Oracle → update mapping doc (optional)
- **NOT sync** — `/report` is live, mapping doc is notes

### 4. Mapping Doc vs Live Data
| File | Purpose |
|------|---------|
| `backstage.md` (in Oracle) | Our notes about the project |
| `/report` (in backstage) | Live status, always current |

They're not copies — one is notes, one is reality.

### 5. Give Them Freedom
- ψ/ = soul = heart — everyone should have their own
- `/soul-init` creates full structure + Obsidian vault
- Team can share ψ/ in team repo (like backstage)

## Plugin Commands Created

| Command | Purpose |
|---------|---------|
| `oracle-init` | Philosophy (.claude/knowledge/) |
| `soul-init` | Full ψ/ + Obsidian vault |
| `rrr` | Session retrospective |
| `snapshot` | Capture learnings |
| `trace` | Find lost projects |
| `report` | Report status back to Oracle |

## Why It Matters

- External repos can use Oracle patterns without inheritance
- Knowledge building works anywhere
- Team members can have their own soul (ψ/)
- Portable wisdom, not locked to one repo

## Tags

`plugin` `commands` `inheritance` `symlink` `oracle` `soul`
