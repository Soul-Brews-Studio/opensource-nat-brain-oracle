# Multi-Agent Orchestra (FREE)

> จับมือทำ — Build Your Own Agent Team in 2 Hours

**Status**: FREE (funnel)
**Duration**: 2 hours
**Level**: Beginner-Intermediate
**Prereq**: Basic terminal, Git basics

---

## Workshop Goal

เมื่อจบ workshop นี้ คุณจะ:
1. เข้าใจว่า Multi-Agent ทำงานยังไง
2. สร้าง Agent Team ของตัวเองได้
3. ใช้ `oracle.sh` สั่งงาน Agent หลายตัวพร้อมกัน

---

## The Tool: oracle.sh

```bash
oracle list              # ดู agents ทั้งหมด
oracle hey <name> <msg>  # ส่งงานให้ agent
oracle see <name>        # ดูว่า agent ทำอะไรอยู่
```

**Philosophy**: Agent doesn't LEAVE. Agent EXTENDS.

---

## Workshop Flow (2 hours)

### Part 1: Foundation (30 min)

| Time | Activity |
|------|----------|
| 0:00 | Why multi-agent? Context limits, parallel work |
| 0:10 | Demo: `oracle list` - see what's running |
| 0:20 | Hands-on: Create your first agent (tmux) |

**Exercise 1**:
```bash
# Create agent
tmux new -s agent1

# In another terminal
oracle list
# Should see: agent1
```

### Part 2: Communication (30 min)

| Time | Activity |
|------|----------|
| 0:30 | How agents talk: oracle hey |
| 0:40 | Hands-on: Send message to agent |
| 0:50 | Watch agent work: oracle see |

**Exercise 2**:
```bash
# Send task
oracle hey agent1 "echo hello from agent1"

# Watch result
oracle see agent1
```

### Part 3: Parallel Work (30 min)

| Time | Activity |
|------|----------|
| 1:00 | Create 3 agents |
| 1:10 | Send different tasks to each |
| 1:20 | Collect results |

**Exercise 3**:
```bash
# Create team
tmux new -s agent1 -d
tmux new -s agent2 -d
tmux new -s agent3 -d

# Assign parallel tasks
oracle hey agent1 "find . -name '*.md' | wc -l"
oracle hey agent2 "git log --oneline -5"
oracle hey agent3 "ls -la"

# Check all results
oracle see agent1
oracle see agent2
oracle see agent3
```

### Part 4: Real World (30 min)

| Time | Activity |
|------|----------|
| 1:30 | Pattern: Orchestrator + Workers |
| 1:40 | When to use multi-agent |
| 1:50 | Q&A + Next steps |

**Pattern**:
```
You (Orchestrator)
    ├── oracle hey agent1 "research"
    ├── oracle hey agent2 "code"
    └── oracle hey agent3 "test"
```

---

## Files Needed

```
courses/multi-agent-free/
├── README.md           ← This file
└── oracle.sh           ← Copy from .agents/scripts/
```

**To get oracle.sh**:
```bash
cp .agents/scripts/oracle.sh courses/multi-agent-free/
```

---

## Pricing

| Type | Price |
|------|-------|
| **This workshop** | **FREE** |
| Upgrade: Build Your Oracle | $1,200 (3 days) |
| Bundle: All workshops | $2,000 |

---

## Funnel Strategy

```
FREE Multi-Agent (2h)
        ↓
    "Want more?"
        ↓
Build Your Oracle ($1,200)
    - Day 1: Memory (SQLite)
    - Day 2: Survival (context-finder)
    - Day 3: Intelligence (vectors)
    - Day 4*: Multi-Agent Orchestra (advanced)
```

*Day 4 = upsell for those who want deep dive

---

## Quick Reply for Kim

```
Kim Jiramet

Multi-agent workshop กำลังทำครับ!
แบบ FREE + จับมือทำจริง 2 ชั่วโมง

- สร้าง Agent Team
- ใช้ oracle.sh สั่งงาน
- ทำงาน parallel

Stay tuned! 🔥
```

---

*Created: 2026-01-11*
*Part of: Nat's Workshop Portfolio*
