# Full Day Patterns — 2025-12-13

**Date**: 2025-12-13 (Saturday)
**Source**: 12.5 hours / 63 commits / 8 sessions

## Patterns Discovered

### 1. Simple Beats Complex
```
Complex solution → Test → Fail sometimes
       ↓
Simplify → Test → Works 100%
       ↓
Ship it
```

**Example**: Haiku executor (2/5 fail) → Bash script (5/5 pass)

### 2. Notes Tracked, Repos Ignored
```
ψ/incubate/
├── *.md          ← tracked (notes)
└── repo/         ← gitignored (cloned code)
```

**Pattern**: Separate metadata from code

### 3. ghq-style Clone
```bash
GHQ_ROOT=ψ/incubate/repo ghq get [url]
```

**Result**: `ψ/incubate/repo/github.com/org/repo/`

### 4. Token Efficiency Hierarchy
```
Haiku → gather data (cheap, fast)
Opus → review + decide
Opus → write final (quality matters)
```

### 5. Beer → Code → Beer
```
Life balance pattern:
🍺 Morning: test beer, chat friends
💻 Day: 12.5h productive work
🍺 Evening: brew new batch
```

## Anti-Patterns

| Wrong | Right |
|-------|-------|
| Haiku executor for simple tasks | Bash script (reliable) |
| AI ทำทุกอย่าง | Script logic + AI thinking |
| Docs ใน CLAUDE.md | Docs ใน agent instruction |
| Complex first | Simple first, add complexity if needed |

## Key Insight

> "AI ไม่ต้องทำทุกอย่าง — แค่ทำสิ่งที่มันเก่ง"

## Triggers

| Pattern | Use When |
|---------|----------|
| Simple beats complex | Choosing between AI vs script |
| Notes/Repos separation | Setting up new folder structure |
| ghq-style clone | Incubating external repos |
| Token hierarchy | Deciding Haiku vs Opus |

## Tags

`patterns` `simplicity` `efficiency` `collaboration` `brewing`
