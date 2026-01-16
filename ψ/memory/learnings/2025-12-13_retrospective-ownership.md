# Retrospective Ownership

**Date**: 2025-12-13
**Context**: rrr command workflow

## Rule

**Retrospective draft = Main agent (Opus) เขียนเอง**

## Why

1. **Full context** — Main agent มี session context ทั้งหมด
2. **Nuance needed** — AI Diary ต้องการ vulnerability, reflection
3. **Quality matters** — Retrospective = คุณค่าระยะยาว

## Subagent Role (ถ้าใช้)

```
┌─────────────────────────────────────────┐
│  Subagent (Haiku)                       │
│  - Gather data (git log, files)         │
│  - Draft structure (optional)           │
└─────────────────────────────────────────┘
          │
          ▼
┌─────────────────────────────────────────┐
│  Main Agent (Opus)                      │
│  - Review draft                         │
│  - Reject with feedback                 │
│  - OR write from scratch                │
│  - Final approval                       │
└─────────────────────────────────────────┘
```

## Pattern

| Task | Who | Why |
|------|-----|-----|
| Data gathering | Subagent | Bulk work, saves context |
| Draft writing | **Main** | Needs full context |
| AI Diary | **Main** | Needs vulnerability |
| Review | **Main** | Quality gate |

## Anti-Pattern

❌ Subagent writes full retrospective → Main just commits
✅ Main writes retrospective → Subagent only helps with data

## Tags

`retrospective` `rrr` `main-agent` `quality`
