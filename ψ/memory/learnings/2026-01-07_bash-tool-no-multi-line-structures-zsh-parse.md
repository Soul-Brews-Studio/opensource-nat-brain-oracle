---
title: ## Bash Tool: No Multi-line Structures (zsh parse error)
tags: [bash, zsh, parse-error, tool-usage, prevention]
created: 2026-01-07
source: Session 2026-01-08 - /recap command error
---

# ## Bash Tool: No Multi-line Structures (zsh parse error)

## Bash Tool: No Multi-line Structures (zsh parse error)

**Problem**: zsh parse errors occur with `if/then/else/fi` blocks in Claude Code's Bash tool.

**Error**: `(eval):1: parse error near ')'`

**Root cause**: Command substitution `$()` combined with newlines confuses zsh parser.

**Prevention**:

❌ DON'T do this:
```bash
LATEST=$(ls -t ψ/*.md | head -1)
if [ -n "$LATEST" ]; then
  cat "$LATEST"
fi
```

✅ DO this (one-liner):
```bash
LATEST=$(ls -t ψ/*.md 2>/dev/null | head -1) && [ -n "$LATEST" ] && cat "$LATEST" || echo "none"
```

✅ OR split into multiple Bash tool calls

**Rule**: Avoid `if/then/else/fi`, `for/do/done`, `while/do/done` in single Bash tool call. Use `&&`/`||` one-liners or multiple tool calls.

---
*Added via Oracle Learn*
