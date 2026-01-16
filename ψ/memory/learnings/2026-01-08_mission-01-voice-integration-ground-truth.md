---
title: ## MISSION-01: Voice Integration (Ground Truth)
tags: [mission-01, voice-integration, ground-truth, oracle-voice-tray, squad-challenge]
created: 2026-01-08
source: MISSION-01 Ground Truth
---

# ## MISSION-01: Voice Integration (Ground Truth)

## MISSION-01: Voice Integration (Ground Truth)

### Challenge Info

**Repo**: https://github.com/Soul-Brews-Studio/oracle-voice-tray
**Issue**: https://github.com/Soul-Brews-Studio/oracle-voice-tray/issues/1
**Created**: 2026-01-07

### Success Criteria

- [ ] Voice Tray announces when Claude Code task completes
- [ ] Different agents have different voices (Main=Samantha, Agent1=Daniel, Agent2=Karen, Subagents=Rishi)
- [ ] Announcement message makes sense (extracted from transcript)
- [ ] (Bonus) MQTT working for remote notifications

### Key Files

- `docs/MISSION-01-SETUP.md` - Full setup guide
- `~/.claude/settings.json` - Hooks configuration
- `voice-tray-notify.sh` - Hook script

### Verification Commands

```bash
# Check if app is running
curl http://127.0.0.1:37779/status

# Test voice
curl -X POST http://127.0.0.1:37779/speak \
  -H "Content-Type: application/json" \
  -d '{"text":"Hello!","voice":"Samantha"}'
```

### Platform Support

| Platform | Status |
|----------|--------|
| macOS | ✅ Ready (native say) |
| Linux | ⚠️ Needs espeak |
| Windows | ⚠️ Needs SAPI setup |

---
*Added via Oracle Learn*
