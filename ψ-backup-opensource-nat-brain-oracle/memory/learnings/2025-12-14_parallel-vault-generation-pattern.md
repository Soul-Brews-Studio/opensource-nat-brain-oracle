# Parallel Obsidian Vault Generation Pattern

**Date**: 2025-12-14
**Context**: Building knowledge graph from 7 API data files (1,243 LINE chat records)
**Outcome**: 433 markdown files created in ~2 minutes using 7 parallel Haiku subagents

---

## What Worked

### 1. Parallel Subagent Delegation
```
Main (Opus) → 7x Haiku subagents (parallel) → Main reviews
```
- Each subagent owned one API file completely
- No dependencies between agents = true parallelism
- Cost: 7x Haiku << 1x Opus doing sequential work
- Time: ~2 min total vs ~14 min sequential

### 2. Schema Understanding First
Before spawning anything:
1. Read summary.json (metadata, counts)
2. Sample one data file (actual fields)
3. Identify: id, user_id, display_name, text, msg_type, created_at, group_name

This prevented 7 subagents from all discovering the same schema.

### 3. Scaffold Before Content
```bash
mkdir -p ψ/{messages,senders,groups,daily,sources,.obsidian}
```
Directory structure existed before subagents wrote. No race conditions on mkdir.

### 4. Obsidian Link Format in Prompt
Explicitly showed subagents the exact format:
```markdown
[[senders/display_name]]
[[messages/source_id|timestamp]]
[[groups/group_name]]
```
Consistency across all 433 files.

---

## What Was Hard

### 1. Concurrent Write Conflicts
**Problem**: Multiple subagents writing to same files
- `daily/2025-12-13.md` - 4 APIs had messages on same day
- `senders/Ben Piyanoot.md` - same person in multiple groups

**Result**: Last writer wins, earlier content lost.

**Next time**:
- Use source-prefixed filenames: `daily/haze_2025-12-13.md`
- Or: Main agent aggregates daily files post-hoc

### 2. Thai Filenames in Git
```
\340\270\250\340\270\271\340\270\231\340\270\242\340\271\214...  (git shows octal)
```
Works fine in Obsidian, ugly in git log.

**Next time**: Consider ASCII slug filenames, Thai in content only:
```
groups/cm-emergency-center.md  # filename
# ศูนย์ บชก เหตการณ์ เชียงใหม่  # content
```

### 3. No Global Context in Subagents
Each subagent knew only its API. None could create:
- Cross-source sender deduplication
- Global daily aggregation
- Thematic grouping (haze vs forest fire)

**Solution**: Main agent MUST do aggregation layer:
```
Subagents: Create source-specific files
Main: Create INDEX.md, cross-references, deduplication
```

### 4. Message Type Filtering
Only `msg_type=text` got full files. Images/stickers tracked but not expanded.

**Observation**: 70% of messages were images. Rich content lost.

**Next time**: Consider image notes with metadata even without content.

---

## Recommended Pattern

### For Bulk Data → Obsidian Vault

```
1. EXPLORE (Main)
   - Read metadata/summary
   - Sample 1-2 data files
   - Identify schema + edge cases

2. SCAFFOLD (Main)
   - Create directory structure
   - Write config files (.obsidian/app.json)
   - Create empty INDEX.md

3. DELEGATE (Main → N x Haiku)
   - One subagent per data source
   - Clear input: exact file path
   - Clear output: exact folder + format
   - NO overlapping write targets

4. AGGREGATE (Main)
   - Create cross-source indexes
   - Deduplicate shared entities
   - Build thematic connections
   - Write root INDEX.md

5. VERIFY (Main)
   - Count files (find | wc -l)
   - Spot-check random samples
   - Test Obsidian graph view
```

### Key Rules

| Do | Don't |
|----|-------|
| Prefix files with source | Let subagents share filenames |
| Main owns INDEX files | Subagent creates global index |
| Explicit link format in prompt | Assume subagent knows Obsidian |
| Sample data before delegation | Spawn blind subagents |

---

## Metrics

| Metric | Value |
|--------|-------|
| Input records | 1,243 |
| Output files | 433 |
| Subagents | 7 (Haiku) |
| Wall time | ~2 minutes |
| Unique senders | 72 |
| Unique groups | 7 |
| Date range | Oct 21 - Dec 14, 2025 |

---

## Tags
#pattern #subagent #obsidian #parallel #knowledge-graph #haiku
