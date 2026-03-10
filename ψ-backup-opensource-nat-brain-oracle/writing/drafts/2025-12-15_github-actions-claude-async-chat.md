# GitHub Actions + Claude Code: Technical Deep Dive

**Created**: 2025-12-15 17:28 GMT+7 | **Updated**: 18:11
**Status**: Draft
**Author**: Nat + Claude (Opus 4.5)

---

## TL;DR

Running `claude --print -p` in GitHub Actions self-hosted runner requires: OAuth token, explicit PATH, and `--resume` (not `--session-id`) for persistent context.

---

## Part 1: Self-Hosted Runner Architecture

### How GitHub Actions Runner Works

```
┌─────────────────────────────────────────────────────────────┐
│                    GitHub Actions                           │
│  workflow_dispatch → Queue Job → Find Runner                │
└─────────────────────┬───────────────────────────────────────┘
                      │
                      ▼
┌─────────────────────────────────────────────────────────────┐
│              Self-Hosted Runner (launchd service)           │
│                                                             │
│  ~/actions-runner/                                          │
│  ├── config.sh      # Configure runner                      │
│  ├── svc.sh         # Service management                    │
│  ├── runsvc.sh      # Service entry point                   │
│  └── _work/         # Job working directory                 │
│       └── Nat-s-Agents/                                     │
│            └── Nat-s-Agents/  # Checked out repo            │
└─────────────────────────────────────────────────────────────┘
```

### Runner Installation

```bash
# Download runner
mkdir ~/actions-runner && cd ~/actions-runner
curl -o actions-runner.tar.gz -L https://github.com/actions/runner/releases/download/v2.329.0/actions-runner-osx-arm64-2.329.0.tar.gz
tar xzf actions-runner.tar.gz

# Configure for organization
./config.sh --url https://github.com/laris-co --token YOUR_TOKEN

# Add custom label
# When prompted: "Enter any additional labels: mbanat"

# Install as launchd service
./svc.sh install
./svc.sh start
```

### Runner as launchd Service

The runner runs as a **launchd service**, NOT a shell process:

```bash
# Check service status
./svc.sh status
# Output: Started: 59182 0 actions.runner.laris-co.mbanat

# Service plist location
cat ~/Library/LaunchAgents/actions.runner.laris-co.mbanat.plist
```

**Critical implication**: launchd services have **minimal environment**:
- No shell profile (`.zshrc`, `.bashrc`)
- No PATH inheritance
- No environment variables from interactive shell

---

## Part 2: The PATH Problem

### What Runner Sees

```yaml
# This fails:
run: claude --print -p "hello"
# Error: claude: command not found
```

**Why?** Runner's default PATH:
```
/usr/bin:/bin:/usr/sbin:/sbin
```

Your shell PATH (interactive):
```
/Users/nat/.bun/bin:/Users/nat/.nvm/versions/node/v22/bin:/opt/homebrew/bin:...
```

### Solution: Explicit PATH

```yaml
env:
  PATH: /Users/nat/.bun/bin:/Users/nat/.nvm/versions/node/v22.20.0/bin:/opt/homebrew/bin:/usr/bin:/bin
```

### Finding Your Paths

```bash
# Where is claude?
which claude
# /Users/nat/.bun/bin/claude

# Claude's shebang (what runtime it needs)
head -1 $(which claude)
# #!/usr/bin/env node

# Where is node?
which node
# /Users/nat/.nvm/versions/node/v22.20.0/bin/node
```

**Both paths required**: bun (claude binary) + nvm (node runtime)

---

## Part 3: Authentication

### The HOME Override Problem

GitHub Actions `checkout@v4` **overrides HOME**:

```
Post job cleanup.
Temporarily overriding HOME='/Users/nat/actions-runner/_work/_temp/xxx'
```

**Why?** Git config isolation — prevents workflow from affecting user's git config.

