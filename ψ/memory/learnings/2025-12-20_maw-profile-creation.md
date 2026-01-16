# MAW Profile Creation Guide

> Step-by-step guide to creating custom tmux layouts for multi-agent workflows

**Created**: 2025-12-20
**Category**: MAW System Documentation
**Status**: Complete

---

## Overview

MAW profiles define how tmux panes are arranged for multi-agent sessions. This guide covers the complete process of creating custom profiles, from choosing a layout type to mapping agents to panes.

**Location**: `.agents/profiles/profileN.sh`
**Consumer**: `.agents/scripts/start-agents.sh`

---

## Profile Anatomy

Every profile is a bash script that defines configuration variables:

```bash
#!/bin/bash
# Profile N: Description of your layout
#
# ASCII diagram showing pane arrangement:
# ┌──────────┬──────────┐
# │  Pane 0  │  Pane 1  │
# └──────────┴──────────┘

# Required: Layout type (must match a case in start-agents.sh)
LAYOUT_TYPE="your-layout-type"

# Optional: Dimension variables (depend on layout type)
RIGHT_WIDTH=30
BOTTOM_HEIGHT=50

# This profile is sourced by start-agents.sh
```

**Key points**:
- Profiles are **sourced** (not executed), so variables become available to start-agents.sh
- The `LAYOUT_TYPE` determines which branch of tmux logic runs
- Dimension variables are optional and have sensible defaults

---

## Step 1: Choose Layout Type

### Built-in Layout Types

| LAYOUT_TYPE | Panes | Windows | Description |
|-------------|-------|---------|-------------|
| `two-pane` | 2 | 1 | Top/bottom split |
| `two-pane-bottom-right` | 3 | 1 | Top + bottom split horizontally |
| `three-pane` | 3 | 1 | Left full + right stacked |
| `three-horizontal` | 3 | 1 | Three side-by-side columns |
| `three-horizontal-ws` | 3+1 | 2 | Three horizontal + workspace window |
| `top-full` | 3 | 1 | Top wide + bottom split |
| `full-left` | 3 | 1 | Left full + right stacked |
| `six-pane` | 6 | 1 | Custom 6-pane arrangement |
| `six-horizontal` | 6 | 1 | Six side-by-side columns |
| `six-horizontal-2win` | 6 | 2 | 3+3 across two windows |
| `grid-2x3` | 6 | 1 | 2 rows × 3 columns |
| `grid-3x2` | 6 | 1 | 3 columns × 2 rows |
| `grid-3x2-full` | 6 | 1 | 3×2 with monitor pane |
| `window-1x3` | 3+1 | 2 | 3 agents + workspace window |
| `window-3x1` | 1+3 | 2 | Workspace first, agents second |
| `window-2-pane-3` | 6 | 2 | Two windows, 3 panes each |

### Choosing the Right Type

| Use Case | Recommended Type |
|----------|------------------|
| Pair programming | `two-pane` |
| Lead + support agents | `full-left` or `top-full` |
| 3 parallel agents | `three-horizontal` |
| 6 agents visible | `grid-3x2` or `grid-2x3` |
| Semantic tiers | `six-horizontal-2win` |
| Deep focus + workspace | `window-1x3` |

---

## Step 2: Create the Profile File

### Template

```bash
#!/bin/bash
# Profile N: Your Description
#
# [Required ASCII diagram - helps users understand layout]
# ┌──────────┬──────────┬──────────┐
# │  Agent 1 │  Agent 2 │  Agent 3 │
# │  (33%)   │  (33%)   │  (33%)   │
# └──────────┴──────────┴──────────┘
#
# Navigation:
# - Ctrl+b ← → ↑ ↓ (move between panes)
# - Ctrl+b z (zoom current pane)
# - Ctrl+b n/p (next/previous window)

LAYOUT_TYPE="three-horizontal"

# Dimension variables (optional, have defaults)
CENTER_WIDTH=66    # First split: left 34%, right 66%
RIGHT_WIDTH=50     # Second split: center 50%, right 50%

# This profile is sourced by start-agents.sh
# Used with: .agents/scripts/start-agents.sh profileN
```

### File Naming Convention

```
.agents/profiles/
├── profile0.sh       # Numbered profiles (0-14+)
├── profile6-grid.sh  # Variant with descriptor
└── profile-custom.sh # Custom descriptive name
```

---

## Step 3: Configure Pane Dimensions

### Size Variables by Layout Type

#### Horizontal Layouts (three-horizontal, six-horizontal)

