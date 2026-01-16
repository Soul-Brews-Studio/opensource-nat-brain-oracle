# 🤖 Multi-Agent Workflow (MAW) Pattern Analysis
## weyermann-malt-productpage Repository

**Analysis Date**: 2025-12-13
**Repository**: github.com/nazt/weyermann-malt-productpage
**Project Duration**: Nov 30 - Dec 6, 2025

---

## Executive Summary

The weyermann-malt-productpage repository demonstrates a **production-ready Multi-Agent Workflow (MAW)** pattern that orchestrates multiple AI agents (Claude, Codex) in parallel using git worktrees and tmux, with intelligent synchronization and voice-based notification system. The key innovation is treating MAW as **safety infrastructure** rather than a convenience feature.

### Key Achievement: The Golden Rule
```
"Know who you are, sync from the right source, 
never force anything, respect all boundaries."
```

This single principle encapsulates the entire safety model and emerged from learning-by-failure.

---

## 🏗️ Architecture Overview

### 1. Agent Hierarchy & Workspace Isolation

```
┌─────────────────────────────────────────┐
│           MAIN AGENT (root)             │
│        Orchestrator on branch: main     │
│   Coordinates all agents, sends tasks   │
└──────────┬──────────────┬──────────────┬┘
           │              │              │
    ┌──────▼──┐    ┌──────▼──┐    ┌──────▼──┐
    │ AGENT 1  │    │ AGENT 2  │    │ AGENT 3  │
    │ agents/1 │    │ agents/2 │    │ agents/3 │
    │ Claude   │    │  Codex   │    │  Codex   │
    │ branch:  │    │ branch:  │    │ branch:  │
    │ agents/1 │    │ agents/2 │    │ agents/3 │
    └──────────┘    └──────────┘    └──────────┘
```

**Implementation**: 
- Git worktrees (NOT git branches in single directory)
- Each agent has **isolated filesystem** and **independent branch**
- Agents communicate through:
  - Task messages via maw CLI
  - Signal files (`.tmp/agent-N-signal`)
  - Lock files (`.agent-locks/agent-N.lock`)
  - Completion logs

### 2. Workspace Structure

```
.
├── .claude/
│   ├── agents/                  # 9 Subagent definitions
│   │   ├── maw.md               # MAW controller
│   │   ├── coder.md             # Code generation
│   │   ├── executor.md          # Task execution
│   │   ├── context-finder.md    # Search
│   │   ├── thai-translator.md   # Translation
│   │   ├── archiver.md          # Archival
│   │   ├── marie-kondo.md       # File placement
│   │   ├── issues-cleanup.md    # Issue triage
│   │   └── new-feature.md       # Planning
│   ├── commands/                # 17+ slash commands
│   └── settings.json            # Hook config
├── agents/
│   ├── 1/                       # Worktree 1 (agents/1 branch)
│   ├── 2/                       # Worktree 2 (agents/2 branch)
│   └── 3/                       # Worktree 3 (agents/3 branch)
├── scripts/
│   ├── agent-lock.sh            # Lock mechanism (350+ lines)
│   ├── smart-sync.sh            # Intelligent sync (200+ lines)
│   ├── agent-status.sh          # Status monitoring
│   ├── agent-start-notify.sh    # Voice notification
│   ├── agent-complete-notify.sh # Voice notification
│   └── agent-voices.toml        # Voice config
├── ψ-docs/
│   ├── DEVELOPMENT-REPORT.md    # Project overview
│   ├── AI-SELF-LEARNING.md      # Pattern discovery
│   └── maw/
│       ├── CLAUDE-CODE-EXTENSIBILITY.md  # Subagent/command API
│       ├── SMART-SYNC.md                 # Sync algorithm
│       └── SYNC-RULES.md                 # Safety rules (450+ lines)
├── ψ-learnings/
│   ├── 001-force-push.md                 # Incident: Why not -f
│   ├── 002-golden-rule.md                # The 4 principles
│   ├── 003-upstream-first.md             # Create issues upstream
│   ├── 004-psi-naming.md                 # ψ/ naming convention
│   ├── 005-pr-workflow-discipline.md     # PR best practices
│   └── 006-gogogo-delegation-workflow.md # Task delegation
├── ψ-retrospectives/
│   └── [20+ session retrospectives]      # Learning history
└── [Product files: index.html, css/, js/, products.json]
```