**Impact**: Claude looks for auth in `~/.claude/` but `~` resolves to temp dir.

### Auth Methods Comparison

| Method | Location | Works in Runner? |
|--------|----------|------------------|
| Interactive login | `~/.claude/` (OAuth in Keychain) | NO (HOME overridden) |
| `ANTHROPIC_API_KEY` | Environment variable | YES (but uses API credits) |
| `CLAUDE_CODE_OAUTH_TOKEN` | Environment variable | YES (uses Claude subscription) |

### Getting OAuth Token

```bash
claude setup-token
# Opens browser → Authenticate → Returns token

# Output:
# Your OAuth token (valid for 1 year):
# sk-ant-oat01-XXXX...
#
# Use this token by setting: export CLAUDE_CODE_OAUTH_TOKEN=<token>
```

### Setting GitHub Secret

```bash
# Via CLI
gh secret set CLAUDE_CODE_OAUTH_TOKEN --repo org/repo --body "sk-ant-oat01-..."

# Or via UI
# https://github.com/org/repo/settings/secrets/actions/new
```

---

## Part 4: Claude CLI Print Mode

### Basic Usage

```bash
claude --print -p "your prompt"
#       │       │
#       │       └── prompt (required with --print)
#       └── non-interactive mode, output to stdout
```

### Key Flags

| Flag | Purpose | Example |
|------|---------|---------|
| `-p, --print` | Non-interactive, stdout output | `claude --print -p "hello"` |
| `--output-format` | Response format | `--output-format json` |
| `--session-id <uuid>` | Use specific session | `--session-id abc-123` |
| `-r, --resume [id]` | Resume existing session | `--resume abc-123` |
| `-c, --continue` | Continue most recent | `claude -c -p "..."` |
| `--dangerously-skip-permissions` | No permission prompts | For sandboxed envs |

### Print Mode Behavior

```bash
# Single prompt, single response, exit
claude --print -p "what is 2+2"
# Output: 4

# With JSON output
claude --print --output-format json -p "what is 2+2"
# Output: {"result": "4", ...}

# Capture in variable
RESPONSE=$(claude --print -p "hello")
echo "$RESPONSE"
```

---

## Part 5: Session Management

### Session Storage Structure

```
~/.claude/
├── projects/
│   ├── -Users-nat-project-a/
│   │   ├── session-1.jsonl     # Conversation history
│   │   └── session-2.jsonl
│   └── -Users-nat-project-b/
│       └── session-3.jsonl
├── settings.json
└── history.jsonl
```

**Key insight**: Sessions are **project-specific** (tied to working directory path).

### --session-id vs --resume

| Flag | Behavior | Use Case |
|------|----------|----------|
| `--session-id UUID` | Create OR attach to session | New sessions |
| `--resume UUID` | Resume existing session | Continue conversation |
| `--continue` | Resume most recent | Quick continuation |

### The Lock Problem

```bash
# Terminal 1: Start session
claude --session-id abc-123
# Session active...

# Terminal 2: Try to use same session
claude --print --session-id abc-123 -p "hello"
# Error: Session ID abc-123 is already in use.
```

**`--session-id` locks** the session while active.

### Solution: Use --resume

```bash
# --resume doesn't lock, just loads history
claude --print --resume abc-123 -p "hello"
# Works even if session was used before
```

### Workflow Pattern

```yaml
inputs:
  session_id:
    default: 'f9fa423c-5bb8-4f01-a81b-b530c1d4b6d4'

run: |
  # Use --resume to continue session without locking
  claude --print --resume "${{ inputs.session_id }}" -p "${{ inputs.prompt }}"
```

**Result**: Each workflow run continues the conversation, Claude remembers context.

---

## Part 6: Complete Working Workflow

