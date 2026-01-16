# MAW Profiles Guide

> Configuring tmux layouts for multi-agent workflows

**Created**: 2025-12-20
**Category**: MAW System Documentation
**Status**: Complete

---

## Overview

MAW profiles are shell scripts that configure tmux window and pane layouts for multi-agent sessions. Each profile defines how agents are arranged spatially, enabling different workflows:

- **Focused work**: 2-3 panes for deep tasks
- **Parallel execution**: 6+ panes for simultaneous agents
- **Hybrid**: Multiple windows with different layouts

Profiles live in `.agents/profiles/` and are loaded by `start-agents.sh`.

---

## Profile Anatomy

Every profile is a bash script that sets configuration variables:

```bash
#!/bin/bash
# Profile N: Description of layout

# Layout type (determines which branch in start-agents.sh)
LAYOUT_TYPE="grid-3x2"

# Dimension variables (vary by layout type)
GRID_ROWS=2
GRID_COLS=3
GRID_TOP_HEIGHT=50
GRID_COL_WIDTH=33

# This profile is sourced by start-agents.sh
```

The profile is **sourced** (not executed), so variables become available in start-agents.sh.

---

## LAYOUT_TYPE Reference

The core variable. Determines which tmux split logic runs.

| LAYOUT_TYPE | Description | Panes | Best For |
|-------------|-------------|-------|----------|
| `two-pane` | Two side-by-side | 2 | Pair work |
| `two-pane-bottom-right` | Root left, agent right | 2 | Monitor + work |
| `three-pane` | Left split, right full | 3 | Lead + support |
| `three-horizontal` | Three stacked vertically | 3 | Parallel tasks |
| `three-horizontal-ws` | Three horizontal + workspace window | 3+1 | Focused parallel |
| `top-full` | Top wide, bottom split | 3 | Leader + workers |
| `full-left` | Left full, right stacked | 4 | Deep + shallow |
| `six-pane` | Custom 6-pane arrangement | 6 | Full team |
| `six-horizontal` | 6 horizontal stacked | 6 | Wide displays |
| `six-horizontal-2win` | 3+3 across two windows | 6 | Semantic tiers |
| `grid-2x3` | 2 rows × 3 columns | 6 | Balanced grid |
| `grid-3x2` | 3 columns × 2 rows | 6 | Standard grid |
| `grid-3x2-full` | Full 6-agent grid | 6 | All agents visible |
| `window-1x3` | Window 1: 3 horizontal | 3+1 | Agents + workspace |
| `window-3x1` | Window 1: workspace, Window 2: 3 agents | 1+3 | Workspace first |
| `window-2-pane-3` | Two windows, 3 panes total | varies | Custom multi-window |

---

## Configuration Variables

### Size Variables

```bash
# Column/row percentages
RIGHT_WIDTH=30          # Right column width (%)
BOTTOM_HEIGHT=30        # Bottom row height (%)
TOP_RIGHT_HEIGHT=90     # Top-right pane height (%)

# Grid dimensions
GRID_ROWS=2             # Number of rows
GRID_COLS=3             # Number of columns
GRID_TOP_HEIGHT=50      # Top row height (%)
GRID_COL_WIDTH=33       # Each column width (%)
```

### Window Variables

```bash
# Multi-window layouts
WINDOW_COUNT=2          # Number of tmux windows
PANES_WINDOW_0=3        # Panes in first window
PANES_WINDOW_1=3        # Panes in second window
```

---

## Existing Profiles

### Simple Layouts (2-4 panes)

| Profile | Type | Use Case |
|---------|------|----------|
| `profile2` | 2×2 grid | Quick parallel work |
| `profile3` | top-full | Leader + workers |
| `profile4` | three-pane | Deep work with support |

### Horizontal Stacked (3 panes)

| Profile | Type | Use Case |
|---------|------|----------|
| `profile0` | three-horizontal | Default, 3 agents stacked |
| `profile1` | full-left | Deep left, support right |

### Six-Agent Layouts

| Profile | Type | Use Case |
|---------|------|----------|
| `profile5` | six-pane | Custom 6-pane |
| `profile6` | grid-3x2 | 3×2 grid layout |
| `profile6-grid` | grid-3x2 | Detailed grid docs |
| `profile7` | grid-3x2-full | Full 6-agent grid |
| `profile10` | grid-2x3 | 2×3 equal grid |

### Multi-Window Layouts

| Profile | Type | Use Case |
|---------|------|----------|
| `profile11` | window-1x3 | 3 agents + workspace |
| `profile12` | window-3x1 | Workspace first, agents second |
| `profile13` | three-horizontal-ws | 3 horizontal + workspace |
| `profile14` | six-horizontal-2win | 3+3 in two windows |

---

## How start-agents.sh Consumes Profiles

