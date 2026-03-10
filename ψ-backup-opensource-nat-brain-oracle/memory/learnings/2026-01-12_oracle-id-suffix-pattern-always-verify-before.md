---
title: ## Oracle ID Suffix Pattern - ALWAYS Verify Before Acting
tags: [oracle, supersede, id-format, verification, anti-pattern, important]
created: 2026-01-12
source: Session mistake 2026-01-12
---

# ## Oracle ID Suffix Pattern - ALWAYS Verify Before Acting

## Oracle ID Suffix Pattern - ALWAYS Verify Before Acting

### The Mistake
Said "let me find the old learning ID" but then **guessed** the ID instead of actually searching.

Guessed: `learning_2026-01-02_whitelocal-service-inventory-2026-01-02`
Actual:  `learning_2026-01-02_whitelocal-service-inventory-2026-01-02_1`

The `_1` suffix exists because Oracle chunks documents into sections.

### The Rule
**NEVER say "let me find X" then guess. Actually search.**

When using `oracle_supersede`:
1. First run `oracle_search` or check trace results carefully
2. Copy the EXACT ID including any suffix (`_0`, `_1`, `_2`, etc.)
3. Then call supersede

### Why This Matters
- Oracle IDs have chunk suffixes (`_0`, `_1`, `_2`...)
- Guessing = broken supersede chain
- Broken chain = "Nothing is Deleted" philosophy fails
- Old knowledge doesn't get marked, causes confusion

### Pattern
```
❌ BAD:  "Let me find..." → guess ID → fail
✅ GOOD: "Let me find..." → oracle_search → copy exact ID → succeed
```

> **"Don't announce what you'll do, then skip doing it."**

---
*Added via Oracle Learn*