```yaml
name: Claude Code Session

on:
  workflow_dispatch:
    inputs:
      prompt:
        description: 'Prompt to send to Claude'
        required: true
        type: string
      session_id:
        description: 'Session ID (leave empty for default)'
        required: false
        type: string
        default: 'f9fa423c-5bb8-4f01-a81b-b530c1d4b6d4'

jobs:
  claude-session:
    runs-on: [self-hosted, mbanat]  # Custom label for your runner

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run Claude Code
        env:
          # Auth via OAuth token (1 year validity)
          CLAUDE_CODE_OAUTH_TOKEN: ${{ secrets.CLAUDE_CODE_OAUTH_TOKEN }}
          # Explicit PATH for bun + node
          PATH: /Users/nat/.bun/bin:/Users/nat/.nvm/versions/node/v22.20.0/bin:/opt/homebrew/bin:/usr/bin:/bin
        run: |
          # Chat log for audit trail
          LOG="chat.log"

          # Log prompt
          echo "---" >> "$LOG"
          echo "TIME: $(date '+%Y-%m-%d %H:%M:%S')" >> "$LOG"
          echo "PROMPT: ${{ inputs.prompt }}" >> "$LOG"

          # Run Claude with --resume (not --session-id)
          RESPONSE=$(claude --print --resume "${{ inputs.session_id }}" -p "${{ inputs.prompt }}")

          # Log response
          echo "RESPONSE: $RESPONSE" >> "$LOG"

          # Commit chat log
          git config user.name "Claude Workflow"
          git config user.email "claude@workflow.local"
          git add "$LOG"
          git commit -m "chat: workflow response" || true
          git push || true

          # Output response
          echo "$RESPONSE"
```

---

## Part 7: Debugging Reference

### Common Errors

| Error | Cause | Fix |
|-------|-------|-----|
| `command not found` | Missing PATH | Add bun/node paths |
| `node: No such file` | Missing node in PATH | Add nvm node path |
| `Invalid API key` | No auth token | Set `CLAUDE_CODE_OAUTH_TOKEN` |
| `Session already in use` | Using `--session-id` | Use `--resume` instead |
| `Permission denied` | Runner user mismatch | Check runner user |

### Debug Commands

```bash
# Check runner environment
gh workflow run debug.yml -f command="env | sort"

# Check PATH resolution
gh workflow run debug.yml -f command="which claude && which node"

# Check Claude version
gh workflow run debug.yml -f command="claude --version"

# Test auth
gh workflow run debug.yml -f command="claude --print -p 'hello'"
```

### Session Debugging

```bash
# List all sessions for a project
ls ~/.claude/projects/-Users-nat-Code-*/

# Read session history
cat ~/.claude/projects/-Users-nat-Code-*/session-id.jsonl | jq .

# Find session by content
grep -r "your search term" ~/.claude/projects/
```

---

## Quick Reference

### Environment Variables

| Variable | Purpose | Source |
|----------|---------|--------|
| `CLAUDE_CODE_OAUTH_TOKEN` | OAuth auth (Claude Max) | `claude setup-token` |
| `ANTHROPIC_API_KEY` | API key auth (credits) | console.anthropic.com |
| `PATH` | Binary locations | Your shell config |
| `HOME` | Home directory | Usually `/Users/you` |

### CLI Flags Summary

```bash
# Non-interactive mode
claude --print -p "prompt"

# With session context
claude --print --resume UUID -p "prompt"

# JSON output
claude --print --output-format json -p "prompt"

# Skip permissions (sandboxed)
claude --print --dangerously-skip-permissions -p "prompt"
```

### Workflow Checklist

- [ ] Self-hosted runner installed and running
- [ ] Runner has custom label (`runs-on: [self-hosted, label]`)
- [ ] `CLAUDE_CODE_OAUTH_TOKEN` secret set
- [ ] PATH includes bun and node directories
- [ ] Using `--resume` not `--session-id`
- [ ] Session ID is UUID format

---

## Tags

`github-actions` `claude-code` `self-hosted-runner` `cli` `devops` `session-management`
