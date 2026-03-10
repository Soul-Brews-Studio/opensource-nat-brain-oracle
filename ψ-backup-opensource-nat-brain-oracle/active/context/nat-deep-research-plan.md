# Plan: Deep Research Nat Weerawan

**Created**: 2026-01-03 20:25
**Status**: complete
**Priority**: high

## Goal

Use the 25 links from Gemini report to gather more info about Nat Weerawan.

## Sources to Research

### Tier 1: Primary (High Value)

| # | Source | URL | Info Expected |
|---|--------|-----|---------------|
| 1 | NECTEC ACE 2016 | https://www.nectec.or.th/ace2016/speaker-lineup/nat-weerawan/ | Bio, talk details |
| 3 | PyCon APAC 2021 | https://2021.th.pycon.org/pages/speakers | Speaker bio, talk |
| 12 | Block Mountain 2026 | https://blockmountaincnx.com/ | Current speaker info |
| 14 | Hackster.io | https://www.hackster.io/nazt | Projects, portfolio |
| 15 | Block Mountain 2024 | https://www.eventpop.me/e/16509 | Recent talks |

### Tier 2: GitHub/Technical

| # | Source | URL | Info Expected |
|---|--------|-----|---------------|
| 4 | WiFi Connector Gist | https://gist.github.com/b1d176a2bebf100ac42d | Code, style |
| 6 | CMMC Electron MQTT | https://github.com/cmmakerclub/electron-mqtt | Project details |
| 8 | CMMC NB-IoT | https://github.com/cmmakerclub/CMMC_NB-IoT | Library code |
| 9 | CMMC LED | https://github.com/cmmakerclub/CMMC_LED | Library code |

### Tier 3: Research/Academic

| # | Source | URL | Info Expected |
|---|--------|-----|---------------|
| 19 | PM2.5 Research | ResearchGate publication | Academic work |
| 22 | Prof Sate Sampattagul | SciProfiles | Collaborators |
| 23-24 | Smart Home Energy | ResearchGate/MDPI | Research paper |

### Tier 4: Blockchain/DePIN

| # | Source | URL | Info Expected |
|---|--------|-----|---------------|
| 13 | IoT Blockchain Meetup | https://www.eventpop.me/e/13958 | Talk details |
| 20 | DustBoy Chain | https://chainlist.org/chain/555888 | Chain specs |

## Execution Plan

### Phase 1: Spawn 5 agents to fetch Tier 1 sources

```
Agent 1: NECTEC ACE 2016 bio
Agent 2: PyCon APAC 2021 speaker page
Agent 3: Block Mountain 2026 current info
Agent 4: Hackster.io profile/projects
Agent 5: Block Mountain 2024 event
```

### Phase 2: GitHub analysis

```
Agent 6-9: Analyze GitHub repos for code patterns, commit history
```

### Phase 3: Academic papers

```
Agent 10: Fetch and summarize research papers
```

## Output

- Update `ψ/memory/resonance/nat-weerawan-profile.md`
- Create `ψ/memory/resonance/nat-weerawan-projects.md`
- Create `ψ/memory/resonance/nat-weerawan-talks.md`

## Command to Execute

```bash
# Next session, run:
/trace nat-deep-research
```

Or spawn agents manually with WebFetch on each URL.

---

*Plan created: 2026-01-03 20:25*
