# AI Context Awareness: How Claude Knows Token Usage

**Date**: 2025-12-30
**Category**: Workflow / AI Self-Awareness
**Source**: Session with Nat

---

## The Problem

AI (Claude) doesn't natively know how much context window it has used. Without this info:
- AI might start long tasks when context is almost full
- No warning before autocompact triggers
- Human has to manually tell AI to wrap up

---

## Context Calculation (with Auto-Compact)

```
Total context: 200k
Auto-compact buffer: 20% = 40k
Usable context: 160k (80%)

Thresholds (based on usable):
- 90% of 160k = 144k → HANDOFF NOW
- 80% of 160k = 128k → Prepare handoff
- 70% of 160k = 112k → Finish soon
```

---

## The Solution: 4-Part System

### Part 1: Statusline JSON (Data Source)

`~/.claude/statusline-command.sh` saves Claude's internal data to project:

```bash
# Saves to ψ/active/statusline.json
if [ -n "$CLAUDE_PROJECT_DIR" ] && [ -d "$CLAUDE_PROJECT_DIR/ψ/active" ]; then
  echo "$input" > "$CLAUDE_PROJECT_DIR/ψ/active/statusline.json"
fi
```

**Data available**:
```json
{
  "session_id": "uuid",
  "model": {"id": "claude-opus-4-5-...", "display_name": "Opus 4.5"},
  "cost": {"total_cost_usd": 130.38},
  "context_window": {
    "context_window_size": 200000,
    "current_usage": {
      "input_tokens": 8,
      "cache_creation_input_tokens": 1915,
      "cache_read_input_tokens": 59065
    }
  }
}
```

**Location**: `ψ/active/statusline.json` (main) or `agents/N/ψ/active/statusline.json`

---

### Part 2: Token Check Script (Logic)

`.claude/scripts/token-check.sh` reads JSON and warns:

```bash
#!/bin/bash
ROOT="${CLAUDE_PROJECT_DIR:-/path/to/repo}"
FILE="$ROOT/ψ/active/statusline.json"

[ ! -f "$FILE" ] && exit 0

pct=$(jq -r '
  .context_window as $ctx |
  ($ctx.current_usage.input_tokens + $ctx.current_usage.cache_creation_input_tokens + $ctx.current_usage.cache_read_input_tokens) as $used |
  ($used * 100 / $ctx.context_window_size | floor)
' "$FILE" 2>/dev/null)

[ -z "$pct" ] && exit 0

if [ "$pct" -ge 85 ]; then
  echo "⚠️ CONTEXT ${pct}% - Consider /ccc or handoff NOW"
elif [ "$pct" -ge 70 ]; then
  echo "⚡ Context ${pct}% - Run /ccc soon"
elif [ "$pct" -ge 50 ]; then
  echo "📊 Context ${pct}%"
fi
```

**Thresholds**:
| Level | Output | Action |
|-------|--------|--------|
| <70% | `📊 Opus 4.5 XX% (XXk/200k)` | Normal operation |
| 70%+ | `⚡ ... - Finish soon` | Wrap up current work |
| 80%+ | `⚠️ ... - Wrap up, prepare handoff` | Create handoff soon |
| **90%+** | `🚨 HANDOFF NOW: ...` | **Create handoff immediately** |

---

### Part 3: Hooks (Trigger Points)

`.claude/settings.json` hooks determine WHEN AI sees context:

```json
{
  "hooks": {
    "UserPromptSubmit": [
      {"type": "command", "command": "bash .claude/scripts/token-check.sh"}
    ],
    "PreToolUse": [
      {"matcher": "Bash", "hooks": [{"type": "command", "command": "bash .claude/scripts/token-check.sh"}]},
      {"matcher": "Task", "hooks": [{"type": "command", "command": "bash .claude/scripts/token-check.sh"}]},
      {"matcher": "Read", "hooks": [{"type": "command", "command": "bash .claude/scripts/token-check.sh"}]}
    ],
    "PostToolUse": [
      {"matcher": "Bash", "hooks": [{"type": "command", "command": "bash .claude/scripts/token-check.sh"}]},
      {"matcher": "Task", "hooks": [{"type": "command", "command": "bash .claude/scripts/token-check.sh"}]},
      {"matcher": "Read", "hooks": [{"type": "command", "command": "bash .claude/scripts/token-check.sh"}]}
    ]
  }
}
```

