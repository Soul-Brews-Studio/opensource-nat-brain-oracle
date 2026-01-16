# GitHub Actions + Claude Code Workflow

**Date**: 2025-12-15
**Source**: Session — Setting up async Claude via GitHub Actions
**Category**: DevOps Pattern

## The Pattern

Run Claude Code in GitHub Actions self-hosted runner with session persistence.

```yaml
jobs:
  claude-session:
    runs-on: [self-hosted, mbanat]
    timeout-minutes: 15

    steps:
      - uses: actions/checkout@v4
      - name: Run Claude
        env:
          CLAUDE_CODE_OAUTH_TOKEN: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
          PATH: /Users/nat/.bun/bin:/Users/nat/.nvm/versions/node/v22.20.0/bin:/opt/homebrew/bin:/usr/bin:/bin
        run: |
          claude --print --resume "${{ inputs.session_id }}" -p "${{ inputs.prompt }}"
```

## Key Learnings

### 1. PATH is Everything
Runner service (launchd) has minimal PATH. Must add explicitly:
- `/Users/nat/.bun/bin` — claude binary
- `/Users/nat/.nvm/versions/node/v22/bin` — node runtime

### 2. HOME Gets Hijacked
`actions/checkout@v4` overrides HOME to temp dir for git isolation.
Solution: Use `CLAUDE_CODE_OAUTH_TOKEN` instead of `~/.claude/` auth.

### 3. OAuth Token Setup
```bash
claude setup-token
# Returns: sk-ant-oat01-... (valid 1 year)
# Set as: CLAUDE_CODE_OAUTH_TOKEN
```

### 4. --resume vs --session-id

| Flag | Behavior | Use Case |
|------|----------|----------|
| `--session-id` | Creates/locks session | DON'T USE - causes "already in use" |
| `--resume` | Loads history, no lock | USE THIS for workflows |

### 5. Session IDs are Project-Specific
Sessions stored in `~/.claude/projects/-path-to-project/`
Can't share session across different project folders.

### 6. Add Timeout
```yaml
timeout-minutes: 15
```
Prevents runaway workflows.

## Anti-Patterns

| Wrong | Right |
|-------|-------|
| `--session-id UUID` | `--resume UUID` |
| Expecting `~/.claude/` auth | Use `CLAUDE_CODE_OAUTH_TOKEN` |
| No PATH env | Explicit bun + node paths |
| No timeout | `timeout-minutes: 15` |

## Debug Commands

```bash
# Check where claude is
which claude  # /Users/nat/.bun/bin/claude

# Check what it needs
head -1 $(which claude)  # #!/usr/bin/env node

# Get OAuth token
claude setup-token

# Set secret
gh secret set CLAUDE_CODE_OAUTH_TOKEN --body "sk-ant-..."
```

## Result

Async Claude chat via GitHub Actions:
- Trigger from phone/web
- Claude responds + commits to chat.log
- Session persists across runs
- Can spawn subagents for long tasks

## Related

- `.github/workflows/claude-session.yml`
- `ψ/inbox/workflow/chat.log`
- `ψ/writing/drafts/2025-12-15_github-actions-claude-async-chat.md`
