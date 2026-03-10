# Symlink = Identity, NOT Sync

**Date**: 2025-12-15
**Context**: Confusion about /report vs mapping doc relationship
**Priority**: HIGH — This is a core mental model

## The Confusion

I wrote "synced" when describing:
```
backstage runs /report → Oracle updates backstage.md
```

User corrected: **"not sync — it's the same!"**

## The Truth

```
ψ/incubate/github.com/Soul-Brews-Studio/backstage
                    ↓
              SYMLINK (ln -s)
                    ↓
/Users/nat/Code/github.com/Soul-Brews-Studio/backstage
```

**These are NOT two copies. This is ONE thing with TWO paths.**

## Why? Because `ln -s`

```bash
ln -s /Users/nat/Code/.../backstage ψ/incubate/.../backstage
      ↑                              ↑
   TARGET (real location)         LINK (shortcut/pointer)
```

**Symlink = shortcut** — ไม่ได้ copy file, แค่ชี้ไปที่เดิม

### How It Works

```
เมื่อ open ψ/incubate/.../backstage/README.md:
1. OS เห็น symlink
2. OS ตาม pointer ไป target
3. OS open file จาก ~/Code/.../backstage/README.md จริงๆ
```

### ln -s vs cp

| Command | Result |
|---------|--------|
| `cp -r A B` | **Copy** — two separate folders |
| `ln -s A B` | **Link** — B points to A (same files!) |

### Verify Symlink

```bash
# See the arrow = symlink
ls -la ψ/incubate/github.com/Soul-Brews-Studio/
# backstage -> /Users/nat/Code/.../backstage

# Check type
file ψ/incubate/.../backstage
# symbolic link to /Users/nat/Code/...
```

## Visual Model

```
WRONG Mental Model (Sync):
┌─────────────┐         ┌─────────────┐
│   Oracle    │  sync   │  backstage  │
│ backstage.md│ ←────→  │   /report   │
└─────────────┘         └─────────────┘
     Copy A                  Copy B


CORRECT Mental Model (Identity):
┌─────────────────────────────────────────┐
│                                         │
│     /Users/nat/Code/.../backstage       │
│              (THE repo)                 │
│                                         │
└─────────────────────────────────────────┘
        ↑                       ↑
        │                       │
   via symlink              directly
        │                       │
ψ/incubate/.../backstage    cd ~/Code/...
   (Oracle view)            (normal view)
```

## Why This Matters

| Concept | Sync (WRONG) | Identity (CORRECT) |
|---------|--------------|-------------------|
| Data | Two copies | One source |
| Update | Push/pull needed | Instant (same files) |
| Conflict | Possible | Impossible |
| Truth | Which is master? | Only one truth |

## The Two Files

| File | What It Is | Purpose |
|------|------------|---------|
| `/report` output | Live status FROM backstage | Current reality |
| `backstage.md` | Our notes ABOUT backstage | Context, history, log |

**They serve different purposes, not same purpose synced!**

## Pattern: ghq + symlink

```bash
# ghq clones to ~/Code/github.com/[org]/[repo]
ghq get https://github.com/Soul-Brews-Studio/backstage

# Symlink creates another PATH to SAME repo
ln -sf ~/Code/.../backstage ψ/incubate/.../backstage
```

After this:
- `ls ψ/incubate/.../backstage/` = same files
- `ls ~/Code/.../backstage/` = same files
- Edit in one = changed in "both" (because it's ONE)

## Hard Rule

> **Symlink creates IDENTITY, not COPY.**
>
> Never say "sync" when talking about symlinked paths.
> They are the SAME THING viewed from different locations.

## Analogies

### House Address
Like one house with two addresses:
- "123 Main St" (official address)
- "The blue house on the corner" (nickname)

Not two houses synced. ONE house, two ways to find it.

### File System Reality
```
# These commands show THE SAME FILES:
ls ~/Code/github.com/Soul-Brews-Studio/backstage/
ls ψ/incubate/github.com/Soul-Brews-Studio/backstage/

# Edit in one = changed in "both" (because ONE file)
echo "test" >> ~/Code/.../backstage/test.txt
cat ψ/incubate/.../backstage/test.txt  # same content!
```

### inode Proof
```bash
# Symlink points to same inode (same physical file)
ls -i ~/Code/.../backstage/README.md
ls -i ψ/incubate/.../backstage/README.md
# Same inode number = same file
```

## Common Mistakes

| Wrong | Right |
|-------|-------|
| "sync the changes" | Changes are instant (same file) |
| "copy from A to B" | No copy needed (identity) |
| "which is the source?" | Both ARE the source |
| "update the other one" | Already updated (one thing) |

## When Symlink Breaks

Symlink breaks when:
1. **Target deleted**: `rm -rf ~/Code/.../backstage` → symlink becomes dead
2. **Target moved**: `mv backstage backstage-old` → symlink points to nothing
3. **Disk unmounted**: External drive removed → symlink can't resolve

Check with:
```bash
# Dead symlink shows red in ls, or:
readlink -e ψ/incubate/.../backstage || echo "BROKEN!"
```

## Claude Code Gotcha: Symlink Breaks Inheritance

**This is why we need plugin commands!**

```
Oracle/
├── .claude/commands/trace.md    ← Parent command
└── ψ/incubate/backstage/        ← Symlink to ~/Code/.../backstage
```

**Expected**: Claude in backstage sees `/trace`
**Reality**: Claude **resolves symlink first** → looks for parent `.claude/` in wrong tree

```
1. Claude opens: ψ/incubate/backstage (symlink)
2. Claude resolves: ~/Code/.../Soul-Brews-Studio/backstage
3. Claude looks for parent: ~/Code/.../Soul-Brews-Studio/.claude/
4. NOT FOUND! (Oracle is in laris-co, not Soul-Brews-Studio)
```

**Solution**: Use plugin commands (travel with user, not repo):
```
/nat-data-personal:trace    ← Works everywhere!
/nat-data-personal:rrr      ← Works everywhere!
```

## Oracle Pattern Summary

| Situation | Use |
|-----------|-----|
| Real nested folder | Command inheritance works |
| Symlinked repo | Plugin commands (no inheritance) |
| Any external repo | `/nat-data-personal:*` commands |

## Full Picture

```
Symlink = Identity
├── Files: ONE source, TWO paths ✅
├── Changes: Instant (same file) ✅
├── Git: Works normally ✅
└── Claude inheritance: BREAKS ❌ (resolves outside tree)
```

**Symlink is perfect for files, but Claude's command lookup doesn't follow the Oracle tree through symlinks.**

## Tags

`symlink` `identity` `mental-model` `critical` `ghq` `claude-code` `inheritance`
