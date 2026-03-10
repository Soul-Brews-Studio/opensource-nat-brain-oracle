---
title: "white.local Full Setup - Sync from MBA"
date: 2025-12-31 12:40
context_at_handoff: 88%
status: handoff
machine: white.local
---

# white.local Full Setup Complete

## What Was Done

### 1. SSH Sync from MBA (192.168.1.106)
- Copied `~/.claude-mem/` (30MB SQLite + vector-db)
- Copied `~/.claude/plugins/` (all plugins)
- Copied `~/.zshrc` + `~/.p10k.zsh`
- Copied `~/.claude/statusline-command.sh`
- Copied Oracle data (`oracle.db` 37MB + `chroma_data/` 26MB)

### 2. Path Fixes (Mac → Linux)
- `/Users/nat/` → `/home/nat/`
- `/Code/github.com/` → `/ghq/github.com/`
- `Nat-s-Agents` → `nat-s-Agents` (case)

### 3. Files Modified
- `~/.claude/settings.json` - added plugins + statusline
- `~/.claude/plugins/installed_plugins.json` - fixed paths
- `~/.claude/plugins/known_marketplaces.json` - fixed paths
- `~/.zshrc` - removed macos plugin, fixed fzf loading
- `~/.claude/statusline-command.sh` - fixed ROOT path

### 4. Plugins Working
- claude-mem@thedotmack ✅
- handoff-mcp-v4@nat-plugins ✅
- ralph-local@nat-plugins ✅
- project-manager@claude-project-manager ✅
- claude-voice-notify (DISABLED - no `say` on Linux)

### 5. Tools Installed
- zsh + oh-my-zsh + powerlevel10k
- zsh-autosuggestions + zsh-completions
- fzf (apt)

## Key Learnings

### Plugin System Internals
```
~/.claude/
├── settings.json              # enabledPlugins
├── statusline-command.sh      # custom statusline
└── plugins/
    ├── cache/                 # actual plugin files
    │   ├── thedotmack/claude-mem/
    │   └── nat-plugins/
    ├── marketplaces/          # manifest repos
    ├── installed_plugins.json # paths matter!
    └── known_marketplaces.json # registry
```

### Cross-Machine Sync Pattern
1. `scp -r` for directories
2. `sed -i` to fix paths
3. Restart Claude Code to load

### ralph-loop.local.md
- Source of Stop callback messages
- Delete file to stop callback
- Location: `.claude/ralph-loop.local.md`

## Oracle MCP Status
- Data copied: `oracle.db` + `chroma_data/`
- Deps installed: `npm install` done
- NOT RUNNING YET - needs path fix in source code

## Next Steps
1. Fix Oracle MCP path issue (src/index.ts line 85)
2. Test Oracle MCP server
3. Add to Claude settings as MCP server
4. Create learning snapshot document

## Git Status
- Synced with origin/main
- No uncommitted changes

## Context Management - ไม่ต้องกลัว!

**อย่ากลัว context หมด** เพราะ:
1. **Auto-compact enabled** - Claude จัดการเอง
2. **Auto-handoff at 95%** - สร้างไฟล์อัตโนมัติ
3. **Keep updating handoff** - จด progress เรื่อยๆ ตั้งแต่ 95%+
4. **ข้อมูลไม่หลุด** - handoff เก็บทุกอย่างไว้

**Pattern:**
```
70% → ⚡ Finish soon
80% → ⚠️ Wrap up
90% → 🚨 HANDOFF NOW (manual)
95% → 🚨 AUTO-HANDOFF (auto-create file)
```

**เมื่อ context สูง:**
- อัปเดต handoff file เรื่อยๆ
- Commit บ่อยๆ
- ไม่ต้องรีบ ไม่ต้องกลัว
- Auto-compact จะช่วย

---
white.local now mirrors MBA setup