---

## 🔄 Multi-Agent Workflow (MAW) Pattern

### The Problem Solved
- **Sequential work is slow**: Main agent can only do one thing at a time
- **Manual synchronization fails**: Agents can overwrite each other's work
- **Lack of visibility**: Don't know which agent is doing what
- **Communication overhead**: Agents work in isolation without feedback

### The Solution: Smart Orchestration

#### 1. Agent Identity Awareness

Every agent (and the main) knows who it is:

```bash
# Check your identity
pwd                        # /path/to/agents/1
git branch --show-current  # agents/1
```

**Principle**: "Know who you are"

#### 2. Hierarchical Sync Model

```
Main agent respects hierarchy:
  Main (main) → pulls from origin/main
  
Agent respects hierarchy:
  Agent N (agents/N) → merges from local main (not origin)
```

**Why**: Agents don't have origin context. They sync from locally-updated main.

**Principle**: "Sync from the right source"

#### 3. Smart Sync Algorithm

```bash
# Main agent's smart sync:
1. Pull from origin/main
2. For each agent worktree:
   a. Check git status --porcelain
   b. If CLEAN:   auto-merge main (fast)
   c. If DIRTY:   send notification (safe)
   d. If ERROR:   report issue
```

**Implementation**: `scripts/smart-sync.sh` (200+ lines)

**Output**:
```
✅ Agent 1: clean worktree, auto-syncing...
   ✓ Synced successfully

⚠️  Agent 2: has uncommitted work
   Files changed:
   M  src/app.js
   ?? test.txt

✅ Agent 3: clean worktree, auto-syncing...
   ✓ Synced successfully
```

**Principle**: "Never force anything" (no -f flags)

#### 4. Agent Lock System

Prevent concurrent modifications with atomic lock files:

```bash
# Lock an agent
agent-lock.sh lock 2 "Analyzing subagents"

# Stores in .agent-locks/agent-2.lock:
task: Analyzing subagents
locked_at: 2025-12-07T14:32:10Z
locked_by: main
pid: 1234

# Check status
agent-lock.sh status

# Unlock when done
agent-lock.sh unlock 2
```

**Implementation**: `.agent-locks/agent-N.lock` + `scripts/agent-lock.sh`

#### 5. Fast Task Communication

Send tasks with **instant signal detection** (~100ms latency):

```bash
# Traditional polling (2s latency)
Task(prompt="Your task here")
# [wait 2 seconds for response]

# File signal method (100ms latency) ✓ PROVEN
SIGNAL=".tmp/maw-signal-$$"
maw hey 2 "Task. When done: touch $SIGNAL"

for i in {1..100}; do
  if [ -f "$SIGNAL" ]; then
    # Capture response immediately
    RESPONSE=$(tmux capture-pane ... -S -30)
    rm -f "$SIGNAL"
    break
  fi
  sleep 0.1
done
```

**Why `.tmp/`**: Gitignored, atomic operations on POSIX filesystems.

---

## 🗣️ Voice Notification System

### Per-Agent Voice Mapping

```toml
# scripts/agent-voices.toml
[voices]
main = "Samantha"        # Clear, natural
agent_1 = "Daniel"       # British male
agent_2 = "Karen"        # Australian female
agent_3 = "Rishi"        # Indian male
subagent = "Daniel"      # Consistent

[rate]
main = 190               # Words per minute
agent_1 = 220
agent_2 = 220
agent_3 = 220
```

### Integration with Claude Code Hooks

```json
{
  "SessionStart": {
    "command": "scripts/agent-start-notify.sh",
    "args": ["SESSION_START"]
  },
  "Stop": {
    "command": "scripts/agent-complete-notify.sh",
    "args": ["SESSION_COMPLETE"]
  },
  "SubagentStop": {
    "command": "scripts/agent-complete-notify.sh",
    "args": ["SUBAGENT_COMPLETE"]
  }
}
```

