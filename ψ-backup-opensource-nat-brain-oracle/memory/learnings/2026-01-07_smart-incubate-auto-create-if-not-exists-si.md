---
title: ## Smart Incubate: Auto-Create if Not Exists
tags: [smart-incubate, command-simplification, project-lifecycle]
created: 2026-01-07
source: Session 2026-01-07 23:10 - Nat's simplification idea
---

# ## Smart Incubate: Auto-Create if Not Exists

## Smart Incubate: Auto-Create if Not Exists

**Simplification**: Merge `/project create` into `/project incubate`

### New Behavior
```
/project incubate [name]

→ Check: does repo exist on GitHub?
   YES → ghq get + symlink to ψ/incubate/ (incubate existing)
   NO  → gh repo create + ghq get + symlink (auto-create then incubate)
```

### Final /project Command Set
```
/project learn     → 📚 Study (read-only, ψ/learn/)
/project incubate  → 🌱 Work (auto-create if needed, ψ/incubate/)
/project spinoff   → 🎓 Graduate (own repo)
/project reunion   → 🤝 Sync back (index learnings to Oracle)
```

### Why This Works
- One less command to remember
- `incubate` is the natural verb for "start working on something"
- If it doesn't exist, create it — obvious behavior
- `/project create` becomes unnecessary (or alias to incubate)

---
*Added via Oracle Learn*
