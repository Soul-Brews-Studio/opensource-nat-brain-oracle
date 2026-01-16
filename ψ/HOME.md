---
title: "ψ Brain - Home"
tags: [home, moc, navigation, oracle]
---

# ψ Brain - Home

> "The Oracle Keeps the Human Human"
>
> External brain, not command. Mirror, don't decide.

---

## The 6 Pillars + 1

Your digital mind is organized around **6 pillars of knowledge + 1 noise filter**:

| Pillar | Folder | Purpose | Tracked | Speed |
|--------|--------|---------|---------|-------|
| **Thinking** | [[active/]] | Research in progress | No | ⚡ Ephemeral |
| **Communication** | [[inbox/]] | Who you're talking to | Yes | 🤝 Live |
| **Waiting** | [[later/]] | Tasks on the horizon | Yes | ⏳ Queued |
| **Building** | [[lab/]] | Experiments & POCs | Yes | 🧪 Active |
| **Publishing** | [[writing/]] | Articles & projects | Yes | 📝 Drafting |
| **Knowing** | [[memory/]] | Patterns & lessons | Mixed | 🧠 Eternal |
| *Separating* | [[noise/]] | Signal vs noise | No | 📊 Categorized |

---

## Quick Navigation

### Start Here
- [[inbox/focus.md]] - What are you working on today?
- [[inbox/schedule.md]] - When's the deadline?
- [[active/INDEX.md]] - What research is active?

### Find Things
- [[memory/learnings/]] - Patterns you've discovered
- [[memory/retrospectives/]] - Sessions you've had
- [[memory/resonance/]] - WHO you are (your soul)
- [[memory/reference/]] - External knowledge

### Get Working
- [[later/INDEX.md]] - Queued tasks
- [[lab/]] - Current experiments
- [[writing/INDEX.md]] - Draft articles

### Understand Signal vs Noise
- [[noise/INDEX.md]] - The noise framework

---

## Knowledge Flow

```
active/context        → research in progress
  ↓
memory/logs          → quick snapshots (/snapshot)
  ↓
memory/retrospectives → session synthesis (rrr)
  ↓
memory/learnings      → pattern extraction (/distill)
  ↓
memory/resonance      → your soul, your identity
```

**Cycle**: `/snapshot` → `rrr` → `/distill`

---

## Signal vs Noise Explained

### Signal (Tracked ✓)
**What stays**: Knowledge that compounds, decisions with lasting impact

