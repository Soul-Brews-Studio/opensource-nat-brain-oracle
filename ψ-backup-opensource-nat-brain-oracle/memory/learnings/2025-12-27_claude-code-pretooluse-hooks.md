# Lesson: Claude Code PreToolUse Hooks

**Date**: 2025-12-27
**Context**: Creating safety hook to block dangerous commands
**Confidence**: High (tested and verified)

---

## The Problem

Wanted to block dangerous commands like `--force`, `rm -rf`, `git push main` at the hook level, not just documentation.

First attempt used environment variable:
```bash
CMD="$CLAUDE_TOOL_INPUT"  # ❌ WRONG - doesn't exist
```

## The Solution

Hook input comes via **stdin as JSON**, not environment variables.

```bash
#!/bin/bash
# Read JSON from stdin, parse with jq
CMD=$(jq -r '.tool_input.command // ""' 2>/dev/null)

if echo "$CMD" | grep -qE '--force'; then
  echo "BLOCKED: reason" >&2
  exit 2  # Exit 2 = block
fi

exit 0  # Exit 0 = allow
```

## Input Structure

```json
{
  "session_id": "abc123",
  "hook_event_name": "PreToolUse",
  "tool_name": "Bash",
  "tool_input": {
    "command": "git push --force",
    "description": "Force push"
  }
}
```

## Exit Codes

| Code | Meaning |
|------|---------|
| 0 | Allow tool to proceed |
| 2 | Block tool, show stderr message |
| 1 | Error (treated as allow) |

## File Locations

| File | Purpose |
|------|---------|
| `~/.claude/settings.json` | Global config (all projects) |
| `~/.claude/hooks/*.sh` | Hook scripts |
| `.claude/settings.local.json` | Project-specific (not tracked) |
| `.claude/settings.json` | Project config (tracked) |

## Pattern: Safety via Hooks

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "/path/to/safety-check.sh"
          }
        ]
      }
    ]
  }
}
```

## Anti-Patterns

| ❌ Wrong | ✅ Right |
|----------|----------|
| `$CLAUDE_TOOL_INPUT` | `jq -r '.tool_input.command'` |
| `exit 1` to block | `exit 2` to block |
| Inline long command | External script file |
| Assume env vars | Read from stdin |

---

**Tags**: #claude-code #hooks #safety #pretooluse
