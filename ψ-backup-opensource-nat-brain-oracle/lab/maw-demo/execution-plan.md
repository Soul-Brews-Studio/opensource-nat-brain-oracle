# MAW Execution Plan - Complete Lifecycle

> All operations from MAIN agent only

---

## Phase 0: Pre-Flight (Main Agent)

**Location**: Main repo (not worktrees)

```bash
# 1. Check clean state
git status
maw peek

# 2. Sync all agents to same commit
maw sync

# 3. Create checkpoint tag (BEFORE any work)
git tag -a "maw/checkpoint/$(date +%Y%m%d-%H%M)" -m "Pre-work checkpoint"

# 4. Verify all ready
maw peek   # All agents should show ✓
echo "✅ Pre-flight complete. Ready to assign tasks."
```

---

## Phase 1: Task Assignment (Main Agent)

### Send All Tasks (Parallel)

Each agent is in a **separate tmux pane** → no waiting needed!

```bash
# Send to all agents simultaneously
maw hey 1 "$(cat ψ/lab/maw-demo/tasks/agent-1-instruction-report.md)"
maw hey 2 "$(cat ψ/lab/maw-demo/tasks/agent-2-blog-post.md)"
maw hey 3 "$(cat ψ/lab/maw-demo/tasks/agent-3-tag-feature.md)"
```

**Why no sleep?**
- Each `maw hey` types into a DIFFERENT tmux pane
- Agents are independent Claude Code sessions
- They start working immediately in parallel

### One-Liner (Optional)

```bash
for i in 1 2 3; do
  maw hey $i "$(cat ψ/lab/maw-demo/tasks/agent-$i-*.md)"
done
```

---

## Phase 2: Monitor Progress (Main Agent)

### Primary Method: `maw peek`

```bash
maw peek
```

**Output tells you everything:**
```
Agent │ Status   │ Task              │ Commit
──────┼──────────┼───────────────────┼────────
1     │ 2m 3+    │ MAW instruction   │ 1f59058  ← Working (2 modified, 3 new)
2     │ ✓        │ Blog post         │ 1f59058  ← Done (clean)
3     │ 1 mod    │ Tag feature       │ 1f59058  ← Working (1 modified)
```

**Status meanings:**
- `✓` = Clean, work committed (DONE)
- `2m` = 2 modified files (WORKING)
- `3+` = 3 new/untracked files (WORKING)
- Same commit = synced
- Different commit = has new commits

### Watch Mode (Auto-Refresh)

```bash
# Refresh every 10 seconds
watch -n 10 maw peek
```

### When All Agents Show ✓ → Ready for Sync

```bash
# All done? Sync their commits to main
maw sync
```

---

## Phase 2.5: Low-Context Verification (After Sync)

> **"Trust but verify — ถ้า verify ผ่าน ไม่ต้องอ่านเอง"**

After `maw sync`, verify outputs WITHOUT reading:

```bash
# Quick checks
wc -l ψ/memory/learnings/2025-12-20_maw-hey-instruction.md   # >100 lines?
wc -w ψ/writing/drafts/2025-12-20_maw-parallel-agents-tutorial.md  # 1000-1500 words?
grep -c "##" ψ/memory/learnings/2025-12-20_maw-tag-checkpoint-pattern.md  # >5 sections?
```

### Verification Checklist

| Agent | Verify Command | Expected |
|-------|---------------|----------|
| 1 | `wc -l ...maw-hey-instruction.md` | >100 lines |
| 2 | `wc -w ...maw-parallel-agents-tutorial.md` | 1000-1500 words |
| 3 | `grep -c "git tag" ...maw-tag-checkpoint-pattern.md` | >3 mentions |

### If Verify Fails → Go to Phase 4 (Feedback)

---

## Phase 2.5: Wait for Completion (Background)

### Background Monitor Script

```bash
#!/bin/bash
# maw-wait-done - Alert when all agents complete (doesn't sync!)

echo "👀 Watching agents..."
while maw peek 2>/dev/null | grep -E "^[0-9]" | grep -qv "✓"; do
  sleep 10
done

echo "🔔 ALL AGENTS DONE!"
osascript -e 'display notification "Ready for sync approval" with title "MAW Complete"' 2>/dev/null
say "MAW agents complete" 2>/dev/null
```

### Usage

```bash
# Start monitoring in background
./maw-wait-done &

# Do other work while waiting...

# When notification appears:
maw peek              # Confirm all ✓

# HUMAN APPROVAL REQUIRED
# Only sync after you decide:
maw sync
```

### No Auto-Sync!

