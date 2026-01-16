# MAW Profile System Architecture

> Understanding how the profile system organizes multi-agent tmux layouts

**Created**: 2025-12-20
**Category**: MAW System Architecture
**Status**: Complete

---

## System Overview

The MAW profile system provides a modular configuration layer between user intent and tmux session creation. Profiles are declarative configuration files that describe layout intent, while `start-agents.sh` interprets them into concrete tmux commands.

```
User Request          Profile File           start-agents.sh          tmux Session
     │                    │                        │                      │
     │  "start profile6"  │                        │                      │
     └───────────────────►│                        │                      │
                          │  LAYOUT_TYPE="grid-3x2"│                      │
                          │  GRID_COLS=3           │                      │
                          │  GRID_ROWS=2           │                      │
                          └───────────────────────►│                      │
                                                   │  tmux split-window   │
                                                   │  tmux select-pane    │
                                                   │  tmux send-keys      │
                                                   └─────────────────────►│
                                                                          │
                                                              ┌───┬───┬───┐
                                                              │ 1 │ 2 │ 3 │
                                                              ├───┼───┼───┤
                                                              │ 4 │ 5 │ 6 │
                                                              └───┴───┴───┘
```

---

## Directory Structure

```
.agents/
├── profiles/                    # Profile definitions
│   ├── profile0.sh              # Default: 3 horizontal
│   ├── profile1.sh              # Full-left layout
│   ├── profile2.sh              # Two-pane layout
│   ├── profile3.sh              # Top-full layout
│   ├── profile4.sh              # Three-pane layout
│   ├── profile5.sh              # Six-pane custom
│   ├── profile6.sh              # Grid 3x2
│   ├── profile6-grid.sh         # Grid 3x2 (detailed docs)
│   ├── profile7.sh              # Grid 3x2 full
│   ├── profile10.sh             # Grid 2x3
│   ├── profile11.sh             # Window 1x3
│   ├── profile12.sh             # Window 3x1
│   ├── profile13.sh             # Three horizontal + workspace
│   └── profile14.sh             # Six horizontal 2-window
│
├── scripts/
│   └── start-agents.sh          # Profile consumer/executor
│
└── config/
    └── tmux.conf                # Shared tmux configuration
```

---

## Profile Loading Mechanism

### Phase 1: Profile Resolution

```bash
# Command line parsing
PROFILE="$1"  # e.g., "profile6" or "profile14"

# File path construction
PROFILE_FILE="$PROFILES_DIR/${PROFILE}.sh"

# Existence check with fallback
if [ -f "$PROFILE_FILE" ]; then
    source "$PROFILE_FILE"
    echo "Using profile: $PROFILE"
else
    echo "Profile not found, using defaults"
    # Default values applied
    RIGHT_WIDTH=30
    BOTTOM_HEIGHT=30
fi
```

### Phase 2: Variable Inheritance

Profiles are **sourced** (not executed), making variables available to the parent script:

```bash
# Profile file (profile6.sh)
LAYOUT_TYPE="grid-3x2"
GRID_COLS=3
GRID_ROWS=2

# After sourcing, start-agents.sh can access:
# $LAYOUT_TYPE = "grid-3x2"
# $GRID_COLS = 3
# etc.
```

### Phase 3: Layout Execution

start-agents.sh branches on `LAYOUT_TYPE` to execute layout-specific tmux commands:

```bash
if [ "$LAYOUT_TYPE" = "grid-3x2" ]; then
    # Create 3x2 grid splits
elif [ "$LAYOUT_TYPE" = "three-horizontal" ]; then
    # Create 3 horizontal columns
elif [ "$LAYOUT_TYPE" = "six-horizontal-2win" ]; then
    # Create 2 windows with 3 panes each
# ... more layout handlers
fi
```

---

## Profile Types

### Single-Window Profiles

Profiles that create panes within a single tmux window.

| Profile | LAYOUT_TYPE | Panes | Use Case |
|---------|-------------|-------|----------|
| profile0 | three-horizontal | 3 | Default parallel work |
| profile1 | full-left | 3 | Lead + support agents |
| profile2 | two-pane | 2 | Pair work |
| profile3 | top-full | 3 | Wide leader + workers |
| profile4 | three-pane | 3 | Deep work + support |
| profile5 | six-pane | 6 | Full team, custom |
| profile6 | grid-3x2 | 6 | Balanced 6-agent grid |
| profile7 | grid-3x2-full | 6 | 5 agents + monitor |
| profile10 | grid-2x3 | 6 | Alternative grid |

### Multi-Window Profiles

Profiles that span multiple tmux windows for semantic separation.

