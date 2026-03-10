# MAW (Multi-Agent Workflow) Documentation Index

**Created**: 2025-12-20
**Status**: Complete navigation guide for all MAW learning materials
**Scope**: 15+ learning files, root docs, retrospectives, configuration files

---

## Quick Start (Read These First)

### For New Users — Start Here
1. **[2025-12-13_maw-comprehensive-guide.md](../2025-12-13_maw-comprehensive-guide.md)** (449 lines)
   - Full architecture overview, installation, commands, patterns
   - Best entry point if discovering MAW for first time
   - Read time: 15-20 minutes

2. **[MAW-COMPLETE-SYSTEM.md](../../../MAW-COMPLETE-SYSTEM.md)** (295 lines)
   - 10 production-ready iterations consolidated
   - Conflict prevention patterns (8 patterns, 100% validation)
   - Safe reset + smart lock system
   - Read time: 10-15 minutes

3. **[2025-12-17_maw-sync-best-practices.md](../2025-12-17_maw-sync-best-practices.md)** (225 lines)
   - 4 sync patterns (Agent→Main, Main→All, Full Sync, Quick Check)
   - Golden commands (maw peek, maw sync, maw log)
   - Key principles: `git -C` vs `cd`, rebase for same hash
   - Read time: 10-12 minutes

### For Troubleshooting
- **[2025-12-13_maw-setup-mistakes.md](../2025-12-13_maw-setup-mistakes.md)** — Common pitfalls & solutions
- **[2025-12-14_maw-control-guide.md](../2025-12-14_maw-control-guide.md)** — Practical command copy-paste

---

## Core Learning Files by Topic

### Architecture & Design

| File | Lines | Focus | Key Points |
|------|-------|-------|-----------|
| **[2025-12-13_maw-comprehensive-guide.md](../2025-12-13_maw-comprehensive-guide.md)** | 449 | Full overview | Worktree structure, installation, profiles, control commands |
| **[MAW_ANALYSIS.md](./MAW_ANALYSIS.md)** | 2000+ | Production patterns | Safety infrastructure, agent hierarchy, communication flow |
| **[maw-trace-2025-12-13.md](./maw-trace-2025-12-13.md)** | 500+ | Real implementation | weyermann repository analysis, golden rules |
| **[2025-12-17_maw-git-worktree-patterns.md](../2025-12-17_maw-git-worktree-patterns.md)** | 148 | Git patterns | `git -C`, rebase vs merge, worktree boundaries |
| **[MAW-AGENTS.md](../../../MAW-AGENTS.md)** | 52 | Agent setup | Worktree configuration, multi-agent safety rules |

### Synchronization & Git Operations

| File | Lines | Focus | Key Points |
|------|-------|-------|-----------|
| **[2025-12-17_maw-sync-best-practices.md](../2025-12-17_maw-sync-best-practices.md)** | 225 | Sync patterns | 4 patterns, `git -C`, rebase strategy, conflict resolution |
| **[2025-12-17_maw-git-worktree-patterns.md](../2025-12-17_maw-git-worktree-patterns.md)** | 148 | Worktree mastery | `git -C` vs `cd`, rebase for sync, per-agent logs |
| **[2025-12-17_maw-wip-branch-pattern.md](../2025-12-17_maw-wip-branch-pattern.md)** | 119 | PR workflow | Optional PR review flow, direct sync vs review |
| **[2025-12-17_maw-branching-decisions.md](../2025-12-17_maw-branching-decisions.md)** | 48 | Branch strategy | When to use PR, rebase strategy, cleanup |

### Control & Operations

| File | Lines | Focus | Key Points |
|------|-------|-------|-----------|
| **[2025-12-14_maw-control-guide.md](../2025-12-14_maw-control-guide.md)** | 248 | Command reference | Pane mapping (profile14), maw hey, tmux capture, workflows |
| **[2025-12-13_maw-start-control.md](../2025-12-13_maw-start-control.md)** | 132 | Control patterns | maw start, maw hey, maw kill, signal patterns |
| **[2025-12-17_maw-peek-table-format.md](../2025-12-17_maw-peek-table-format.md)** | 62 | Status display | Pane status table, column definitions |
| **[MAW-COMPLETE-SYSTEM.md](../../../MAW-COMPLETE-SYSTEM.md)** | 295 | Smart lock system | maw-lock.sh commands, status, assign, wait, unlock |

### Installation & Setup

