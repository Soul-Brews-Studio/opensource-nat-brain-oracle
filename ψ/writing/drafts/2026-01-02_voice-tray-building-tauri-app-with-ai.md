# Building a Desktop App with AI in 30 Minutes — Voice Tray

**Created**: 2026-01-02 17:07 GMT+7
**Status**: Draft
**Author**: Human + AI collaboration

---

## Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Retrospective | ψ/memory/retrospectives/2026-01/02/17.05_voice-tray-central-voice-system.md | Main session |
| Retrospective | ψ/memory/retrospectives/2025-12/30/09.43_oracle-status-tray-tauri.md | Tauri pattern |
| Learning | ψ/memory/learnings/2025-12-30_oracle-status-tray-v1-working.md | Tray icon pattern |
| Source | ψ/incubate/voice-tray/ | Complete source code |

---

## TL;DR

I built a complete Tauri desktop app in 30 minutes using AI pair programming. The app sits in the macOS menu bar, receives voice notifications via HTTP, queues them, and speaks using the system TTS. Here's how AI-assisted development actually works in practice.

---

## The Problem

### Context

I have multiple AI agents running in parallel (Claude Code with worktrees). When they complete tasks, I want voice notifications — but with a twist:

1. **No overlap** — voices shouldn't talk over each other
2. **Timeline** — I want to see what was said
3. **Different voices** — each agent should sound different
4. **Central control** — one app to rule them all

The existing solution was shell scripts calling `say` directly. It worked, but:
- No queue (voices overlapped)
- No history (gone after spoken)
- No UI (invisible)

---

## The Journey

### The Prompt

I used a "Ralph Loop" — a self-referential development loop that keeps feeding the same prompt until completion:

```
i want to create tauri app like the oracle app we incubate
the repo and i want create central voice system the hooks
send to the voice app the voice app control say -v and can
see the timeline and text
```

Not the most polished prompt, but AI understood the intent.

### Iteration 1: Scaffold

AI created the Tauri project:

```bash
npm create tauri-app@latest . -- --template vanilla
```

Then updated `Cargo.toml` with dependencies:
- `tauri` with `tray-icon` feature
- `axum` for HTTP server
- `tokio` for async runtime
- `chrono` for timestamps

### Iteration 2: Core Logic

The Rust backend in ~200 lines:

```rust
// Voice entry for timeline
pub struct VoiceEntry {
    pub id: u64,
    pub timestamp: DateTime<Utc>,
    pub text: String,
    pub voice: String,
    pub rate: u32,
    pub agent: Option<String>,
    pub status: String, // "queued", "speaking", "done"
}

// Speak using macOS say
fn speak_text(text: &str, voice: &str, rate: u32) {
    Command::new("say")
        .args(["-v", voice, "-r", &rate.to_string(), text])
        .spawn()
        .and_then(|mut child| child.wait());
}
```

### Iteration 3: HTTP API

Axum server on port 37779:

```rust
Router::new()
    .route("/speak", post(handle_speak))
    .route("/timeline", get(handle_timeline))
    .route("/status", get(handle_status))
```

### Iteration 4: Timeline UI

Simple HTML/CSS/JS with dark theme:

```html
<div class="voice-entry speaking">
  <div class="time">16:47:22</div>
  <div class="content">
    <div class="text">Agent 1 completed task</div>
    <div class="meta">
      <span class="agent">Agent 1</span>
      <span class="voice">Daniel</span>
    </div>
  </div>
</div>
```

### Iteration 5: Rate Support

User wanted faster speech. Added `-r` flag:

```rust
fn speak_text(text: &str, voice: &str, rate: u32) {
    Command::new("say")
        .args(["-v", voice, "-r", &rate.to_string(), text])
        // ...
}
```

### Iteration 6: Testing

```bash
# Send test voice
curl -X POST http://127.0.0.1:37779/speak \
  -d '{"text":"Hello","voice":"Samantha","rate":220}'

# Check timeline
curl http://127.0.0.1:37779/timeline
```

