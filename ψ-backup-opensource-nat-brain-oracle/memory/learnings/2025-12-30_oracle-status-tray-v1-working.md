# Oracle Status Tray v1 - Working Snapshot

**Date**: 2025-12-30
**Status**: Working (v0.2.5)
**Source**: Session retrospective

---

## What It Does

macOS system tray app showing Oracle MCP server status:
- Psi (ψ) icon in menu bar
- Left-click shows popup with stats
- Right-click shows quit menu
- Auto-hides on focus loss

## Key Technical Patterns

### 1. Tauri 2.0 System Tray (Left vs Right Click)
```rust
TrayIconBuilder::new()
    .show_menu_on_left_click(false)  // Left = popup, Right = menu
    .on_tray_icon_event(|tray, event| {
        match event {
            TrayIconEvent::Click { button: MouseButton::Left, .. } => {
                // Show popup
            }
            _ => {}
        }
    })
```

### 2. macOS Agent App (No Dock Icon)
```xml
<!-- Info.plist -->
<key>LSUIElement</key>
<true/>
```

### 3. Multi-Monitor Positioning (Retina/5K)
```rust
// Tray events use PHYSICAL coordinates, not logical
let pos = PhysicalPosition::new(
    (x - 280.0) as i32,  // Window width offset
    (y + 30.0) as i32    // Below menu bar
);
```

### 4. Click Debounce Pattern
```rust
static LAST_CLICK: Mutex<Option<Instant>> = Mutex::new(None);

fn toggle_popup(...) {
    let mut last = LAST_CLICK.lock().unwrap();
    if let Some(t) = *last {
        if t.elapsed() < Duration::from_millis(300) {
            return; // Debounce
        }
    }
    *last = Some(Instant::now());
}
```

### 5. RGBA PNG Icon (Tauri Requirement)
```bash
# ImageMagick conversion
convert input.png -background none -gravity center \
    -resize 22x22 -extent 22x22 PNG32:output.png
# Or use: -define png:color-type=6
```

## Known Issues

- Double window sometimes appears (1 popup + 1 white square)
- Root cause unclear - may be Tauri/wry webview bug
- Workaround: debounce helps but doesn't fully fix

## Files

- `ψ/lab/oracle-status-tray/src-tauri/src/lib.rs` - Main logic
- `ψ/lab/oracle-status-tray/src-tauri/tauri.conf.json` - Config
- `ψ/lab/oracle-status-tray/src-tauri/Info.plist` - LSUIElement
- `ψ/lab/oracle-status-tray/src/index.html` - Popup UI

---

**Concepts**: tauri, system-tray, macos, rust, menu-bar-app
