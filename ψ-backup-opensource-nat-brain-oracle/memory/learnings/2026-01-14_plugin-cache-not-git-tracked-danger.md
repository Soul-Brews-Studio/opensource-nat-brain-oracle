---
title: Plugin Cache is NOT Git Tracked - Use Symlinks to Git Repo
tags: [skills, symlink, plugin-cache, git, architecture, danger]
created: 2026-01-14
source: Skill symlink architecture session
---

# Plugin Cache is NOT Git Tracked

## The Danger

```
~/.claude/plugins/cache/oracle-skills/...  <- NOT git tracked!
```

If symlinks point here:
- Edits are LOST on plugin update
- No version control
- Can't share changes
- Can't rollback

## The Solution

Always symlink to git repo:

```bash
# Wrong (plugin cache)
~/.claude/skills/trace -> ~/.claude/plugins/cache/oracle-skills/.../trace

# Right (git repo)
~/.claude/skills/trace -> $(ghq root)/github.com/laris-co/oracle-proof-of-concept-skills/skills/trace
```

## One-liner Fix

```bash
ORACLE="$(ghq root)/github.com/laris-co/oracle-proof-of-concept-skills/skills"
for s in $ORACLE/*/; do
  ln -sf "$s" ~/.claude/skills/$(basename "$s")
done
```

## How to Check

```bash
# Show all symlink targets
ls -la ~/.claude/skills/

# Good: points to github.com/...
# Bad: points to plugins/cache/...
```

## Why This Happens

Claude plugins install to cache directory automatically. The plugin system creates symlinks for convenience, but these point to the cached copy, not the source repo.

## Related

- See: `.claude/docs/SKILL-SYMLINKS.md`
- Oracle learning: `2026-01-14_skill-development-pattern-git-repo-global-sy.md`
