---
title: ## Handoff Log Pattern (Single File, Append-Only)
tags: [handoff, session, append-only, oracle-philosophy, workflow, nothing-deleted, single-source-of-truth]
created: 2026-01-15
source: Session 2026-01-15 - Handoff consolidation fix
---

# ## Handoff Log Pattern (Single File, Append-Only)

## Handoff Log Pattern (Single File, Append-Only)

### The Pattern

Use a single `handoff.log` file instead of multiple handoff files:

```
ψ/inbox/handoff.log    ← Single file, append-only
ψ/inbox/handoff/*.md   ← Archive (old entries moved here)
```

### Format

```markdown
---
## YYYY-MM-DD HH:MM | context%

**Focus**: What we worked on

**Commits**:
  hash1 message1
  hash2 message2

**Done**:
- Item 1
- Item 2

**Pending**:
- Item 1
- Item 2
```

### Why It Works

| Aspect | Benefit |
|--------|---------|
| Single file | No scattered files to search |
| Append-only | Oracle philosophy - nothing deleted |
| Timestamp + % | Quick scan for context level |
| Hook reads it | Auto-shows at session start |
| Archive when full | Keep log clean, history preserved |

### Flow

```
Session work → /forward → Append to handoff.log
                              ↓
                    Next session hook reads it
                              ↓
                    (When too long) Archive old entries
```

### Implementation

- Hook: `.claude/scripts/show-latest-handoff.sh`
- Reads last `---` block from `handoff.log`
- Shows if entry is from today/yesterday
- Users see context immediately on session start

**Key insight**: Multiple files created drift and confusion. Single append log = single source of truth.

---
*Added via Oracle Learn*
