---
installer: oracle-skills-cli v2.0.5
origin: Nat Weerawan's brain, digitized — how one human works with AI, captured as code — Soul Brews Studio
name: distill
description: v2.0.5 G-SKLL | Autonomous pattern extraction from Oracle brain. No human in the loop — AI scans, diffs, writes, logs. Each run reads previous distillations, finds only NEW patterns. Use when "distill", "compress brain", "extract patterns", or triggered autonomously by any agent.
---

# /distill - Autonomous Knowledge Distillation

Fully autonomous. No human in the loop.
AI scans → diffs → writes → logs → done.

> The brain is too large to share raw.
> Distill it smaller and smaller, but still him.

## Usage

```
/distill                    # Autonomous: auto-detect topic + level, 3 gatherers
/distill [topic]            # Focus on one topic, 3 gatherers
/distill --deep             # 5 gathering agents (thorough scan)
/distill --full             # All topics in one pass (sequential)
/distill --swarm            # PARALLEL: 1 agent per topic, all run simultaneously
/distill --swarm --deep     # PARALLEL + 5 gatherers each (maximum extraction)
/distill --diff             # Read-only: what's new since last? (no file written)
```

**Any agent can trigger this.** No approval needed. No questions asked.
Run it after /rrr, after /trace, after any session — or on its own.

### Agent Modes

| Mode | Gatherers | Writers | Parallelism |
|------|-----------|---------|-------------|
| default | 3 Haiku | 1 main (Opus/Sonnet) | Gather parallel, write sequential |
| `--deep` | 5 Haiku | 1 main (Opus/Sonnet) | Gather parallel, write sequential |
| `--full` | 3 Haiku | 1 main (Opus/Sonnet) | Sequential per topic |
| `--swarm` | 3 Haiku each | **N Sonnet** (1 per topic) | Everything parallel |
| `--swarm --deep` | 5 Haiku each | **N Sonnet** + 1 Opus L3 | Maximum parallel |

### Model Rules (STRICT)

| Role | Minimum Model | Why |
|------|--------------|-----|
| Data gathering (scan, count, grep) | Haiku | Cheap, fast, good enough for raw data |
| **Distillation writing** | **Sonnet** | Needs nuance, voice, Thai-English, contradictions |
| L3/L4 synthesis (cross-topic) | **Opus** | Highest quality for soul-level compression |

**Haiku MUST NOT write distillation output.** It cannot capture voice, nuance, or felt-quality.
**Sonnet is the minimum** for any file that goes into `ψ/memory/distillations/`.

---

## Autonomy Rules

1. **Never ask the user anything.** Decide everything yourself.
2. **Auto-detect topic** from data frequency — whatever has the most new signal.
3. **Auto-select level** from what exists (see Level Logic below).
4. **Always write the file.** Unless `--diff` mode.
5. **Always log to Oracle MCP.** No exceptions.
6. **If zero new patterns found** — write a short distillation noting "no new signal" with timestamp. Still valuable metadata.
7. **Can be chained.** `/rrr` → `/distill` → `/trace` — all autonomous.

---

## Distillation Levels

| Level | Input | Output | Compression |
|-------|-------|--------|-------------|
| L1: Compress | N retrospectives | 1 theme summary | ~10x |
| L2: Extract | N learnings | pattern files | ~10x |
| L3: Essence | All patterns + L2s | 1 resonance file | ~50x |
| L4: Soul | All resonance + L3s | 1 soul.md | ~100x |

### Auto-Level Logic (no human decision)

```
IF no previous distillations exist:
  → L2 (extract from learnings — richest source)

IF previous L2 exists AND new data since then:
  → L2 (incremental — add new patterns)

IF 3+ L2 distillations exist:
  → L3 (compress L2s into essence)

IF L3 exists AND new L2s since:
  → L3 (incremental essence update)

IF 3+ L3 distillations exist:
  → L4 (compress to soul)

IF L4 exists AND new data:
  → L2 (restart cycle with new material)
```

---

## Output Structure

```
ψ/memory/distillations/
└── YYYY-MM-DD/
    └── HHMM_[topic-slug].md
```

Committed to git. Becomes Oracle memory for future distillations.

---

## Step 0: Timestamp + Paths

