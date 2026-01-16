# MAW Task Template

> Standard format for assigning work to agents via `maw hey`

---

## Task Assignment Format

```markdown
# Task: [TASK_ID]

## Objective
[One-line description of what to do]

## Output
- File: `[output/path/filename.md]`
- Format: [markdown/code/json]

## Inputs (Read these first)
- `[file1.md]` — [why read this]
- `[file2.md]` — [why read this]

## Instructions
1. [Step 1]
2. [Step 2]
3. [Step 3]

## Success Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## When Done

1. **Summary Report** (Main will verify with this):
   ```
   ✅ Done: [filename]

   Stats:
   - Lines: [wc -l result]
   - Sections: [grep -c "##" result]
   - Word count: [wc -w result] (if blog)

   Verify commands:
   - wc -l [file] → [expected]
   - grep -c "##" [file] → [expected]
   ```

2. **Commit**:
   ```bash
   git add [file] && git commit -m "[message]"
   ```

3. **Signal**:
   ```bash
   touch .agent-signals/agent-[N].done
   ```

## Response Format for Main Agent Questions

If Main asks yes/no question:
```
Q: "Does your output include X?"
A: "YES [count/proof]" or "NO - [reason/fixing now]"
```

Keep responses SHORT. Main will verify with commands, not by reading.
```

---

## Example: Agent 1 Task

```markdown
# Task: MAW-001

## Objective
Write MAW instruction report documenting parallel workflow

## Output
- File: `ψ/memory/learnings/2025-12-20_maw-hey-workflow.md`
- Format: markdown

## Inputs
- `MAW-COMPLETE-SYSTEM.md` — Full system overview
- `.agents/scripts/hey.sh` — How maw hey works
- `ψ/memory/learnings/2025-12-17_maw-sync-best-practices.md` — Sync patterns

## Instructions
1. Read all input files
2. Document the complete `maw hey` workflow
3. Include command examples with expected output
4. Add troubleshooting section

## Success Criteria
- [ ] Complete workflow documented (start → assign → monitor → sync)
- [ ] All commands have examples
- [ ] Git tag checkpoint pattern included
- [ ] Ready for developer to follow

## When Done
1. Commit: `git add ψ/memory/learnings/2025-12-20_maw-hey-workflow.md && git commit -m "docs: MAW hey workflow instruction"`
2. Signal: `touch .agent-signals/agent-1.done`
```

---

## Pre-Flight Protocol

Before sending tasks to agents:

```bash
# 1. Create checkpoint tag
git tag -a "maw/pre-work/$(date +%Y%m%d-%H%M)" -m "Before parallel work"

# 2. Sync all agents to same commit
maw sync

# 3. Create signal directory
mkdir -p .agent-signals

# 4. Clear old signals
rm -f .agent-signals/*.done
```

---

## Send Task to Agent

```bash
# Method 1: Inline (short tasks)
maw hey 1 "Read MAW-COMPLETE-SYSTEM.md and write a summary to ψ/lab/maw-summary.md"

# Method 2: From file (complex tasks)
maw hey 1 "$(cat ψ/lab/maw-demo/tasks/agent-1-task.md)"

# Method 3: Reference issue
maw hey 1 "Execute task from Issue #27, Agent 1 section"
```

---

## Monitor Progress

```bash
# Check agent status
maw peek

# Check for completion signals
ls -la .agent-signals/

# Watch for all agents done
watch -n 5 'ls .agent-signals/*.done 2>/dev/null | wc -l'
```

---

## Collect Results

```bash
# After all signals received:

# 1. Sync all work to main
maw sync

# 2. Review commits
git log --oneline -10

# 3. Push to remote
git push origin main

# 4. Clean up signals
rm -rf .agent-signals/
```

---

## Rollback if Needed

```bash
# List checkpoints
git tag -l "maw/pre-work/*"

# Rollback to checkpoint
git checkout "maw/pre-work/20251220-1112"

# Create new branch from checkpoint
git checkout -b "recovery/$(date +%H%M)"
```
