# Smart Hook Command Detection

**Date**: 2025-12-28
**Category**: Pattern
**Source**: Session retrospective

## The Rule/Pattern

Safety hooks should detect actual commands, not text content. Use regex anchors to match command start positions only.

## Why It Matters

- Hooks blocking documentation text = false positives
- Can't write examples/docs mentioning dangerous commands
- Users disable hooks entirely instead of fixing them

## Example

```bash
# ❌ WRONG - matches anywhere in text
if echo "$CMD" | grep -qE 'rm\s+-rf'; then

# ✅ CORRECT - only matches actual commands
if echo "$CMD" | grep -qE '(^|;|&&|\|\|)\s*rm\s+-rf'; then
```

The pattern `(^|;|&&|\|\|)` ensures we match:
- `^` - Start of string (first command)
- `;` - After semicolon (sequential command)
- `&&` - After AND (conditional command)
- `||` - After OR (conditional command)

## Prevention/Application

When writing safety hooks:
1. Consider where the pattern appears, not just if it appears
2. Use anchors to identify command boundaries
3. Test with both actual commands AND text content

---

**Related**: `ψ/memory/retrospectives/2025-12/28/08.43_statusline-shortcodes-safety-hook.md`