| File | Lines | Focus | Key Points |
|------|-------|-------|-----------|
| **[2025-12-13_maw-setup-patterns.md](../2025-12-13_maw-setup-patterns.md)** | 56 | Setup workflow | Directory structure, init process, profile selection |
| **[2025-12-13_maw-setup-mistakes.md](../2025-12-13_maw-setup-mistakes.md)** | 109 | Common pitfalls | Python 3.14 incompatibility, profile confusion, path errors |
| **[2025-12-13_maw-copy-order-pattern.md](../2025-12-13_maw-copy-order-pattern.md)** | 67 | Multi-repo sync | What files to copy in what order across repos |

### Philosophy & Learning

| File | Lines | Focus | Key Points |
|------|-------|-------|-----------|
| **[MAW_ANALYSIS.md](./MAW_ANALYSIS.md)** | 2000+ | Philosophy | "Prevention over resolution", safety by design, audit trails |
| **[maw-trace-2025-12-13.md](./maw-trace-2025-12-13.md)** | 500+ | Golden rules | Know who you are, sync from right source, never force, respect boundaries |
| **[2025-12-13_maw-comprehensive-guide.md](../2025-12-13_maw-comprehensive-guide.md)** § 6 & 10 | 150 | Patterns | Inline call pattern, capture-after-send, learn→pain→incubate |

---

## Session History & Retrospectives

### Week of Dec 13-17: MAW Setup & Mastery

| Date & Time | File | Focus | Outcome |
|-------------|------|-------|---------|
| **2025-12-13 23:01** | [maw-installation-journey.md](../../retrospectives/2025-12/13/23.01_maw-installation-journey.md) | Installation sprint | Profile14 setup complete |
| **2025-12-13 23:24** | [maw-profile14-setup-journey.md](../../retrospectives/2025-12/13/23.24_maw-profile14-setup-journey.md) | Final profile setup | Auto-start agents working |
| **2025-12-13 23:42** | [full-session-maw-antigravity.md](../../retrospectives/2025-12/13/23.42_full-session-maw-antigravity.md) | Full day summary | MAW + architecture integration |
| **2025-12-13 22:03** | [full-day-maw-brewing-architecture.md](../../retrospectives/2025-12/13/22.03_full-day-maw-brewing-architecture.md) | System overview | MAW fit in architecture |
| **2025-12-14 00:11** | [maw-autostart-polish-session.md](../../retrospectives/2025-12/14/00.11_maw-autostart-polish-session.md) | Polish & tuning | AUTO_START_AGENTS environment |
| **2025-12-14 03:06** | [maw-incubation-vault-session.md](../../retrospectives/2025-12/14/03.06_maw-incubation-vault-session.md) | Incubation planning | Repository management strategy |
| **2025-12-17 00:30** | [maw-conflict-prevention-system.md](../../retrospectives/2025-12/17/00.30_maw-conflict-prevention-system.md) | 8 patterns tested | 100% validation score |
| **2025-12-17 13:17** | [maw-git-worktree-mastery.md](../../retrospectives/2025-12/17/13.17_maw-git-worktree-mastery.md) | Worktree deep dive | `git -C`, rebase, same hash |
| **2025-12-17 14:14** | [maw-sync-patterns-mastery.md](../../retrospectives/2025-12/17/14.14_maw-sync-patterns-mastery.md) | Sync patterns | 4 patterns, agent autonomy |
| **2025-12-17 22:56** | [maw-branching-deep-dive.md](../../retrospectives/2025-12/17/22.56_maw-branching-deep-dive.md) | PR review strategy | Optional flow, agent-initiated sync |

**Progress**: Installation (Dec 13) → Mastery (Dec 17) → Production Ready (Dec 17 end)

### Week of Dec 20-28: Advanced Patterns & Safety

| Date & Time | File | Focus | Outcome |
|-------------|------|-------|---------|
| **2025-12-20** | Multiple sessions | Demo trials 1-10 | Zero conflicts achieved |
| **2025-12-21** | [maw-review-gate-pattern.md](../2025-12-21_maw-review-gate-pattern.md) | Review gate | checkpoint → review → merge |
| **2025-12-28 07:39** | [maw-amend-divergence-fix.md](../../retrospectives/2025-12/28/07.39_maw-amend-divergence-fix.md) | **CRITICAL** | `--amend` breaks sync, hook added |

**Progress**: Demo mastery (Dec 20) → Review patterns (Dec 21) → Safety hardening (Dec 28)

---

## Command Reference

### Essential Commands