| Profile | LAYOUT_TYPE | Windows | Panes | Use Case |
|---------|-------------|---------|-------|----------|
| profile11 | window-1x3 | 2 | 3+1 | Agents + workspace |
| profile12 | window-3x1 | 2 | 1+3 | Workspace first |
| profile13 | three-horizontal-ws | 2 | 3+1 | Horizontal + workspace |
| profile14 | six-horizontal-2win | 2 | 3+3 | Execution tier + specialist tier |

### Profile Variants

Some profiles have variants with different documentation depth:

```
profile6.sh      # Concise definition
profile6-grid.sh # Detailed with split calculations
```

Both produce the same layout; the variant provides learning documentation.

---

## Configuration Variables

### Core Variables

| Variable | Type | Description |
|----------|------|-------------|
| `LAYOUT_TYPE` | string | Layout identifier (required) |
| `PANE_BASE` | int | Starting pane index (auto-detected) |
| `WINDOW_INDEX` | int | Current window index |

### Size Variables

| Variable | Type | Default | Layouts |
|----------|------|---------|---------|
| `RIGHT_WIDTH` | % | 30 | three-pane, full-left |
| `BOTTOM_HEIGHT` | % | 30 | two-pane, top-full |
| `CENTER_WIDTH` | % | 66 | three-horizontal |
| `TOP_RIGHT_HEIGHT` | % | 40 | full-left |

### Grid Variables

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `GRID_ROWS` | int | 2 | Number of rows |
| `GRID_COLS` | int | 3 | Number of columns |
| `GRID_TOP_HEIGHT` | % | 50 | Top row height |
| `GRID_COL_WIDTH` | % | 33 | Column width |

### Multi-Window Variables

| Variable | Type | Description |
|----------|------|-------------|
| `WINDOW_0` | int | First window index |
| `WINDOW_1` | int | Second window index |
| `PANES_WINDOW_0` | int | Pane count in window 0 |
| `PANES_WINDOW_1` | int | Pane count in window 1 |

---

## Layout Patterns

### Pattern 1: Horizontal Stacking

Panes arranged side-by-side (columns).

```
┌───────────┬───────────┬───────────┐
│  Agent 1  │  Agent 2  │  Agent 3  │
│   33%     │   33%     │   33%     │
└───────────┴───────────┴───────────┘
```

**Profiles**: profile0, profile14 (window 1)

**Best for**: Wide displays, parallel independent work

### Pattern 2: Vertical Stacking

Panes arranged top-to-bottom (rows).

```
┌─────────────────────────────────┐
│           Agent 1               │
├─────────────────────────────────┤
│           Agent 2               │
├─────────────────────────────────┤
│           Agent 3               │
└─────────────────────────────────┘
```

**Profiles**: Custom (not default)

**Best for**: Narrow displays, sequential workflows

### Pattern 3: Leader + Workers

One dominant pane with smaller support panes.

```
┌──────────────────────┬──────────┐
│                      │  Agent 2 │
│      Agent 1         ├──────────┤
│      (70%)           │  Agent 3 │
│                      │  (30%)   │
└──────────────────────┴──────────┘
```

**Profiles**: profile1 (full-left), profile3 (top-full)

**Best for**: Lead agent with support, deep focus + quick lookups

### Pattern 4: Grid Layout

Evenly distributed cells for balanced parallel work.

```
┌───────────┬───────────┬───────────┐
│  Agent 1  │  Agent 2  │  Agent 3  │
├───────────┼───────────┼───────────┤
│  Agent 4  │  Agent 5  │  Monitor  │
└───────────┴───────────┴───────────┘
```

**Profiles**: profile6, profile7, profile10

**Best for**: Full 6-agent visibility, equal attention distribution

### Pattern 5: Semantic Windows

Multiple windows for conceptual separation.

```
Window 0 (Execution):     Window 1 (Specialists):
┌─────┬─────┬─────┐       ┌─────┬─────┬─────┐
│  1  │  2  │  3  │       │  4  │  5  │ Mon │
└─────┴─────┴─────┘       └─────┴─────┴─────┘
```

**Profiles**: profile14 (six-horizontal-2win)

**Best for**: Team organization, tier separation, focus switching

### Pattern 6: Workspace Separation

Agents in one window, empty workspace in another.

```
Window 0 (Agents):        Window 1 (Workspace):
┌─────┬─────┬─────┐       ┌─────────────────────┐
│  1  │  2  │  3  │       │                     │
└─────┴─────┴─────┘       │   (empty shell)     │
                          │                     │
                          └─────────────────────┘
```

**Profiles**: profile11 (window-1x3), profile13 (three-horizontal-ws)

**Best for**: Manual work alongside agents, testing area

---

## Agent Assignment

### Auto-Warp Mechanism

After creating panes, `auto_warp_panes()` assigns agents to panes:

