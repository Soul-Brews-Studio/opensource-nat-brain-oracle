# Claude Code Settings: Hooks Merge, Not Override

**Date**: 2025-12-29
**Category**: Discovery
**Source**: Session retrospective

## The Rule

Both `settings.json` AND `settings.local.json` hooks **run together** (merge). They do NOT override each other.

## Why It Matters

If you define the same hook in both files, it runs **twice**.

## Example

```bash
# Check both files
jq '.hooks.UserPromptSubmit' .claude/settings.json
jq '.hooks.UserPromptSubmit' .claude/settings.local.json

# If both have hooks → both run → duplicate output
```

## Prevention

| File | Purpose | When to Use |
|------|---------|-------------|
| `settings.json` | Tracked, shared | Default hooks for all |
| `settings.local.json` | Gitignored, local | Machine-specific overrides |

**Rule**: Define each hook in ONE file only.

## Verification

```bash
# Validate JSON
jq . .claude/settings.json > /dev/null && echo "valid"
jq . .claude/settings.local.json > /dev/null && echo "valid"
```

---

**Related**: Timestamp hook duplicate issue (2025-12-29)
