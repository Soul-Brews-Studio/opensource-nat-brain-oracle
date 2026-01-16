# Track: MAW Merge

**Created**: 2025-12-27 13:33
**Last touched**: 2025-12-27 13:33
**Status**: 🟡 Cooling

---

## Goal

Perfect `maw merge` command - seamless agent → main merging

## Current State

Command exists at `.agents/scripts/merge.sh`:
- Check main is clean
- Fetch origin + rebase
- Rebase main onto agent
- Push immediately
- Sync all agents

## Next Action

Fix 4 known issues:
- [ ] Handle agent uncommitted changes
- [ ] Show clearer progress during merge
- [ ] Handle merge conflicts gracefully
- [ ] Add `--dry-run` flag

## Context

**Files**:
- `.agents/scripts/merge.sh` - The merge script
- `.agents/maw.env.sh` - MAW CLI
- `.claude/commands/maw-boot.md` - Documentation

**Test workflow**:
```bash
source .agents/maw.env.sh
maw start
maw hey 1 "task"
maw watch
maw merge 1
maw peek
```

**Golden Rule**: Never `cd` into agent directories - use `git -C`