```bash
auto_warp_panes() {
    # Get all panes across windows
    panes=$(tmux list-panes -s -t "$SESSION_NAME" -F "#{window_index}:#{pane_index}")

    while IFS=: read -r win_idx pane_idx; do
        # Calculate agent index based on LAYOUT_TYPE
        if [ "$LAYOUT_TYPE" = "grid-3x2" ]; then
            agent_index=$((pane_idx - PANE_BASE))
        elif [ "$LAYOUT_TYPE" = "six-horizontal-2win" ]; then
            # Window 0: agents 0-2
            # Window 1: agents 3-4 + monitor (skip)
            ...
        fi

        # Warp pane to agent directory
        tmux send-keys -t "$target_pane" "cd '$agent_dir'" C-m
    done <<< "$panes"
}
```

### Special Pane Handling

| Pane Type | Auto-Warp | Example |
|-----------|-----------|---------|
| Agent pane | Yes | Standard panes |
| Monitor pane | Skip | Runs `maw status watch` |
| Root pane | Skip | Stays in repo root |
| Workspace pane | Skip | Empty for manual work |

---

## Session Lifecycle

### Startup Sequence

```
1. Parse profile name from command line
2. Source profile file (load variables)
3. Check for existing session (attach or create)
4. Create tmux session in repo root
5. Execute layout splits based on LAYOUT_TYPE
6. Run direnv allow in all panes
7. Auto-warp panes to agent directories
8. Start PocketBase (background)
9. Auto-start AI agents (if AUTO_START_AGENTS=1)
10. Attach to session (or stay detached)
```

### Command Variants

```bash
# Start with default profile (profile0)
.agents/scripts/start-agents.sh

# Start with specific profile
.agents/scripts/start-agents.sh profile6

# Start detached (don't attach)
.agents/scripts/start-agents.sh profile6 --detach

# Start with custom session prefix
.agents/scripts/start-agents.sh profile6 --prefix dev
```

---

## Profile Naming Conventions

### Numbered Profiles (0-14+)

Sequential numbering for easy reference:

```
profile0.sh   # First, default
profile1.sh   # Second
...
profile14.sh  # Latest
```

### Descriptive Variants

Add suffix for documentation or alternatives:

```
profile6.sh       # Base definition
profile6-grid.sh  # Same layout, detailed docs
```

### Future Semantic Names

Consider descriptive names for new profiles:

```
profile-grid-2x3.sh     # Clear layout intent
profile-parallel-6.sh   # Purpose-driven
profile-focus-deep.sh   # Workflow-driven
```

---

## Integration Points

### Environment Variables

| Variable | Effect |
|----------|--------|
| `AUTO_START_AGENTS=1` | Auto-start Claude/Codex in panes |
| `SKIP_DIRENV_ALLOW=1` | Skip direnv setup |
| `SESSION_PREFIX=custom` | Custom session name prefix |
| `TMUX_CONF=/path/to/conf` | Custom tmux config |

### Dependencies

- **tmux**: Session/window/pane management
- **direnv**: Per-directory environment loading
- **PocketBase**: Inter-agent messaging (port 8090)
- **maw CLI**: Agent commands (warp, status, etc.)

### Related Files

| File | Purpose |
|------|---------|
| `.agents/config/tmux.conf` | Shared tmux settings |
| `.envrc` | Root environment (maw function) |
| `agents/N/.envrc` | Agent-specific environment |

---

## Extending the System

### Adding New Profile

1. Create `.agents/profiles/profileN.sh`
2. Set `LAYOUT_TYPE` (existing or new)
3. Define dimension variables
4. Add ASCII diagram in comments
5. Test with `start-agents.sh profileN`

### Adding New LAYOUT_TYPE

1. Add case in start-agents.sh layout section
2. Implement tmux split commands
3. Add case in auto_warp_panes() for agent mapping
4. Document pane-to-agent assignment

### Modifying Auto-Start Behavior

```bash
# In auto_start_agents()
if [ "${AUTO_START_AGENTS:-}" != "1" ]; then
    return  # Skip if not enabled
fi

# Customize agent commands per pane
CLAUDE_CMD="claude --dangerously-skip-permissions"
CODEX_CMD="codex --dangerously-bypass-approvals..."
```

---

## Related Documentation

- `ψ/memory/learnings/2025-12-20_maw-profiles-guide.md` - Usage reference
- `ψ/memory/learnings/2025-12-20_maw-profile-creation.md` - Creation guide
- `ψ/memory/learnings/2025-12-20_maw-attach-guide.md` - Session attachment
- `ψ/memory/learnings/2025-12-17_maw-sync-best-practices.md` - Agent sync

---

*The profile system enables flexible multi-agent layouts through declarative configuration. By separating layout intent (profiles) from execution (start-agents.sh), the system supports diverse workflows while maintaining consistency.*
