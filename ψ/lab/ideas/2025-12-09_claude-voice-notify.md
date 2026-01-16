# Idea: Claude Voice Notify (Separate Repo)

**Date**: 2025-12-09
**Status**: Incubating
**Origin**: Weyermann repo voice system

---

## The Problem

Currently the voice notification scripts are copied between repos. This is:
- Hard to maintain (changes don't propagate)
- Duplicated code
- No versioning

## The Proposal

Create a standalone repo: `claude-voice-notify` or `agent-voice-hooks`

### What It Would Contain

```
claude-voice-notify/
├── scripts/
│   ├── agent-voices.toml      # Voice config
│   ├── agent-start-notify.sh  # PreToolUse hook
│   └── agent-complete-notify.sh # SubagentStop hook
├── install.sh                 # One-line installer
├── README.md                  # Setup guide
└── examples/
    └── settings.json          # Example Claude Code hooks config
```

### Installation Flow

```bash
# One-liner to install
curl -sSL https://raw.githubusercontent.com/nazt/claude-voice-notify/main/install.sh | bash

# Or clone and symlink
git clone git@github.com:nazt/claude-voice-notify.git ~/.claude-voice
ln -s ~/.claude-voice/scripts ~/myproject/scripts
```

### Claude Code Hook Config

After install, add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Task",
        "command": "~/.claude-voice/scripts/agent-start-notify.sh"
      }
    ],
    "SubagentStop": [
      {
        "command": "~/.claude-voice/scripts/agent-complete-notify.sh"
      }
    ]
  }
}
```

---

## Features to Add

### Phase 1: Basic (Current)
- [x] Start notification (PreToolUse)
- [x] Complete notification (SubagentStop)
- [x] TOML voice config
- [x] Atomic speech queuing

### Phase 2: Enhancements
- [ ] Per-project voice overrides
- [ ] Volume control
- [ ] Mute hours (quiet mode 22:00-08:00)
- [ ] Linux support (espeak/festival)

### Phase 3: Advanced
- [ ] Custom phrases per agent type
- [ ] Sound effects (not just speech)
- [ ] Integration with tmux status bar
- [ ] Webhook for remote notifications

---

## Questions to Resolve

1. **Repo name**: `claude-voice-notify` vs `agent-voice-hooks` vs `maw-voice`?
2. **Scope**: Just voice? Or all Claude Code hooks?
3. **Platform**: macOS only? Or cross-platform from start?
4. **Config location**: Per-project or global `~/.claude-voice/`?

---

## Why Separate Repo?

| Approach | Pros | Cons |
|----------|------|------|
| Copy scripts | Simple | Hard to update, duplicated |
| Git submodule | Versioned | Complex for simple use |
| Separate repo + install.sh | Easy to share, versioned | Extra repo to maintain |
| npm/brew package | Proper distribution | Overkill for shell scripts |

**Recommendation**: Separate repo with install.sh — simple, shareable, maintainable.

---

## Trigger

Graduate this idea when:
- Voice system is stable (no changes for 1 week)
- Need to use in 3+ projects
- Someone else wants to use it

---

*This idea came from the weyermann repo where voice notifications made multi-agent work much more manageable. Hearing "Agent 2 completed" is faster than checking tmux panes.*