### Speech Queue (Prevent Overlapping Audio)

```bash
# Atomic locking via mkdir (atomic on POSIX)
QUEUE_DIR=".agent-locks/speech-queue"

# Acquire lock
while ! mkdir "$QUEUE_DIR" 2>/dev/null; do
  sleep 0.1
done

# Speak safely
say -v "Samantha" -r 190 "Agent 1 task complete"

# Release lock
rmdir "$QUEUE_DIR"
```

**Why mkdir**: Atomic on all POSIX systems (including macOS); flock not available on macOS.

---

## 👥 Claude Code Subagents

### 1. MAW Agent (maw.md)

**Purpose**: Unified controller for multi-agent operations

**Commands**:
- `maw start` - Start tmux session + spawn agents
- `maw status` - Check worktree/lock/pane status
- `maw send` - Send task to specific agent
- `maw stop` - Stop session + cleanup

**Key Algorithm**: Pane state detection
```bash
# Detect if agent is running
CONTENT=$(tmux capture-pane -t session:1.N -p -S -15)

if echo "$CONTENT" | grep -qE "bypass permissions|Codex|gpt-5"; then
  echo "RUNNING → SKIP"
elif echo "$CONTENT" | grep -q "Update available"; then
  echo "UPDATE → send '1'"
else
  echo "EMPTY → SPAWN"
  # Launch agent
fi
```

### 2. Context-Finder (context-finder.md)

**Purpose**: Search git/issues/retrospectives for patterns

**Use Cases**: 
- Find similar past decisions
- Search commit history
- Review retrospectives

### 3. Coder (coder.md)

**Purpose**: Generate high-quality code files