```bash
# Status Check (always first!)
maw peek              # See what all agents are doing
maw peek 1            # Check specific agent
maw peek --table      # Tabular format (pane-based)

# Sync Operations
maw sync              # Sync all clean agents to main (rebase)
git -C agents/1 rebase main        # Rebase agent onto main
git rebase agents/1                # Pull agent's work to main

# Task Assignment
maw hey 1 "task description"       # Send to agent 1
maw hey all "git pull"             # Broadcast to all

# Logging
maw log activity "Started task"    # Write to per-agent log file

# Session Control
maw start profile14                # Start with 6-pane layout
maw attach                         # Connect to running session
maw kill                          # Stop all sessions
```

### Smart Lock System

```bash
# Via .agents/scripts/maw-lock.sh
./.agents/scripts/maw-lock.sh status          # Show all agent status
./.agents/scripts/maw-lock.sh check 1         # Check agent 1
./.agents/scripts/maw-lock.sh hey 1 "task"    # Assign with auto-lock
./.agents/scripts/maw-lock.sh wait 1          # Wait for completion
./.agents/scripts/maw-lock.sh lock 1 "task"   # Manual lock
./.agents/scripts/maw-lock.sh unlock 1        # Manual unlock
```

### Common Workflows

```bash
# Pattern A: Agent Work → Main → All
git -C agents/1 add -A && git -C agents/1 commit -m "work"
git rebase agents/1
git pull --rebase origin main
maw sync && git push origin main

# Pattern B: Main Work → All Agents
git add -A && git commit -m "work"
maw sync && git push origin main

# Pattern C: Agent-Initiated Full Sync (Powerful!)
ROOT="/Users/nat/Code/github.com/laris-co/Nat-s-Agents"
git add -A && git commit -m "my work"
git -C "$ROOT" rebase agents/1
git -C "$ROOT" pull --rebase origin main
for i in 2 3 4 5; do git -C "$ROOT/agents/$i" rebase main; done
git -C "$ROOT" push origin main
```

---

## Root Documentation Files

### Project Configuration

| File | Purpose |
|------|---------|
| **[MAW-COMPLETE-SYSTEM.md](../../../MAW-COMPLETE-SYSTEM.md)** | 10 iterations, production checklist |
| **[MAW-AGENTS.md](../../../MAW-AGENTS.md)** | Safety rules, worktree setup |
| **.agents/agents.yaml** | Agent configuration |
| **.agents/maw.env.sh** | Shell functions & exports |
| **.agents/maw-lock.sh** | Smart lock implementation |

### Architecture & Infrastructure

| Location | Purpose |
|----------|---------|
| **.agents/profiles/profile14.sh** | 2-window × 3-pane horizontal layout |
| **.agents/scripts/maw-wrapper.sh** | MAW command wrapper |
| **.agents/scripts/safe-reset.sh** | WIP backup + reset |
| **.agents/scripts/maw-safe.sh** | Safe operations |
| **.agents/maw-warp-function.sh** | Directory warp function |

---

## Learning Progression Guide

### If New to MAW

```
1. Start: 2025-12-13_maw-comprehensive-guide.md (15 min)
   ↓ Understand: What is MAW? How does it work?

2. Install: 2025-12-13_maw-setup-patterns.md (5 min)
   ↓ How to set up? What files needed?

3. Troubleshoot: 2025-12-13_maw-setup-mistakes.md (5 min)
   ↓ What could go wrong? How to fix?

4. Control: 2025-12-14_maw-control-guide.md (10 min)
   ↓ How to operate agents? What commands?

5. Deep Dive: MAW_ANALYSIS.md (20 min)
   ↓ Production patterns, safety infrastructure, philosophy
```

**Total Time**: ~50 minutes for solid understanding

### If Debugging Sync Issues

```
1. Check status: 2025-12-17_maw-sync-best-practices.md § Pattern D
   → maw peek first!

2. Understand patterns: 2025-12-17_maw-sync-best-practices.md § Patterns A-C
   → Which sync pattern applies to your situation?

3. Worktree mastery: 2025-12-17_maw-git-worktree-patterns.md
   → Use git -C, rebase for same hash

4. Conflict resolution: 2025-12-17_maw-sync-best-practices.md § Conflict Resolution
   → Handle rebase/push conflicts safely
```

**Common Fixes**:
- Different hashes → Use `rebase` instead of `merge`
- Dirty worktrees → Use `maw peek`, let them commit first
- Push rejected → `git pull --rebase origin main` then push again

### If Improving MAW System

