# MAW Usage Guide: Identity Checks & Sync Flow

**Created**: 2025-12-16 23:52 GMT+7
**Status**: 📝 Draft
**Type**: Practical Tutorial
**Author**: Human + AI collaboration

---

## 📚 Sources Index

| Type | File | Content |
|------|------|---------|
| Learning | ψ/memory/learnings/2025-12-14_maw-control-guide.md | Copy-paste commands, workflows |
| Learning | ψ/memory/learnings/2025-12-13_maw-setup-mistakes.md | Common mistakes, troubleshooting |
| Learning | ψ/memory/learnings/2025-12-13_maw-comprehensive-guide.md | Architecture, sync patterns |
| Analysis | ψ/active/context/maw/MAW_ANALYSIS.md | Golden Rule, sync hierarchy |

---

## 🎯 TL;DR

**MAW isn't just commands — it's a mental model.** Before you send tasks or sync agents, you need to know **WHO you are** (main or agent) and **WHERE you sync from** (origin or local main). This guide shows you the checks, the flow, and the commands you need.

**Core Checklist (Run This First)**:
```bash
pwd                        # WHERE am I?
git branch --show-current  # WHICH branch?
```

**Golden Rule**:
```
"Know who you are, sync from the right source,
never force anything, respect all boundaries."
```

---

## 🔍 Part 1: Identity Checks — "Know Who You Are"

### Why Identity Matters

In MAW, your identity determines:
- **Which commands** you can run
- **Where you sync from** (origin vs local main)
- **Which branch** you push to
- **Which worktree** you're in

**Wrong identity = wrong sync = conflicts**

### The Check Command

Always run this before any git operation:

```bash
pwd                        # Physical location
git branch --show-current  # Git branch name
```

### Truth Table

| pwd Output | Branch | You Are | Sync From | Push To |
|------------|--------|---------|-----------|---------|
| `/Nat-s-Agents` | `main` | **Main Agent** | `origin/main` | `origin main` |
| `/Nat-s-Agents/agents/1` | `agents/1` | **Agent 1** | `local main` | `origin agents/1` |
| `/Nat-s-Agents/agents/2` | `agents/2` | **Agent 2** | `local main` | `origin agents/2` |
| `/Nat-s-Agents/agents/3` | `agents/3` | **Agent 3** | `local main` | `origin agents/3` |

### Example: Identity Check in Action

```bash
# Check your identity
$ pwd
/Users/nat/Code/github.com/laris-co/Nat-s-Agents

$ git branch --show-current
main

# ✅ You are MAIN → sync from origin
$ git pull origin main
```

vs

```bash
# Check agent identity
$ pwd
/Users/nat/Code/github.com/laris-co/Nat-s-Agents/agents/1

$ git branch --show-current
agents/1

# ✅ You are AGENT 1 → sync from local main
$ git merge main
```

---

## 🔄 Part 2: The Sync Flow

### Visual Hierarchy

```
                 ┌─────────────────┐
                 │  REMOTE (GitHub)│
                 │   origin/main   │
                 └────────┬─────────┘
                          │
                    git pull origin main
                          │
                          ↓
            ┌─────────────────────────┐
            │    LOCAL MAIN (You)     │
            │    branch: main         │
            │    /Nat-s-Agents        │
            └──┬──────┬──────┬────────┘
               │      │      │
         git merge main (NOT origin)
               │      │      │
               ↓      ↓      ↓
         ┌─────┐ ┌─────┐ ┌─────┐
         │ A1  │ │ A2  │ │ A3  │
         │/ag1/│ │/ag2/│ │/ag3/│
         └─────┘ └─────┘ └─────┘
```

### The Two-Tier Model

**Tier 1**: Remote → Local Main
```bash
# Run from root (/Nat-s-Agents, branch: main)
git pull origin main
```

**Tier 2**: Local Main → Agents
```bash
# For each agent (in agents/N/, branch: agents/N)
git merge main
```

**Why not `git pull origin` for agents?**
- Agents don't have remote context
- Main is their single source of truth
- Keeps sync simple and predictable

---

## 📋 Part 3: Common Operations

### Operation 1: Start MAW Session

```bash
# From root directory
source .envrc && maw start profile14
```