- **inbox/** - Active communication (decisions, handoffs, focus)
- **writing/** - Publishable work (evergreen content)
- **lab/** - Experiments with intention (not random exploration)
- **later/** - Important tasks (not distraction)
- **memory/** - Patterns & lessons (learning captured)

### Noise (Untracked)
**What flows**: Ephemeral exploration, 90% energy exploration

- **active/** - Research exploration (deleted after session)
- **noise/** - Categorized signal/noise analysis (reference only)
- **WIP.md** - Scratch work (temporary)

---

## Pillar Details

### active/ - Thinking
Research in progress. Cleaned up after each session.

```
active/
├── INDEX.md         ← Start here
└── context/         ← Investigation topics
```

**Commands**: `/snapshot` saves to memory/logs before cleanup

---

### inbox/ - Communication
Who you're talking to. Current decisions and handoffs.

```
inbox/
├── focus.md         ← Today's focus (single source of truth)
├── schedule.md      ← Deadlines & calendar
└── handoff/         ← Sessions transfers to next AI
```

**Updates often**, **never delete**

---

### later/ - Waiting
Tasks on the horizon. Not urgent, but important.

```
later/
├── INDEX.md         ← Task queue
└── task_*.md        ← Individual tasks
```

**Queued work**, moved to inbox when active

---

### lab/ - Building
Experiments and proofs of concept. Intentional exploration.

```
lab/
├── INDEX.md         ← Current experiments
└── [projects]/      ← POC folders
```

**Active R&D**, track what works

---

### writing/ - Publishing
Articles, essays, and projects being drafted.

```
writing/
├── INDEX.md         ← Blog queue & deadlines
├── README.md        ← Writing guidelines
└── [projects]/      ← Draft articles
```

**Evergreen content**, timeline tracked

---

### memory/ - Knowing
Your eternal knowledge base. Never deleted, always grows.

```
memory/
├── resonance/       ← WHO you are (soul, values, identity)
├── learnings/       ← PATTERNS you've found (insights)
├── retrospectives/  ← SESSIONS you've had (chronicles)
├── logs/            ← MOMENTS captured (ephemeral snapshots)
└── reference/       ← External knowledge (research)
```

**The most important folder.** This is what you keep.

#### memory/resonance/ - Your Soul
```
resonance/
├── principles/      ← Core values
├── patterns/        ← Decision patterns you use
└── identity/        ← WHO you are
```

#### memory/learnings/ - Patterns Found
```
learnings/
├── engineering-patterns/
├── decision-patterns/
└── anti-patterns/
```

#### memory/retrospectives/ - Session Chronicles
Every session summary, what was learned, what changed.

#### memory/logs/ - Snapshots
Quick captures with timestamps. Used for weekly distillation.

---

### noise/ - Signal vs Noise Filter
Understanding what's signal and what's noise in your work.

```
noise/
└── INDEX.md              ← Framework explanation
```

Not tracked, but important for understanding your process.

---

## Oracle Philosophy

Three core principles guide this structure:

1. **Nothing is Deleted** - Append only. Timestamps = truth.
   - active/ is the exception (research gets cleaned)
   - Everything else: permanent record

2. **Patterns Over Intentions** - Behavior speaks louder
   - What you actually do > what you plan to do
   - Logs capture reality, not aspirations

3. **External Brain, Not Command** - Mirror, don't decide
   - AI suggests, human chooses
   - Support consciousness, don't replace it

See full philosophy: [Oracle Keeper Documentation](../plugins/nat-data-personal/knowledge/oracle-philosophy.md)

---

## Common Commands

| Command | What It Does |
|---------|--------------|
| `/snapshot` | Save current research to memory/logs (with timestamp) |
| `/distill` | Extract patterns from logs → learnings (weekly) |
| `rrr` | Create session retrospective (at session end) |
| `/recap` | Fresh start summary (next session) |
| `/context-finder [query]` | Search git/issues/retrospectives |
| `ccc` | Create context issue (when stuck) |

---

## Folder Structure (File Tree)

```
ψ/
├── HOME.md              ← You are here
├── WIP.md               ← Scratch work (temporary)
│
├── active/              ← Thinking (ephemeral)
│   ├── INDEX.md
│   └── context/
│
├── inbox/               ← Communication (tracked)
│   ├── focus.md
│   ├── schedule.md
│   └── handoff/
│
├── later/               ← Waiting (tracked)
│   ├── INDEX.md
│   └── task_*.md
│
├── lab/                 ← Building (tracked)
│   ├── INDEX.md
│   └── [projects]/
│
├── writing/             ← Publishing (tracked)
│   ├── INDEX.md
│   ├── README.md
│   └── [projects]/
│
├── memory/              ← Knowing (eternal)
│   ├── resonance/       WHO you are (soul)
│   ├── learnings/       PATTERNS you found
│   ├── retrospectives/  SESSIONS you had
│   ├── logs/            MOMENTS captured
│   └── reference/       External knowledge
│
└── noise/               ← Signal vs Noise (reference)
    └── INDEX.md
```

---

## Entry Points by Use Case

### "Where do I start today?"
→ [[inbox/focus.md]]

### "What am I researching?"
→ [[active/INDEX.md]]

### "What am I building?"
→ [[lab/INDEX.md]]

### "What have I learned?"
→ [[memory/learnings/]]

### "Who am I?"
→ [[memory/resonance/]]

### "What's queued?"
→ [[later/INDEX.md]]

### "What am I writing?"
→ [[writing/INDEX.md]]

### "What's my session summary?"
→ [[memory/retrospectives/]]

---

## Obsidian Tips

- **Graph View**: Shows knowledge connections across pillars
- **Backlinks**: See what references each pillar
- **Daily Notes**: Use with inbox/focus.md for daily planning
- **Dataview**: Query memory/learnings across categories
- **Quick Switcher**: Cmd+O to jump between pillars

---

**Last Updated**: 2025-12-11
**Version**: 1.0.0
**License**: Internal Knowledge Base