```
1. Philosophy: MAW_ANALYSIS.md
   ↓ Understand prevention-first approach

2. Patterns: 2025-12-17_maw-git-worktree-patterns.md
   ↓ Current best practices

3. Complete System: MAW-COMPLETE-SYSTEM.md
   ↓ 10 iterations, validation scores, production checklist

4. Retrospectives: 2025-12/17/ folder
   ↓ Session-by-session learning journey
```

---

## Architecture Files

### Configuration (`.agents/`)

```bash
.agents/
├── agents.yaml              # Agent definitions
├── maw.env.sh              # Shell functions
├── maw-lock.sh             # Smart lock system (350+ lines)
├── maw.completion.bash     # Bash completions
├── maw.completion.zsh      # Zsh completions
├── maw-warp-function.sh    # Directory warping
│
├── scripts/
│   ├── maw                 # Main wrapper
│   ├── maw-wrapper.sh      # Alternative wrapper
│   ├── maw-safe.sh         # Safe operations
│   ├── maw-lock.sh         # Lock mechanism
│   ├── safe-reset.sh       # WIP backup
│   └── [other utilities]
│
└── profiles/
    ├── profile0.sh         # Vertical layout (N stacked)
    ├── profile14.sh        # Horizontal layout (2 windows × 3 panes) ← Recommended
    ├── profile3.sh         # Single pane (focus mode)
    └── [other layouts]
```

### Signal System

```bash
.sync/                      # Shared signal directory
├── .gitkeep               # Keep directory in git
├── demo-signal-pattern.sh # POC demo
└── test-conflict-prevention.sh  # Test suite

.agent-locks/              # Lock files
├── agent-1.lock          # JSON: {agent, task, timestamp, signal}
├── agent-2.lock
├── activity.log           # Assignment log
└── reset.log              # Reset audit trail
```

---

## Related Documentation

### In Root of Repository

- **MAW-COMPLETE-SYSTEM.md** — Official production checklist
- **MAW-AGENTS.md** — Multi-agent safety rules
- **CLAUDE.md** — Quick reference (link to CLAUDE_subagents.md for agent details)

### Elsewhere in ψ/ Tree

