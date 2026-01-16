# macOS CapsLock Delay Fix with hidutil

**Date**: 2026-01-12
**Significance**: medium
**Tags**: macos, keyboard, capslock, hidutil, thai-input

## Problem

macOS has built-in CapsLock delay that interferes with fast language switching (Thai/English).

## Solutions Tried

| Method | Pros | Cons |
|--------|------|------|
| Karabiner | Works well, no delay | Heavy program for simple task |
| CapslockNoDelay | Lighter than Karabiner | Still has delay |
| **hidutil (native)** | No install, no delay | Resets on reboot |

## Solution: hidutil (built-in macOS)

### One-time command
```bash
hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000006D}]}'
```

This maps CapsLock (0x700000039) to F18 (0x70000006D).

Then set System Preferences > Keyboard > Shortcuts > Input Sources to use F18.

### Persist on boot (LaunchAgent)

```bash
cat <<EOF > ~/Library/LaunchAgents/com.local.KeyRemapping.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.local.KeyRemapping</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/hidutil</string>
        <string>property</string>
        <string>--set</string>
        <string>{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x70000006D}]}</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>
EOF

# Load the agent
launchctl load ~/Library/LaunchAgents/com.local.KeyRemapping.plist
```

## Result

- No delay when switching languages
- No extra software needed
- Works like Karabiner but lighter