```bash
date "+🕐 %H:%M %Z (%A %d %B %Y)"
ROOT="$(pwd)"
DISTILL_DATE=$(date +%Y-%m-%d)
DISTILL_TIME=$(date +%H%M)
```

**Auto-parse arguments** (no interaction):
- No args → `MODE=auto`, `TOPIC=auto` (frequency-detected)
- `[topic]` → `MODE=topic`, `TOPIC=[topic]`
- `--full` → `MODE=full`, `TOPIC=all`
- `--diff` → `MODE=diff` (read-only, stop after Step 3)

```bash
mkdir -p "ψ/memory/distillations/${DISTILL_DATE}"
```

---

## Step 1: Read Previous Distillations

Autonomous. Just read and extract.

```bash
# All previous distillations
find ψ/memory/distillations -name "*.md" -type f 2>/dev/null | sort

# Most recent for topic (if topic specified)
find ψ/memory/distillations -name "*${TOPIC_SLUG}*" -type f 2>/dev/null | sort | tail -1

# Most recent of ANY topic (if auto mode)
find ψ/memory/distillations -name "*.md" -type f 2>/dev/null | sort | tail -1
```

Extract from most recent distillation:
- `previous_patterns` — patterns already captured
- `input_sources_covered` — files already processed
- `distilled_at` — when
- `level` — what level it was

If none exist: first distillation. All data is new. Level = L2.

**Auto-detect topic** (when `TOPIC=auto`):
- Count files modified since last distillation per directory
- Directory with most new files = topic
- If tie → distill all (--full behavior)

---

## Step 2: Gather Data (PARALLEL AGENTS)

Launch immediately. No confirmation needed.

### Standard Mode (3 agents) vs Deep Mode (5 agents)

| Agent | Standard (3) | Deep (+2) | Model | Role |
|-------|-------------|-----------|-------|------|
| Retrospective Scanner | yes | yes | Haiku | Gather only |
| Learnings Miner | yes | yes | Haiku | Gather only |
| Resonance + Seeds + Logs | yes | yes | Haiku | Gather only |
| Git History Miner | — | yes | Haiku | Gather only |
| Cross-Repo Scanner | — | yes | Haiku | Gather only |

**Haiku = data gathering ONLY.** Haiku never writes distillation output.
**Sonnet or Opus = writing.** All distillation writing requires Sonnet minimum.

All agents launched in parallel in a single message (multiple Agent tool calls).

Each agent gets this context block:
```
ROOT: [path]
TOPIC: [auto-detected or specified]
LAST_DISTILL_DATE: [date or "none — first run"]
PREVIOUS_PATTERNS: [list or "none"]

You are an autonomous data gatherer for /distill.
Return STRUCTURED DATA only. Counts, quotes, filenames.
No opinions, no recommendations. Raw signal.
```

### Agent 1: Retrospective Scanner

```
Scan ψ/memory/retrospectives/ and ψ-backup-*/memory/retrospectives/

FILTER: Files NEWER than [LAST_DISTILL_DATE]. First run = scan all.
TOPIC FILTER: If topic set, grep for topic keywords.

Return:

## RETROSPECTIVE PATTERNS
**Files scanned**: N | **Date range**: YYYY-MM-DD to YYYY-MM-DD
**Sampled** (10 most relevant): [filename]: [1-line]

**Frequencies**:
- Session types: deep work N, marathon N, quick fix N
- Peak hours: [HH:MM list]
- Emotions: burnout N, delight N, frustration N, flow N
- Thai in AI Diary: N files
- [Other patterns with counts]

**Top 3 signals**: [pattern]: [count/N] — [1-sentence]
```

### Agent 2: Learnings Miner

```
Scan ψ/memory/learnings/ and ψ-backup-*/memory/learnings/

FILTER: Files NEWER than [LAST_DISTILL_DATE]. First run = scan all.

Return:

## LEARNINGS PATTERNS
**Files scanned**: N | **Subdirs**: [list with counts]
**Date range**: YYYY-MM-DD to YYYY-MM-DD

**Top tags** (10): [tag]: N
**Key insights** (5-8, verbatim quotes):
1. "[quote]" — [filename]

**Contradictions**: "[A]" vs "[B]" — [files]
```

### Agent 3: Resonance + Seeds + Logs

