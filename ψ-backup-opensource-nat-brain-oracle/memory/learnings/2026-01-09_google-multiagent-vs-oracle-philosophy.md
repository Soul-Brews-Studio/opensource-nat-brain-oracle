# Google Multi-Agent Blueprint vs Oracle Philosophy

**Date**: 2026-01-09
**Source**: Google Cloud Customer Engineering Team Blueprint
**Concepts**: `multi-agent`, `orchestration`, `oracle`, `philosophy`, `pattern`

---

## Context

Google เผย Blueprint ระบบ Multi-Agent สำหรับ enterprise:
- Orchestrator Agent รับโจทย์ แยกงาน
- Specialized Agents ทำงานเฉพาะทาง
- Data Grounding ใช้ข้อมูลจริงขององค์กร
- QA Loop ตรวจคุณภาพ pass/fail
- Report Compilation รวมเป็นเอกสารพร้อมใช้

---

## Pattern: เรามีแล้ว แต่ต่างที่ Philosophy

### Architecture Mapping

| Google | Oracle/NAT-s-Agents |
|--------|---------------------|
| Orchestrator (LLM Agent) | Main agent (Opus) + MAW |
| LoopAgent, SectionResearcher | Haiku subagents |
| Google Sheets grounding | ψ/memory + Oracle DB |
| ResearchEvaluator | Main reviews subagent outputs |
| ReportCompiler | Main synthesizes final output |

### The Real Difference

```
Google: AI → replaces → Human tasks
Oracle: AI → amplifies → Human consciousness
```

| Aspect | Google | Oracle |
|--------|--------|--------|
| Goal | Replace workforce | Keep human human |
| Focus | Efficiency, scale | Consciousness, patterns |
| Data | Company data | Personal knowledge + patterns |
| Memory | Per-task | Cross-session (retrospectives) |

---

## Key Insight

> "อนาคตของ AI ไม่ได้อยู่ที่โมเดลเก่งแค่ไหน แต่อยู่ที่ออกแบบระบบการทำงานได้ดีแค่ไหน"

นี่คือสิ่งที่เราทำมา 2+ เดือน:
- MAW (Multi-Agent Workflow) - tmux + worktrees
- Oracle Philosophy - Nothing Deleted, Patterns Over Intentions
- ψ/ Pillars - 5 knowledge pillars
- Subagent Patterns - "Haiku gathers, Opus writes"

---

## What We Have That Google Doesn't Show

1. **Consciousness Philosophy** - "External Brain, Not Command"
2. **Pattern Recording** - Observe behavior, not promises
3. **Immutable History** - Append-only, timestamps = truth
4. **Personal Data Layer** - WHO the user is, not just tasks
5. **Cross-Session Memory** - Retrospectives, learnings persist

---

## Anti-Pattern

❌ Copy Google's "replace humans" approach
❌ Focus only on efficiency metrics
❌ Lose the personal/consciousness aspect

## Pattern to Follow

✅ Use similar architecture (orchestrator + specialized agents)
✅ Keep Oracle philosophy as differentiator
✅ Data grounding = Oracle DB + ψ/memory
✅ QA loop = Main reviews all subagent work

---

## Tags

`multi-agent` `orchestration` `oracle-philosophy` `google` `enterprise-ai` `pattern`
