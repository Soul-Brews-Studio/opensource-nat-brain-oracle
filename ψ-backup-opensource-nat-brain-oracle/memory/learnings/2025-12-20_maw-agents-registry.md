# MAW Agents Registry Guide

> Complete documentation for the `maw agents` command and `agents.yaml` registry system

## Overview

The MAW (Multi-Agent Workflow) agents registry is a **YAML-based configuration system** that defines all agents in the system. The `agents.yaml` file serves as the single source of truth for agent configuration, and the `maw agents` command provides CLI operations for managing worktrees based on this registry.

```
.agents/
├── agents.yaml         <- Registry (source of truth)
├── scripts/
│   ├── agents.sh       <- `maw agents` implementation
│   ├── setup.sh        <- Batch creation from registry
│   └── remove.sh       <- Batch removal from registry
└── profiles/           <- Layout configurations
```

---

## The agents.yaml Registry

### Location

```
.agents/agents.yaml
```

### Schema Structure

```yaml
agents:
  <agent_id>:
    branch: <branch_name>           # Git branch name
    worktree_path: <relative_path>  # Path from repo root
    model: <model_type>             # claude | codex
    role: <role_name>               # shadow | executor | specialist
    specialty: <specialty_name>     # Optional: pocketbase, research, etc.
    description: <text>             # Human-readable description
    responsibilities:               # List of task categories
      - <responsibility_1>
      - <responsibility_2>
```

### Example Registry

```yaml
# 6-Agent Architecture Configuration
agents:
  # Tier 2: Tactical Executor
  1:
    branch: agents/1
    worktree_path: agents/1
    model: claude
    role: shadow
    description: Shadow Claude - executes / commands for Agent 0

  # Tier 3: General Execution
  2:
    branch: agents/2
    worktree_path: agents/2
    model: codex
    role: executor
    description: General execution - handles assigned tasks

  # Tier 3: Specialized
  4:
    branch: agents/4
    worktree_path: agents/4
    model: codex
    role: specialist
    specialty: pocketbase
    description: PocketBase specialist - database operations only
```

---

## Agent Naming Conventions

### Agent ID Format

| Pattern | Example | Notes |
|---------|---------|-------|
| Numeric | `1`, `2`, `3` | Standard agents |
| Named | `shadow`, `db` | Role-based naming (less common) |

### Branch Naming

| Pattern | Example | Purpose |
|---------|---------|---------|
| `agents/N` | `agents/1` | Standard agent branch |
| `agents/N-topic` | `agents/1-auth` | Topic-specific work |

**Convention**: Directory and branch should match:
```
agents/1  ->  branch: agents/1
agents/2  ->  branch: agents/2
```

### Worktree Path Validation

The `agents.sh` script enforces a critical validation rule:

```bash
case "$path" in
  agents/*) : ;;
  *) echo "Error: worktree_path '$path' must start with agents/" >&2; exit 1;;
esac
```

**All worktree paths MUST start with `agents/`** - this prevents agents from being created in arbitrary locations.

---

## The maw agents Command

### Command Structure

```bash
maw agents <subcommand> [agent_id]
```

### Available Subcommands

| Command | Usage | Description |
|---------|-------|-------------|
| `list` | `maw agents list` | Show all worktrees and their branches |
| `create` | `maw agents create 3` | Create worktree for agent 3 |
| `remove` | `maw agents remove 3` | Remove worktree for agent 3 |

### List Output

```bash
$ maw agents list
📋 Git worktrees:
/path/to/repo                     927fa15 [main]
/path/to/repo/agents/1            927fa15 [agents/1]
/path/to/repo/agents/2            927fa15 [agents/2]
/path/to/repo/agents/3            927fa15 [agents/3]

📤 Agents under agents/
  agents/1 [agents/1]
  agents/2 [agents/2]
  agents/3 [agents/3]
```

---

## Worktree Creation

### Single Agent Creation

```bash
maw agents create 3
```

This command:
1. Reads `agents.yaml` for agent `3`'s configuration
2. Extracts `branch` and `worktree_path`
3. Creates the branch if it doesn't exist
4. Creates the worktree at the specified path
5. Links the worktree to the branch

### Implementation Details

```bash
create() {
  local agent=${1:?usage: $0 create <agent>}
  local branch path abs_path

  # Read from registry
  branch=$(read_yaml ".agents.$agent.branch")
  path=$(read_yaml ".agents.$agent.worktree_path")

  # Validate path starts with agents/
  case "$path" in
    agents/*) : ;;
    *) echo "Error: worktree_path must start with agents/" >&2; exit 1;;
  esac

  # Create branch if needed
  if ! git rev-parse --verify "$branch" >/dev/null 2>&1; then
    git branch "$branch"
  fi

  # Create worktree
  git worktree add "$abs_path" "$branch"
}
```

### Batch Creation (maw install)

```bash
maw install   # or: maw setup
```

This reads all agents from `agents.yaml` and creates worktrees for each:

```bash
AGENTS=$(yq e '.agents | keys | .[]' "$AGENTS_YAML")

for agent in $AGENTS; do
    "$SCRIPT_DIR/agents.sh" create "$agent"
done
```

---

## Worktree Deletion