```bash
CENTER_WIDTH=66   # First split percentage (remaining becomes left pane)
RIGHT_WIDTH=50    # Second split percentage of the right portion
```

**Calculation for 3 equal columns**:
- First split: 66% right (leaves 34% left)
- Second split: 50% of 66% = 33% each for center and right
- Result: 34% | 33% | 33%

#### Vertical Layouts (two-pane, top-full)

```bash
BOTTOM_HEIGHT=30  # Bottom row percentage
TOP_HEIGHT=70     # Implied (100 - BOTTOM_HEIGHT)
```

#### Grid Layouts (grid-3x2, grid-2x3)

```bash
GRID_ROWS=2           # Number of rows
GRID_COLS=3           # Number of columns
GRID_TOP_HEIGHT=50    # Top row height percentage
GRID_COL_WIDTH=33     # Each column width percentage
```

#### Multi-Window Layouts

```bash
WINDOW_0=0            # First window index
WINDOW_1=1            # Second window index
# Pane dimensions apply per-window
```

### Tmux Split Math

When splitting panes, percentages apply to the **remaining** space:

```
Initial:     [████████████████████████████████████] 100%
                          ↓ split -h -p 66
Left (34%):  [███████████]
Right (66%): [█████████████████████████]
                          ↓ split -h -p 50 on right
Left (34%):  [███████████]
Center (33%):[████████████]
Right (33%): [█████████████]
```

---

## Step 4: Understand Agent Mapping

### How Agents Get Assigned to Panes

The `auto_warp_panes()` function in start-agents.sh maps agents to panes:

```
Pane Index → Agent Index → Agent Directory
    0      →     0       → agents/1/
    1      →     1       → agents/2/
    2      →     2       → agents/3/
```

### Agent Directory Structure

```
agents/
├── 1/    # Agent 1 worktree (Shadow Claude)
├── 2/    # Agent 2 worktree (Executor)
├── 3/    # Agent 3 worktree (Executor)
├── 4/    # Agent 4 worktree (Specialist)
└── 5/    # Agent 5 worktree (Specialist)
```

### Special Pane Types

| Pane Type | Agent? | Auto-Warp? | Example |
|-----------|--------|------------|---------|
| Agent pane | Yes | Yes | Panes 0-4 in grid-3x2 |
| Monitor pane | No | No | Pane 5 in grid-3x2-full |
| Root pane | No | No | Pane 0/5 in six-pane |
| Workspace pane | No | No | Window 2 in window-1x3 |

### Customizing Agent Mapping

For custom pane-to-agent mapping, add a case in `auto_warp_panes()`:

```bash
elif [ "$LAYOUT_TYPE" = "my-custom" ]; then
    # Custom mapping logic
    if [ "$pane_index" -eq 0 ]; then
        agent_index=2  # Pane 0 → Agent 3
    elif [ "$pane_index" -eq 1 ]; then
        agent_index=0  # Pane 1 → Agent 1
    fi
```

---

## Step 5: Test Your Profile

### Basic Test

```bash
# Start with your profile
.agents/scripts/start-agents.sh profileN

# Verify layout looks correct
# Check agents are in correct panes
```

### Verify Pane Count

```bash
# Inside tmux session
tmux list-panes -t ai-Nat-s-Agents

# Expected output (example for 3-pane):
# 0: [180x20] [history 0/50000, 0 bytes] %0
# 1: [180x20] [history 0/50000, 0 bytes] %1
# 2: [180x20] [history 0/50000, 0 bytes] %2
```

### Verify Agent Mapping

```bash
# In each pane, check working directory
pwd
# Should show: /path/to/repo/agents/N
```

---

## Step 6: Document Your Profile

### Required Documentation

1. **ASCII diagram** - Visual representation of layout
2. **Pane assignments** - Which agent goes where
3. **Navigation tips** - How to move between panes
4. **Use case** - When to use this profile

### Example Documentation Block

```bash
#!/bin/bash
# Profile 15: Deep Focus Layout
#
# For intensive work with one main agent + support.
#
# ┌──────────────────────────┬──────────────────┐
# │                          │  Agent 2         │
# │     Agent 1              │  (25%)           │
# │     (75%)                ├──────────────────┤
# │                          │  Agent 3         │
# │                          │  (25%)           │
# └──────────────────────────┴──────────────────┘
#        75% width                 25% width
#
# Pane Assignments:
# - Pane 0 (left): Main agent - deep work
# - Pane 1 (top-right): Support agent 1
# - Pane 2 (bottom-right): Support agent 2
#
# Navigation:
# - Ctrl+b ← (focus left - main)
# - Ctrl+b → (focus right column)
# - Ctrl+b ↑/↓ (move in right column)
# - Ctrl+b z (zoom any pane to full screen)
#
# Use Case:
# - Complex refactoring with research support
# - Lead agent with junior helpers
# - Deep focus with quick lookups
```