All 6 iterations happened automatically in the Ralph Loop.

---

## The Solution

### Architecture

```
Claude Code Hook
      |
voice-tray-notify.sh (POST to HTTP)
      |
Voice Tray App (Tauri + Rust)
      |
   +--+--+
   |     |
Queue   Timeline UI
   |
macOS say -v [voice] -r [rate]
```

### Files Created

```
ψ/incubate/voice-tray/
├── src-tauri/
│   ├── src/lib.rs          # 312 lines Rust
│   └── Cargo.toml
├── src/
│   ├── index.html
│   ├── styles.css          # Dark theme
│   └── main.js
└── scripts/
    ├── voice-tray-notify.sh
    └── agent-voices.toml
```

### Usage

```bash
# Install
cp -r src-tauri/target/release/bundle/macos/voice-tray.app /Applications/

# Launch
open /Applications/voice-tray.app

# Send voice
curl -X POST http://127.0.0.1:37779/speak \
  -H "Content-Type: application/json" \
  -d '{"text":"Hello","voice":"Samantha","agent":"Main","rate":220}'
```

---

## The Pattern

### AI Pair Programming Works When:

1. **Clear intent** — Even messy prompts work if intent is clear
2. **Iterative** — Build → test → improve loops
3. **Existing patterns** — AI recognized "like oracle-status-tray"
4. **Human testing** — AI writes, human verifies

### What AI Did Well:

| Task | Quality |
|------|---------|
| Scaffold Tauri project | Excellent |
| Write Rust backend | Very good |
| Create HTTP API | Excellent |
| Design UI | Good |
| Debug issues | Good |

### What Human Did:

| Task | Value |
|------|-------|
| Define requirements | Essential |
| Test the app | Essential |
| Catch stuck loops | Essential |
| Approve commits | Important |

### Time Breakdown

| Phase | Time |
|-------|------|
| Scaffold | 2 min |
| Core logic | 10 min |
| HTTP + UI | 10 min |
| Rate support | 5 min |
| Testing | 3 min |
| **Total** | **~30 min** |

---

## Key Takeaways

1. **Tauri 2.0 is fast** — Scaffold to working app in minutes
2. **Ralph Loop works** — Self-referential prompts keep AI focused
3. **Test as you go** — `curl` is your friend
4. **AI handles boilerplate** — Rust, HTML, CSS all generated
5. **Human handles intent** — What to build, when it's done

---

## Full Context (for AI continuation)

### Session Timeline

| Time | Event |
|------|-------|
| 16:37 | Started Ralph Loop |
| 16:38 | Scaffold created |
| 16:45 | First build success |
| 16:47 | HTTP API working |
| 16:54 | Rate support added |
| 16:57 | Installed to /Applications |
| 17:03 | Ralph Loop cancelled |
| 17:05 | Retrospective written |

### Commits

| Hash | Message |
|------|---------|
| dbce73ca | rrr: Voice Tray central voice system complete |

### Tech Stack

- Tauri 2.0
- Rust + Axum
- HTML/CSS/JS (vanilla)
- macOS `say` command

---

## Tags

`tauri` `rust` `ai-pair-programming` `desktop-app` `voice` `tts` `macos`

---

## Writing Notes

### Tone
- Technical but accessible
- Story-driven (the journey)
- Practical (show code)

### Target Audience
- Developers curious about AI-assisted development
- Tauri/Rust learners
- People building desktop apps

### Suggested Title Alternatives
1. "30 Minutes to Desktop App: AI Pair Programming with Tauri"
2. "How I Built a Menu Bar App Using AI in Half an Hour"
3. "Voice Tray: A Case Study in AI-Assisted Rust Development"

### Next Steps
- [ ] Add screenshots of the app
- [ ] Record demo video
- [ ] Polish language
- [ ] Publish to blog

---

*Draft generated from session knowledge*
*Ready for human review and AI continuation*
