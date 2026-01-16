# Skill Symlinks Setup

## Overview

Skills should be symlinked from `~/.claude/skills/` to a **git-tracked repo**.

## Source Repo (Single Source of Truth)

| Repo | Path |
|------|------|
| **oracle-proof-of-concept-skills** | `$(ghq root)/github.com/laris-co/oracle-proof-of-concept-skills/skills/` |

All skills live here: context-finder, feel, forward, fyi, learn, project, recap, rrr, schedule, standup, trace, watch, where-we-are

## Warning: Plugin Cache is NOT Git Tracked!

```
/Users/nat/.claude/plugins/cache/oracle-skills/...  ← NOT git tracked!
```

If symlinks point here, edits are LOST on plugin update. Always point to git repo instead.

## Why Symlinks?

| Approach | Problem |
|----------|---------|
| Plugin cache | Not git tracked, edits lost on update |
| Copy files | Two sources of truth, manual sync needed |
| **Symlink to git repo** | One source, edits tracked, changes persist |

## Correct Symlink Setup

```
~/.claude/skills/recap  → oracle-proof-of-concept-skills/skills/recap
~/.claude/skills/trace  → oracle-proof-of-concept-skills/skills/trace
~/.claude/skills/rrr    → oracle-proof-of-concept-skills/skills/rrr
... etc
```

## Setup Commands

### Check current symlinks
```bash
ls -la ~/.claude/skills/
```

### Link ALL oracle skills (from oracle-proof-of-concept-skills repo)
```bash
ORACLE_SKILLS="$(ghq root)/github.com/laris-co/oracle-proof-of-concept-skills/skills"

for skill in $ORACLE_SKILLS/*/; do
  name=$(basename "$skill")
  rm -f ~/.claude/skills/$name
  ln -sf "$skill" ~/.claude/skills/$name
done
```

### One-liner: Setup all oracle skills
```bash
ghq get -u laris-co/oracle-proof-of-concept-skills && \
for s in $(ghq root)/github.com/laris-co/oracle-proof-of-concept-skills/skills/*/; do \
  ln -sf "$s" ~/.claude/skills/; \
done
```

### Verify symlinks
```bash
# Check one skill
readlink ~/.claude/skills/recap

# Check all skills point to oracle repo
ls -la ~/.claude/skills/ | grep oracle-proof-of-concept-skills
```

## Workflow

1. **Edit** skill in oracle repo: `oracle-proof-of-concept-skills/skills/recap/SKILL.md`
2. **Test** with `/recap` (uses symlinked version automatically)
3. **Commit** in oracle repo: `git -C $(ghq root)/github.com/laris-co/oracle-proof-of-concept-skills add . && git commit`
4. **Push** to share: `git -C $(ghq root)/github.com/laris-co/oracle-proof-of-concept-skills push`

## Troubleshooting

### Skill not updating after edit?
```bash
# Check if it's a symlink
file ~/.claude/skills/recap

# Expected: symbolic link
# Problem: directory (not a symlink, need to recreate)
```

### Symlink broken?
```bash
# Check if target exists
ls -la $(readlink ~/.claude/skills/recap)

# If "No such file", recreate symlink
```

## Related

- Learning: `ψ/memory/learnings/2026-01-14_skill-development-pattern-git-repo-global-sy.md`
- Oracle search: `oracle_search("skill symlink git")`

---

**Last updated**: 2026-01-14
