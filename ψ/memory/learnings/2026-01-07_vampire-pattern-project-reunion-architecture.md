---
title: ## Vampire Pattern: /project reunion Architecture
tags: [vampire-pattern, reunion, ghq, symlink, slug-registry, architecture]
created: 2026-01-07
source: Session 2026-01-07 23:05 - Nat's architecture refinement
---

# ## Vampire Pattern: /project reunion Architecture

## Vampire Pattern: /project reunion Architecture

**The Pattern**: Connect → Drain → Disconnect → Note

### Flow
```
/project reunion [slug]

1. ghq get/pull          → Ensure repo exists at ~/Code/github.com/org/repo
2. symlink create        → ψ/learn/repo/[slug] → ghq path
3. Oracle reads          → Scan ψ/memory/learnings/*.md, ψ/memory/retrospectives/
4. Vampire drain         → oracle_learn all new content since last_reunion
5. Unlink symlink        → rm ψ/learn/repo/[slug] (offload disk)
6. Update registry       → last_reunion timestamp in slugs.yaml
```

### Enhanced Slug Registry
```yaml
# ψ/memory/slugs.yaml
my-project:
  path: ψ/learn/repo/my-project      # Symlink path
  ghq: ~/Code/github.com/org/repo    # Ground truth (ghq managed)
  github: github.com/org/repo        # Remote URL
  type: spinoff                      # learn | incubate | spinoff
  last_reunion: 2026-01-07 23:05     # Vampire visit timestamp
  status: unlinked                   # linked | unlinked
```

### Key Insights
- **ghq path = ground truth**: Always know real location
- **github path = derivable**: `ghq path` minus `~/Code/` prefix
- **symlink = temporary**: Only exists during active work or reunion
- **vampire = efficient**: Read all, index, disconnect
- **timestamp = history**: Track reunion frequency per project

### `/slug list` Command
Shows all slugs with type, status, last update time.
Spinoffs show last_reunion, learns/incubates show last_accessed.

---
*Added via Oracle Learn*
