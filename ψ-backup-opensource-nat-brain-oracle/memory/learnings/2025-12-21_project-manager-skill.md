# Project Manager Skill Workflow

**Date**: 2025-12-21
**Context**: Unifying learn/incubate behaviors with ghq, slugs, and symlinks

## Why This Matters

Project management commands need to feel instant, predictable, and low-friction.
The user should only think in repo names and intent, not filesystem topology.
This learning consolidates the operational contract for the project-manager skill.

## Learn vs Incubate Actions

### `/project learn [repo-url | owner/repo]`

**Intent**: Bring external knowledge into the learn system.

**Actions**:
- Ensure repo exists via ghq (`ghq get` or `ghq get -u`).
- Create a read-first symlink into `ψ/learn/repo/`.
- Register slug for fast lookup.
- Optionally open or index the repo for learning agents.

**Outputs**:
- Slug entry → `ψ/memory/slugs.yaml`.
- Symlink → `ψ/learn/repo/<slug>`.
- Learn hub file → `ψ/learn/<slug>/<SLUG>.md` (if created).

### `/project incubate [repo-url | owner/repo]`

**Intent**: Create a working sandbox with evolution potential.

**Actions**:
- Ensure repo exists via ghq (same as learn).
- Create a writable symlink into `ψ/incubate/` (or incubate workspace root).
- Register slug for fast lookup.
- Optionally create an incubation state file (progress/log).

**Outputs**:
- Slug entry → `ψ/memory/slugs.yaml`.
- Symlink → `ψ/incubate/<slug>`.
- Incubation metadata → `ψ/incubate/<slug>/.incubation.md` (if used).

## Learn vs Incubate Decision Rules

- **Learn** when the repo is a knowledge source, not a workspace.
- **Incubate** when the repo is expected to change, fork, or evolve.
- If unsure, start with learn and promote to incubate by adding a new symlink.
- Both paths can coexist (one repo, two symlinks, single ghq source).

## ghq Integration Contract

### Source of Truth

- ghq-managed clone is the canonical location.
- All downstream references are symlinks, never duplicate clones.
- ghq provides stable paths for rehydration and updates.

### Typical Flow

```bash
# Acquire or update source
ghq get -u https://github.com/owner/repo

# Create learn symlink
ln -s "$(ghq root)/github.com/owner/repo" "ψ/learn/repo/repo"

# Create incubate symlink
ln -s "$(ghq root)/github.com/owner/repo" "ψ/incubate/repo"
```

**Benefits**:
- Single disk copy.
- Consistent path resolution.
- Easy updates with `ghq get -u`.
- Slug registry can point to symlink rather than source path.

## Slug Registry Rules

### Registry Location

- `ψ/memory/slugs.yaml` is the system-wide registry.

### Registry Format

```yaml
repo-name: ψ/learn/repo/repo-name
service-tooling: ψ/incubate/service-tooling
```

### Registration Behavior

- Auto-register when learn/incubate creates a symlink.
- Prefer the **symlink path**, not the ghq path.
- Use full repo name as the slug (no abbreviations).
- Allow multiple entries for the same repo if paths differ.

### Lookup Behavior

- First try exact slug match.
- Then fallback to fuzzy AND matching.
- Only spawn deeper search if registry lookup misses.

## Symlink Structure

### Learn Path

```
ψ/learn/repo/
└── repo-name -> $(ghq root)/github.com/owner/repo
```

### Incubate Path

```
ψ/incubate/
└── repo-name -> $(ghq root)/github.com/owner/repo
```

### Rationale

- **Identity over location**: symlink name is the repo identity.
- **Fast lookup**: slug points to stable, human paths.
- **Isolation**: learn vs incubate stays visually distinct.

## Error Handling Notes

- If ghq is missing, fail fast with a clear instruction.
- If symlink exists, verify it points to the expected ghq path.
- If slug exists with a conflicting path, warn and request confirmation.
- If repo has moved, update ghq and refresh symlink.

## Command Summary Table

| Command | ghq | Symlink Target | Slug Registry | Notes |
| --- | --- | --- | --- | --- |
| `/project learn` | get/update | `ψ/learn/repo/<slug>` | add/refresh | knowledge intake |
| `/project incubate` | get/update | `ψ/incubate/<slug>` | add/refresh | working sandbox |
| `/learn` | none | uses registry | lookup only | read-only |
| `/trace` | none | uses registry | hint only | exhaustive search |

## Checklist (Execution Order)

1. Parse input into repo slug + source URL.
2. Ensure ghq clone exists (update if needed).
3. Create or refresh symlink.
4. Register slug to symlink path.
5. Report the resolved path to the user.

## Anti-Patterns to Avoid

- Duplicating clones outside ghq.
- Registering slugs before symlink creation.
- Overwriting existing slug mappings silently.
- Treating incubate as read-only.

## Related Learnings

- `2025-12-17_slug-registry-design.md`
- `2025-12-15_ghq-symlink-project-pattern.md`
- `2025-12-17_agent-incubation-workflow.md`

## Quote

> "Let ghq own the source; let symlinks own the identity; let slugs own the speed."