- **ψ/learn/maw.md** — Learning notes from exploration
- **ψ/incubate/** — MAW kit development (gitignored)
- **ψ/active/** — Current MAW research (gitignored)

### Upstream Projects

- **Soul-Brews-Studio/multi-agent-workflow-kit** — Official MAW toolkit
- **nazt/weyermann-malt-productpage** — Real production implementation (FloodBoy workshop demo)
- **nazt/000-workshop-product-page** — 6-agent example

---

## Key Insights Summary

### The Golden Rule (Single Principle)

```
"Know who you are, sync from the right source,
never force anything, respect all boundaries."
```

This encapsulates entire MAW safety model:
1. **Know who you are** — `pwd` + `git branch --show-current` always
2. **Sync from the right source** — main ← origin, agents ← main (never origin directly)
3. **Never force anything** — No `-f`, `-ff-only`, `--hard`
4. **Respect boundaries** — Use `git -C`, don't cross worktree lines

### The Four Key Principles

1. **Prevention Over Resolution** — Check BEFORE conflicts happen
2. **Safety by Design** — WIP commits, never force, reversible operations
3. **Atomic Operations** — Signals, locks, status checks
4. **Full Audit Trail** — Every action logged

### The Three Conflict Patterns Solved

| Pattern | Solution | File |
|---------|----------|------|
| Different commit hashes | Use `rebase` not `merge` | git-worktree-patterns.md |
| Merge conflicts on sync | Per-agent log files (agent-N.log) | git-worktree-patterns.md |
| Agent isolation breaks | Use `git -C` not `cd` | git-worktree-patterns.md |

### The Four Sync Patterns

| Pattern | Use Case | Command |
|---------|----------|---------|
| **A: Agent→Main** | Agent has work | git rebase agents/N && git rebase origin/main |
| **B: Main→All** | Main has updates | git add && git commit && maw sync |
| **C: Agent-Initiated** | Autonomy | git -C $ROOT operations from any agent |
| **D: Quick Check** | Safety | maw peek before any sync |

---

## File Statistics

### Learning Files (13 active + 2 archive)

| Category | Count | Lines | Files |
|----------|-------|-------|-------|
| Architecture & Design | 5 | 3,097 | comprehensive, analysis, trace, worktree-patterns, agents |
| Sync & Git | 4 | 541 | sync-best-practices, git-worktree-patterns, wip-branch, branching |
| Control & Operations | 3 | 442 | control-guide, start-control, peek-table |
| Installation & Setup | 3 | 232 | setup-patterns, setup-mistakes, copy-order |
| **Total** | **15** | **4,312** | **Primary files** |

### Retrospectives (10 sessions)

| Date | Files | Focus |
|------|-------|-------|
| 2025-12-13 | 4 | Installation day (startup, profile, full day, integration) |
| 2025-12-14 | 2 | Polish & planning (autostart, incubation) |
| 2025-12-17 | 4 | Mastery week (conflict prevention, worktrees, sync, branching) |

### Root Docs

| File | Status | Purpose |
|------|--------|---------|
| MAW-COMPLETE-SYSTEM.md | ✅ Production | 10 iterations, 100% validated |
| MAW-AGENTS.md | ✅ Active | Safety rules, configuration |
| .agents/ directory | ✅ Active | Scripts, profiles, configuration |

---

## Navigation Quick Links

### By Role

- **User/Orchestrator**: control-guide.md → sync-best-practices.md
- **Agent Developer**: git-worktree-patterns.md → complete-system.md
- **System Architect**: maw_analysis.md → complete-system.md
- **Troubleshooter**: setup-mistakes.md → sync-best-practices.md

### By Task

- "How do I use MAW?" → comprehensive-guide.md
- "How do I install it?" → setup-patterns.md
- "How do I sync properly?" → sync-best-practices.md
- "How do I control agents?" → control-guide.md
- "Something's broken" → setup-mistakes.md
- "I want safety guarantees" → complete-system.md
- "I want to understand philosophy" → maw_analysis.md

### By Time

- 10 min: comprehensive-guide.md
- 20 min: comprehensive-guide.md + control-guide.md
- 45 min: Add sync-best-practices.md + git-worktree-patterns.md
- 90 min: Full learning progression above

---

---

## Critical Safety Rules (Added Dec 2025)

### NEVER Use Git Amend in Multi-Agent Setup

**File**: [2025-12-28_never-amend-in-multi-agent.md](./2025-12-28_never-amend-in-multi-agent.md)

| Command | Effect | Solution |
|---------|--------|----------|
| `git commit --amend` | Creates hash divergence across ALL agents | Use NEW commit instead |
| `git rebase -i` | Rewrites history, orphans synced agents | Avoid or use with extreme care |

**Why it breaks**:
1. Main has commit `abc123`, agents sync to `abc123`
2. You amend → Main now has `def456`
3. Agents still have `abc123` (content same, hash different)
4. `git rebase` says "already up to date" but branches are diverged
5. Only `reset --hard` can fix

**Hook protection**: `~/.claude/hooks/safety-check.sh` blocks `--amend`

---

## Additional Learning Files (Dec 20-28)

### Commands & Operations (Dec 20)

| File | Focus |
|------|-------|
| [2025-12-20_maw-hey-command-guide.md](../2025-12-20_maw-hey-command-guide.md) | hey command usage |
| [2025-12-20_maw-hey-communication.md](../2025-12-20_maw-hey-communication.md) | Agent communication |
| [2025-12-20_maw-hey-instruction.md](../2025-12-20_maw-hey-instruction.md) | Task instructions |
| [2025-12-20_maw-hey-multiline-fix.md](../2025-12-20_maw-hey-multiline-fix.md) | Multiline fix |
| [2025-12-20_maw-peek-guide.md](../2025-12-20_maw-peek-guide.md) | peek command |
| [2025-12-20_maw-peek-monitoring.md](../2025-12-20_maw-peek-monitoring.md) | Monitoring |
| [2025-12-20_maw-sync-command.md](../2025-12-20_maw-sync-command.md) | sync command |
| [2025-12-20_maw-sync-internals.md](../2025-12-20_maw-sync-internals.md) | Sync internals |
| [2025-12-20_maw-kill-command.md](../2025-12-20_maw-kill-command.md) | kill command |
| [2025-12-20_maw-kill-guide.md](../2025-12-20_maw-kill-guide.md) | Kill guide |
| [2025-12-20_maw-wait-command.md](../2025-12-20_maw-wait-command.md) | wait command |
| [2025-12-20_maw-send-command.md](../2025-12-20_maw-send-command.md) | send command |

### Setup & Configuration (Dec 20)

| File | Focus |
|------|-------|
| [2025-12-20_maw-start-guide.md](../2025-12-20_maw-start-guide.md) | Start guide |
| [2025-12-20_maw-attach-guide.md](../2025-12-20_maw-attach-guide.md) | Attach guide |
| [2025-12-20_maw-status-guide.md](../2025-12-20_maw-status-guide.md) | Status guide |
| [2025-12-20_maw-profiles-guide.md](../2025-12-20_maw-profiles-guide.md) | Profiles |
| [2025-12-20_maw-profile-system.md](../2025-12-20_maw-profile-system.md) | Profile system |
| [2025-12-20_maw-profile-creation.md](../2025-12-20_maw-profile-creation.md) | Creating profiles |
| [2025-12-20_maw-direnv-setup.md](../2025-12-20_maw-direnv-setup.md) | direnv setup |
| [2025-12-20_maw-direnv-integration.md](../2025-12-20_maw-direnv-integration.md) | direnv integration |
| [2025-12-20_maw-tmux-config.md](../2025-12-20_maw-tmux-config.md) | tmux config |
| [2025-12-20_maw-tmux-pane-management.md](../2025-12-20_maw-tmux-pane-management.md) | Pane management |
| [2025-12-20_maw-worktree-setup.md](../2025-12-20_maw-worktree-setup.md) | Worktree setup |
| [2025-12-20_maw-zoom-panes.md](../2025-12-20_maw-zoom-panes.md) | Zoom panes |

### Patterns & Workflows (Dec 20-21)

| File | Focus |
|------|-------|
| [2025-12-20_maw-workflow-automation.md](../2025-12-20_maw-workflow-automation.md) | Automation |
| [2025-12-20_maw-git-workflow-patterns.md](../2025-12-20_maw-git-workflow-patterns.md) | Git patterns |
| [2025-12-20_maw-conflict-prevention.md](../2025-12-20_maw-conflict-prevention.md) | Conflict prevention |
| [2025-12-20_maw-lock-system.md](../2025-12-20_maw-lock-system.md) | Lock system |
| [2025-12-20_maw-session-management.md](../2025-12-20_maw-session-management.md) | Sessions |
| [2025-12-20_maw-tag-checkpoint-pattern.md](../2025-12-20_maw-tag-checkpoint-pattern.md) | Checkpoints |
| [2025-12-20_maw-agents-registry.md](../2025-12-20_maw-agents-registry.md) | Registry |
| [2025-12-20_maw-cheatsheet.md](../2025-12-20_maw-cheatsheet.md) | Cheatsheet |
| [2025-12-21_maw-fast-context.md](../2025-12-21_maw-fast-context.md) | Fast context |
| [2025-12-21_maw-orchestrator-skill.md](../2025-12-21_maw-orchestrator-skill.md) | Orchestrator |
| [2025-12-21_maw-review-gate-pattern.md](../2025-12-21_maw-review-gate-pattern.md) | Review gate |

### Troubleshooting (Dec 20)

| File | Focus |
|------|-------|
| [2025-12-20_maw-troubleshooting.md](../2025-12-20_maw-troubleshooting.md) | General troubleshooting |
| [2025-12-20_maw-error-recovery.md](../2025-12-20_maw-error-recovery.md) | Error recovery |
| [2025-12-20_maw-auto-warp-bug-fix.md](../2025-12-20_maw-auto-warp-bug-fix.md) | Auto-warp bug |

### Experimental (Dec 20)

| File | Focus |
|------|-------|
| [2025-12-20_maw-pocketbase.md](../2025-12-20_maw-pocketbase.md) | PocketBase |
| [2025-12-20_maw-pocketbase-status.md](../2025-12-20_maw-pocketbase-status.md) | Status |
| [2025-12-20_maw-external-inbox-pattern.md](../2025-12-20_maw-external-inbox-pattern.md) | External inbox |
| [2025-12-20_maw-portfolio-demo-workflow.md](../2025-12-20_maw-portfolio-demo-workflow.md) | Demo workflow |

---

## Version & Status

**Index Version**: 2.0 (Updated with Dec 20-28 files)
**Last Updated**: 2025-12-28
**MAW Status**: Production Ready ✅
**Documentation Status**: Complete ✅
**All Files Indexed**: 50+ learning files + retrospectives + root docs ✅
**Critical Safety**: `--amend` blocked by hook ✅

**Ready for**: Immediate use in multi-agent workflows

---

**Created as Issue #26 response**
Agent 5 (Research Specialist - Haiku) | Comprehensive Navigation Index
**Updated 2025-12-28**: Added amend safety rule + Dec 20-28 files
