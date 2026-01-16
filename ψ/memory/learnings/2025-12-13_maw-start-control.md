# MAW Start & Control — Lesson Learned

> 2025-12-13 22:32 — How to start and control Multi-Agent Workflow

## Key Discovery

**Learn clone ≠ Real repo**

| Location | Purpose | MAW works? |
|----------|---------|------------|
| `/Users/nat/000-workshop-product-page` | **REAL repo** | ✅ Yes |
| `ψ/learn/repo/.../weyermann-malt-productpage/` | Read docs only | ❌ No `.envrc` |

---

## How to Start MAW

```bash
# Inline call (from anywhere)
cd /Users/nat/000-workshop-product-page && source .envrc && maw start profile0
```

**Why `source .envrc`?**
- `maw` is a shell function (not binary)
- `export -f maw` makes it available in subshells
- Without sourcing → "command not found: maw"

---

## Control Commands

| Command | Purpose |
|---------|---------|
| `maw hey 1 "task"` | Send to Agent 1 |
| `maw hey all "cmd"` | Broadcast to all |
| `maw zoom 1` | Maximize pane |
| `maw warp 2` | CD to agents/2 |
| `maw sync` | Git sync all |
| `maw attach` | Connect to session |
| `maw kill` | Stop session |

---

## Tmux Pane Mapping

```
Session: ai-000-workshop-product-page

Pane 0 → Agent 1 (agents/1)
Pane 1 → Agent 2 (agents/2)
Pane 2 → Agent 3 (agents/3)
```

**Direct tmux control:**
```bash
tmux send-keys -t ai-000-workshop-product-page:0.0 "pwd" C-m
```

---

## Profiles

| Profile | Layout | Panes |
|---------|--------|-------|
| profile0 | 3 vertical | 3 stacked |
| profile8 | 2 windows vertical | 3+3 stacked |
| **profile14** | **2 windows horizontal** | **3+3 side-by-side** |

```
Profile14 Layout:
Window 1: [Agent 1 | Agent 2 | Agent 3]  ← horizontal
Window 2: [Agent 4 | Agent 5 | Monitor]  ← horizontal
```

---

## Auto-Start Agents (Claude/Codex)

**By default**: Agents don't auto-start (just shell panes)

**To enable**:
```bash
AUTO_START_AGENTS=1 maw start profile14
```

**What it launches**:
| Agent | Command |
|-------|---------|
| Agent 1 | `claude --dangerously-skip-permissions` |
| Agent 2-5 | `codex --dangerously-bypass-approvals-and-sandbox --enable web_search_request` |

---

## Capture Output (Claude Code Pattern)

```bash
# Send command
maw hey 1 "git status"

# Wait & capture
sleep 1
tmux capture-pane -t ai-000-workshop-product-page:1.1 -p -S -50 | tail -15
```

**Pane reference**: `SESSION:WINDOW.PANE`
- Window 1: `1.1`, `1.2`, `1.3`
- Window 2: `2.1`, `2.2`, `2.3`

---

## Pattern: Inline Call

**Problem**: Claude Code bash runs in isolated subshell

**Solution**: Chain commands
```bash
cd /path && source .envrc && maw [command]
```

**Why it works**: `source` exports functions to current shell before `maw` runs

---

## Golden Rules (From Weyermann)

1. **NEVER use `-f`** — destroys agent history
2. **NEVER cross worktree** — stay in your directory
3. **Sync from right source** — Main ← origin, Agents ← local main

---

*Extracted from MAW exploration session*
