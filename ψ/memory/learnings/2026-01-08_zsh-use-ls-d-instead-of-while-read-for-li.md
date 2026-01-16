---
title: ## zsh: Use `ls -d` instead of `while read` for listing
tags: [zsh, bash, ls, while-loop, prevention]
created: 2026-01-08
source: Session 2026-01-08 - incubate cleanup
---

# ## zsh: Use `ls -d` instead of `while read` for listing

## zsh: Use `ls -d` instead of `while read` for listing

**Problem**: zsh has issues with `while read` loops piped from `ls`.

**Error**: `unknown file attribute` spam

**Prevention**:

❌ DON'T:
```bash
ls path/*/* | while read link; do basename "$link"; done
```

✅ DO:
```bash
ls -d path/*/*  # Lists directories/symlinks only, no content
```

**Why**: `ls -d` shows directory names without descending into them. Cleaner than piping to while loop which causes zsh parsing issues.

---
*Added via Oracle Learn*
