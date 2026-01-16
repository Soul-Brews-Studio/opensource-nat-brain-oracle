# AI Life Buddy - Starter Kit

> ให้ AI เป็นเพื่อนคู่คิด — ทั้งเขียนโค้ดและจัดการชีวิต

## Quick Start

```bash
# 1. Copy this folder to your project
cp -r ai-life-buddy ~/my-project/

# 2. Rename ψ-template to ψ
mv ~/my-project/ai-life-buddy/ψ-template ~/my-project/ψ

# 3. Copy commands to Claude
cp -r commands/* ~/.claude/commands/

# 4. Start using!
```

## What's Included

```
ai-life-buddy/
├── README.md              ← You are here
├── ψ-template/            ← Folder structure template
│   ├── active/
│   ├── inbox/
│   ├── writing/
│   ├── lab/
│   └── memory/
├── commands/              ← Custom slash commands
│   ├── feel.md
│   ├── fyi.md
│   ├── jump.md
│   └── rrr.md
├── templates/             ← File templates
│   ├── retrospective.md
│   ├── handoff.md
│   └── feeling-log.md
└── CLAUDE.md.example      ← Example CLAUDE.md
```

## The 5 Pillars (ψ/)

| Folder | Question | Purpose |
|--------|----------|---------|
| `active/` | กำลังค้นคว้าอะไร? | Current research (ephemeral) |
| `inbox/` | คุยกับใคร? | Communication, handoffs |
| `writing/` | กำลังเขียนอะไร? | Creative output |
| `lab/` | กำลังทดลองอะไร? | Experiments |
| `memory/` | จำอะไรได้? | Knowledge base |

### Memory Sub-folders

```
memory/
├── resonance/      ← WHO I am (core identity)
├── learnings/      ← PATTERNS I found
├── retrospectives/ ← SESSIONS I had
└── logs/           ← MOMENTS captured
    ├── feelings/
    └── info/
```

## Commands

### /feel — Log Emotions
```
/feel tired after long meeting
```
Creates: `ψ/memory/logs/feelings/2026-01-08_16-30_tired.md`

### /fyi — Log Information
```
/fyi deadline moved to Friday
```
Creates: `ψ/memory/logs/info/2026-01-08_16-32_deadline-moved.md`

### /jump — Switch Topics
```
/jump new-feature
```
Saves current context, starts new topic

### /rrr — Session Retrospective
```
rrr
```
Creates end-of-session reflection

## Oracle Philosophy

> "The Oracle Keeps the Human Human"

1. **Nothing is Deleted** — Append only, timestamps = truth
2. **Patterns Over Intentions** — Observe behavior, not promises
3. **External Brain, Not Command** — AI reflects, you decide

## Next Steps

1. [ ] Create your ψ/ structure
2. [ ] Install commands
3. [ ] Log your first feeling
4. [ ] Write your first retrospective
5. [ ] Build the habit

---

*AI Life Buddy Starter Kit v1.0*