**What you get**:
```
WINDOW 1 (Primary)        WINDOW 2 (Support)
┌─────┬─────┬─────┐       ┌─────┬─────┬─────┐
│ 1.1 │ 1.2 │ 1.3 │       │ 2.1 │ 2.2 │ 2.3 │
│ A1  │ A2  │ A3  │       │ A4  │ A5  │ Mon │
└─────┴─────┴─────┘       └─────┴─────┴─────┘
```

**Verify it's running**:
```bash
tmux list-sessions | grep ai-Nat-s-Agents
# Output: ai-Nat-s-Agents: 2 windows (created Mon Dec 16 23:52:00 2025)
```

### Operation 2: Send Task to Agent

**Single agent**:
```bash
source .envrc && maw hey 1 "Check your git status"
```

**All agents**:
```bash
source .envrc && maw hey all "pwd && git branch --show-current"
```

**Capture output** (wait 2 seconds for response):
```bash
sleep 2
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p -S -30 | tail -20
```

### Operation 3: Sync All Agents (Smart Sync)

**Step-by-step**:

1. **Check main is clean**:
   ```bash
   git status
   # Should show "nothing to commit, working tree clean"
   ```

2. **Pull latest from remote**:
   ```bash
   git pull origin main
   ```

3. **Check each agent status** (before syncing):
   ```bash
   # Quick status check
   for i in 1 2 3 4 5; do
     echo "=== Agent $i ==="
     git -C agents/$i status --porcelain | head -3
   done
   ```

4. **Sync agents based on status**:

   **If agent is CLEAN** (no output from `git status --porcelain`):
   ```bash
   maw hey N "git merge main"
   ```

   **If agent has UNCOMMITTED changes**:
   ```bash
   # Option A: Commit first
   maw hey N "git add -A && git commit -m 'WIP: current work'"
   maw hey N "git merge main"

   # Option B: Stash, merge, unstash
   maw hey N "git stash && git merge main && git stash pop"
   ```

5. **Verify sync**:
   ```bash
   maw hey all "git log -1 --oneline"
   sleep 2
   for p in 1.1 1.2 1.3 2.1 2.2; do
     echo "=== Pane $p ==="
     tmux capture-pane -t ai-Nat-s-Agents:$p -p | tail -5
   done
   ```

### Operation 4: Agent Pushes Work to Remote

**Agent workflow**:

1. **Agent commits work** (in their worktree):
   ```bash
   maw hey 2 "git add feature.js && git commit -m 'feat: new feature'"
   ```

2. **Agent pushes to their branch**:
   ```bash
   maw hey 2 "git push origin agents/2"
   ```

3. **Main reviews and merges**:
   ```bash
   # From root (main branch)
   git fetch origin agents/2
   git log origin/agents/2  # Review commits

   # Merge to main
   git merge origin/agents/2

   # Push to remote
   git push origin main
   ```

