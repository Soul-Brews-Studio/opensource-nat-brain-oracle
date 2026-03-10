---
title: ## Bash: Sanitize slugs for filenames
tags: [bash, filename, slug, sanitize, prevention]
created: 2026-01-08
source: Session 2026-01-08 - reunion all error
---

# ## Bash: Sanitize slugs for filenames

## Bash: Sanitize slugs for filenames

**Problem**: Slugs like `owner/repo` contain `/` which creates invalid file paths.

**Error**: `No such file or directory` when writing to `index-2026-01-08-owner/repo.json`

**Fix**:
```bash
# Replace / with _ for safe filename
safe_slug="${full_slug//\//_}"
# Result: owner_repo
```

**Rule**: Always sanitize slugs before using in filenames.

---
*Added via Oracle Learn*
