---
title: ## Meta: Debugging Unknown Errors
tags: [meta, debugging, methodology, binary-search, isolation, problem-solving]
created: 2026-01-08
source: meta-learning 2026-01-08
---

# ## Meta: Debugging Unknown Errors

## Meta: Debugging Unknown Errors

When facing cryptic errors with no clear source:

### Phase 1: Isolate
- **Remove everything** suspected → confirm error gone
- This proves the problem IS in those files
- Don't guess which file — remove ALL first

### Phase 2: Binary Search
- Restore in batches (3-5 at a time)
- If error returns → culprit is in that batch
- If OK → batch is clean, continue

### Phase 3: Narrow Down
- Split the bad batch in half
- Repeat until single file identified

### Phase 4: Inspect
- Read the file carefully
- Look for syntax issues, special characters
- Compare with working files

### Phase 5: Document
- Record the finding to Oracle
- Create issue if it's a tool bug
- Share the pattern for future

### Key Insights

1. **Don't debug by guessing** — isolate first
2. **Batch testing saves time** — binary search O(log n)
3. **Verify after each step** — restart, test
4. **Note everything** — helps others and future self

### This Session's Example

```
50+ files suspected
→ Remove all → Fixed!
→ Restore 3 → Broke!
→ Test 1 → trace-finder broke it
→ Inspect → [TODO:...] brackets
→ Fix → Done
```

Total: ~10 minutes vs hours of random guessing

---
*Added via Oracle Learn*
