# Self-Hosted Runner Uses Local Auth

**Date**: 2025-12-15
**Source**: Session — GitHub Actions runner setup
**Category**: DevOps Pattern

## The Pattern

Self-hosted runner on your own machine = uses YOUR local credentials.

No need for API keys in secrets!

```yaml
# Wrong (unnecessary)
env:
  ANTHROPIC_API_KEY: ${{ secrets.ANTHROPIC_API_KEY }}

# Right (uses local auth)
run: |
  claude --print -p "hello"
```

## Why It Works

| Runner Type | Auth Source |
|-------------|-------------|
| GitHub-hosted | Need secrets (fresh VM each time) |
| Self-hosted (MBA) | Uses `~/.claude/` local auth |

## Setup Summary

```bash
# 1. Get token from GitHub org settings
# https://github.com/organizations/laris-co/settings/actions/runners/new

# 2. Configure with custom name + label
cd ~/actions-runner
./config.sh --url https://github.com/laris-co \
  --token YOUR_TOKEN \
  --name mbanat \
  --labels mbanat \
  --unattended

# 3. Install as service (auto-start on login)
./svc.sh install && ./svc.sh start
```

## Workflow Example

```yaml
jobs:
  claude-session:
    runs-on: [self-hosted, mbanat]
    steps:
      - uses: actions/checkout@v4
      - run: claude --print --session-id "${{ inputs.session_id }}" -p "${{ inputs.prompt }}"
```

## Key Points

- `RunAtLoad = true` → auto-starts on MBA login
- Session files in `~/.claude/projects/` persist across runs
- Same Claude account, same subscription, no extra cost

## Related

- `.github/workflows/claude-session.yml`
- Runner: `mbanat` on laris-co org
