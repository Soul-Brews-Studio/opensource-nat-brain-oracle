# Status Line Context Display: Check Docs for System Values

**Date**: 2025-12-28
**Category**: Pattern
**Source**: Session retrospective

## The Rule

**Always check official documentation for system values** - don't guess or accept approximations. Autocompact buffer is 45k (22.5%), not 20k.

## Why It Matters

Using wrong values leads to:
- Misleading percentage displays
- Incorrect capacity planning
- Multiple wasted iterations fixing values

## Example

```bash
# ❌ WRONG - guessed value
usable=$((size - 20000))  # 180k usable - WRONG!

# ❌ WRONG - user approximation
usable=$((size - 20000))  # "feels like 20k" - WRONG!

# ✅ CORRECT - from Claude Code docs
usable=$((size * 775 / 1000))  # 77.5% usable (22.5% reserved)
# 200k → 155k usable
# 1M → 775k usable (scales!)
```

## The Formula

```
Usable Context = Total × 77.5%
               = Total × 775 / 1000
               = Total - (Total × 22.5%)

For 200k: 200,000 × 0.775 = 155,000 usable
For 1M:   1,000,000 × 0.775 = 775,000 usable
```

## Bonus: MCP Token Savings

Unused MCP tools consume context. Check `/context` and remove what you don't use:

```bash
# Before: 43k MCP tokens (unused Playwright + chrome tools)
# After:  14k MCP tokens (only Playwright)
# Saved:  29k tokens!
```

## Prevention

1. When dealing with system limits → check docs first
2. Use `claude-code-guide` subagent to search documentation
3. Prefer percentage-based calculations (scales for different context sizes)
4. Run `/context` to audit token usage

---

**Related**:
- Retrospective: `ψ/memory/retrospectives/2025-12/28/11.50_statusline-context-display-config.md`
- Claude Code docs: autocompact buffer = 22.5%
