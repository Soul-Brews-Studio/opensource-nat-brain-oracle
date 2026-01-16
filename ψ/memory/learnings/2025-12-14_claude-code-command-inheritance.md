# Claude Code Command Inheritance (Undocumented Feature)

**Date**: 2025-12-14 03:31
**Status**: Discovered & Proven

## Discovery

Claude Code inherits `.claude/commands/` from **parent directories** — not just project and user scope.

## What Docs Say (Incomplete)

Official docs only mention 2 scopes:
- Project: `.claude/commands/`
- Personal: `~/.claude/commands/`

**No mention of parent directory inheritance.**

## What Actually Happens

Claude Code walks **UP** the directory tree and **MERGES** all commands found.

### Proof Test

```bash
# Parent repo
/Users/nat/Code/github.com/laris-co/Nat-s-Agents/.claude/commands/prove-inheritance.md

# Child repo (inside parent)
/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/incubate/repo/github.com/laris-co/headline-analyzer/

# Result: Child sees /prove-inheritance command!
```

## Behavior Details

| Test | Result |
|------|--------|
| Empty `.claude/commands/` in child | Still inherits parent |
| README.md in child commands/ | Still inherits parent |
| Move repo outside parent tree | No inheritance |
| Create new command in parent | Child sees it (after restart) |

## Oracle Pattern Benefit

```
Nat-s-Agents/                    (Oracle Hub)
├── .claude/commands/            (Oracle commands)
│   ├── rrr.md
│   ├── feel.md
│   ├── snapshot.md
│   └── ...
│
└── ψ/incubate/
    └── any-repo/                (Auto-inherits!)
        └── No setup needed
```

### Before vs After

| Before (plugin approach) | After (inheritance) |
|--------------------------|---------------------|
| Install plugin every repo | No installation |
| Maintain multiple copies | Single source |
| Manual updates | Auto-propagates |

## Usage

1. Use ghq to get repo into `ψ/incubate/`:
   ```bash
   GHQ_ROOT=ψ/incubate/repo ghq get [url]
   # or
   ./.claude/scripts/incubate.sh [url]
   ```
2. Done — Oracle commands available immediately
3. No symlinks, no plugins needed

## Caution

- **Undocumented behavior** — may change in future versions
- Commands cached at session start — restart to see new parent commands
- Only works when child is **inside** parent directory tree

## Sources

- Official docs: https://code.claude.com/docs/en/slash-commands.md (incomplete)
- Community: https://www.danielcorin.com/til/anthropic/custom-slash-commands-hierarchy/
- Our testing: Proven 2025-12-14

---

**Tags**: #claude-code #commands #inheritance #undocumented #oracle-pattern
