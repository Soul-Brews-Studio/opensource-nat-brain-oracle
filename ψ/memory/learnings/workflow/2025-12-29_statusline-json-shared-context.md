# Statusline JSON: Shared AI Context

**Date**: 2025-12-29
**Category**: Pattern
**Source**: Session with Nat

## What It Is

The statusline script now saves Claude's context data to `ψ/active/statusline.json` - a shared asset between human and AI.

## Location

| Agent | File Path |
|-------|-----------|
| Main | `ψ/active/statusline.json` |
| Agent N | `agents/N/ψ/active/statusline.json` |

## Data Available

```json
{
  "session_id": "uuid",
  "transcript_path": "/path/to/session.jsonl",
  "model": {"id": "claude-opus-4-5-...", "display_name": "Opus 4.5"},
  "version": "2.0.71",
  "cost": {
    "total_cost_usd": 0.61,
    "total_duration_ms": 215074,
    "total_lines_added": 5,
    "total_lines_removed": 0
  },
  "context_window": {
    "context_window_size": 200000,
    "current_usage": {
      "input_tokens": 8,
      "output_tokens": 1,
      "cache_creation_input_tokens": 705,
      "cache_read_input_tokens": 37621
    }
  }
}
```

## Token Calculation

```bash
# Used tokens (approximate)
used = input_tokens + cache_creation_input_tokens + cache_read_input_tokens

# Remaining
remaining = context_window_size - used

# Usable (77.5% due to autocompact buffer)
usable = context_window_size * 0.775
```

## Quick Check Command

```bash
# Check current tokens
jq '{
  used: (.context_window.current_usage | .input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens),
  total: .context_window.context_window_size,
  pct: ((.context_window.current_usage | .input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens) * 100 / .context_window.context_window_size)
}' ψ/active/statusline.json
```

## For AI (Claude)

Read this file anytime to know:
- Current token usage and remaining capacity
- Session cost so far
- Session ID for reference

```
Read ψ/active/statusline.json
```

## Implementation

Added to `~/.claude/statusline-command.sh`:

```bash
# Save to project's ψ/active/ if available (shared AI context)
if [ -n "$CLAUDE_PROJECT_DIR" ] && [ -d "$CLAUDE_PROJECT_DIR/ψ/active" ]; then
  echo "$input" > "$CLAUDE_PROJECT_DIR/ψ/active/statusline.json"
fi
```

---

**Related**: `ψ/memory/learnings/workflow/2025-12-28_statusline-context-display.md`