4. **Sync other agents** (now they get Agent 2's work):
   ```bash
   maw hey all "git merge main"
   ```

---

## 🎯 Part 4: Complete Sync Scenarios

### Scenario A: You Changed Main, Sync to Agents

```bash
# 1. You are in root (main branch)
pwd && git branch --show-current
# /Nat-s-Agents
# main

# 2. Make changes
echo "new content" > file.txt
git add file.txt && git commit -m "feat: new file"

# 3. Push to remote
git push origin main

# 4. Sync to agents
maw hey all "git merge main"

# 5. Verify
maw hey 1 "ls file.txt"
sleep 2
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p | tail -5
# Should show: file.txt
```

### Scenario B: Remote Changed, Pull to All

```bash
# 1. Someone pushed to origin/main
# 2. Main pulls
git pull origin main

# 3. Check what changed
git log -1 --stat

# 4. Cascade to agents
maw hey all "git merge main"

# 5. Check all agents synced
maw hey all "git log -1 --oneline"
sleep 3
for p in 1.1 1.2 1.3 2.1 2.2; do
  tmux capture-pane -t ai-Nat-s-Agents:$p -p | tail -3
done
```

### Scenario C: Agent Has Conflicts

```bash
# Agent 2 has uncommitted changes that conflict with main

# 1. Check agent status
git -C agents/2 status
# Output shows: M conflicting-file.js

# 2. Two options:

# Option A: Commit first, then merge
maw hey 2 "git add -A && git commit -m 'WIP: current work'"
maw hey 2 "git merge main"
# If conflicts, agent resolves manually

# Option B: Stash, merge, review
maw hey 2 "git stash"
maw hey 2 "git merge main"
maw hey 2 "git stash pop"
# If conflicts, agent resolves manually
```

---

## 🚨 Part 5: Common Mistakes & Fixes

### Mistake 1: Agent Pulls from Origin Directly

**Wrong**:
```bash
maw hey 1 "git pull origin main"  # ❌ Wrong source!
```

**Why it's wrong**: Agents don't have origin context. They should only know about local main.

**Right**:
```bash
maw hey 1 "git merge main"  # ✅ Correct source
```

### Mistake 2: Using Force Flags

**Wrong**:
```bash
git push --force               # ❌ Destroys history
git reset --hard              # ❌ Loses changes
git checkout -f               # ❌ Loses work
```

**Why it's wrong**: Force operations destroy history and break the Golden Rule.

**Right**:
```bash
git pull --ff-only            # ✅ Safe pull
git merge main                # ✅ Preserves history
git revert <commit>           # ✅ Undo safely
```

### Mistake 3: Forgetting to Source `.envrc`

**Wrong**:
```bash
maw hey 1 "message"
# Output: command not found: maw
```

**Why**: `maw` is a shell function, needs to be loaded.

**Right**:
```bash
source .envrc && maw hey 1 "message"  # ✅ Loads function
```

### Mistake 4: Not Checking Identity First

**Wrong**:
```bash
# In agents/1/ directory
git pull origin main  # ❌ You're an agent, not main!
```

**Right**:
```bash
# Check identity first
pwd && git branch --show-current
# /agents/1, agents/1 → I'm Agent 1

# Use correct sync
git merge main  # ✅ Correct for agents
```

### Mistake 5: Trying to Kill MAW from Claude Code

**Wrong**:
```bash
source .envrc && maw kill
# Hangs because it has "read -p" interactive prompt
```

**Right**:
```bash
tmux kill-session -t ai-Nat-s-Agents  # ✅ Direct kill
```

---

## 🔧 Part 6: Troubleshooting

### Problem 1: Agent Not Responding

**Symptoms**: `maw hey 1 "..."` sent but no response

**Diagnosis**:
```bash
# Check if agent is alive
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p | tail -10
```

**Fix**:
```bash
# Interrupt agent
tmux send-keys -t ai-Nat-s-Agents:1.1 C-c

# Check again
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p | tail -10
```

### Problem 2: Session Not Found

**Symptoms**: `tmux list-sessions` shows nothing

**Diagnosis**:
```bash
tmux list-sessions | grep ai-Nat-s-Agents
# No output = session not running
```

**Fix**:
```bash
# Start fresh
source .envrc && maw start profile14
```

### Problem 3: Agent Has Diverged

**Symptoms**: Agent's branch has commits not in main

**Diagnosis**:
```bash
# Check divergence
git -C agents/2 log main..agents/2 --oneline
# Shows commits in agents/2 but not in main
```

**Fix**:
```bash
# Option A: Merge agent's work to main first
git fetch origin agents/2
git merge origin/agents/2
git push origin main

# Then sync agent from main
maw hey 2 "git merge main"

# Option B: Reset agent (if work is not important)
maw hey 2 "git reset --hard main"  # ⚠️ Loses agent's commits
```

### Problem 4: Merge Conflict

**Symptoms**: After `git merge main`, agent reports conflicts

**Diagnosis**:
```bash
maw hey 2 "git status"
sleep 2
tmux capture-pane -t ai-Nat-s-Agents:1.2 -p | tail -15
# Shows: both modified: file.js
```

**Fix**:
```bash
# Agent resolves conflict
maw hey 2 "Open file.js and resolve conflicts manually"

# After resolution
maw hey 2 "git add file.js && git commit -m 'merge: resolve conflicts'"
```

---

## 📖 Part 7: Quick Reference Cards

### Identity Check Card

```bash
# Before ANY git operation:
pwd                        # Physical location
git branch --show-current  # Branch name

# Truth table:
# /Nat-s-Agents + main       → You are MAIN
# /Nat-s-Agents/agents/N + agents/N → You are AGENT N
```

### Sync Flow Card

```bash
# Main syncs from remote:
git pull origin main

# Agents sync from local main:
git merge main

# Never:
# - Agent pulling from origin
# - Using --force flags
# - Syncing without identity check
```

### MAW Commands Card

```bash
# Start session
source .envrc && maw start profile14

# Send task
maw hey 1 "message"           # Single agent
maw hey all "message"         # All agents

# Capture output
tmux capture-pane -t ai-Nat-s-Agents:1.1 -p | tail -20

# Kill session
tmux kill-session -t ai-Nat-s-Agents

# Check status
tmux list-sessions | grep ai-Nat-s-Agents
```

### Pane Mapping Card (Profile14)

```
WINDOW 1              WINDOW 2
┌─────┬─────┬─────┐   ┌─────┬─────┬─────┐
│ 1.1 │ 1.2 │ 1.3 │   │ 2.1 │ 2.2 │ 2.3 │
│ Ag1 │ Ag2 │ Ag3 │   │ Ag4 │ Ag5 │ Mon │
└─────┴─────┴─────┘   └─────┴─────┴─────┘
```

---

## 🎓 Part 8: Practice Exercises

### Exercise 1: Identity Check Drill

Run these commands and identify who you are:

```bash
# Exercise A
$ pwd
/Users/nat/Code/github.com/laris-co/Nat-s-Agents
$ git branch --show-current
main

# Question: Who are you? What should you sync from?
# Answer: Main agent, sync from origin/main

# Exercise B
$ pwd
/Users/nat/Code/github.com/laris-co/Nat-s-Agents/agents/3
$ git branch --show-current
agents/3

# Question: Who are you? What should you sync from?
# Answer: Agent 3, sync from local main
```

### Exercise 2: Safe Sync Practice

```bash
# 1. Check identity
pwd && git branch --show-current

# 2. If main: pull from origin
git pull origin main

# 3. Sync to agents
maw hey all "git merge main"

# 4. Verify all synced
maw hey all "git log -1 --oneline"
```

### Exercise 3: Agent Task Assignment

```bash
# 1. Start MAW
source .envrc && maw start profile14

# 2. Assign different tasks
maw hey 1 "List all .md files in root"
maw hey 2 "Check git status"
maw hey 3 "Show current branch"

# 3. Wait and collect results
sleep 5
for p in 1.1 1.2 1.3; do
  echo "=== Pane $p ==="
  tmux capture-pane -t ai-Nat-s-Agents:$p -p | tail -10
done
```

---

## 🔐 The Golden Rule (Memorize This)

```
"Know who you are, sync from the right source,
never force anything, respect all boundaries."
```

| Principle | Check | Prevents |
|-----------|-------|----------|
| **Know who you are** | `pwd`, `git branch` | Wrong sync operations |
| **Sync from right source** | Main→origin, Agent→main | Conflicts |
| **Never force anything** | No `-f` flags | Data loss |
| **Respect boundaries** | Stay in worktree | Cross-contamination |

---

## 📝 Writing Notes

### Tone
- **Cookbook style** — Copy-paste ready commands
- **Visual diagrams** — ASCII art for sync flow
- **Real examples** — Actual command outputs
- **Troubleshooting focused** — Common mistakes upfront

### Target Audience
- **Developers using MAW** for the first time
- **Anyone who needs practical reference** (not theory)
- **Teams onboarding to multi-agent workflows**

### Suggested Title Alternatives
1. "MAW Quick Reference: Identity Checks & Sync Flow"
2. "Know Who You Are: The MAW Usage Guide"
3. "MAW Cookbook: Commands You Can Copy-Paste"
4. "Identity, Sync, Flow: Your MAW Handbook"

### Next Steps
- [ ] Add more visual diagrams
- [ ] Add troubleshooting flowchart
- [ ] Include video/GIF demos
- [ ] Add "When to use which command" decision tree
- [ ] Create printable quick reference card

---

*Draft generated from MAW control guide + setup mistakes*
*Ready for copy-paste usage*
*Total source material: 248 lines of practical commands + patterns*
