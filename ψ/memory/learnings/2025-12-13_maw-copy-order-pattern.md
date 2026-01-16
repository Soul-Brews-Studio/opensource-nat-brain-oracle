# MAW Copy Order Pattern

**Date**: 2025-12-13

## What We Learned

When copying MAW setup from one repo to another, order matters:

```
Config → Setup → Script → Start
```

**NOT**: Start → Debug → Realize missing pieces

### The Order

| Step | File | Why First |
|------|------|-----------|
| 1 | `agents.yaml` | Defines how many agents |
| 2 | `maw setup` | Creates worktrees |
| 3 | `start-agents.sh` | Has layout implementation |
| 4 | `profiles/*.sh` | Just config, needs script |
| 5 | `maw start profile14` | Now it works |

### Key Insight

**Profiles are config, scripts are implementation.**

`profile14.sh` says `LAYOUT_TYPE="six-horizontal-2win"` but if `start-agents.sh` doesn't have code to handle that layout type, it falls back to default.

## How Things Connect

```
agents.yaml (5 agents)
    ↓
maw setup (creates agents/1-5)
    ↓
start-agents.sh (reads profile, creates tmux layout)
    ↓
profile14.sh (LAYOUT_TYPE="six-horizontal-2win")
    ↓
2 windows × 3 panes
```

## Anti-Pattern

```
Copy profiles → Start → "Why only 3 panes?"
→ Realize script missing
→ Copy script → Restart
→ Wasted 10 minutes
```

## Quick Checklist

Before copying MAW to new repo:
- [ ] `diff -r .agents/ /source/.agents/` first
- [ ] Copy agents.yaml
- [ ] Run `maw setup`
- [ ] Copy start-agents.sh
- [ ] Copy profiles
- [ ] Kill with `tmux kill-session` (not `maw kill`)
- [ ] Start fresh

## Tags

`maw` `multi-agent` `tmux` `config-order` `pattern`
