# Slug Registry Design Pattern

**Date**: 2025-12-17
**Context**: Designing `/project`, `/learn`, `/trace` slug resolution

## The Problem

Multiple repos across different locations (ghq, ψ/learn, ψ/incubate). Need fast lookup without remembering full paths or complex names.

## Bad Approach (Initial)

❌ Pre-populate slugs.yaml with all repos
❌ Manual registration during lookup
❌ Complex abbreviations (`mem` for `claude-mem`)
❌ Search first, resolve later

## Good Approach (Final)

✅ **Auto-register at source** - `/project learn [url]` adds slug automatically
✅ **Fast path first** - instant grep before expensive search
✅ **Fuzzy AND matching** - `claude-mem` → `grep -i claude | grep -i mem`
✅ **Simple naming** - full repo name as slug (no mental mapping)
✅ **Organic growth** - registry grows from actual usage

## Key Insights

### 1. Register at Source, Not at Use

```
❌ /learn mem → search → register
✅ /project learn [url] → auto-register → done
```

**Why**: Registration is a side effect of adding a project, not looking it up.

### 2. Fast Path Before Slow Path

```bash
# 1. Slug lookup (instant grep) - 10ms
grep "^$INPUT:" slugs.yaml

# 2. Direct find (fast) - 50ms
find ψ/learn/repo -name "$INPUT"

# 3. Fuzzy search (slow) - 200ms
find ... | grep -i word1 | grep -i word2

# 4. Subagent search (slowest) - 2s
spawn context-finder
```

**Why**: Most lookups are happy path (slug exists). Don't pay for search when not needed.

### 3. Fuzzy AND Matching

```bash
# Input: "claude-mem"
# Split by - and chain greps
grep -i claude | grep -i mem

# Matches:
# - claude-mem ✅
# - my-claude-mem-fork ✅
# - claude-memory ✅ (partial)
```

**Why**: Handles slight variations without exact match requirement.

### 4. Simplicity Over Cleverness

```yaml
# ❌ Complex abbreviations
mem: claude-mem
hl: headline
maw: multi-agent-workflow-kit

# ✅ Simple, predictable
claude-mem: ψ/learn/repo/.../claude-mem
headline: ψ/learn/repo/.../the-headline
```

**Why**: No mental overhead. Type what you see.

## Flow Diagram

```
User: /project learn https://github.com/owner/repo
    │
    ├─► ghq get → clone
    ├─► symlink to ψ/learn/repo/
    └─► AUTO: register "repo" in slugs.yaml ✅

Later: /learn repo
    │
    ├─► grep slugs.yaml → FOUND (10ms) ✅
    └─► proceed to learning (3 agents)
```

## Anti-Patterns Avoided

1. **Manual registration burden** - user has to remember to register
2. **Abbreviation cognitive load** - what's the short code for X?
3. **Search-first approach** - slow even for known repos
4. **Pre-population** - stale data, unused entries

## Command Responsibilities

| Command | Slug Behavior |
|---------|---------------|
| `/project learn` | Creates + auto-registers |
| `/project incubate` | Creates + auto-registers |
| `/learn` | Looks up (fast path → 3 agents) |
| `/trace` | Hint only (always searches everywhere with 5 agents) |

**Key**: `/trace` remains generic - slug is just a hint, comprehensive search always runs.

## Documentation Organization

### Timestamped + Hub File Pattern

```
ψ/learn/claude-mem/
├── CLAUDE-MEM.md                     # Hub (uppercase = clear in graph)
├── 2025-12-17_ARCHITECTURE.md        # Timestamped (never overwrite)
├── 2025-12-17_CODE-SNIPPETS.md
├── 2025-12-17_QUICK-REFERENCE.md
└── 2025-12-20_ARCHITECTURE.md        # Re-learning adds new version
```

**Benefits**:
- **REPO-NAME.md** - hub file named after repo (uppercase, clear in Obsidian graph)
- **Timestamps** - compare discoveries over time
- **Never lose insights** - history preserved
- **Meaningful names** - graph shows "CLAUDE-MEM" not "INDEX"
- **Timeline** - track evolution of understanding
- **Incremental discovery** - re-learning appends to hub, compares new vs old

## Files Changed

- `.claude/commands/project.md` - auto-register on learn/incubate
- `.claude/commands/learn.md` - fast path + fuzzy matching + INDEX + timestamps
- `.claude/commands/trace.md` - slug support
- `ψ/memory/slugs.yaml` - registry file

## Quote

> "Register at source, lookup at use. Simple names, fast paths."

## Related Patterns

- [Subagent delegation pattern](2025-12-13_subagent-delegation-pattern.md) - when to use subagents
- Oracle philosophy - patterns over intentions, let behavior emerge

---

**Validated**: First use (claude-mem) - fast path worked in 10ms