```bash
# 1. Parse command line
PROFILE="$1"  # e.g., "profile6"

# 2. Source the profile file
PROFILE_FILE="$PROFILES_DIR/${PROFILE}.sh"
source "$PROFILE_FILE"

# 3. Branch on LAYOUT_TYPE
if [ "$LAYOUT_TYPE" = "grid-3x2" ]; then
    # Create 3x2 grid splits
elif [ "$LAYOUT_TYPE" = "three-horizontal" ]; then
    # Create 3 horizontal splits
# ... more branches
fi

# 4. Auto-warp panes to agent directories
for pane in $PANES; do
    tmux send-keys -t "$SESSION:0.$pane" "maw warp $agent" Enter
done
```

---

## Creating a New Profile

### Step 1: Choose Layout Type

Pick an existing `LAYOUT_TYPE` or create a new one (requires modifying start-agents.sh).

### Step 2: Create Profile File

```bash
#!/bin/bash
# Profile N: Your Description
#
# ASCII diagram of layout:
# ┌──────────┬──────────┐
# │  Pane 0  │  Pane 1  │
# ├──────────┼──────────┤
# │  Pane 2  │  Pane 3  │
# └──────────┴──────────┘

LAYOUT_TYPE="grid-2x2"  # or existing type

# Dimension variables
GRID_ROWS=2
GRID_COLS=2
GRID_TOP_HEIGHT=50
GRID_COL_WIDTH=50

# This profile is sourced by start-agents.sh
# Used with: .agents/scripts/start-agents.sh profileN
```

### Step 3: Test It

```bash
.agents/scripts/start-agents.sh profileN
```

### Step 4: Document Navigation

Always include navigation hints:
```bash
# Navigation:
# - Ctrl+b ← → ↑ ↓ (arrow keys to move)
# - Ctrl+b z (zoom current pane)
# - Ctrl+b n/p (next/previous window)
```

---

## Adding New LAYOUT_TYPE

If no existing type fits, add a new branch to start-agents.sh:

```bash
elif [ "$LAYOUT_TYPE" = "my-custom" ]; then
    # Create initial pane
    tmux split-window -h -p 50 -t "$SESSION:0.0"
    # Split again
    tmux split-window -v -p 50 -t "$SESSION:0.0"
    # ... more splits

    PANE_COUNT=3
fi
```

The tmux split commands:
- `-h`: horizontal split (left/right)
- `-v`: vertical split (top/bottom)
- `-p N`: percentage size
- `-t TARGET`: which pane to split

---

## Best Practices

### 1. Always Include ASCII Diagram

```bash
# ┌──────────────┬──────────────┐
# │ Agent 1      │ Agent 2      │
# │ 50%          │ 50%          │
# └──────────────┴──────────────┘
```

Visual documentation prevents confusion.

### 2. Document Pane Assignments

```bash
# Pane 0: Top-left (Agent 1)
# Pane 1: Top-right (Agent 2)
# Pane 2: Bottom-left (Agent 3)
```

Clarifies which agent goes where.

### 3. Include Navigation Tips

Help users navigate the layout.

### 4. Name Profiles Semantically

Consider aliases or descriptive names:
- `profile-grid-2x3` instead of `profile10`
- `profile-parallel-3` instead of `profile0`

### 5. Test on Target Display

Profiles work differently on:
- Wide monitors (ultrawide: 32:9)
- Standard monitors (16:9)
- Split screen scenarios

---

## Common Patterns

### Pattern: Grid Layout

Equal-sized cells for parallel agents.

```bash
LAYOUT_TYPE="grid-2x3"
GRID_ROWS=2
GRID_COLS=3
GRID_TOP_HEIGHT=50
GRID_COL_WIDTH=33
```

### Pattern: Leader + Workers

One large pane for lead, smaller panes for workers.

```bash
LAYOUT_TYPE="full-left"
RIGHT_WIDTH=30  # Workers get 30%
```

### Pattern: Multi-Window Tiers

Semantic separation across windows.

```bash
LAYOUT_TYPE="six-horizontal-2win"
# Window 0: Primary agents (1-3)
# Window 1: Specialist agents (4-6)
```

---

## Troubleshooting

### Profile Not Found

```
⚠️  Profile 'profileX' not found, using defaults
```

Check file exists at `.agents/profiles/profileX.sh`.

### Panes Don't Match Expected

Verify:
1. `LAYOUT_TYPE` matches start-agents.sh case
2. Dimension variables are correct
3. Enough agents exist (check `agents/` directory)

### Agents Not Auto-Warping

The `maw warp` command may fail if:
- Agent worktree doesn't exist
- Wrong directory structure

---

## Quick Reference

```bash
# Start with specific profile
.agents/scripts/start-agents.sh profile6

# Start detached
.agents/scripts/start-agents.sh profile6 --detach

# Check available profiles
ls .agents/profiles/

# See profile contents
cat .agents/profiles/profile6.sh
```

---

## Related Documentation

- `ψ/memory/learnings/2025-12-20_maw-hey-instruction.md` - Agent communication
- `ψ/memory/learnings/2025-12-17_maw-sync-best-practices.md` - Sync patterns
- `ψ/memory/learnings/2025-12-20_maw-tag-checkpoint-pattern.md` - Rollback safety

---

*Profile configuration determines how your multi-agent workspace looks and feels. Choose layouts that match your workflow—deep focus, parallel execution, or hybrid approaches.*
