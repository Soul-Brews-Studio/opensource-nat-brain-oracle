# Use `git -C` Not `cd` - Stay in ψ Path

**Date**: 2025-12-28
**Category**: Safety Rule
**Source**: Session retrospective - /create fitbit-analysis

## The Rule

**Never use `cd` to change into external repos.** Use `git -C [path]` instead.

## Why It Matters

1. **Shell state pollution** - `cd` changes cwd, confuses future commands
2. **Multi-agent safety** - Agents should stay in their worktree
3. **Context preservation** - Stay in ψ path, work on external repos remotely
4. **Recovery** - Claude Code shows "Shell cwd was reset" when this happens

## Example

```bash
# ❌ WRONG - leaves ψ path
cd ~/Code/github.com/laris-co/fitbit-analysis
git add -A
git commit -m "Initial commit"
git push
# Shell is now in wrong directory!

# ✅ CORRECT - stays in ψ path
REPO=~/Code/github.com/laris-co/fitbit-analysis
git -C "$REPO" add -A
git -C "$REPO" commit -m "Initial commit"
git -C "$REPO" push -u origin main
# Still in ψ path ✓
```

## The Pattern

```bash
# Define path once
REPO_PATH=~/Code/github.com/org/repo

# All git operations use -C
git -C "$REPO_PATH" status
git -C "$REPO_PATH" add -A
git -C "$REPO_PATH" commit -m "message"
git -C "$REPO_PATH" push
git -C "$REPO_PATH" log --oneline -5
```

## When You Might Forget

- Running `gh repo create` then wanting to commit
- Cloning via `ghq` then wanting to add files
- Copying data to external repo then committing

## Already in CLAUDE.md

```markdown
10. **Use `git -C` not `cd`** - Respect worktree boundaries, control from anywhere
```

## Related

- MAW multi-agent sync uses this pattern
- `scripts/project-create.sh` uses this pattern
- All agent worktree operations should use this

---

**Related**: `ψ/memory/retrospectives/2025-12/28/17.07_project-create-nnn-unified.md`
