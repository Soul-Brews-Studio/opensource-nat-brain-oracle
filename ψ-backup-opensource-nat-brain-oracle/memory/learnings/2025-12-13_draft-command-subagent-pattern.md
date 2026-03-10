# /draft Command: Subagent Delegation Pattern

**Date**: 2025-12-13

## What We Learned

### 1. Subagents Return PATHS, Not Content
- Subagent หา files → return paths + 1-line summary
- Main agent เลือกอ่านเฉพาะที่ต้องการ
- ประหยัด tokens ทั้งสองฝั่ง

### 2. Main Agent Writes Quality Content
- Subagent = data gathering (Haiku)
- Main agent = writing + decisions (Opus)
- Quality requires full context → main must write

### 3. Iteration Pattern (5 rounds)
```
1. Dispatch subagents (parallel)
2. Review results + decide
3. Write/Edit content
4. Verify via subagent
5. Final review
```

### 4. 90/10 Cleanup Shows Pattern
- ค้นหา → พบ 103 mentions ใน 45 files
- ลบจาก core files เท่านั้น
- เก็บ history ใน noise/, retrospectives (Nothing is Deleted)

## How Things Connect

| Pattern | Application |
|---------|-------------|
| Subagent delegation | /draft, /trace, /recap |
| Paths not content | Save tokens both sides |
| Main writes quality | Retrospectives, drafts, learnings |
| Iterative refinement | 5 rounds = thorough |

## Anti-Pattern

```
❌ Subagent reads full files → sends to main
✅ Subagent finds paths → main reads selectively
```

## Tags

`subagent` `delegation` `draft` `pattern` `tokens`