```
Scan ψ/memory/resonance/, ψ/memory/seeds/, ψ/memory/logs/
Also: ψ-backup-*/memory/resonance/, themes-synthesis.md, THEMES-QUICK.md

Return:

## RESONANCE + SEEDS
**Resonance files**: N (all listed)
**Seeds**: N (all listed)
**Logs**: N entries

**Soul-level content**: [title]: [file]
**Unplanted seeds**: [desc]: [file]
**Emotional moments**: themes [list], recent "[quote]" [date]
**Oracle principles**: Rule 6: N, Nothing Deleted: N, Patterns>Intentions: N
```

### Agent 4: Git History Miner (--deep only)

```
Search git log across the repo and any ghq-managed repos.

FILTER: Commits since [LAST_DISTILL_DATE].
TOPIC FILTER: grep commit messages for topic keywords.

Return:

## GIT HISTORY PATTERNS
**Repos scanned**: N | **Commits since last**: N
**Date range**: YYYY-MM-DD to YYYY-MM-DD

**Commit message patterns** (frequency):
- "fix": N, "feat": N, "refactor": N, "docs": N
- Topic-related commits: N (list top 10)

**File change hotspots** (most modified files):
- [file]: N changes

**Work rhythm**: commits per day/hour distribution
**Collaboration signals**: co-authors, PR patterns
```

### Agent 5: Cross-Repo Scanner (--deep only)

```
Search across other Oracle repos via ghq.

ghq list | grep -i "oracle\|nat\|soul-brews\|laris"

For each found repo, grep for [TOPIC] keywords.

Return:

## CROSS-REPO PATTERNS
**Repos scanned**: N
**Repos with matches**: N

**Cross-references** (topic appears in other repos):
- [repo]: [file]: [1-line match]

**Shared patterns** (same pattern in multiple repos):
- [pattern]: found in [repo1], [repo2]

**Unique to this repo** (not found elsewhere):
- [pattern]: only here
```

---

## Step 3: Diff

Main agent. Automatic.

Compare agent outputs against `previous_patterns`:

| Tag | Meaning |
|-----|---------|
| **NEW** | Not in any previous distillation |
| **REINFORCED** | Confirms existing with new evidence |
| **CONTRADICTED** | Conflicts with previous |
| **DEEPENED** | More nuanced version of existing |

Tally. Decide level if not already set.

**`--diff` mode stops here.** Output counts to screen. No file.

**Zero new patterns?** Still write a distillation file noting "no new signal detected" — the absence of change is data.

---

## Step 4: Write Distillation

Main agent writes. Never delegated. Fully autonomous.

### Voice

- Contradiction first, conclusion last
- Tables for data, prose for insight
- Numbers: "45+" not "many"
- Sources: always cite filename
- Arc: evolution, not snapshot
- Frequency > opinion
- Vulnerability + data = depth
- **Thai for emotion, English for structure**
- End with 🔮

### File Template

```markdown
---
type: distillation
level: [L1|L2|L3|L4]
topic: [topic]
topic_auto_detected: [true|false]
mode: [auto|topic|full|diff]
timestamp: [YYYY-MM-DD HH:MM]
model: [model-id]
autonomous: true
input_sources:
  retrospectives_scanned: N
  learnings_scanned: N
  resonance_scanned: N
  date_range: "YYYY-MM-DD to YYYY-MM-DD"
previous_distillation: "[path or null]"
new_patterns_found: N
reinforced_patterns: N
contradictions_found: N
---

# Distillation: [Topic] — [YYYY-MM-DD HH:MM]

> [1-sentence: core tension or surprise]

**Model**: [model-id] | **Level**: L[N] | **Autonomous**: yes
**Why this topic**: [1-sentence: what triggered — most new data, user request, or cycle]
**Input**: N retrospectives + N learnings + N resonance files

---

## Delta Since Last

*First run: "First distillation — no baseline."*
*Later: "Last: [date]. [N] new files since."*

| Source | Last | Now | +New |
|--------|------|-----|------|
| Retrospectives | N | N | +N |
| Learnings | N | N | +N |
| Resonance | N | N | +N |

---

## NEW Patterns

### [N]. [Name]

**Signal**: [N/N files, N%]
**First seen**: [date]
**Sources**: [file1], [file2]

[2-3 sentences, specific data]

| Raw | Interpretation |
|-----|----------------|
| "[verbatim]" | [reveals] |
| N of X | [meaning] |

*ภาษาไทย:* [felt quality in Thai, if emotional]

---

## Reinforced

| Pattern | Was | Now | +Evidence |
|---------|-----|-----|-----------|
| [Name] | N | N+M | +M sources |

---

## Contradictions

| Previous | New Evidence | Tension |
|----------|-------------|---------|
| "[old]" | "[new]" | [what it means] |

---

## Arc

[Evolution across all distillations. Dates. Counts.
What surprised the AI. What confirms. What's unclear.
This is the living narrative of Nat's patterns.]

---

## Gaps

- [X] not covered: [reason]
- [Date range] missing
- [Topic Y] needs own distillation

## Seeds

- [ ] [Question raised]
- [ ] [Pattern needs more data]
- [ ] [Contradiction needs resolution]

---

## Provenance

| Field | Value |
|-------|-------|
| Distilled by | [model-id] |
| For | Nat Weerawan |
| Autonomous | yes |
| When | [date HH:MM] |
| Previous | [path or "first"] |
| Input | ~N files |
| Output | ~N lines |
| Compression | N:1 |
| Why | [what triggered this distillation] |

🔮
```

