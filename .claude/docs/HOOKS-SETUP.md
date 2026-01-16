---
name: HOOKS-SETUP
description: Reference document.
---

# Claude Code Hooks Setup

Setup instructions for statusline hooks that show timestamp, context usage, and branch.

## What You Get

```
🕐 11:57 | 31 December 2025 | Nat-s-Agents | main
📊 Opus 4.5 22% (36k/160k usable)
```

## Files Needed

### 1. `.claude/settings.json`

Copy from repo - contains all hook definitions.

### 2. `.claude/scripts/token-check.sh`

Shows context usage with urgency levels:
- `📊` Normal (< 70%)
- `⚡` Finish soon (70-80%)
- `⚠️` Wrap up (80-90%)
- `🚨` HANDOFF NOW (> 90%)

### 3. `.claude/scripts/agent-id.sh`

Returns current git branch or agent ID.

### 4. `ψ/active/statusline.json`

Created automatically by Claude Code's status callback hook.

## Setup Steps

```bash
# 1. Pull latest from origin
cd /home/nat/ghq/github.com/laris-co/nat-s-Agents
git pull origin main

# 2. Make scripts executable
chmod +x .claude/scripts/*.sh
chmod +x .claude/hooks/*.sh

# 3. Create statusline.json if missing
mkdir -p ψ/active
echo '{}' > ψ/active/statusline.json

# 4. Restart Claude Code
# The hooks will now show on each prompt
```

## Hook Triggers

| Hook | When | Shows |
|------|------|-------|
| UserPromptSubmit | Every prompt | Timestamp + Context % |
| PreToolUse:Bash | Before bash | Safety check + Context |
| PreToolUse:Task | Before subagent | Log start |
| PostToolUse:Task | After subagent | Log end |
| SessionStart | Session begin | Agent identity + Handoff |

## Callback Hook (for statusline.json)

Add to settings.json under each hook section:

```json
{
  "type": "command",
  "command": "callback"
}
```

This makes Claude Code write current model/context info to statusline.json.

## Troubleshooting

**Hooks not showing?**
- Check scripts are executable
- Verify CLAUDE_PROJECT_DIR is set
- Check jq is installed for token-check.sh

**Permission errors?**
- Run: `chmod +x .claude/scripts/*.sh .claude/hooks/*.sh`

---
Created: 2025-12-31
