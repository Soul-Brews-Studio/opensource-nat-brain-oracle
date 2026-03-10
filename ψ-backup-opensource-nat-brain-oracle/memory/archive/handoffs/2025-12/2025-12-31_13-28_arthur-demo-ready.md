---
title: "Arthur Demo Ready + Mac Presentation"
date: 2025-12-31 13:28
context_at_handoff: 92%
status: handoff
meeting: อ.Sate @ 14:00
---

# Handoff: Arthur Demo Ready

## Meeting @ 14:00

**With**: อ.Sate (advisor)
**Topic**: Mac purchase plan for Local AI

## Ready Items

### 1. Presentation
```
ψ/writing/drafts/2025-12-31_mac-purchase-presentation.html
```
- 11 slides, reveal.js
- Pricing: ฿166,080 per party

### 2. Arthur Demo
```
http://localhost:5173/#arthur
```
- RAG: Active (4.6K docs)
- Voice: Ready

### 3. New Command Created
```
/arthur-demo
```
Starts all 3 services automatically.

## Services Running

| Service | Port | Status |
|---------|------|--------|
| Vite UI | 5173 | ✅ |
| Arthur API | 3456 | ✅ |
| Oracle API | 37778 | ✅ |

## If Services Die

Run `/arthur-demo` or manually:
```bash
cd ψ/lab/oracle-v2 && npm run server &
cd ψ/lab/oracle-jarvis && bun run server.ts &
cd ψ/lab/oracle-v2/react-ui && npm run dev &
```

## Pricing Summary

| Item | Amount |
|------|--------|
| Hardware (Mac + AppleCare) | ฿276,800 |
| ค่าระบบ | ฿221,440 |
| **Total** | **฿498,240** |
| **Per Party** | **฿166,080** |

---
Good luck with the meeting!
