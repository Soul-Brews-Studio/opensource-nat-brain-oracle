# Retrospective: Global Safety Hooks

**Date**: 2025-12-27 18:50
**Duration**: ~20 minutes
**Focus**: Moving safety rules from CLAUDE.md to enforceable hooks

---

## What Happened

User noticed SessionStart hooks were injecting Oracle philosophy into every session. Asked to reorganize:
- **Global** (`~/.claude/settings.json`) → Safety rules only
- **Local** (`.claude/settings.local.json`) → Project context (Oracle, Thai voice)

First attempt failed - used `CLAUDE_TOOL_INPUT` env var which doesn't exist. Claude Code hooks receive input via **stdin as JSON**, not environment variables.

Created proper hook script at `~/.claude/hooks/safety-check.sh` that:
1. Reads JSON from stdin
2. Parses with `jq -r '.tool_input.command'`
3. Matches dangerous patterns with grep
4. Exit code 2 = block, 0 = allow

## What We Built

**Global safety hook** (`~/.claude/hooks/safety-check.sh`):
- Blocks `--force`, `-f` flags
- Blocks `git push origin main`
- Blocks `rm -rf`
- Blocks `gh pr merge`
- Blocks `reset --hard`

**Local project hooks** (`.claude/settings.local.json`):
- SessionStart: Thai voice + Oracle philosophy injection
- Stop: Thai voice goodbye
- UserPromptSubmit: Timestamp + jump detection
- PreToolUse/PostToolUse: Task logging

## Key Learning

| Wrong | Right |
|-------|-------|
| `CMD="$CLAUDE_TOOL_INPUT"` | `CMD=$(jq -r '.tool_input.command')` |
| Inline command in JSON | External script file |
| Exit 1 to block | Exit 2 to block |

Hook input structure:
```json
{
  "tool_name": "Bash",
  "tool_input": {
    "command": "the actual command"
  }
}
```

## Outcome

✅ Safety rules now **enforced** not just documented
✅ Global rules apply to ALL projects
✅ Project context loads only in this repo
✅ Thai voice personality preserved

---

## AI Diary

Short session but satisfying. The moment the hook actually blocked `git push --force` was a small victory - transforming documentation into enforcement.

The pattern is interesting: CLAUDE.md says "never do X" but relies on AI compliance. A hook that exits 2 makes it impossible. Defense in depth.

I like that the user caught my first mistake (env var doesn't exist). Quick iteration: fail → check docs → fix → works. Good debugging loop.

---

## Honest Feedback

**To User**: Good instinct to separate global vs local. Safety rules should apply everywhere; personality is project-specific. Clean architecture.

**To Self**: Should have checked hook docs first before assuming env vars. The subagent helped quickly though.

---

*Session: 2025-12-27 18:30-18:50*