---

## Creating New LAYOUT_TYPE

If no existing type fits your needs, add a new one:

### Step 1: Define in start-agents.sh

```bash
elif [ "$LAYOUT_TYPE" = "my-custom-layout" ]; then
    # Create pane 1 (right of pane 0)
    echo "Adding pane 1..."
    tmux split-window -h -t "$(pane_ref 0)" -c "$REPO_ROOT" -p 30

    # Create pane 2 (below pane 0)
    echo "Adding pane 2..."
    tmux select-pane -t "$(pane_ref 0)"
    tmux split-window -v -t "$(pane_ref 0)" -c "$REPO_ROOT" -p 50

    # Warning if too many agents
    if [ $TOTAL -gt 3 ]; then
        echo "Warning: my-custom-layout shows only 3 panes" >&2
    fi
```

### Step 2: Add Agent Mapping

```bash
# In auto_warp_panes() function
elif [ "$LAYOUT_TYPE" = "my-custom-layout" ]; then
    # Map panes to agents
    # Skip monitor panes, root panes as needed
    agent_index=$((pane_index - PANE_BASE))
```

### Tmux Split Commands Reference

| Command | Effect |
|---------|--------|
| `split-window -h` | Horizontal split (left/right) |
| `split-window -v` | Vertical split (top/bottom) |
| `-p N` | New pane gets N% of space |
| `-t TARGET` | Which pane to split |
| `select-pane -t TARGET` | Focus a pane before splitting |
| `new-window` | Create new window |

---

## Common Patterns

### Pattern 1: Grid Layout

Equal-sized cells for parallel work.

```bash
LAYOUT_TYPE="grid-3x2"
GRID_ROWS=2
GRID_COLS=3
GRID_TOP_HEIGHT=50
GRID_COL_WIDTH=33
```

### Pattern 2: Leader + Workers

One large pane for lead agent, smaller for workers.

```bash
LAYOUT_TYPE="full-left"
RIGHT_WIDTH=30  # Workers share 30%
```

### Pattern 3: Multi-Window Tiers

Semantic separation across windows.

```bash
LAYOUT_TYPE="six-horizontal-2win"
# Window 0: Primary agents (1-3)
# Window 1: Specialist agents (4-5) + Monitor
```

### Pattern 4: Focus + Workspace

Agents in one window, empty workspace in another.

```bash
LAYOUT_TYPE="window-1x3"
# Window 0: 3 agents
# Window 1: Empty workspace for manual work
```

### Pattern 5: Monitor Pane

Last pane runs `maw status watch` for visibility.

```bash
# In start-agents.sh, after creating panes:
tmux send-keys -t "$(pane_ref 5)" "maw status watch" C-m
```

---

## Troubleshooting

### Profile Not Found

```
⚠️  Profile 'profileX' not found, using defaults
```

**Fix**: Ensure file exists at `.agents/profiles/profileX.sh`

### Panes Don't Match Expected Layout

1. Verify `LAYOUT_TYPE` matches a case in start-agents.sh
2. Check dimension variables are correctly set
3. Ensure enough agents exist in `agents/` directory

### Agents Not Auto-Warping

The `maw warp` or `cd` command may fail if:
- Agent worktree doesn't exist
- Directory structure mismatch
- PANE_BASE mismatch (check tmux config)

### Wrong Agent in Wrong Pane

Check the `auto_warp_panes()` mapping for your LAYOUT_TYPE.

---

## Quick Reference

```bash
# List existing profiles
ls .agents/profiles/

# View profile contents
cat .agents/profiles/profile6.sh

# Start with profile
.agents/scripts/start-agents.sh profile6

# Start detached
.agents/scripts/start-agents.sh profile6 --detach

# List panes in session
tmux list-panes -s -t ai-Nat-s-Agents
```

---

## Related Documentation

- `ψ/memory/learnings/2025-12-20_maw-profiles-guide.md` - Profile usage reference
- `ψ/memory/learnings/2025-12-20_maw-status-guide.md` - Status monitoring
- `ψ/memory/learnings/2025-12-17_maw-sync-best-practices.md` - Agent sync patterns

---

*Creating custom profiles lets you tailor the multi-agent workspace to your specific workflow. Start with an existing LAYOUT_TYPE, customize dimensions, and iterate until the layout matches your working style.*
