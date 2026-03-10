# MAW Portfolio Demo Workflow

> Multi-agent collaborative development - one project, three agents, zero conflicts

## The Pattern

```
┌─────────────────────────────────────────────────────────┐
│                    MAIN AGENT (Opus)                    │
│  - Reviews quality                                      │
│  - Designs tasks                                        │
│  - Fixes issues                                         │
│  - Orchestrates flow                                    │
└─────────────────┬───────────────────────────────────────┘
                  │
         ┌────────┼────────┐
         │        │        │
         ▼        ▼        ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│  Agent 1    │ │  Agent 2    │ │  Agent 3    │
│  index.html │ │  styles.css │ │  script.js  │
│  (HTML)     │ │  (CSS)      │ │  (JS)       │
└─────────────┘ └─────────────┘ └─────────────┘
```

## Workflow Steps

### 1. Create Project Structure
```bash
mkdir -p ψ/lab/portfolio-demo
```

### 2. Sync Agents
```bash
maw sync
```

### 3. Send Parallel Tasks (Different Files)
```bash
maw hey 1 "Create index.html - Complete portfolio structure. Commit when done."
maw hey 2 "Create styles.css - Modern CSS with gradients. Commit when done."
maw hey 3 "Create script.js - Interactivity and animations. Commit when done."
```

### 4. Wait for Completion
```bash
maw wait 1 2 3   # Blocks until all commit (1s polling)
```

### 5. Collect Results
```bash
git rebase agents/1 && git rebase agents/2 && git rebase agents/3
```

### 6. Review & Iterate
```bash
open ψ/lab/portfolio-demo/index.html  # View in browser

# If not good enough, send fixes:
maw hey 1 "The HTML needs more personality. Add real content. Fix and commit."
maw hey 2 "The CSS is boring. Add glassmorphism and gradients. Fix and commit."
maw hey 3 "The JS needs polish. Add scroll animations. Fix and commit."

maw wait 1 2 3
git rebase agents/1 && git rebase agents/2 && git rebase agents/3
```

### 7. Fine-tune (Opus Intervention)
When agent quality isn't enough, main agent fixes directly:
```bash
# Edit file directly with Opus taste
# Then sync to agents for next iteration
maw sync
```

## Key Success Factors

### Why No Conflicts?
| Rule | Implementation |
|------|----------------|
| Different files | Each agent owns ONE file |
| Serial rebase | `rebase agents/1 && rebase agents/2` |
| Sync before tasks | `maw sync` ensures same base |
| No focus.md edits | Task includes "DO NOT modify focus.md" |

### Efficient Waiting
```bash
# BAD - wastes time
sleep 45 && maw peek

# GOOD - event-driven
maw wait 1 2 3  # Returns when ALL commit
```

### Quality Control Loop
```
Agent creates → Main reviews → Agent fixes → Main reviews → Done
       ↓              ↓              ↓              ↓
    (draft)     (not good)     (improved)    (approved)
```

## Real Session Example

### Trial 14 Results

| Phase | Agent 1 | Agent 2 | Agent 3 |
|-------|---------|---------|---------|
| Initial | 377 lines HTML | 596 lines CSS | 368 lines JS |
| After fix | 324 lines (better) | 1157 lines | 854 lines |
| Polish | +font links | +grid pattern | +scroll reveal |

**Total: 2,335+ lines, zero conflicts**

### What Each Round Produced

**Round 1: Structure**
- Generic template
- Basic styling
- Minimal interactivity

**Round 2: Personality**
- Real content (Nat Weerawan, MAW, Oracle)
- Modern aesthetics (but nav broken)
- Delightful interactions (but over-engineered)

**Round 3: Polish (Opus direct)**
- Fixed nav layout
- Added gradient orbs
- Proper Linear.app aesthetic

**Round 4: Refinements**
- Google Fonts
- Grid background
- Scroll animations

## Commands Reference

| Command | Purpose |
|---------|---------|
| `maw start profile14` | Start 3-agent session |
| `maw sync` | Sync all agents to main |
| `maw hey N "task"` | Send task to agent N |
| `maw wait 1 2 3` | Wait for agents to commit |
| `maw peek` | Check agent status |
| `git rebase agents/N` | Collect agent N's work |

## Lessons Learned

1. **Agents make functional, not beautiful** - Need Opus review for taste
2. **Iteration is fast** - `maw wait` enables tight feedback loops
3. **File ownership prevents conflicts** - One agent per file
4. **Direct intervention is sometimes better** - Opus can fix faster than instructing

## The Meta-Pattern

```
Delegate bulk work → Review quality → Fix gaps → Iterate
     (agents)          (Opus)          (Opus)    (agents)
```

---

*Created: 2025-12-20*
*Trial: 14 (Portfolio Demo)*
*Agents: 3 parallel*
*Output: Complete portfolio site*
