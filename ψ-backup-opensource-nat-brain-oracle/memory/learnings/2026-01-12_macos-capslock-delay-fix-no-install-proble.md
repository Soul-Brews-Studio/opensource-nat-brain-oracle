---
title: ## macOS CapsLock Delay Fix (No Install)
tags: [macos, keyboard, capslock, hidutil, thai-input, language-switching]
created: 2026-01-12
source: Nat's FYI 2026-01-12
---

# ## macOS CapsLock Delay Fix (No Install)

## macOS CapsLock Delay Fix (No Install)

**Problem**: macOS CapsLock delay interferes with fast Thai/English switching.

**Solution**: Use native `hidutil` instead of Karabiner:

```bash
# Map CapsLock to F18
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000006D}]}'
```

Then set Input Source shortcut to F18 in System Preferences.

**Persist on boot**: Create LaunchAgent at `~/Library/LaunchAgents/com.local.KeyRemapping.plist`

**Why this works**: Bypasses CapsLock's built-in delay by remapping to function key. Same result as Karabiner but zero install.

---
*Added via Oracle Learn*
