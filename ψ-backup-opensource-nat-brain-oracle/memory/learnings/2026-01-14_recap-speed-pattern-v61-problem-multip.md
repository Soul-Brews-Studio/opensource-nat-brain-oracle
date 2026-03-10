---
title: ## Recap Speed Pattern (v6.1)
tags: [recap, performance, bash-scripts, division-of-labor]
created: 2026-01-14
source: Session 2026-01-14
---

# ## Recap Speed Pattern (v6.1)

## Recap Speed Pattern (v6.1)

**Problem**: Multiple parallel tool calls still have round-trip latency (5 calls × 20s = 2min)

**Solution**: Single bash script outputs everything, LLM just adds "What's next?"

```
.claude/scripts/recap.sh      # fast mode (~0.1s)
.claude/scripts/recap-rich.sh # full context (~0.2s)
```

**Division of labor**:
- Bash: instant at data gathering (git, grep, ls)
- LLM: good at synthesis ("what's next?")

Each does what it's best at. Don't make LLM do what bash can do instantly.

---
*Added via Oracle Learn*
