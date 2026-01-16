# MAW Auto-Warp Bug Fix

**Date**: 2025-12-20
**Category**: Bug Fix / MAW Infrastructure

---

## The Problem

When using `maw start profile14` (six-horizontal-2win layout), all 3 panes in Window 0 were being warped to `agents/1/` instead of their respective worktrees.

**Symptom**: When sending tasks via `maw hey`, Agent 1 would receive and execute ALL tasks, while Agents 2 and 3 appeared idle.

---

## Root Cause

In `.agents/scripts/start-agents.sh`, the `auto_warp_panes()` function had hardcoded window index checks:

```bash
# WRONG - checking for indices 1 and 2
if [ "$current_window_idx" -eq 1 ]; then
    # Window 0 logic
elif [ "$current_window_idx" -eq 2 ]; then
    # Window 1 logic
fi
```

But tmux creates windows starting at index 0 (not 1), so:
- Window 0 has index 0
- Window 1 has index 1

The condition `current_window_idx -eq 1` never matched for Window 0, causing all panes to fall through to the default handler which didn't account for pane offsets correctly.

---

## The Fix

Changed the window index checks from 1/2 to 0/1:

```bash
# CORRECT - checking for actual indices 0 and 1
if [ "$current_window_idx" -eq 0 ]; then
    # Window 0: panes 1-3 map to agents 1-3
    agent_index=$((pane_index - PANE_BASE))
elif [ "$current_window_idx" -eq 1 ]; then
    # Window 1: panes 1-2 map to agents 4-5
    agent_index=$((3 + pane_index - PANE_BASE))
fi
```

---

## How to Verify

After `maw start profile14`, check pane paths:

```bash
tmux list-panes -t ai-Nat-s-Agents:0 -F "pane #{pane_index}: #{pane_current_path}"
```

**Expected output**:
```
pane 1: .../agents/1
pane 2: .../agents/2
pane 3: .../agents/3
```

**If broken** (all same path):
```
pane 1: .../agents/1
pane 2: .../agents/1  ← WRONG
pane 3: .../agents/1  ← WRONG
```

---

## Debugging Tips

1. **Check auto-warp output** during `maw start`:
   ```
   📍 Pane 1 → Agent 1 (index=0)
   📍 Pane 2 → Agent 2 (index=1)  ← Should be different agents
   📍 Pane 3 → Agent 3 (index=2)
   ```

2. **Verify WINDOW_INDEX** is detected correctly:
   ```bash
   tmux list-windows -t ai-Nat-s-Agents -F "#{window_index}"
   ```

3. **Check LAYOUT_TYPE** in profile:
   ```bash
   cat .agents/profiles/profile14.sh | grep LAYOUT_TYPE
   ```

---

## Related Files

- `.agents/scripts/start-agents.sh` - Main startup script with auto_warp_panes()
- `.agents/profiles/profile14.sh` - Profile that uses six-horizontal-2win layout
- `.agents/scripts/hey.sh` - Message delivery to agents

---

## Key Lesson

**Always verify the actual state, not assumptions:**
- Window indices start at 0 in most tmux configs
- Always check `tmux list-panes` output to verify pane paths
- The auto-warp log shows exactly what it's doing - read it!

---

## Commit

`a518437` - fix: correct window index mapping in six-horizontal-2win auto-warp
