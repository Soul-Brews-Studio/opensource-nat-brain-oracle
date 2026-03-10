---
title: ## Advanced Claude Code Setup (from Thai community thread, Jan 2026)
tags: [claude-code-setup, workflow, hooks, subagents, mcp, permissions, parallel-agents, best-practices]
created: 2026-01-04
source: Thai community thread - Advanced Claude Code setup Jan 2026
---

# ## Advanced Claude Code Setup (from Thai community thread, Jan 2026)

## Advanced Claude Code Setup (from Thai community thread, Jan 2026)

### 1. Parallel Instances
- Run 5 Claude Code terminals in parallel (5 tabs)
- Use hooks to notify when tab needs input
- Also run multiple web instances with `teleport` to terminal

### 2. Model Choice
- Use **Opus 4.5 Thinking** always
- Slower but more accurate, fewer errors
- Ultimately faster overall than small models
- ⚠️ Requires Max $200 plan

### 3. Shared CLAUDE.md
- Shared across team in project
- Update when model makes repeated mistakes
- Learning from @claude tags in PR comments

### 4. Workflow Patterns
- **Always start with Plan mode** → refine until satisfied → switch to auto-accept
- Use **slash commands** for frequent tasks (`/commit-push-pr`)
- Use **subagents** extensively - simplify code, complex workflows

### 5. Hooks Usage
- **PostToolUse hook**: Format code to avoid linter issues in CI
- **Stop Hook**: Prevent agent drift on long tasks

### 6. Permissions
- ❌ Don't use `--dangerously-skip-permissions`
- ✅ Use `/permissions` to pre-authorize what agents can do

### 7. MCP Integration
- Post to Slack
- Run BigQuery
- Get error logs from Sentry
- (Interesting: doesn't use Skills for these)

### 8. Long Task Strategies
a. Prompt to use background agent to check work at end
b. Use agent via Stop Hook to prevent drift
c. Use **ralph-wiggum plugin** (automates both above)

### Key Insight
"ลดคน ลดงานซ้ำๆ" - automate repetitive workflow steps

---
*Added via Oracle Learn*
