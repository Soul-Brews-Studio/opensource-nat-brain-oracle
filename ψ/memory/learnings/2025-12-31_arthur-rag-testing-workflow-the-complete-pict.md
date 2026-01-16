---
title: Arthur RAG - Complete Test/See/Implement Cycle
tags: [arthur, rag, testing, browser-automation, bilingual-search, implementation-pattern, e2e]
created: 2025-12-31
source: Session 2025-12-31 - Arthur RAG #80 completion
---

# Arthur RAG - Complete Test/See/Implement Cycle

> **The Pattern**: Implement → See in logs → Verify in UI → Browser automation → Screenshot proof

## Quick Reference

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  IMPLEMENT  │ ──▶ │     SEE     │ ──▶ │    TEST     │
│  (Backend)  │     │   (Logs)    │     │ (Browser)   │
└─────────────┘     └─────────────┘     └─────────────┘
      │                   │                   │
      ▼                   ▼                   ▼
  server.ts          Console +           dev-browser
  useArthur.ts       UI badges           screenshots
  Conversation.tsx   Modal view          tmp/*.png
```

---

## 1. HOW TO IMPLEMENT

### Backend (`ψ/lab/oracle-jarvis/server.ts`)

```typescript
// Bilingual search - expand Thai to English keywords
const bilingualKeywords = {
  'นัท': ['nat', 'nut', 'owner', 'creator'],
  'โปรเจค': ['project', 'repo', 'codebase'],
  // ... add more mappings
};

// Return sources in response
return {
  response: answer,
  ragSources: topResults.map(r => ({
    file: r.file,
    score: r.score,
    snippet: r.content.slice(0, 100)
  }))
};
```

### Frontend Hook (`useArthur.ts`)

```typescript
// Attach sources to message
const newMessage: Message = {
  role: 'assistant',
  content: data.response,
  ragSources: data.ragSources  // <-- pass through
};
```

### UI Component (`Conversation.tsx`)

```tsx
// Inline badges
{message.ragSources?.map(src => (
  <SourceBadge key={src.file} source={src} />
))}

// Modal expansion
<dialog>
  {selectedMessage?.ragSources?.map(src => (
    <div className="source-detail">
      <span className="file">{src.file}</span>
      <span className="score">{src.score.toFixed(2)}</span>
    </div>
  ))}
</dialog>
```

---

## 2. HOW TO SEE

### Console Logs (Terminal running Arthur API)

```bash
# Watch for these logs:
[RAG] Query: "Who is Nat?"
[RAG] Keywords: ["nat", "owner", "creator"]
[RAG] Found 5 sources in 23ms
[RAG] Top: ψ/memory/resonance/identity.md (0.89)
```

### UI Verification

| Element | Where | What to Check |
|---------|-------|---------------|
| Cyan badges | Below assistant message | Source count visible |
| Badge text | On badge | Shows filename |
| Modal | Click any message | Full source details |
| Score | In modal | Relevance 0.00-1.00 |

### Screenshot Locations

```
tmp/arthur-test.png       # Basic UI
tmp/arthur-modal.png      # Modal open
tmp/arthur-thai-test.png  # Thai query
```

---

## 3. HOW TO TEST

### Manual Test

```bash
# 1. Start services
cd ψ/lab/oracle-jarvis && bun run server.ts  # Port 3456
cd ψ/lab/oracle-v2/react-ui && npm run dev   # Port 5173

# 2. Open browser
open http://localhost:5173/#arthur

# 3. Test queries
"Who is Nat?"           # English - should find identity.md
"นัทเป็นคนยังไง"         # Thai - bilingual search kicks in
"What is Oracle?"       # Concept search
```

### Automated Test (dev-browser skill)

```
/skill dev-browser

# Then run:
goto http://localhost:5173/#arthur
type .chat-input "Who is Nat?"
click button[type="submit"]
wait 2000
screenshot tmp/arthur-test.png
click .message.assistant
wait 500
screenshot tmp/arthur-modal.png
```

### E2E Test Checklist

- [ ] English query returns sources
- [ ] Thai query triggers bilingual expansion
- [ ] Sources display as badges
- [ ] Click opens modal with details
- [ ] Score shows relevance
- [ ] Navigation Oracle ↔ Arthur works

---

## 4. DEBUGGING

| Symptom | Check | Fix |
|---------|-------|-----|
| No sources | Console logs | Verify RAG query runs |
| Empty badges | API response | Check `ragSources` in response |
| Thai not working | Bilingual dict | Add missing keywords |
| Modal empty | Component props | Verify sources passed to modal |
| Navigation broken | Hash routing | Check `#arthur` vs `#oracle` |

---

## Files Changed (Issue #80)

| File | Changes |
|------|---------|
| `server.ts` | Bilingual search + ragSources response |
| `useArthur.ts` | Attach sources to messages |
| `Conversation.tsx` | SourceBadge + modal expansion |
| `arthur.css` | Cyan badge styling |
| `App.tsx` | Hash routing fix |

---

## Key Insight

**The confidence cycle:**

1. **Implement** with logging built in
2. **See** results immediately in console
3. **Verify** visually in UI
4. **Automate** with browser skill
5. **Screenshot** for proof

This creates **confidence** that changes work end-to-end.

No more "I think it works" — you have **proof**.

---
*Added via Oracle Learn - Updated for clarity*
