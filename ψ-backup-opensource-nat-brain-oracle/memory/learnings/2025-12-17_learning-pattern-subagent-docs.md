# Learning Pattern: Subagent Documentation

**Date**: 2025-12-17

## What We Learned

When exploring new codebases (like claude-mem), use this pattern:

1. **Haiku explores** (3 parallel subagents):
   - Structure explorer → directories, entry points
   - Implementation finder → storage, patterns, architecture
   - Documentation reader → README, docs, changelog

2. **Haiku creates docs** (organized by project name):
   - `ψ/learn/[project]/ARCHITECTURE.md` → How it works
   - `ψ/learn/[project]/CODE-SNIPPETS.md` → Essential code examples
   - `ψ/learn/[project]/QUICK-REFERENCE.md` → One-page cheat sheet

3. **Main reviews** → Verify accuracy, add insights

## The Pattern

```
/project learn [url]
     ↓
/trace [repo-path]
     ↓
Haiku × 3 (parallel) → Explore + Create Docs
     ↓
Main reviews → Ready to learn!
```

**Thai**: "แจกงาน (Haiku) → รวบรวม → สร้าง docs → ตรวจ (Opus)"

## Directory Structure (Hybrid)

**Repos** = nested (github.com/org/repo)
**Learnings** = flat by project name (simple)

```
ψ/learn/
├── 📚 Learning Notes (flat)
│   ├── claude-mem/           ← Folder with docs
│   │   ├── ARCHITECTURE.md
│   │   ├── CODE-SNIPPETS.md
│   │   └── QUICK-REFERENCE.md
│   ├── maw.md                ← Single file notes
│   └── weyermann.md
│
└── 📦 repo/ (nested symlinks)
    └── github.com/
        ├── thedotmack/claude-mem → ~/Code/...
        ├── jqlang/jq
        └── ...
```

**Why hybrid?**
- Repos keep ghq-compatible paths
- Learnings are easy to find by name
- No prefix clutter

## How Things Connect

- **Token efficiency**: Haiku = $0.25/M vs Opus = $15/M (60x cheaper)
- **Speed**: 3 parallel agents faster than 1 sequential
- **Quality**: Haiku gathers data, Opus reviews (best of both)
- **Persistence**: Docs saved in ψ/learn/[project]/ for future reference

## When to Use

- Learning new repos (`/project learn [url]`)
- Exploring existing code (`/trace [path]`)
- Understanding dependencies
- Onboarding to new projects

## Anti-Pattern

❌ Main reads all files directly (expensive, slow)
❌ Single sequential exploration (wastes time)
❌ No documentation created (knowledge lost)
❌ Docs scattered in root (messy, hard to find)

## Tags

`learning` `subagent` `haiku` `documentation` `pattern` `organization`
