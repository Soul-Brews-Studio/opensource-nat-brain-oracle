# Subagent Write Permissions

**Date**: 2025-12-27
**Context**: `/learn` agents couldn't write files, explored but output was lost

## What Happened

3 Explore agents were told to "Write output to: ψ/learn/..." but returned with:
> "I cannot write files directly. Here's the content..."

All exploration work was done, but files weren't created.

## Root Cause

1. **Explore agents may have read-only access** — depends on tool permissions
2. **Asking agent to write != agent can write** — permission varies by agent type
3. **No fallback strategy** — if write fails, work is lost

## Fix

Change strategy: Agents **return content** → Main agent writes

```markdown
# Before (broken)
prompt: |
  Explore and document...
  Write output to: ψ/learn/[name]/file.md  ← Agent can't do this

# After (works)
prompt: |
  Explore and document...
  Return your findings in this format:  ← Agent returns, main writes
  [markdown template]
```

Main agent then writes:
```bash
cat > ψ/learn/[name]/file.md << 'EOF'
[Agent output here]
EOF
```

## Prevention Pattern

| Do | Don't |
|----|----|
| "Return your findings" | "Write to file" |
| Main agent writes all files | Assume subagent has write access |
| Use heredoc for file creation | Trust subagent to save output |

## When This Applies

- Any subagent that needs to persist output
- Especially `Explore` agents (often read-only)
- Any workflow where work could be lost

## Tags

#subagents #permissions #file-operations #explore-agent
