# Oracle Voice Tray v2.0 - Bug Fixes Summary

**Date**: 2026-01-05

## What We Learned

### Voice Hook Task Description Fix
- **Problem**: Voice notification said "Subagent completed" with no context
- **Root cause**: Old grep pattern `'"text":"[^"]*"'` didn't match new transcript format
- **Fix**: Use `jq` to parse `.message.content` from first JSONL line
- **Result**: Now shows "slug done: [first 50 chars of task]"

### Main Agent Notifications Restored
- **Problem**: Samantha voice (Main agent) never announced
- **Root cause**: v2 refactor removed SessionStart/Stop support for Main
- **Fix**: Added Main agent handling in both start and complete hooks
- **Result**: "Main agent starting" and "Main completed" with Samantha voice

### DMG Icon Visibility
- **Problem**: `.VolumeIcon.icns` showing as visible file in DMG
- **Fix**: `chflags hidden "/Volumes/app-name/.VolumeIcon.icns"`
- **Oracle found it**: Search "DMG icon VolumeIcon" returned exact fix

## How Things Connect

```
Claude Code Hooks → claude-voice-notify (MQTT) → Oracle Voice Tray → macOS say
     ↓                      ↓                          ↓
SessionStart           agent-start-notify.sh      Samantha/Daniel
SubagentStop           agent-complete-notify.sh   Task description
Stop                   agent-complete-notify.sh   Main completed
```

## Key Code Changes

**claude-voice-notify commits**:
- `566d1aa` - fix: Show task description in voice notification
- `d8b6acc` - feat: Add Main agent voice notifications

**Pattern for transcript parsing**:
```bash
SLUG=$(head -1 "$TRANSCRIPT" | jq -r '.slug // empty')
TASK=$(head -1 "$TRANSCRIPT" | jq -r '.message.content // empty' | head -c 50)
```

## Tags

`voice-notify` `hooks` `bugfix` `mqtt` `tauri` `oracle-voice-tray`