**When AI sees context**:
| Event | When | Why |
|-------|------|-----|
| UserPromptSubmit | Every user message | Baseline awareness |
| PreToolUse (Bash/Task/Read) | Before heavy operations | Warn before starting |
| PostToolUse (Bash/Task/Read) | After heavy operations | Track after growth |

---

## How AI Should Behave

### When Context <70%
- Normal operation
- `📊 Opus 4.5 XX% (XXk/200k)` shown
- AI continues normally

### When Context 70-79%
- `⚡ ... - Finish soon` appears
- AI should:
  - Finish current task
  - Not start new complex tasks

### When Context 80-89%
- `⚠️ ... - Wrap up, prepare handoff` appears
- AI should:
  - Complete only essential work
  - Start drafting handoff in mind

### When Context 90%+
- `🚨 HANDOFF NOW: ...` appears
- AI MUST:
  - **Stop current work immediately**
  - **Create handoff file**: `ψ/inbox/handoff/YYYY-MM-DD_HH-MM_topic.md`
  - Include: what was done, what's pending, next steps, files changed
  - Run `rrr` if time permits

---

## Quick Commands

```bash
# Check current context (AI or human)
jq '{used: (.context_window.current_usage | .input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens), total: .context_window.context_window_size, pct: ((.context_window.current_usage | .input_tokens + .cache_creation_input_tokens + .cache_read_input_tokens) * 100 / .context_window.context_window_size | floor)}' ψ/active/statusline.json

# Manual trigger
bash .claude/scripts/token-check.sh
```

---

## Files Involved

| File | Purpose |
|------|---------|
| `~/.claude/statusline-command.sh` | Saves Claude data to JSON |
| `ψ/active/statusline.json` | Shared AI context data |
| `.claude/scripts/token-check.sh` | Logic + thresholds |
| `.claude/settings.json` | Hook configuration |

---

## Future Improvements

- [ ] Add cost threshold warnings (e.g., $50+ session)
- [ ] Lower threshold for subagents (they have less context)
- [ ] Sound notification at 85%+
- [ ] Auto-create handoff at 90%

---

## New Session: Auto-Pickup Handoff

When a new session starts (or after auto-compact), AI automatically sees the latest handoff.

**SessionStart hook** runs `.claude/scripts/show-latest-handoff.sh`:

```bash
#!/bin/bash
# Find latest handoff from today/yesterday
LATEST=$(ls -t ψ/inbox/handoff/*.md | head -1)

# If recent, show to AI
if [ recent ]; then
  echo "📋 RECENT HANDOFF: $LATEST"
  cat "$LATEST"
  echo "💡 Read this handoff and continue where previous session left off."
fi
```

**AI sees on session start**:
```
📋 RECENT HANDOFF: ψ/inbox/handoff/2025-12-30_11-30_context-hooks.md
---
[handoff content]
---
💡 Read this handoff and continue where previous session left off.
```

---

## Complete Flow

```
Session running → 90% context reached
       ↓
🚨 HANDOFF NOW message appears
       ↓
AI creates handoff: ψ/inbox/handoff/YYYY-MM-DD_HH-MM_topic.md
       ↓
Auto-compact triggers (or user starts new session)
       ↓
New session starts → SessionStart hook
       ↓
show-latest-handoff.sh finds recent handoff
       ↓
AI sees handoff content → continues smoothly
```

---

## Files Involved

| File | Purpose |
|------|---------|
| `~/.claude/statusline-command.sh` | Saves Claude data to JSON |
| `ψ/active/statusline.json` | Shared AI context data |
| `.claude/scripts/token-check.sh` | Context % + urgency levels |
| `.claude/scripts/show-latest-handoff.sh` | Show handoff on session start |
| `.claude/settings.json` | Hook configuration |
| `ψ/inbox/handoff/*.md` | Handoff files |

---

**Related**:
- `ψ/memory/learnings/workflow/2025-12-28_statusline-context-display.md`
- `ψ/memory/learnings/workflow/2025-12-29_statusline-json-shared-context.md`