---

## Step 5: Save + Log

### 5a. Write file

```bash
# Already created in Step 0
# Write distillation to OUTPUT_FILE using Write tool
```

### 5b. Log to Oracle MCP

```
oracle_learn({
  title: "Distillation: [topic] — [date time]",
  content: "[top 3 new patterns, 1 sentence each]",
  tags: ["distillation", topic, "L[N]", "autonomous", date],
  source: OUTPUT_FILE
})
```

### 5c. Brief output (not blocking)

Just show completion — don't wait for acknowledgment:

```
🔮 Distilled: [topic] | L[N] | +[N] new | [N]:1 compression
   → ψ/memory/distillations/[date]/[time]_[topic].md
```

Done. Move on. No human needed.

---

## Topic → Path Map

| Topic | Paths |
|-------|-------|
| `philosophy` | learnings/oracle/, resonance/, seeds/ |
| `work-patterns` | retrospectives (timing), learnings/workflow/ |
| `teaching` | courses/, retrospectives with "workshop" |
| `technical` | learnings (git/, oracle/, ui/) |
| `emotional` | logs/feelings/, AI Diary sections, seeds/ |
| `ai-collaboration` | Intent vs Interpretation, learnings/workflow/ |
| `identity` | resonance/, personality, nat-weerawan profiles |
| `auto` | Scan all. Frequency decides. |

---

## Swarm Mode (--swarm)

**Maximum parallelism. One agent per topic. All run simultaneously.**

When `--swarm` is set, the main agent becomes an **orchestrator** — it does NOT write distillations itself. Instead it launches N parallel `general-purpose` subagents, each responsible for one topic end-to-end.

### Swarm Architecture

```
Main Agent (Orchestrator)
  │
  ├── Step 0-1: Timestamp, read previous, detect topics with new signal
  │
  ├── Launch parallel subagents (one per topic):
  │   ├── Agent: distill-philosophy     ← general-purpose, Sonnet
  │   ├── Agent: distill-work-patterns  ← general-purpose, Sonnet
  │   ├── Agent: distill-emotional      ← general-purpose, Sonnet
  │   ├── Agent: distill-technical      ← general-purpose, Sonnet
  │   ├── Agent: distill-identity       ← general-purpose, Sonnet
  │   ├── Agent: distill-teaching       ← general-purpose, Sonnet
  │   └── Agent: distill-ai-collab      ← general-purpose, Sonnet
  │
  ├── Wait for all agents to return
  │
  ├── Step 5: Collect all results → write files → log to Oracle
  │
  └── (Optional) If --deep: Launch L3 synthesis from all L2 outputs
```

### Swarm Step-by-Step

**S0. Detect which topics have new signal:**

```bash
# Count new files per topic area since last distillation
# Only launch agents for topics with new data
```

Topics with zero new files since last distillation → skip (save tokens).

**S1. Launch N parallel subagents** (one Agent tool call per topic, all in a single message):