### Single Agent Removal

```bash
maw agents remove 3
```

Or using the dedicated remove command:

```bash
maw remove 3
```

### Bulk Removal with Safety

The `remove.sh` script provides advanced options:

```bash
# Dry run - show what would be removed
maw remove --dry-run

# Force removal (ignores uncommitted changes)
maw remove --force

# Remove specific agents
maw remove 4 5

# Remove all agents
maw remove
```

### Dirty Worktree Detection

Before removal, the script checks for uncommitted changes:

```bash
has_uncommitted_changes() {
    local worktree=$1
    local status
    status=$(git -C "$worktree" status --porcelain)
    [ -n "$status" ]
}
```

| Scenario | Without --force | With --force |
|----------|-----------------|--------------|
| Clean worktree | Removed | Removed |
| Dirty worktree | Skipped with warning | Forced removal |

### Branch Cleanup

After worktree removal, the script attempts to delete the associated branch:

```bash
# Safe delete (only if fully merged)
git branch -d agents/3

# Force delete (with --force flag)
git branch -D agents/3
```

---

## Registry Validation

### Dependency: yq

The registry system requires `yq` (YAML processor):

```bash
# Install
brew install yq

# Used for reading agents.yaml
yq e '.agents | keys | .[]' agents.yaml
```

### Path Validation Rules

| Rule | Validation | Error |
|------|------------|-------|
| Path prefix | Must start with `agents/` | `worktree_path must start with agents/` |
| Registry exists | `agents.yaml` must exist | `Missing agents.yaml` |
| Agent defined | Agent key must exist in YAML | `Agent 'X' is not defined in agents.yaml` |

### Pre-Commit Requirements

The `create` function validates repository state:

```bash
if ! git rev-parse --verify HEAD >/dev/null 2>&1; then
    echo "Repository has no commits yet."
    echo "Create an initial commit before running agent setup"
    exit 1
fi
```

---

## Integration with Other MAW Commands

### maw start

Uses worktree list from filesystem (not registry):

```bash
AGENTS=$(ls -d agents/*/ | sed 's#/##')
```

### maw warp

Navigates to agent worktrees:

```bash
maw warp 1    # cd to agents/1
maw warp root # cd to repo root
```

### maw sync

Syncs all worktrees using git rebase:

```bash
maw sync      # Smart sync respecting boundaries
```

### maw hey

Sends messages to agents via their worktrees:

```bash
maw hey 2 "analyze the auth module"
```

---

## Architecture Tiers in agents.yaml

The registry documents the conceptual tiering:

| Tier | Agents | Role | Communication |
|------|--------|------|---------------|
| Tier 1 (Strategic) | 0 (You) | Orchestration | Direct control |
| Tier 2 (Tactical) | 1 | Shadow Claude | Executes / commands |
| Tier 3 (Operational) | 2-5 | Executors | maw hey → Inbox |

### Role Types

| Role | Model | Purpose |
|------|-------|---------|
| `shadow` | claude | Executes slash commands for Agent 0 |
| `executor` | codex | General task execution |
| `specialist` | codex | Domain-specific tasks (DB, research) |

---

## Troubleshooting

### "Agent not defined in agents.yaml"

```bash
# Check what agents are defined
yq e '.agents | keys | .[]' .agents/agents.yaml

# Verify agent exists
yq e '.agents.3' .agents/agents.yaml
```

### "Worktree already exists"

```bash
# Prune stale references
git worktree prune

# Then recreate
maw agents create 3
```

### "Branch already checked out"

```bash
# A branch can only be checked out in ONE worktree
git worktree list | grep "agents/3"

# Remove the conflicting worktree first
git worktree remove agents/3 --force
```

### Missing yq

```bash
# Install yq
brew install yq

# Or on Linux
sudo apt install yq
```

---

## Best Practices

### 1. Registry as Source of Truth

Always modify `agents.yaml` before creating/removing agents:

```bash
# Add agent to yaml first, then create
vim .agents/agents.yaml
maw agents create 6
```

### 2. Consistent Naming

Keep directory, branch, and agent ID aligned:

```yaml
6:
  branch: agents/6
  worktree_path: agents/6
```

### 3. Document Specialties

For specialist agents, document their focus:

```yaml
4:
  role: specialist
  specialty: pocketbase
  description: PocketBase specialist - database operations only
```

### 4. Verify After Changes

```bash
# After creating/removing
maw agents list
git worktree list
```

---

## Quick Reference

| Task | Command |
|------|---------|
| List all agents | `maw agents list` |
| Create agent | `maw agents create N` |
| Remove agent | `maw agents remove N` |
| Batch create | `maw install` |
| Batch remove | `maw remove` |
| Force remove | `maw remove --force` |
| Dry run | `maw remove --dry-run` |

---

## Related Documentation

- `2025-12-20_maw-worktree-setup.md` - Git worktree fundamentals
- `2025-12-17_maw-sync-best-practices.md` - Sync patterns
- `2025-12-13_maw-comprehensive-guide.md` - Full MAW architecture
- `2025-12-20_maw-hey-communication.md` - Inter-agent messaging

---

*Created: 2025-12-20*
*Context: MAW agents registry documentation task*
