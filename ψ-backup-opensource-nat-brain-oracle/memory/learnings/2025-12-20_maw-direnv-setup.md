# MAW direnv Integration Guide

> Automatic environment loading for Multi-Agent Workflows

## What is direnv?

direnv is a shell extension that loads/unloads environment variables based on directory. When you `cd` into a directory with an `.envrc` file, direnv automatically sources it.

**Why MAW uses direnv:**
- Auto-loads the `maw` command when entering repo
- Each agent worktree gets its own environment
- No manual sourcing required
- Clean shell state management

## Installation

```bash
# macOS
brew install direnv

# Add to shell (zsh)
eval "$(direnv hook zsh)"

# Add to shell (bash)
eval "$(direnv hook bash)"
```

## The .envrc File

MAW creates `.envrc` files in:
- Repository root (`/repo/.envrc`)
- Each agent worktree (`/repo/agents/N/.envrc`)

### Root .envrc Structure

```bash
# Key environment variables
export AUTO_START_AGENTS=1       # Enable agent auto-start
export DIRENV_LOG_FORMAT=""      # Silence loading messages

# Directory detection
repo_root="$PWD"
toolkit_dir="$repo_root/.agents"
codex_dir="$codex_root/.codex"
export CODEX_HOME="$codex_dir"

# maw command definition
maw() { ... }

# Aliases
alias maw-start='maw start'
alias maw-attach='maw attach'
alias maw-warp='maw warp'
```

### Agent Worktree .envrc

Each agent worktree gets a copy of the root `.envrc`. This ensures:
- `maw` command works from any worktree
- Consistent environment across all agents
- Shell completion available everywhere

## Environment Variables

| Variable | Purpose | Default |
|----------|---------|---------|
| `AUTO_START_AGENTS` | Enable agent auto-start on `maw start` | `1` |
| `DIRENV_LOG_FORMAT` | Control direnv output verbosity | `""` (silent) |
| `CODEX_HOME` | Codex configuration directory | `$repo_root/.codex` |
| `MAW_REPO_ROOT` | Temporary variable during sourcing | (unset after) |

## The `maw direnv` Command

Runs `direnv allow` in all worktrees at once.

```bash
# Allow direnv in repo root + all agent worktrees
maw direnv
```

### What It Does

1. Checks if direnv is installed
2. Runs `direnv allow` in repository root
3. Copies `.envrc` to agent worktrees if missing
4. Runs `direnv allow` in each agent worktree

### When to Use

- After cloning a new MAW repository
- After creating new agent worktrees with `maw install`
- If direnv prompts "not allowed"
- After modifying `.envrc` files

## Auto-Allow During Start

When running `maw start`, direnv is automatically configured:

```bash
# In start-agents.sh
if command -v direnv >/dev/null 2>&1; then
    # Run direnv-allow.sh before creating session
    "$SCRIPT_DIR/direnv-allow.sh"
fi

# After session creation, broadcast to all panes
direnv_broadcast() {
    for pane_id in $(tmux list-panes -s -t "$session_name" -F '#{pane_id}'); do
        tmux send-keys -t "$pane_id" "direnv allow >/dev/null" C-m
    done
}
```

This ensures every tmux pane has the environment loaded.

## Using direnv exec

Run MAW commands from anywhere without changing directory:

```bash
# Check agents from any location
direnv exec /path/to/repo maw peek

# Sync from anywhere
direnv exec "$ROOT" maw sync
```

### Pattern Comparison

| Approach | Problem |
|----------|---------|
| `cd /repo && maw peek` | Pollutes shell state |
| `source .envrc` | Side effects |
| `direnv exec /repo maw` | Clean, no side effects |

## Troubleshooting

### "direnv: not allowed"

```bash
# Allow the current directory
direnv allow

# Or allow all worktrees
maw direnv
```

### "maw: command not found"

```bash
# Check if .envrc exists
ls -la .envrc

# Check if direnv is hooked
which direnv
eval "$(direnv hook zsh)"
```

### Silent Loading

If direnv messages are noisy:

```bash
# Add to .envrc
export DIRENV_LOG_FORMAT=""
```

### Environment Not Loading in tmux

Ensure your shell config loads direnv hook:

```bash
# ~/.zshrc or ~/.bashrc (must be before tmux starts)
eval "$(direnv hook zsh)"
```

## Best Practices

1. **Run `maw direnv` after setup** - Ensures all worktrees are allowed
2. **Keep DIRENV_LOG_FORMAT empty** - Reduces tmux pane noise
3. **Don't commit .envrc to worktrees** - They're in .gitignore
4. **Use `direnv exec` for cross-worktree commands** - Respects boundaries

## Integration Points

```
┌─────────────────────────────────────────────────────┐
│                    Shell Session                     │
├─────────────────────────────────────────────────────┤
│  direnv hook ──────────────────────────────────┐    │
│       │                                         │    │
│       ▼                                         │    │
│  cd /repo ─────► .envrc sourced ─────► maw()   │    │
│       │                                         │    │
│       ▼                                         │    │
│  cd agents/1 ──► .envrc sourced ─────► maw()   │    │
│                                                 │    │
│  direnv exec /repo maw peek ◄──────────────────┘    │
└─────────────────────────────────────────────────────┘
```

---

*Created: 2025-12-20*
*Related: [direnv-exec-pattern](2025-12-17_direnv-exec-pattern.md)*
