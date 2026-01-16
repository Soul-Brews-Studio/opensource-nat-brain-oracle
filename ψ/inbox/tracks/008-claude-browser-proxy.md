# Track: Gemini Proxy (was claude-browser-proxy)

**Status**: 🟢 Complete (v1.5.3)
**Last touch**: 2026-01-04 20:31
**Repo**: github.com/laris-co/claude-browser-proxy

## What

Chrome extension: Claude Code ↔ Gemini via MQTT

## Current State (v1.5.3)

- Renamed to "Gemini Proxy" - Gemini-specific
- Full chat workflow: click → type → enter → wait_response
- Smart response detection (waits for NEW response, stable text)
- Clean sidebar UI with Gemini Response box
- Badge shows ON only on Gemini sites
- Sidebar enabled only on Gemini

## MQTT Topics

| Topic | Retained | Purpose |
|-------|----------|---------|
| `claude/browser/command` | No | Send commands |
| `claude/browser/response` | Yes | Last result |
| `claude/browser/page` | Yes | Current page |
| `claude/browser/answer` | Yes | Gemini's answer |

## Actions

`click`, `type`, `key`, `wait_response`, `get_url`, `get_text`, `get_html`, `screenshot`, `find`, `get_videos`

## Next

- [ ] Commit changes to repo
- [ ] Test on fresh Gemini conversation
- [ ] Consider MCP wrapper for direct integration

## Files

- Extension: `~/Code/github.com/laris-co/claude-browser-proxy/`
- Mosquitto: `/opt/homebrew/etc/mosquitto/mosquitto.conf`