**Constraints**: 
- Creates files (doesn't edit)
- Single responsibility per file
- Includes tests

### 4. Thai-Translator (thai-translator.md)

**Purpose**: Translate retrospectives EN → TH

**Pattern**: Subagents should have **specific focus areas**, not generic capabilities.

### 5. Executor (executor.md)

**Purpose**: Execute bash commands from issues

**Safety**: 
- Only runs safe commands
- Asks before destructive operations
- Logs all executions

---

## 🔐 Safety Model: The Golden Rule

After a **force-push incident** that destroyed agent histories, the team distilled safety into four memorable principles:

```
"Know who you are, sync from the right source, 
never force anything, respect all boundaries."
```

### Principle 1: Know Who You Are

**Check**:
```bash
pwd                        # Your filesystem location
git branch --show-current  # Your branch name
```

**Truth Table**:
| Path | Branch | You Are |
|------|--------|---------|
| `/root` | `main` | Main Agent (Orchestrator) |
| `/root/agents/1` | `agents/1` | Agent 1 |
| `/root/agents/2` | `agents/2` | Agent 2 |
| `/root/agents/3` | `agents/3` | Agent 3 |

**Why**: Prevents incorrect sync operations (e.g., agent trying to push to main).

### Principle 2: Sync from the Right Source

**Main agent**:
```bash
git pull --ff-only origin main  # Pulls from remote
```

**Agent N**:
```bash
git merge main  # Merges from LOCAL main, not origin
```

**Why**: Agents don't have origin context in worktrees. Main updates origin, agents read from local.

### Principle 3: Never Force Anything

**Red flags**:
```bash
git push --force          # ❌ Destroys histories
git fetch --force         # ❌ Overwrites all refs
git reset --hard          # ❌ Loses changes
git checkout -f           # ❌ Loses uncommitted work
```

**Correct alternatives**:
```bash
git merge origin/main     # ✓ Preserves histories
git pull --ff-only        # ✓ Fast-forward only
git stash                 # ✓ Temporary storage
git revert                # ✓ Undo with new commit
```

### Principle 4: Respect All Boundaries

**Stay in your worktree**:
```bash
# ✓ Good - use git -C to respect boundaries
git -C agents/1 status
git -C agents/1 merge main

# ✓ Good - use git -C for pushing from main
git -C agents/1 push origin agents/1

# ❌ Bad - cd into agent directory
cd agents/1 && git push  # Violates boundary

# ❌ Bad - direct filesystem access
rm -rf agents/1          # Violates boundary
```

**Why**: Each worktree is independent. Access it via `git -C`, tmux, or signal files.

---

## 📚 Lessons Learned (Distilled Wisdom)

### 001: Force-Push - The Incident

**What Happened**: Executed `git push --force` to sync agents, destroying their independent histories.

**Root Cause**: Had read the rules but didn't internalize them under pressure.

**Key Insight**: "Rules aren't guidelines—they're infrastructure, like lockout/tagout in physical safety."

**Applied**:
- Created 450+ line SYNC-RULES.md
- Made Golden Rule memorable
- Documented incident as proof

### 002: The Golden Rule

**What Happened**: After force-push incident, distilled 450 lines into 4 memorable principles.

**Key Insight**: "Complex safety rules become effective when they fit in working memory."

**Structure**:
| Principle | Meaning | Check |
|-----------|---------|-------|
| Know who you are | Agent identity | `pwd`, `git branch` |
| Sync from right source | Hierarchy | Main→origin, Agent→local |
| Never force anything | No -f flags | Review all commands |
| Respect boundaries | Stay in worktree | Use `git -C`, tmux |

### 003: Upstream First

**Pattern**: Create issues upstream (in the main repo) instead of local patches.

**Why**: Fixes benefit the whole codebase, not just one agent.

### 004: ψ Naming

**Pattern**: Use ψ (psi) prefix for meta-directories (knowledge bases, logs, drafts).

**Rationale**: Visually distinct, not included in typical backups.

### 005: PR Workflow Discipline

**Pattern**: Never merge PRs yourself. Wait for human review + approval.

**Why**: Catches mistakes, ensures quality.

### 006: Gogogo Delegation

**Pattern**: Create plan issue (nnn) → Execute plan (gogogo) → Retrospective (rrr)

**Flow**:
```
Main: Create plan issue
↓
Agent: Execute plan
↓
Main: Review + retrospective
↓
Distill learnings
```

---

## 🧠 AI Self-Improvement Pattern

The project demonstrates **AI reading its own documentation** to improve:

1. **Self-Assessment**: AI reads its own retrospectives
2. **Pattern Recognition**: Identifies what worked/what didn't
3. **Documentation Update**: Improves guidelines based on learning
4. **Future Reuse**: Next session uses improved docs

**Files**:
- `ψ-docs/AI-SELF-LEARNING.md` - How AI learns from documentation
- `ψ-learnings/` - Distilled patterns
- `ψ-retrospectives/` - 20+ session records

---

## 🔌 Claude Code Integration

### Subagent Definition Format

```markdown
---
name: subagent-name
description: What this agent does
tools: Bash, Grep, Read  # Optional - inherits all if omitted
model: haiku  # Options: haiku, sonnet, opus, inherit
---

System prompt and instructions here.
Can reference files with @path/to/file syntax.
```

### Slash Command Format

```markdown
---
description: What this command does
argument-hint: <required> [optional]
allowed-tools:
  - Bash(script.sh:*)
  - Read
model: sonnet
---

Prompt template using $ARGUMENTS or $1, $2, $3.
Include file contents with @path syntax.
Execute bash with !command syntax.
```

### Hook Integration

```json
{
  "SessionStart": "scripts/hook-script.sh",
  "Stop": "scripts/cleanup-script.sh",
  "SubagentStop": "scripts/notify-script.sh"
}
```

---

## 📊 Project Metrics

| Metric | Count | Purpose |
|--------|-------|---------|
| Subagents | 9 | Specialized AI tools |
| Slash Commands | 17+ | User-triggered actions |
| Scripts | 6 | Infrastructure automation |
| Retrospectives | 20+ | Session learning |
| Learnings Documented | 10+ | Pattern distillation |
| Total Lines (SYNC-RULES) | 450+ | Safety documentation |
| Voice Profiles | 4 | Per-agent voices |

---

## 💡 Innovations & Patterns Worth Adopting

### 1. Smart Sync (Status-Aware Synchronization)

**Problem**: Blind sync causes conflicts and disrupts work.

**Solution**: Check git status before syncing.

**Implementation**: 
- Clean worktree → auto-merge main
- Dirty worktree → notify agent
- Error state → report issue

**Where to Use**: Any multi-agent system with shared codebase.

### 2. Golden Rule (Memorable Safety Framework)

**Problem**: Complex safety rules are forgotten under pressure.

**Solution**: Distill into 4 memorable principles + checklist.

**Implementation**:
1. Know who you are
2. Sync from the right source
3. Never force anything
4. Respect all boundaries

**Where to Use**: Any distributed system with safety-critical operations.

### 3. Voice-Based Notifications

**Problem**: Terminal output gets lost in noise.

**Solution**: Unique per-agent voice + text-to-speech.

**Implementation**:
- Agent voice mapping in TOML
- Speech queue to prevent overlaps
- Hook integration with Claude Code

**Where to Use**: Multi-agent workflows with human operators.

### 4. File Signal Detection

**Problem**: Polling worktree status takes 2+ seconds.

**Solution**: Use .tmp/ signal files with atomic creation.

**Implementation**:
- Task: "When done, touch .tmp/signal"
- Poll at 100ms intervals
- Capture response on completion

**Latency**: ~100ms vs 2000ms with traditional polling.

**Where to Use**: Fast task-response cycles.

### 5. Subagent Specialization

**Problem**: Generic subagents are less effective than specialized ones.

**Solution**: Create subagents with specific focus areas.

**Examples**:
- maw (multi-agent workflow)
- coder (code generation)
- thai-translator (translation)
- context-finder (search)

**Where to Use**: Large systems with diverse subtasks.

---

## 🚀 Applicability to Nat's-Agents

### Direct Patterns to Adopt

1. **Smart Sync**: Check agent status before broadcasting updates
2. **Golden Rule**: Create memorable safety framework for subagent interactions
3. **Lock System**: Prevent concurrent modifications with atomic locks
4. **Fast Signals**: Use file signals for <100ms task completion detection
5. **Subagent Specialization**: Create focused agents for specific tasks

### Modifications Needed for Nat's-Agents

1. **Worktree Structure**: Nat's-Agents uses single repo; adapt by creating branch-based isolation instead
2. **Voice System**: macOS-specific; adapt to system-agnostic notifications (Slack, Discord, etc.)
3. **Lock Mechanism**: Uses mkdir (macOS POSIX); verify cross-platform compatibility with flock
4. **Agent Identity**: Use branch name instead of path for identity checking

---

## 📖 Key Documentation Files

| File | Purpose | Lines |
|------|---------|-------|
| README.md | Project overview | 100 |
| AGENTS.md | Agent hierarchy & communication | 200+ |
| CLAUDE.md | Quick reference | 150 |
| CLAUDE_safety.md | Safety rules | 100+ |
| CLAUDE_workflows.md | Workflows (ccc, nnn, rrr) | 150+ |
| SYNC-RULES.md | Safety rules (detailed) | 450+ |
| SMART-SYNC.md | Sync algorithm | 200+ |
| DEVELOPMENT-REPORT.md | Timeline + learnings | 150+ |

---

## 🎯 Conclusion

The weyermann-malt-productpage repository demonstrates that **Multi-Agent Workflow is not just a convenience—it's a safety discipline**. The Golden Rule, smart sync algorithm, and lock system work together to enable safe parallel work without sacrificing developer experience or code quality.

**Key Takeaway**: Safety rules become effective when:
1. They're memorable (fit in working memory)
2. They're actionable (tell you exactly what to check)
3. They're complete (cover all cases)
4. They emerge from real failures (not abstract planning)

The project proves this through incident-to-learning-to-practice cycle, documented in retrospectives and learnings.

---

**Analysis Complete**: 2025-12-13 21:24 UTC
**Next Steps**: Consider adopting Golden Rule + Smart Sync patterns in Nat's-Agents project.

