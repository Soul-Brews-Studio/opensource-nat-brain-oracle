---
title: Tauri tray popup behavior has two options:
tags: [tauri, tray, macos, popup, UX]
created: 2026-01-09
source: Oracle Pulse development
---

# Tauri tray popup behavior has two options:

Tauri tray popup behavior has two options:
- Option A (current): Popup stays open until tray icon clicked again - better for dashboards/monitoring
- Option B: Hide on blur (loses focus) - better for quick glances

To switch, comment/uncomment the blur handler in lib.rs:
```rust
// Hide popup when it loses focus
window.on_window_event(move |event| {
    if let tauri::WindowEvent::Focused(false) = event {
        hide_popup(&app_handle_blur);
    }
});
```

Also: LSUIElement=true in Info.plist hides from Cmd+Tab (menu bar only app).

---
*Added via Oracle Learn*
