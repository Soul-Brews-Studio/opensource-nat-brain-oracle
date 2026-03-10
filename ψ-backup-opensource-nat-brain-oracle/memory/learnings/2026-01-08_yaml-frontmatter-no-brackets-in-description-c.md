---
title: ## YAML Frontmatter: No Brackets in Description
tags: [yaml, parser, claude-code, debugging, frontmatter]
created: 2026-01-08
source: debugging session 2026-01-08
---

# ## YAML Frontmatter: No Brackets in Description

## YAML Frontmatter: No Brackets in Description

Claude Code parser crashes when skill description contains brackets `[...]`.

**Breaks:**
```yaml
description: [TODO: something]
description: [array, syntax]
```

**Works:**
```yaml
description: "Plain text here"
description: No brackets allowed
```

**Why:** YAML interprets `[...]` as array. Parser calls `.split(" ")` on array → crash.

**Debug approach:**
1. Move all files to backup → confirm fix
2. Restore in batches → isolate folder
3. Test one at a time → find exact file
4. Inspect → find bad syntax

---
*Added via Oracle Learn*
