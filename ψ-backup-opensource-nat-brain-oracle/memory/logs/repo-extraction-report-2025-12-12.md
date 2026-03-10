# Laris-Co Repository Extraction Report

## Summary
**Nat-s-Agents Creation Date**: 2025-12-09 11:46:35 +0700

### Repositories Extracted from Nat-s-Agents

| Repository | Creation Date | Status | Commits | Evidence |
|------------|---------------|--------|---------|----------|
| **claude-voice-notify** | 2025-12-09 14:46:25 +0700 | EXTRACTED | 4 | "Origin: Nat-s-Agents (Oracle project)" |
| **headline-analyzer** | 2025-12-10 10:19:10 +0700 | EXTRACTED | 1 | "from Nat-s-Agents" in commit message |
| **the-headline** | 2025-12-09 23:00:29 +0700 | NEW | 1 | Associated with headline-analyzer |

---

## Detailed Information

### 1. claude-voice-notify
- **First Commit**: 2025-12-09 14:46:25 +0700
- **Time After Nat-s-Agents**: ~3.5 hours
- **Commits**: 4
- **Latest Update**: 2025-12-09 16:32:08 +0700
- **Status**: ACTIVELY DEVELOPED
- **Extract Evidence**: 
  - First commit mentions "Origin: Nat-s-Agents (Oracle project)"
  - Contains agent hooks and notification system
  - Plugin structure for Claude Code framework
  
**First Commit Details**:
```
feat: initial voice notification system

Install: ln -s ~/Code/.../claude-voice-notify/scripts ./scripts

Files:
- agent-start-notify.sh (PreToolUse hook)
- agent-complete-notify.sh (SubagentStop hook)
- agent-voices.toml (Samantha, Daniel, Karen, Rishi)

Origin: Nat-s-Agents (Oracle project)
```

**Second Commit Details**:
```
feat: full plugin structure with hooks, commands, skills

Plugin components:
- .claude-plugin/plugin.json: Plugin metadata
- hooks/hooks.json: PreToolUse + SubagentStop hooks
- commands/voice-test.md: /voice-test command
- commands/voice-config.md: /voice-config command
- skills/thai-voice/SKILL.md: Thai TTS skill (Kanya, Narisa)
```

---

### 2. headline-analyzer
- **First Commit**: 2025-12-10 10:19:10 +0700
- **Time After Nat-s-Agents**: ~23 hours
- **Commits**: 1
- **Status**: SINGLE COMMIT (INITIAL)
- **Extract Evidence**: 
  - Commit message explicitly states "from Nat-s-Agents"
  - LINE U-LIB API analyzer for Northern Thailand news

**First Commit Details**:
```
init: headline analyzer from Nat-s-Agents

LINE U-LIB API analyzer for The HEADLINE project
- Fetches data from CMU/LP news APIs
- Analyzes PM2.5, haze, and news content
- Streamlit dashboard for visualization
- Graph builder for relationship mapping
```

---

### 3. the-headline
- **First Commit**: 2025-12-09 23:00:29 +0700
- **Time After Nat-s-Agents**: ~11.5 hours
- **Commits**: 1
- **Status**: SINGLE COMMIT (COMPLETED PROJECT)
- **Relationship**: Uses headline-analyzer
- **Project Details**: 
  - U-LIB API analyzer dashboard
  - 7 APIs, 1,210 messages
  - PM2.5 monitoring with threshold alerts
  - Knowledge graph with 1,269 nodes
  - Interactive Plotly visualizations

---

## All Repositories Timeline

| Rank | Repository | Creation Date | Age (days) |
|------|-----------|---------------|-----------|
| 1 | 00_mz_forwarder | 2024-11-15 12:14:30 | 27 |
| 2 | esphome-fw | 2024-11-18 08:04:44 | 24 |
| 3 | liff-carbon-offset-app | 2025-05-15 21:28:34 | 211 |
| 4 | obsidian-vault | 2025-06-24 11:05:16 | 171 |
| 5 | esphome-floodboy-4g | 2025-09-22 18:43:47 | 81 |
| 6 | esphome-radar | 2025-09-28 16:30:34 | 75 |
| 7 | multi-agent-workflow-kit | 2025-10-04 09:30:50 | 69 |
| 8 | 0xkm | 2025-10-07 09:19:26 | 66 |
| 9 | proof-maw-multi-agent-worktree-kit | 2025-10-09 10:03:54 | 64 |
| 10 | esphome-heating-visualizer | 2025-10-11 12:37:21 | 62 |
| **11** | **Nat-s-Agents** | **2025-12-09 11:46:35** | **3** |
| 12 | claude-voice-notify | 2025-12-09 14:46:25 | 3 |
| 13 | the-headline | 2025-12-09 23:00:29 | 3 |
| 14 | headline-analyzer | 2025-12-10 10:19:10 | 2 |

---

## Conclusions

### High Confidence Extractions:
1. **claude-voice-notify** - Explicitly mentions "Origin: Nat-s-Agents"
2. **headline-analyzer** - Explicitly mentions "from Nat-s-Agents"

### Likely Related (Same Project):
3. **the-headline** - Created ~11 hours after Nat-s-Agents, uses headline-analyzer

### Extraction Pattern:
- All 3 repos created within 23 hours of Nat-s-Agents
- Commits explicitly mention extraction source
- claude-voice-notify continues development (4 commits)
- the-headline + headline-analyzer appear to be completed subprojects

