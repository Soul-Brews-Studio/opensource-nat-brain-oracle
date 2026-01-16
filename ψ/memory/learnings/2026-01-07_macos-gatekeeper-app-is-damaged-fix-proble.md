---
title: ## macOS Gatekeeper "App is damaged" Fix
tags: [macos, gatekeeper, quarantine, distribution, xattr]
created: 2026-01-07
source: Voice Tray v0.2.1 download issue 2026-01-07
---

# ## macOS Gatekeeper "App is damaged" Fix

## macOS Gatekeeper "App is damaged" Fix

**Problem**: Downloaded app shows "is damaged and can't be opened"

**Cause**: macOS Gatekeeper quarantines unsigned/unnotarized apps

**Fix**:
```bash
# Remove quarantine attribute
xattr -cr "/path/to/App.app"

# Or right-click → Open (bypasses once)
```

**For distribution**: Need Apple Developer certificate ($99/year) to sign and notarize.

**Tags**: macos, gatekeeper, quarantine, unsigned, distribution

---
*Added via Oracle Learn*
