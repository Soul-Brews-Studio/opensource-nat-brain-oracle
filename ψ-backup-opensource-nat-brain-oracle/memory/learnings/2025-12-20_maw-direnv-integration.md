# MAW direnv Integration

> How Multi-Agent Workflow uses direnv for environment setup across worktrees

**Date**: 2025-12-20
**Category**: Infrastructure
**Status**: Active

---

## Overview

MAW uses [direnv](https://direnv.net/) to automatically load environment variables and shell functions when entering any agent worktree. This ensures each agent has access to the `maw` command and consistent configuration without manual setup.

---

## The Problem direnv Solves

Without direnv, each tmux pane would need manual setup:

```bash
# Without direnv - manual every time
cd agents/1
source .envrc  # or manually export vars
maw hey 2 "hello"  # finally works
```

With direnv, entering the directory automatically loads everything:

```bash
# With direnv - automatic
cd agents/1
# .envrc auto-loaded
maw hey 2 "hello"  # just works
```

---

## Architecture

### File Structure

```
repo/
├── .envrc                    # Root environment (MAW functions)
├── .agents/
│   ├── maw.env.sh           # MAW function definitions
│   └── scripts/
│       └── direnv-allow.sh  # Bulk allow script
└── agents/
    ├── 1/.envrc             # Copied from root
    ├── 2/.envrc             # Copied from root
    └── 3/.envrc             # Copied from root
```

### How .envrc Works

The `.envrc` file is the entry point for direnv. It:

1. **Detects worktree context** - Uses `git rev-parse --git-common-dir` to find the primary repo
2. **Resolves CODEX_HOME** - Shared across all worktrees for auth/state
3. **Sources maw.env.sh** - Loads all MAW functions and aliases
4. **Sets up PATH** - Adds `.agents/scripts` to PATH
5. **Loads completions** - Tab completion for both zsh and bash

```bash
# Key lines from .envrc
codex_root="$repo_root"
if git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null); then
  codex_root=$(cd "$git_common_dir/.." && pwd)
fi

export CODEX_HOME="$codex_dir"

maw_env="$toolkit_dir/maw.env.sh"
source "$maw_env"
```

---

## direnv-allow.sh Deep Dive

**Location**: `.agents/scripts/direnv-allow.sh`

### Purpose

The script runs `direnv allow` in the repository root and all agent worktrees. This is required because direnv blocks untrusted `.envrc` files by default.

### Script Flow

```
1. Check direnv is installed
   └── Exit with error if not found

2. Allow in repo root
   ├── Check for .envrc
   └── Run: direnv allow "$REPO_ROOT"

3. Iterate agent worktrees
   ├── Check agents/ directory exists
   └── For each agent:
       ├── Copy .envrc from root if missing
       └── Run: direnv allow "$agent_dir"

4. Report summary
   └── Count of configured worktrees
```

### Key Features

**Auto-copy .envrc to worktrees**:
```bash
# If agent doesn't have .envrc but root does, copy it
if [ ! -f "$agent_dir/.envrc" ] && [ -f "$REPO_ROOT/.envrc" ]; then
    cp "$REPO_ROOT/.envrc" "$agent_dir/.envrc"
    echo "   Copied .envrc from repo root"
fi
```

**Graceful handling**:
- Skips directories without `.envrc`
- Counts successful configurations
- Provides next step guidance

---

## Integration Points

### 1. maw direnv Command

Exposed as a MAW subcommand for manual use:

```bash
maw direnv
```

**Definition in maw.env.sh**:
```bash
case "$subcommand" in
    direnv)
      __maw_exec direnv-allow.sh "$@"
      ;;
esac
```

### 2. Automatic on maw start

When starting agents with `maw start`, direnv is configured automatically:

```bash
# From start-agents.sh
if command -v direnv >/dev/null 2>&1 && [ "${SKIP_DIRENV_ALLOW:-}" != "1" ]; then
    DIRENV_SCRIPT="$SCRIPT_DIR/direnv-allow.sh"
    if [ -f "$DIRENV_SCRIPT" ]; then
        "$DIRENV_SCRIPT" || true
    fi
fi
```

### 3. direnv_broadcast Function

After tmux session creation, runs `direnv allow` in each pane:

```bash
direnv_broadcast() {
    local panes
    panes=$(tmux list-panes -s -t "$SESSION_NAME" -F "#{pane_id}")

    while IFS= read -r pane_id; do
        tmux send-keys -t "$pane_id" "direnv allow >/dev/null" C-m
    done <<<"$panes"
}
```

This ensures each pane trusts its directory's `.envrc` after the tmux session starts.

### 4. Setup Script Check

During `maw install`, the setup script verifies direnv:

```bash
# From setup.sh
if ! command -v direnv &> /dev/null; then
    echo "direnv not found. Install it for automatic config loading:"
    echo "   brew install direnv"
else
    echo "direnv installed"
    if [ -f ".envrc" ]; then
        echo "Run 'direnv allow' to enable project config auto-loading"
    fi
fi
```

---

## Worktree-Aware Design

### Shared State via git-common-dir

All worktrees share authentication and state by resolving the primary repo:

```bash
# .envrc uses git to find the real repo root
if git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null); then
  codex_root_candidate=$(cd "$git_common_dir/.." && pwd)
fi
```

This means:
- Agent 1, 2, 3 all use the same CODEX_HOME
- Claude Code auth is shared
- No need to re-authenticate per worktree

### PATH Resolution

Scripts directory is added to PATH for direct script access:

```bash
if command -v PATH_add >/dev/null 2>&1; then
  PATH_add "$maw_path_dir"  # direnv's helper
elif [[ :$PATH: != *":$maw_path_dir:"* ]]; then
  export PATH="$maw_path_dir:$PATH"  # fallback
fi
```

---

## Skip Mechanism

For debugging or special cases, direnv setup can be skipped:

```bash
SKIP_DIRENV_ALLOW=1 maw start profile0
```

This environment variable:
- Skips `direnv-allow.sh` on startup
- Skips `direnv_broadcast()` in tmux panes

---

## Troubleshooting

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| `maw: command not found` | .envrc not allowed | `maw direnv` or `direnv allow` |
| direnv not loading | Shell hook missing | Add `eval "$(direnv hook zsh)"` to .zshrc |
| Stale environment | .envrc changed | `direnv reload` |
| Permission denied | New .envrc | `direnv allow` |

### Debug Commands

```bash
# Check if direnv is active
echo $DIRENV_FILE

# Check direnv status for directory
direnv status

# Manually reload
direnv reload

# Check what would be loaded
direnv export bash
```

---

## Best Practices

### 1. Run direnv Before tmux

Always run `maw direnv` before `maw start` if you've made changes:

```bash
# After modifying .envrc
maw direnv
maw start profile0
```

### 2. Keep .envrc in Sync

When updating root `.envrc`, propagate to worktrees:

```bash
# Manual sync (direnv-allow.sh does this)
for d in agents/*; do
  cp .envrc "$d/.envrc"
  direnv allow "$d"
done
```

### 3. Don't Commit Agent .envrc

Agent worktree `.envrc` files should match root. The copy is automatic.

---

## Shell Completion Integration

direnv enables shell completions for `maw`:

**Zsh**:
```bash
if [[ -f "$toolkit_dir/maw.completion.zsh" ]]; then
  fpath=("$toolkit_dir" $fpath)
  source "$toolkit_dir/maw.completion.zsh"
  compdef _maw maw
fi
```

**Bash**:
```bash
if [[ -f "$completion_file" ]]; then
  source "$completion_file"
fi
```

---

## Summary

| Component | Purpose |
|-----------|---------|
| `.envrc` | Entry point for direnv, loads MAW |
| `maw.env.sh` | MAW function definitions |
| `direnv-allow.sh` | Bulk allow script for all worktrees |
| `direnv_broadcast()` | Post-tmux setup in each pane |
| `SKIP_DIRENV_ALLOW` | Bypass mechanism for debugging |

direnv is the glue that makes `maw` "just work" in every terminal, every agent, every worktree - without manual configuration.

---

**Related Learnings**:
- `2025-12-17_maw-sync-best-practices.md` - Worktree coordination
- `.agents/README.md` - Full MAW documentation