```
🔔 Notification
      ↓
  maw peek (confirm)
      ↓
  Human: "Approve?"
      ↓
   YES → maw sync
   NO  → investigate first
```

---

## Phase 3: Review & Decision (Main Agent)

### After Sync - Review Each Agent

```bash
# Low-context verify first
wc -l ψ/memory/learnings/2025-12-20_maw-hey-instruction.md          # >100?
wc -w ψ/writing/drafts/2025-12-20_maw-parallel-agents-tutorial.md   # 1000-1500?
grep -c "##" ψ/memory/learnings/2025-12-20_maw-tag-checkpoint-pattern.md  # >5?

# If counts look good, check structure
head -30 ψ/memory/learnings/2025-12-20_maw-hey-instruction.md

# If structure looks good, spot-check content
grep -A3 "troubleshooting" ψ/memory/learnings/2025-12-20_maw-hey-instruction.md
```

### QC Checklist

| Agent | Verify | Check |
|-------|--------|-------|
| 1 | `wc -l` >100 | ☐ Workflow complete? ☐ Commands have examples? ☐ Troubleshooting? |
| 2 | `wc -w` 1000-1500 | ☐ Tutorial structure? ☐ Hook opening? ☐ Copy-paste commands? |
| 3 | `grep -c "##"` >5 | ☐ Problem explained? ☐ Implementation? ☐ Integration options? |

### Decision Tree

```
Low-context verify (wc, grep)
         ↓
     Pass? ────────────────── YES → ACCEPT
         │
        NO
         ↓
Check structure (head -30)
         ↓
  Fixable? ───────────────── YES → REJECT (Phase 4)
         │
        NO
         ↓
Completely wrong? ────────── YES → ROLLBACK (Phase 5)
```

### Decision: ACCEPT

```bash
# Mark as reviewed
echo "Reviewed: $(date)" >> .maw-review-log

# Ready for Phase 7 (Finalize)
```

### Decision: REJECT → Go to Phase 4

### Decision: ROLLBACK → Go to Phase 5

---

## Phase 4: Reject & Revise Loop (Main Agent)

### Rejection Flow

```
REJECT decision
      ↓
Identify specific issues
      ↓
Send feedback via maw hey
      ↓
Wait (maw peek for ✓)
      ↓
maw sync
      ↓
Re-verify
      ↓
   ┌──┴──┐
   ↓     ↓
 PASS   FAIL
   ↓     ↓
ACCEPT  Retry (max 3x)
         ↓
    Still fail? → ROLLBACK
```

### Step 1: Identify Issues

```bash
# What's wrong?
wc -l file.md                    # Too short?
grep -c "troubleshooting" file.md  # Missing section?
head -20 file.md                 # Wrong structure?
```

### Step 2: Send Specific Feedback

```bash
# Be specific! Tell agent exactly what to fix
maw hey 1 "REVISION NEEDED:
1. Missing troubleshooting section - add 3+ common issues with solutions
2. Only 50 lines - expand to 100+ lines
3. Commands need expected output examples

Fix these issues. I will check with: wc -l (expect >100) and grep troubleshooting (expect >0)"
```

### Step 3: Wait for Revision

```bash
# Watch for agent to finish (status → ✓)
watch -n 10 maw peek

# Or background wait
./maw-wait-done &
```

### Step 4: Re-Sync & Re-Verify

```bash
# Get revised work
maw sync

# Check if fixed
wc -l file.md                     # Now >100?
grep -c "troubleshooting" file.md   # Now >0?
```

### Step 5: Decision

| Result | Action |
|--------|--------|
| Fixed ✅ | → ACCEPT (Phase 7) |
| Partially fixed | → Another revision (Step 2) |
| Still broken after 3 tries | → ROLLBACK (Phase 5) |

### Revision Tracking

```bash
# Track revision attempts
echo "Revision 1: $(date) - missing troubleshooting" >> .maw-revisions.log
echo "Revision 2: $(date) - still too short" >> .maw-revisions.log
echo "Revision 3: $(date) - GIVING UP, rollback" >> .maw-revisions.log
```

### Max 3 Revisions Rule

```
Revision 1 → Specific feedback → Wait → Check
     ↓ (fail)
Revision 2 → More specific feedback → Wait → Check
     ↓ (fail)
Revision 3 → Final attempt → Wait → Check
     ↓ (fail)
ROLLBACK → Fresh start
```

### Example Revision Messages

**Revision 1 (General):**
```bash
maw hey 1 "Missing troubleshooting section. Add it with 3+ common issues."
```

**Revision 2 (More Specific):**
```bash
maw hey 1 "Troubleshooting still missing. Add section with:
- Issue: Agent not responding → Solution: check tmux pane
- Issue: Sync conflict → Solution: manual merge
- Issue: Wrong output → Solution: rollback and retry"
```

