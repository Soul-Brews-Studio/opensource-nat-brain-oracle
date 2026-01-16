# MAW (Multi-Agent Workflow) — Comprehensive Guide

> 2025-12-13 22:54 — Everything learned from MAW exploration session

---

## Table of Contents

1. [What is MAW](#1-what-is-maw)
2. [Architecture](#2-architecture)
3. [Installation](#3-installation)
4. [Profiles & Layouts](#4-profiles--layouts)
5. [Control Commands](#5-control-commands)
6. [Golden Rules](#6-golden-rules)
7. [Pain Points & Solutions](#7-pain-points--solutions)
8. [Open Issues](#8-open-issues)
9. [Key Files Reference](#9-key-files-reference)
10. [Patterns Learned](#10-patterns-learned)

---

## 1. What is MAW

**Multi-Agent Workflow** — tmux-based orchestration for multiple AI agents working in parallel.

| Component | Purpose |
|-----------|---------|
| **Git Worktrees** | Each agent = isolated directory + branch |
| **Tmux** | See all agents simultaneously |
| **maw commands** | Control agents from anywhere |
| **File signals** | Fast communication (~100ms) |

**Origin**: Extracted from `nazt/weyermann-malt-productpage` project (FloodBoy workshop demo)

**Official Kit**: https://github.com/Soul-Brews-Studio/multi-agent-workflow-kit

---

## 2. Architecture

### Worktree Structure

```
repo/                      ← main worktree (branch: main)
├── agents/
│   ├── 1/                ← agent 1 (branch: agents/1)
│   ├── 2/                ← agent 2 (branch: agents/2)
│   ├── 3/                ← agent 3 (branch: agents/3)
│   ├── 4/                ← agent 4 (branch: agents/4)
│   └── 5/                ← agent 5 (branch: agents/5)
├── .agents/              ← MAW toolkit
│   ├── scripts/          ← hey.sh, start-agents.sh, etc.
│   ├── profiles/         ← tmux layouts
│   ├── agents.yaml       ← agent configuration
│   └── maw.env.sh        ← shell functions
└── .envrc                ← environment setup
```

### Sync Hierarchy (CRITICAL)

```
origin/main → local main → agents/N
     ↓            ↓
   (pull)      (merge)
```

- **Main** pulls from `origin/main`
- **Agents** merge from `local main` (NEVER from origin directly)

### Communication Flow

```
You (Main Context)
    ↓
maw hey N "task"
    ↓
Agent N (tmux pane)
    ↓
tmux capture-pane (read output)
```

---

## 3. Installation

### Prerequisites

- git (≥2.5)
- tmux (≥3.2)
- yq (YAML processor)
- uvx (Python package executor)

### Quick Install (One Command)

```bash
# IMPORTANT: Use Python 3.12 (3.14 has compatibility issues)
UV_PYTHON=3.12 uvx --no-cache \
  --from git+https://github.com/Soul-Brews-Studio/multi-agent-workflow-kit.git@v0.5.1 \
  multi-agent-kit init
```

### What It Creates

```
.agents/           ← Scripts, profiles, config
.claude/commands/  ← Slash commands (maw.hey, maw.sync, etc.)
.codex/prompts/    ← Codex prompt templates
.envrc             ← Environment variables
MAW-AGENTS.md      ← Agent documentation
agents/1,2,3/      ← Git worktrees
```

### Post-Install

```bash
source .envrc      # Load maw functions
maw attach         # Connect to tmux session
```

---

## 4. Profiles & Layouts

### Available Profiles

| Profile | Layout | Panes | Best For |
|---------|--------|-------|----------|
| **profile0** | 3 vertical (stacked) | 3 | Default, simple |
| **profile1** | Left + stacked right | 3 | Primary/secondary |
| **profile2** | Top + full bottom | 3 | Pair programming |
| **profile3** | Single full-width | 1 | Focus mode |
| **profile4** | Three-pane | 3 | Small team |
| **profile5** | Six-pane dashboard | 6 | Full visibility |
| **profile8** | 2 windows, 3 vertical each | 6 | Semantic tiers |
| **profile14** | **2 windows, 3 horizontal each** | 6 | **Recommended** |

### Profile14 Layout (Best for 5 agents)

```
Window 1: [Agent 1 | Agent 2 | Agent 3]  ← horizontal (side-by-side)
Window 2: [Agent 4 | Agent 5 | Monitor]  ← horizontal (side-by-side)
```

**Pane References**:
- Window 1: `1.1`, `1.2`, `1.3`
- Window 2: `2.1`, `2.2`, `2.3`

### Start with Profile

```bash
maw start profile14
# or
maw start profile0
```

---

## 5. Control Commands

### Session Management

| Command | Purpose |
|---------|---------|
| `maw start <profile>` | Launch tmux session |
| `maw attach` | Connect to running session |
| `maw kill` | Terminate all sessions |

### Agent Communication

| Command | Purpose |
|---------|---------|
| `maw hey 1 "task"` | Send to Agent 1 |
| `maw hey 2 "task"` | Send to Agent 2 |
| `maw hey all "cmd"` | Broadcast to all |
| `maw send "cmd"` | Send to all panes |

### Navigation

| Command | Purpose |
|---------|---------|
| `maw warp 1` | CD to agents/1 (inside pane) |
| `maw warp root` | CD to repo root |
| `maw zoom 1` | Maximize Agent 1 pane |

### Sync & Management

| Command | Purpose |
|---------|---------|
| `maw sync` | Git sync (smart) |
| `maw sync --files` | Quick file copy |
| `maw direnv` | Allow direnv everywhere |
| `maw agents list` | List all agents |
| `maw agents create N` | Create new agent |
| `maw remove N` | Delete agent worktree |

### Capture Output (Claude Code Pattern)

```bash
# Send command
maw hey 1 "git status"

# Wait & capture
sleep 1
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p -S -50 | tail -15
```

### Auto-Start Agents

By default, agents don't auto-start (just shell panes).

```bash
# Enable auto-start
AUTO_START_AGENTS=1 maw start profile14
```

**What it launches**:
| Agent | Command |
|-------|---------|
| Agent 1 | `claude --dangerously-skip-permissions` |
| Agent 2-5 | `codex --dangerously-bypass-approvals-and-sandbox --enable web_search_request` |

---

## 6. Golden Rules

### ABSOLUTE PROHIBITIONS

1. **NEVER use `-f` flag** (NO EXCEPTIONS)
   - `git push -f` ❌
   - `git checkout -f` ❌
   - `git reset --hard` ❌
   - **Why**: 2025-11-30 incident destroyed all agents' WIP commits

2. **NEVER Cross Worktree Boundaries**
   - Agent 1 stays in `agents/1/` ONLY
   - Agent 2 stays in `agents/2/` ONLY
   - Main stays in root ONLY
   - **Why**: Breaks isolation, creates conflicts

3. **NEVER Sync from Wrong Source**
   - Main: `git pull --ff-only origin main`
   - Agents: `git merge main` (local, not origin)
   - **Why**: Prevents sync conflicts

### Identity Check (ALWAYS FIRST)

```bash
pwd                           # WHERE am I?
git branch --show-current     # WHICH branch?
```

---

## 7. Pain Points & Solutions

### Pain #1: Python 3.14 Incompatibility

**Error**:
```
ImportError: cannot import name 'Traversable' from 'importlib.abc'
```

**Solution**:
```bash
UV_PYTHON=3.12 uvx --no-cache --from git+... multi-agent-kit init
```

### Pain #2: "command not found: maw"

**Cause**: `maw` is a shell function, not exported to subshell

**Solution**:
```bash
# Always source before using
cd /path/to/repo && source .envrc && maw [command]
```

**Why it works**: `export -f maw` in maw.env.sh exports function to subshells

### Pain #3: tmux attach fails from Claude Code

**Error**: `open terminal failed: not a terminal`

**Cause**: Claude Code bash isn't interactive terminal

**Solution**: Run `tmux attach` from real terminal, use `maw hey` + `tmux capture-pane` from Claude Code

### Pain #4: Vertical vs Horizontal Confusion

| Term | Layout |
|------|--------|
| **Vertical** | Stacked (top/bottom) |
| **Horizontal** | Side-by-side (left/right) |

**profile14** = horizontal (side-by-side)

---

## 8. Open Issues

### Bugs (2)

| # | Issue | Fix |
|---|-------|-----|
| **#26** | OSC escape sequences in hey.sh | Add `-l` flag to `tmux send-keys` |
| **#17** | Missing `os` import in cli.py | Add `import os` |

### Features (8)

| # | Title | Theme |
|---|-------|-------|
| #25 | Knowledge sharing patterns | Docs |
| #24 | Philosophy config in agents.yaml | Config |
| #23 | Enhanced status (WIP + divergence) | UX |
| #22 | `maw pick` - self-assign issues | Workflow |
| #21 | `maw pr` - create PRs | Workflow |
| #20 | Free will workflow template | Docs |
| #19 | Visual sync output | UX |
| #18 | Agent coordination guidance | Docs |

### Our Discovered Issue (Not Filed Yet)

**Python 3.14 compatibility** — `Traversable` import fails

---

## 9. Key Files Reference

### In Nat-s-Agents (After Install)

| File | Purpose |
|------|---------|
| `.agents/maw.env.sh` | Shell functions + export -f |
| `.agents/scripts/hey.sh` | Send messages to agents |
| `.agents/scripts/start-agents.sh` | Launch tmux session |
| `.agents/profiles/profile14.sh` | 2-window horizontal layout |
| `.agents/agents.yaml` | Agent configuration |
| `.envrc` | Environment setup |
| `MAW-AGENTS.md` | Agent documentation |

### Weyermann (Learn Reference)

| File | Purpose |
|------|---------|
| `ψ/learn/repo/.../weyermann-malt-productpage/` | Real MAW implementation |
| `ψ/learn/weyermann.md` | Learning notes |
| `ψ-docs/maw/SYNC-RULES.md` | Golden rules |
| `ψ-docs/maw/SMART-SYNC.md` | Sync strategy |

### MAW Kit (Incubate)

| File | Purpose |
|------|---------|
| `ψ/incubate/repo/.../multi-agent-workflow-kit/` | Official toolkit |
| `README.md` | Installation guide |
| `src/multi_agent_kit/` | Python source |

---

## 10. Patterns Learned

### Pattern 1: Inline Call (Claude Code)

```bash
cd /path && source .envrc && maw [command]
```

**Why**: Subshell isolation requires sourcing in same command chain

### Pattern 2: Capture-After-Send

```bash
maw hey 1 "command"
sleep 1
tmux capture-pane -t SESSION:WINDOW.PANE -p -S -50 | tail -15
```

**Why**: Commands execute async, need delay before capture

### Pattern 3: Learn → Pain → Incubate

```
Clone to learn/ → Use in real project → Hit pain points → Fix in incubate/
```

**Applied Today**:
1. Learned from weyermann (ψ/learn/)
2. Installed in Nat-s-Agents (pain: Python 3.14)
3. Will fix in MAW kit (ψ/incubate/)

### Pattern 4: Notes Tracked, Repos Ignored

```
ψ/learn/weyermann.md       ← tracked (notes)
ψ/learn/repo/...           ← gitignored (clone)
```

**Why**: Separate knowledge (evolves) from code (snapshot)

### Pattern 5: Real Path vs Learn Clone

| Location | Purpose | Works? |
|----------|---------|--------|
| `/Users/nat/000-workshop-product-page` | REAL repo | ✅ MAW runs here |
| `ψ/learn/repo/.../weyermann-malt-productpage/` | Clone for docs | ❌ No .envrc |

---

## Quick Reference Card

```bash
# Install
UV_PYTHON=3.12 uvx --no-cache --from git+https://github.com/Soul-Brews-Studio/multi-agent-workflow-kit.git@v0.5.1 multi-agent-kit init

# Start
source .envrc && maw start profile14

# Control
maw hey 1 "task"              # Send to agent
maw hey all "git status"      # Broadcast
maw zoom 1                    # Maximize pane
maw sync                      # Git sync

# Capture (Claude Code)
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p -S -50 | tail -15

# Session
maw attach                    # Connect
maw kill                      # Stop
tmux list-sessions            # List all
```

---

## Session Stats

| Metric | Value |
|--------|-------|
| Time exploring MAW | ~2 hours |
| Repos analyzed | 2 (weyermann, MAW kit) |
| Docs read | 8+ files |
| Pain points found | 4 |
| Issues discovered | 10 open |
| Commands learned | 15+ |

---

*Comprehensive MAW knowledge from 2025-12-13 session*
*Ready for incubation improvements based on real usage*
