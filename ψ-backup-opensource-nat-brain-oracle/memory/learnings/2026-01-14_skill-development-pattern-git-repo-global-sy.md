---
title: ## Skill Development Pattern: Git Repo → Global Symlink
tags: [skill, symlink, git, claude-code, development, workflow]
created: 2026-01-14
source: Recap v6.1 revert session - 2026-01-14
---

# ## Skill Development Pattern: Git Repo → Global Symlink

## Skill Development Pattern: Git Repo → Global Symlink

**Pattern**: Develop skills in git repo, symlink to `~/.claude/skills/` for global use.

**Structure**:
```
Nat-s-Agents/.claude/skills/recap/     ← Git tracked (source of truth)
            ↓ symlink
~/.claude/skills/recap                 ← Global scope (Claude loads from here)
```

**Setup**:
```bash
ln -sf /Users/nat/Code/.../Nat-s-Agents/.claude/skills/recap ~/.claude/skills/recap
```

**Benefits**:
- ✅ Git tracks all changes
- ✅ Edits auto-reflect globally (symlink follows source)
- ✅ Can commit/push/branch skill updates
- ✅ No manual copying between repo and global
- ✅ Version control for skill evolution

**Workflow**:
1. Edit: `.claude/skills/recap/skill.md` in repo
2. Test: `/recap` uses symlinked version
3. Commit: `git commit` tracks changes
4. Push: `git push` shares with others

**Why Not Copy**:
- Copying = two sources of truth (divergence risk)
- Symlink = one source, multiple access points

**Use Case**: Editing `/recap` v6.1 in Nat-s-Agents repo immediately reflects in all Claude sessions.

---
*Added via Oracle Learn*
