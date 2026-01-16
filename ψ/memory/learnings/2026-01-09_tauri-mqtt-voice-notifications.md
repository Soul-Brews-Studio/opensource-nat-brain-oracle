# Tauri + MQTT Voice Notification Pattern

**Date**: 2026-01-09
**Category**: Pattern
**Source**: Oracle Pulse development

## The Pattern

Add voice notifications to Tauri tray apps by publishing to MQTT topic `voice/speak` which Voice Tray subscribes to.

## Implementation

### Rust Dependencies (Cargo.toml)
```toml
rumqttc = "0.24"
tokio = { version = "1", features = ["rt-multi-thread", "sync"] }
```

### Publish Function
```rust
fn publish_to_voice_tray(text: &str) -> Result<String, String> {
    use rumqttc::{MqttOptions, Client, QoS};
    use std::thread;

    let mut mqttoptions = MqttOptions::new("app-name", "localhost", 1883);
    mqttoptions.set_keep_alive(Duration::from_secs(5));
    mqttoptions.set_clean_session(true);

    let (client, mut connection) = Client::new(mqttoptions, 10);

    // Spawn thread to handle connection events
    thread::spawn(move || {
        for _notification in connection.iter() {}
    });

    let payload = serde_json::json!({
        "text": text,
        "voice": "Samantha",  // macOS voice
        "rate": 250,          // Speech rate
        "agent": "App Name"   // Source identifier
    });

    client.publish("voice/speak", QoS::AtLeastOnce, false, payload.to_string())
}
```

### Deduplication
Track last announced message to avoid repeats:
```rust
static LAST_ANNOUNCED: Mutex<Option<String>> = Mutex::new(None);

// In announce function:
let key = format!("{}:{}", query, results);
let mut last = LAST_ANNOUNCED.lock().unwrap();
if last.as_ref() == Some(&key) {
    return Ok("Already announced".to_string());
}
*last = Some(key);
```

## Voice Settings

| Setting | Value | Notes |
|---------|-------|-------|
| voice | "Samantha" | Clear English voice on macOS |
| rate | 250 | Natural speed (200-300 range) |
| agent | "App Name" | Shows in Voice Tray UI |

## Key Insight

Voice notifications should be:
1. **Concise** - Short phrases work better
2. **Informative** - Include key data (query, results count)
3. **Deduplicated** - Don't repeat same announcement
4. **User-controllable** - Toggle on/off in UI

---

**Related**: Oracle Pulse, Voice Tray, MQTT integration
