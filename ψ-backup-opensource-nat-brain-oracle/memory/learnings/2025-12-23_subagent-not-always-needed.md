# Subagent Not Always Needed

**Date**: 2025-12-23
**Context**: `/project list` was using subagent but didn't need to

## The Problem

```markdown
# Old /project list
> Use `Task` tool with `model: haiku` to execute.
```

This spawns a subagent just to run `ls -la` — overkill!

## Solution

Direct bash for simple operations:

```bash
# Instant - no subagent
echo "## 📚 Learn"
ls -la ψ/learn/repo/github.com/*/ 2>/dev/null | grep "^l" | awk '{print "✅", $9, "→", $11}'
echo ""
echo "## 🌱 Incubate"
ls -la ψ/incubate/repo/github.com/*/ 2>/dev/null | grep "^l" | awk '{print "✅", $9, "→", $11}'
```

## When to Use Subagent

| Task | Subagent? | Why |
|------|-----------|-----|
| `ls`, `cat`, simple commands | ❌ No | Direct bash faster |
| Multi-file search | ✅ Yes | Parallel, saves context |
| Complex analysis | ✅ Yes | Let Haiku do heavy lifting |
| Writing/reflection | ❌ No | Main agent (Opus) should write |

## Pattern

```markdown
# In command docs, be explicit:

### list (default)
> **NO SUBAGENT** — direct bash, instant response
```

## Key Insight

> "Subagent is for heavy lifting, not for `ls`"

---

**Tags**: #subagent #performance #pattern