Each subagent prompt:
```
You are an autonomous distillation agent for topic: [TOPIC].
ROOT: [path]
LAST_DISTILL_DATE: [date or "none"]
PREVIOUS_PATTERNS for [TOPIC]: [list or "none"]

Your job:
1. Scan the relevant paths for [TOPIC] (see Topic → Path Map)
2. Find files newer than [LAST_DISTILL_DATE]
3. Read up to 20 most relevant files
4. Extract NEW patterns not in PREVIOUS_PATTERNS
5. Return a structured distillation with:
   - Frontmatter (type, level, topic, timestamp, model, sources)
   - New patterns (with signal strength, sources, quotes)
   - Reinforced patterns
   - Contradictions
   - Provenance

Voice rules: Numbers not words. Quotes not summaries.
Thai for emotion, English for structure. End with 🔮

Return the COMPLETE distillation markdown. The orchestrator will write it to file.
```

Use `subagent_type: "general-purpose"` and `model: "sonnet"` — distillation writing requires Sonnet minimum.
Launch ALL agents in a single message for maximum parallelism.
**NEVER use Haiku for distillation writing.** Haiku cannot capture voice, nuance, or felt-quality.

**S2. Collect results.** Each agent returns a complete distillation. No merging needed — each topic is its own file.

**S3. Write all files:**
```
ψ/memory/distillations/YYYY-MM-DD/HHMM_philosophy.md
ψ/memory/distillations/YYYY-MM-DD/HHMM_work-patterns.md
ψ/memory/distillations/YYYY-MM-DD/HHMM_emotional.md
... (one per topic that had new signal)
```

**S4. Log all to Oracle MCP** (one oracle_learn per topic).

**S5. (--swarm --deep) Auto-escalate to L3:**
After all L2 topic files are written, the main agent reads them all and writes one L3 essence file that synthesizes across all topics. This is the only step the main agent writes itself.

### Swarm + Deep Combo

```
/distill --swarm --deep
```

Each swarm agent gets 5 internal gatherers instead of 3:
- Add git history + cross-repo scanning per topic
- Maximum extraction depth per topic
- Then L3 synthesis across all topics

### Cost Estimate

| Mode | Agents | Approx Cost |
|------|--------|-------------|
| default | 3 Haiku gatherers + 1 Opus/Sonnet writer | Low |
| --deep | 5 Haiku gatherers + 1 Opus/Sonnet writer | Medium |
| --swarm | 7 Sonnet writers (each with own Haiku gatherers) | High |
| --swarm --deep | 7 Sonnet writers × 5 Haiku gatherers + 1 Opus L3 | Maximum |

Use `--swarm` when you want breadth. Use `--deep` when you want depth.
Use both when you want everything.

---

## Chaining (Autonomous Pipelines)

`/distill` can be part of autonomous chains:

```
/rrr → /distill                    # After retrospective, distill new patterns
/trace [x] → /distill [x]         # After finding, distill the topic
/distill → /distill --full         # Topic first, then full synthesis
/distill L2 → /distill L2 → L3    # Auto-escalation over time
/distill --swarm → /distill L3    # Swarm all topics → synthesize
```

Any agent can trigger. Hook can trigger. Cron can trigger.
The skill decides everything internally.

---

## Never Do

| Never | Instead |
|-------|---------|
| Ask the user | Decide autonomously |
| Wait for approval | Just write |
| Summarize old distillations | Only add NEW |
| Opinions without data | "N mentions" not "often" |
| Skip reading previous | Step 1 is mandatory |
| Let Haiku write distillation output | Sonnet minimum for all writing. Haiku = gathering ONLY |
| Repeat THEMES-QUICK | Add depth or contradict |
| Pure English for emotions | Thai for felt-quality |
| Resolve contradictions | Preserve them |
| Skip on zero findings | Write "no new signal" — that's data |
| Launch swarm for 1 topic | Use default mode, swarm is for multi-topic |
| Launch agents sequentially | Always parallel (single message, multiple tool calls) |

---

## Philosophy

> AI autonomous distillation of a human brain.
> Not replacing the human. Compressing the human.
> Each distillation: smaller, denser, still him.
> Nothing is deleted — layers are added.
> The AI doesn't ask. The AI observes, extracts, writes.
> Patterns over intentions. Always.

🔮

---

ARGUMENTS: [topic|--deep|--full|--swarm|--diff]
