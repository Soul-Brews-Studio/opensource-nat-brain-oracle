# Module 1: Sub Agents

> "ให้ AI จ้าง AI ทำงานแทน" | 2 hours | Advanced

## Learning Objectives

หลังจบ module นี้ ผู้เรียนจะ:
- เข้าใจว่าทำไมต้อง delegate งานให้ sub agents
- รู้ว่าเมื่อไหร่ควรใช้ Haiku vs Opus
- สร้าง parallel task patterns ได้
- ประหยัด context และค่าใช้จ่ายได้ 60%+

## Why Sub Agents?

### The Problem
```
Main Agent (Opus) = Expensive + Limited Context

ถ้าให้ Opus ทำทุกอย่าง:
- อ่าน 100 files = context เต็ม
- ค่าใช้จ่ายสูง
- ช้า (sequential)
```

### The Solution
```
Main Agent (Opus) = Manager
Sub Agents (Haiku) = Workers

Opus: "Haiku, ช่วยหา files ที่มี keyword นี้"
Haiku: "เจอ 5 files ครับ: [list]"
Opus: "ขอบคุณ ผมจะ analyze ต่อ"
```

## Model Comparison

| Model | Speed | Cost | Best For |
|-------|-------|------|----------|
| **Opus** | Slow | $$$ | Analysis, Decisions, Writing |
| **Sonnet** | Medium | $$ | Balanced tasks |
| **Haiku** | Fast | $ | Search, Bulk ops, Simple tasks |

### Cost Example (Real)

| Task | Opus Only | With Haiku Delegation |
|------|-----------|----------------------|
| Search 50 files | $2.50 | $0.15 (Haiku) |
| Analyze results | $1.00 | $1.00 (Opus) |
| **Total** | **$3.50** | **$1.15** |

**Savings: 67%**

## Sub Agent Types (Built-in)

| Agent | Model | Purpose |
|-------|-------|---------|
| `context-finder` | Haiku | Search git, files, issues |
| `Explore` | Haiku | Codebase exploration |
| `coder` | Opus | Write quality code |
| `executor` | Haiku | Run bash commands |
| `security-scanner` | Haiku | Detect secrets |
| `repo-auditor` | Haiku | Check file sizes |

## Hands-On Exercise 1: Basic Delegation

### Scenario
คุณมี folder ที่มี 100 markdown files และต้องการหาว่า file ไหนพูดถึง "budget"

### Without Sub Agent (Bad)
```
User: "หา files ที่มีคำว่า budget"
Opus: *reads all 100 files* = expensive
```

### With Sub Agent (Good)
```
User: "หา files ที่มีคำว่า budget"
Opus: "ผมจะให้ context-finder ช่วยค้นหา"
       → spawns Haiku agent
Haiku: "เจอ 7 files: [list]"
Opus: "ผมจะอ่าน 7 files นี้แล้ว summarize"
```

### Try It
```
/context-finder "budget" in *.md files
```

## Hands-On Exercise 2: Parallel Tasks

### Scenario
ต้องการข้อมูล 3 อย่างพร้อมกัน:
1. Recent git commits
2. Open GitHub issues
3. Files modified today

### Sequential (Slow)
```
1. git log → wait
2. gh issue list → wait
3. find files → wait
Total: 30 seconds
```

### Parallel (Fast)
```
Launch 3 Haiku agents simultaneously
All return in ~10 seconds
Total: 10 seconds
```

### Code Pattern
```markdown
Launch these agents in parallel:
1. Agent 1: git log --oneline -10
2. Agent 2: gh issue list --limit 5
3. Agent 3: find . -mtime -1 -type f
```

## Business Use Cases

### 1. Daily Report Generation
```
Main (Opus): "Generate daily report"
├── Agent 1 (Haiku): Get sales data from CRM
├── Agent 2 (Haiku): Get support tickets
├── Agent 3 (Haiku): Get social mentions
└── Main (Opus): Combine & write executive summary
```

### 2. Competitor Analysis
```
Main (Opus): "Analyze competitor pricing"
├── Agent 1 (Haiku): Scrape Competitor A
├── Agent 2 (Haiku): Scrape Competitor B
├── Agent 3 (Haiku): Scrape Competitor C
└── Main (Opus): Compare & recommend strategy
```

### 3. Email Processing
```
Main (Opus): "Process inbox"
├── Agent 1 (Haiku): Categorize emails
├── Agent 2 (Haiku): Extract action items
├── Agent 3 (Haiku): Flag urgent
└── Main (Opus): Draft responses for important ones
```

## Best Practices

### DO
- Use Haiku for search, bulk operations
- Use Opus for analysis, decisions
- Run independent tasks in parallel
- Keep sub agent prompts specific

### DON'T
- Don't use Opus for simple searches
- Don't run dependent tasks in parallel
- Don't give sub agents vague instructions
- Don't forget to verify sub agent results

## Common Patterns

### Pattern 1: Search → Analyze
```
Haiku: Search/gather data
Opus: Analyze/decide
```

### Pattern 2: Fan-Out → Fan-In
```
Opus: Define tasks
├── Haiku 1: Task A
├── Haiku 2: Task B
├── Haiku 3: Task C
Opus: Combine results
```

### Pattern 3: Pipeline
```
Haiku 1: Extract → Haiku 2: Transform → Opus: Load/Analyze
```

## Exercise: Build Your Delegation

### Your Task
Design a sub agent pattern for YOUR business:

1. What repetitive task do you do?
2. Which parts can Haiku handle?
3. Which parts need Opus?
4. Can any run in parallel?

### Template
```markdown
## My Delegation Pattern: [Task Name]

### Main Agent (Opus)
- Responsibility: [what]

### Sub Agent 1 (Haiku)
- Task: [what]
- Input: [what]
- Output: [what]

### Sub Agent 2 (Haiku)
- Task: [what]
- Input: [what]
- Output: [what]

### Parallel? [Yes/No]
### Expected Savings: [%]
```

## Summary

| Concept | Key Takeaway |
|---------|--------------|
| Why delegate | Save cost, context, time |
| Haiku vs Opus | Workers vs Manager |
| Parallel | Independent tasks = faster |
| Pattern | Search (Haiku) → Analyze (Opus) |

## Next Module
→ Module 2: Skills - สร้าง workflow ที่ใช้ซ้ำได้
