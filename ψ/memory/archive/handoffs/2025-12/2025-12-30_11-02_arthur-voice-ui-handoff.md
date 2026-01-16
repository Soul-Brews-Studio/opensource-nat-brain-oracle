# Session Handoff: Arthur Voice UI Sprint

**From**: Session 2025-12-30 10:12-11:02
**To**: Next session
**Priority**: Continue Arthur UI work

## Context Snapshot

### What We Built
Arthur AI - a voice/chat interface connected to Oracle v2 RAG system.

### Current State

| Component | Port | Status |
|-----------|------|--------|
| Oracle v2 (RAG) | 37778 | ✅ Running |
| Arthur Server | 3456 | ✅ Running (Claude API + RAG) |
| Arthur UI | 8080 | ✅ Running (http-server) |

### Open PR
**PR #73**: Jarvis-Oracle integration - ready to merge
- https://github.com/laris-co/Nat-s-Agents/pull/73

### New Spec Created
**050-arthur-oracle-ui**: Add Arthur UI to Oracle v2 server (single port)
- `specs/050-arthur-oracle-ui/spec.md`
- Goal: Everything on port 37778

## Key Files

```
ψ/lab/oracle-jarvis/
├── index.html      # Arthur UI (voice, chat, popup, markdown)
├── server.ts       # Claude API + RAG server
├── wake-test.html  # Picovoice test page (needs AccessKey)
├── dist/           # Wake word assets (not integrated yet)
└── models/         # ONNX models (not integrated yet)

ψ/lab/oracle-v2/
└── src/server.ts   # RAG server (search, consult, stats)
```

## What's Working

1. **Arthur UI** - Chat with voice/text input
2. **RAG Integration** - Queries Oracle v2 before Claude API
3. **Speech synthesis** - 1.3x speed, stop button
4. **Message popup** - Click to expand with markdown
5. **Event log** - Shows connection status

## What's Buggy

1. **Wake word with Web Speech API** - False positives on partial words
   - Tried: exact word matching, interimResults: false
   - Still triggers on "either", "or" etc.

2. **Recommended fix**: Use Picovoice Porcupine instead
   - Test page: `wake-test.html`
   - Built-in "Jarvis" keyword available
   - Need AccessKey from console.picovoice.ai (free)

## Immediate Next Steps

1. **Merge PR #73** - Jarvis-Oracle integration
2. **Test Picovoice** - Get AccessKey, test wake-test.html
3. **Implement 050** - Add Arthur UI to Oracle v2 server
4. **Optional**: Create custom "Arthur" wake word in Picovoice Console

## Commands to Resume

```bash
# Start Oracle v2 (if not running)
cd ψ/lab/oracle-v2 && bun run src/server.ts

# Start Arthur server (if not running)
cd ψ/lab/oracle-jarvis && bun run server.ts

# Serve Arthur UI (if not running)
cd ψ/lab/oracle-jarvis && python3 -m http.server 8080

# Open Arthur
open http://localhost:8080/index.html

# Test Picovoice wake word
open http://localhost:8080/wake-test.html
```

## Learning Highlights

- Chrome speech synthesis has autoplay policy - need user click first
- Web Speech API not designed for always-on wake word detection
- Picovoice Porcupine is the proper solution with WebAssembly
- RAG context injection works well - responses are knowledge-grounded
