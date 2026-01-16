# Copy-Paste Commands Need Protection

**Date**: 2025-12-27
**Context**: `/project` command returning empty when projects existed

## What Happened

Command template had correct bash:
```bash
echo "## Learn"
ls -la ψ/learn/repo/github.com/*/ | grep "^l"
```

AI "improved" it by wrapping in a for loop:
```bash
for d in ψ/learn/repo/github.com/*/; do
  ls -la "$d" | grep "^l"
done
```

Result: Empty output. The for loop broke glob expansion.

## Root Cause

1. **Multi-line commands invite modification** — AI sees structure, wants to "fix"
2. **Glob expansion differs in loops** — `*/` inside loop vs direct `ls` behaves differently
3. **No warning = no protection** — Nothing said "don't touch this"

## Prevention Pattern

```bash
# ❌ Before (invites modification)
echo "## Learn"
ls -la path/*/ | grep ...
echo ""
echo "## Incubate"
ls -la path/*/ | grep ...

# ✅ After (copy-paste protection)
# COPY-PASTE EXACTLY — do NOT wrap in a for loop!
echo "## Learn" && ls -la path/*/ | grep ... && echo "" && echo "## Incubate" && ls -la path/*/ | grep ...
```

## Key Principles

| Principle | Why |
|-----------|-----|
| Single-line | Harder to accidentally break |
| Explicit warning | Catches attention before modification |
| Explain anti-pattern | Prevents future mistakes |
| `&&` chain | Makes it feel "atomic" |

## When to Apply

Use this pattern when:
- Command must be executed exactly as written
- Glob expansion or shell features are critical
- AI might "helpfully" restructure the code

## Tags

#commands #bash #glob #ai-behavior #copy-paste