**Revision 3 (Very Specific):**
```bash
maw hey 1 "FINAL ATTEMPT. Copy this exactly into your file:

## Troubleshooting

### Agent Not Responding
Check: maw peek
Fix: Verify Claude Code is running in worktree

### Sync Conflict
Check: git status
Fix: Resolve manually, then maw sync

Add this NOW."
```

---

## Phase 5: Rollback (If Needed)

### When to Rollback

- Agent created wrong file
- Agent broke something
- Quality can't be fixed with revision
- Agent stuck/unresponsive

### How to Rollback Specific Agent

```bash
# 1. Find the checkpoint
git tag -l "maw/checkpoint/*"

# 2. Rollback agent worktree
git -C agents/1 checkout "maw/checkpoint/20251220-1113"

# 3. Recreate working branch
git -C agents/1 checkout -b agents/1

# 4. Re-send task
maw hey 1 "$(cat ψ/lab/maw-demo/tasks/agent-1-instruction-report.md)"
```

### How to Rollback Everything

```bash
# 1. Rollback main
git checkout "maw/checkpoint/20251220-1113"

# 2. Sync all agents to rolled-back state
maw sync

# 3. Clear signals
rm -rf .

# 4. Start fresh
mkdir -p .agent-signals
```

---

## Phase 6: Continue / Resume (Main Agent)

### If Agent Stopped Mid-Work

```bash
# Check where agent stopped
maw peek

# Check git status in agent worktree
git -C agents/1 status
git -C agents/1 log -1

# Send continue message
maw hey 1 "Continue your previous task. Your progress is saved. Complete the remaining items and signal when done."
```

### If Session Interrupted

```bash
# 1. Check current state
maw peek
ls .

# 2. Identify incomplete agents
# (no .done signal = incomplete)

# 3. Resume incomplete agents
maw hey 2 "Resume your task. Check your previous output and continue from where you stopped."
```

---

## Phase 7: Finalize (Main Agent)

### All Approved → Commit

```bash
# 1. Final sync
maw sync

# 2. Verify all files
ls -lh ψ/memory/learnings/2025-12-20_maw-hey-instruction.md
ls -lh ψ/writing/drafts/2025-12-20_maw-parallel-agents-tutorial.md
ls -lh ψ/memory/learnings/2025-12-20_maw-tag-checkpoint-pattern.md

# 3. Stage all
git add \
  ψ/memory/learnings/2025-12-20_maw-hey-instruction.md \
  ψ/writing/drafts/2025-12-20_maw-parallel-agents-tutorial.md \
  ψ/memory/learnings/2025-12-20_maw-tag-checkpoint-pattern.md

# 4. Commit with context
git commit -m "docs: MAW parallel workflow documentation (3 agents)

Agent 1: MAW hey instruction guide
Agent 2: Parallel agents tutorial blog post
Agent 3: Git tag checkpoint pattern design

Pattern: Main orchestrates, agents execute, QC feedback loop
Checkpoint: maw/checkpoint/20251220-1113

🤖 Generated with [Claude Code](https://claude.com/claude-code)"

# 5. Push
git push origin main

# 6. Clean up
rm -rf .

# 7. Create completion tag
git tag -a "maw/complete/$(date +%Y%m%d-%H%M)" -m "MAW session complete"
```

---

## Status Reference (maw peek)

| Status | Meaning | Action |
|--------|---------|--------|
| `✓` | Clean, committed | Done - ready for sync |
| `2m` | 2 modified files | Working |
| `3+` | 3 new files | Working |
| `2m 1+` | Modified + new | Working |
| Different commit | Has new commits | Sync to get them |

**No signal files needed** - `maw peek` tells you everything!

---

## Quick Reference (5 Commands)

```bash
# 1. Pre-flight
git tag -a "maw/checkpoint/$(date +%Y%m%d-%H%M)" -m "Pre-work"
maw sync

# 2. Send tasks (parallel)
maw hey 1 "$(cat task-1.md)"
maw hey 2 "$(cat task-2.md)"
maw hey 3 "$(cat task-3.md)"

# 3. Monitor (watch for all ✓)
watch -n 10 maw peek

# 4. Sync when all done
maw sync

# 5. Verify (low-context)
wc -l [file]    # Line count
wc -w [file]    # Word count
grep -c [pattern] [file]

# If reject → feedback
maw hey 1 "REVISE: [specific issues]"

# If rollback needed
git checkout "maw/checkpoint/..."
maw sync

# Finalize
git add [files] && git commit && git push
```
