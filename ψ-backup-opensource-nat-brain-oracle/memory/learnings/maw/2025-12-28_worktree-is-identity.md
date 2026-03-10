# Worktree Is Identity (Model-Agnostic MAW)

**Date**: 2025-12-28

## What We Learned

- **Worktree = Identity**: The agent's identity comes from its filesystem location, not the AI model running in it
- **Model-Agnostic**: MAW works for Claude Code, z.ai, OpenCode, Codex, Gemini - any AI that can run bash
- **Absolute Paths, Not cd**: Use `git -C /absolute/path` instead of `cd /path && git`. Avoids sandbox reset warnings
- **Export MAW_REPO_ROOT**: Set this environment variable so maw commands work from any worktree

## How Things Connect

```
MAW (Multi-Agent Worktree)
├── Main (/)          ← Any AI
├── Agent 1 (/agents/1) ← Any AI
├── Agent 2 (/agents/2) ← Any AI
└── ...
```

Each worktree is a separate Claude Code (or other AI) session. The identity comes from `$PWD`, detected with:

```bash
if [[ "$PWD" =~ $ROOT/agents/([0-9]+)$ ]]; then
  AGENT_ID="${BASH_REMATCH[1]}"
fi
```

## The Pattern

```bash
# ❌ WRONG - triggers sandbox reset
cd /path/to/repo && maw sync

# ✅ CORRECT - respects boundaries
MAW_REPO_ROOT="/path/to/repo" maw sync
# or
git -C /path/to/repo status
```

## Files Created

- `.claude/scripts/agent-identity.sh` - Detects agent on SessionStart
- `.claude/hooks/safety-check.sh` - Blocks cd outside worktree

## Tags

`maw` `worktree` `identity` `model-agnostic` `absolute-paths`
