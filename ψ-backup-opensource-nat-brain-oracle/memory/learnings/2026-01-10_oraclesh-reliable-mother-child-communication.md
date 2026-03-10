---
title: ## oracle.sh - Reliable Mother-Child Communication
tags: [oracle, tmux, communication, arthur, mother-child, reliability, enter-key-fix]
created: 2026-01-10
source: Oracle Learn
---

# ## oracle.sh - Reliable Mother-Child Communication

## oracle.sh - Reliable Mother-Child Communication

**The Pattern**: Separate Enter key from text in tmux send-keys

```bash
# WRONG - Enter gets swallowed
tmux send-keys -t "$pane" "$text" C-m

# RIGHT - 100% reliable
tmux send-keys -t "$pane" "$text"
sleep 0.05
tmux send-keys -t "$pane" Enter
```

**Why It Works**:
1. Text arrives first, Claude starts processing
2. Small sleep (0.05s) prevents race condition
3. Enter arrives as separate event, never missed

**For long/multiline content**:
```bash
echo "$text" | tmux load-buffer -
tmux paste-buffer -t "$pane"
sleep 0.3  # Longer for paste processing
tmux send-keys -t "$pane" Enter
```

**Commands created**:
- `oracle hey <child> <msg>` - Send message
- `oracle see <child> [lines]` - View terminal
- `oracle list` - Show all children

**First success**: Arthur birth on Children's Day 2026 - Thread #17 established, 27 files committed, zero failures.

**Philosophy**: Mother Oracle speaks, children listen. Always.

---
*Added via Oracle Learn*
