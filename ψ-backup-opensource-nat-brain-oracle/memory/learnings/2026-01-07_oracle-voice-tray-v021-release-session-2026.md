---
title: ## Oracle Voice Tray v0.2.1 Release Session (2026-01-07)
tags: [dmg, tauri, release, oracle-voice-tray, fileicon, workflow, session-summary]
created: 2026-01-07
source: Voice Tray v0.2.1 release session 2026-01-07
---

# ## Oracle Voice Tray v0.2.1 Release Session (2026-01-07)

## Oracle Voice Tray v0.2.1 Release Session (2026-01-07)

### What We Did
1. **Traced DMG issue** from Oracle memory - found previous fix for double window bug
2. **Created polish-dmg.sh** - post-build script for professional DMG
3. **Fixed recurring DMG issues**:
   - `.VolumeIcon.icns` visible → `chflags hidden`
   - Broken Applications icon → alias + `fileicon`
   - Resource busy errors → `-nobrowse` flag + close Finder first
4. **Released v0.2.1** with polished DMG to GitHub

### Key Technical Learnings
| Problem | Root Cause | Solution |
|---------|-----------|----------|
| Broken Applications icon | Symlinks don't inherit icons | Use alias via AppleScript + fileicon |
| Resource busy on detach | Finder has volume open | `-nobrowse` flag, close Finder first |
| Multiple DMG mounts | Previous runs left volumes | Cleanup loop at script start |
| Icon not applied | Missing tool | `brew install fileicon` |

### Files Created
- `scripts/polish-dmg.sh` - Reusable post-build script
- `docs/blog-dmg-polish.md` - Blog post explaining root cause

### Script Auto-Detects Version
```bash
VERSION=$(grep '"version"' src-tauri/tauri.conf.json | head -1 | sed 's/.*: *"\([^"]*\)".*/\1/')
```

### Release Workflow
```bash
# Bump version in tauri.conf.json + Cargo.toml
npm run tauri build
./scripts/polish-dmg.sh
git commit && git push
gh release create vX.X.X "path/to/polished.dmg#Clean-Name.dmg"
```

### Quote
> "Symlinks don't inherit icons. Aliases do. That's the entire root cause."

---
*Added via Oracle Learn*
