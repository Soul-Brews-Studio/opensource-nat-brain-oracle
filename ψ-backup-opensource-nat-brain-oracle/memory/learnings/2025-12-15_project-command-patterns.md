# /project Command Patterns — Nested Structure

**Date**: 2025-12-15
**Context**: Major refactor of /project incubate/learn to use nested ghq-like structure

## Final Structure

```
ψ/incubate/github.com/
├── laris-co/
│   ├── esphome-fw → ~/Code/github.com/laris-co/esphome-fw
│   └── esphome-fw.md
└── Soul-Brews-Studio/
    ├── backstage → ~/Code/github.com/Soul-Brews-Studio/backstage
    ├── backstage.md
    └── share-folder → ~/Code/github.com/Soul-Brews-Studio/share-folder
```

**Mirrors `~/Code/github.com/[org]/[repo]` exactly!**

## Key Patterns

### 1. Nested Structure (Final Pattern)

```bash
# Extract org from URL
ORG=$(echo "$URL" | sed 's|.*/\([^/]*\)/[^/]*$|\1|')
REPO_NAME=$(basename "$URL" .git)

# ghq gives absolute path
REPO_PATH=$(ghq list -p | grep "$REPO_NAME" | head -1)

# Create nested structure matching ~/Code/
mkdir -p "ψ/incubate/github.com/$ORG"
ln -sf "$REPO_PATH" "ψ/incubate/github.com/$ORG/"
```

### 2. Why Nested > Flat

| Flat | Nested |
|------|--------|
| `ψ/incubate/backstage` | `ψ/incubate/github.com/Soul-Brews-Studio/backstage` |
| Name collision possible | No collision (org separates) |
| Unknown origin | Clear ownership |
| Different from ~/Code | Mirrors ~/Code exactly |

### 3. Relative Paths OK (Oracle-only commands)

| Use Case | Path Type |
|----------|-----------|
| Symlink destination | Relative `ψ/incubate/github.com/$ORG/` |
| Symlink target | Absolute (from ghq) |
| readlink/unlink | Relative OK |

**Why**: `/project` always runs from Oracle root — no need for $ORACLE_ROOT

### 4. Never Copy Files to Incubated Repos

| Wrong | Right |
|-------|-------|
| Copy oracle files INTO repo | Symlink only, keep repo clean |
| Modify incubated repo | Use mapping doc `[name].md` in Oracle |
| Create .claude/ in external repo | Use /oracle-init (embedded content) |

### 5. git remote after GitHub rename

When `gh repo rename` is used:
```bash
# Local git remote still has OLD name!
git remote set-url origin [NEW_URL]
```

### 6. $ARGUMENTS in commands

All commands that accept input MUST have:
```markdown
ARGUMENTS: $ARGUMENTS
```
After the Usage section.

## Test Results

| Test | Result | Notes |
|------|--------|-------|
| ghq get -u URL | ✅ | Works, pulls if exists |
| ghq get -u local path | ⚠️ | Must extract remote URL first |
| Symlink creation | ✅ | `ln -sf` idempotent |
| Command inheritance via symlink | ❌ | Symlink resolves outside Oracle tree |
| /oracle-init | ✅ | Embedded content, no curl needed |

## Command Inheritance Finding

**Symlinks break command inheritance** because:
- `ψ/incubate/backstage` → `/Users/nat/Code/.../backstage`
- Claude resolves symlink to actual path
- Looks for parent `.claude/` in wrong tree

**Solution**: Use `/oracle-init` to setup each repo, OR accept no inheritance

## Files Updated

- `.claude/commands/project.md` - Simplified, relative paths
- `.claude/commands/draft.md` - Added $ARGUMENTS
- `.claude/commands/emotional.md` - Added $ARGUMENTS
- `.claude/commands/parallel.md` - Added $ARGUMENTS
- `.claude/commands/repo-scan.md` - Added $ARGUMENTS
- `.claude/commands/trace.md` - Added $ARGUMENTS
- `plugins/nat-data-personal/commands/oracle-init.md` - Embedded content

## Related

- `ψ/memory/learnings/2025-12-15_ghq-symlink-project-pattern.md`
- `ψ/incubate/backstage.md` - Mapping doc example
