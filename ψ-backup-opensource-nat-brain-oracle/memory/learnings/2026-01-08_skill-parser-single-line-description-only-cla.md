---
title: ## Skill Parser: Single-line Description Only
tags: [skill, yaml, parser, claude-code]
created: 2026-01-08
source: error fix 2026-01-08
---

# ## Skill Parser: Single-line Description Only

## Skill Parser: Single-line Description Only

Claude Code's skill parser cannot handle multi-line YAML descriptions.

**Breaks:**
```yaml
description: |
  Multi-line text
  More text
```

**Works:**
```yaml
description: Single line description here.
```

Error when broken: `TypeError: $.description.split is not a function`

---
*Added via Oracle Learn*
