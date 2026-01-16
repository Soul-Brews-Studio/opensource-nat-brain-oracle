# MAW Testing Prompts & Commands

Quick reference for testing MAW delegation and monitoring.

---

## 1. Check Agent Status

```bash
source .agents/maw.env.sh
maw peek
```

Expected: Shows all 5 agents + main with task/commit info.

---

## 2. Talk to Individual Agent

```bash
maw hey 1 "Report: What is your current task?"
maw hey 2 "Report: What files have you modified?"
maw hey 3 "Report: List your ψ/lab/ projects"
```

---

## 3. Delegate with Checkpoint

```bash
# Clear first
.agents/scripts/cp-done.sh clear

# Delegate with checkpoint instruction
CP="/Users/nat/Code/github.com/laris-co/Nat-s-Agents/.agents/checkpoint"
maw hey 1 "Task: Do X. When done: touch $CP/1.done"
maw hey 2 "Task: Do Y. When done: touch $CP/2.done"
# ... etc

# Wait for completion
.agents/scripts/cp-done.sh wait 60
# or check status
.agents/scripts/cp-done.sh status
```

---

## 4. Full Demo Workflow

```bash
source .agents/maw.env.sh
maw demo "echo test from all agents"
```

---

## 5. Context Management Check

### MCP Oracle
```bash
# Search learnings
mcp__oracle-v2__oracle_search "query here"

# List recent learnings
mcp__oracle-v2__oracle_list --type learning --limit 5
```

### MD Files
```bash
# Current focus
cat ψ/inbox/focus.md

# Latest handoff
ls -t ψ/inbox/handoff/*.md | head -1 | xargs cat

# Tracks
cat ψ/inbox/tracks/INDEX.md
```

---

## 6. Health Check

```bash
# Quick health
.agents/scripts/cp-done.sh status

# Full peek
source .agents/maw.env.sh && maw peek
```

---

## Test Prompts for Agents

### Simple Task
```
Task: List files in your current directory. Reply with just the list.
```

### With Checkpoint
```
Task: Check your ψ/lab/ folder, list projects.
When done: touch /path/.agents/checkpoint/N.done
```

### Report Request
```
Report: What is your current task? What files have you modified? Reply 1-2 lines.
```

---

## Expected Results

| Test | Success Criteria |
|------|-----------------|
| maw peek | Shows 5 agents + main |
| maw hey N | "Sent successfully" |
| cp-done.sh clear | "Cleared" |
| cp-done.sh status | Shows 1-5 status |
| cp-done.sh wait | "All done!" when 5/5 |

---

*Created: 2025-12-30*
