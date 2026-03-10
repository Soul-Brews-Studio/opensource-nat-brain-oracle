# ghq + Symlink Pattern for Project Management

**Date**: 2025-12-15
**Context**: Simplified /project command using ghq + symlinks

## Pattern

```
~/Code/github.com/owner/repo/     ← ghq จัดการ (single source)
        ↓ symlink
./ψ/learn/repo                    ← study/reference
./ψ/incubate/repo                 ← active development
```

## Key Principles

1. **ghq get -u = always** — clone if new, update if exists (auto-sync!)
2. **Never git pull** — always use ghq
3. **Symlinks, not copies** — no duplicate repos, no extra disk space
4. **Unlink + relink** — move between learn/incubate is simple

## Commands

```bash
# Clone + symlink
ghq get -u [url]
REPO_PATH=$(ghq list -p | grep [name] | head -1)
ln -sf "$REPO_PATH" ./ψ/learn/

# Move learn → incubate
rm ./ψ/learn/[name]
ln -sf "$REPO_PATH" ./ψ/incubate/

# Move incubate → learn
rm ./ψ/incubate/[name]
ln -sf "$REPO_PATH" ./ψ/learn/
```

## Why This Works

| Old Way | New Way |
|---------|---------|
| Clone ซ้ำหลาย copies | Single source ที่ ~/Code |
| Disk space x2, x3 | No extra space |
| Pull แต่ละที่ | ghq get -u = ทุกที่ update |
| Complex promote/demote | Simple unlink + relink |

## Mapping Doc Pattern

```
ψ/incubate/
├── backstage → ~/Code/.../backstage (symlink)
├── backstage.md                      (mapping doc)
```

**Template: [repo].md**
```markdown
# CODENAME

**Repo**: [org/repo](https://github.com/org/repo)
**Local**: `/Users/nat/Code/github.com/org/repo`
**Status**: 🌱 incubate

## Projects

| Codename | → |
|----------|---|
| SUBPROJECT | [folder/](https://github.com/org/repo/tree/main/folder) |

## Log

| Date | Action |
|------|--------|
| 12-15 | 🌱 Incubated |
```

## Codename = Cool Name

- **BACKSTAGE** not share-folder
- **ORACLE** not Nat-s-Agents
- Use `gh repo rename` to match

## .gitignore

```
ψ/learn/*
ψ/incubate/*
!ψ/learn/.gitkeep
!ψ/incubate/.gitkeep
```

## Related

- `/project` command
- ghq workflow: `ψ/memory/learnings/2025-12-12_ghq-workflow.md`
- codenames: `ψ/memory/resonance/project-codenames.md`
