# Task: Restructure ψ/outbox/ to be sustainable

STATUS: Backlog (decision pending)
CREATED: 2025-12-11
PRIORITY: High (affects future growth)
ESTIMATED TIME: 1-8 hours (depending on option chosen)

---

## Problem Statement

ψ/outbox/ currently contains 229 ephemeral prompt files (16M) that:
1. Violate the 5-pillar architecture (prompts are external commands, not internal brain)
2. Create 21x imbalance (16M prompts vs 740K knowledge)
3. Git-track consumable files (wrong retention model)
4. Will become unmaintainable at 500-1000 prompts (Q1-Q2 2026)
5. Will store 50MB+ PNG images in git when generated (anti-pattern)

See full analysis: `.tmp/outbox-analysis.md`

---

## Decision Options

### Option A: Quick Fix (1 hour) - RECOMMENDED

Add `.gitignore` to ψ/outbox/ to exclude:
- Individual prompt files (007-210-*.md, suno-*.md)
- Results directory (will hold PNG images)

Keep tracked (permanent):
- INDEX.md, README_*.md, GENERATION_GUIDE.md, QUICK_START.md

Impact:
- Reduces tracked files from 16M to ~100K
- Prompts remain locally available for generation
- Safe, reversible, minimal disruption

Execute: 1 hour
Timeline: This week
Cost if delayed: Low (can do anytime)

---

### Option B: Medium Refactor (3 hours)

Do Option A, then:
1. Reorganize by project: antigravity/, suno/, etc
2. Organize by category: antigravity/prompts/007-031-oracle/, 032-056-psi/, etc
3. Create .gitignore pattern for each project

Structure result:
```
ψ/outbox/
├── antigravity/
│   ├── prompts/
│   │   ├── 007-031-oracle-philosophy/
│   │   ├── 032-056-psi-structure/
│   │   ├── 057-100-knowledge-flow/
│   │   └── INDEX.md
│   ├── results/ (PNG images, ignored)
│   ├── GENERATION_GUIDE.md
│   └── QUICK_START.md
├── suno/
│   ├── prompts/
│   └── results/
└── README.md
```

Impact:
- Scalable to 1000+ prompts
- Clear project separation
- Prepares for moving to separate repos later

Execute: 3 hours
Timeline: This week or next
Cost if delayed: Medium (more reorganization)

---

### Option C: Full Refactor (8 hours)

Do Option B, then:
1. Create "Antigravity-Prompts" public GitHub repo
2. Move 007-210-*.md files there (with full git history)
3. Create "Suno-Prompts" repo for song prompts
4. Update main repo to reference external repos

Result:
- Main repo = orchestration system only
- Each AI project = separate repo
- Clean separation of concerns

Execute: 8 hours (mostly git history rewriting)
Timeline: January 2026 (planned)
Cost if delayed: None (this is future-phase, not urgent)

---

## Recommendation

**CHOOSE OPTION A THIS WEEK.**

Why:
1. 1 hour implementation ✓
2. Solves the git bloat immediately ✓
3. Keeps prompts accessible locally ✓
4. Buys time to plan Option B/C ✓
5. Safe to reverse if needed ✓
6. Stops the bleed before 300+ more prompts arrive ✓

After choosing Option A, schedule Option B for January and Option C for Q2.

---

## Decision Timeline

**THIS WEEK (Dec 11-18)**:
- [ ] Choose Option A, B, or C
- [ ] Implement chosen option
- [ ] Verify git is cleaner
- [ ] Update ψ/outbox/README.md with new workflow

**NEXT WEEK (Dec 18-25)**:
- If Option A chosen: Monitor for new prompts, verify exclusions work
- If Option B chosen: Complete reorganization, test generation workflow

**JANUARY (Jan 15 area)**:
- If Option C chosen: Create separate repos, migrate prompts with history

**Q2 2026 (if needed)**:
- Full restructure with per-project repos

---

## Acceptance Criteria

For Option A:
- [ ] .gitignore excludes 007-210-*.md
- [ ] .gitignore excludes suno-*.md
- [ ] .gitignore excludes results/
- [ ] INDEX.md, README.md, GENERATION_GUIDE.md still tracked
- [ ] git status shows 16M reduced from tracked
- [ ] Local generation still works (files available on disk)

For Option B:
- [ ] Do all of Option A
- [ ] antigravity/ and suno/ subdirectories created
- [ ] Prompts organized by category within each project
- [ ] New structure documented in README.md

For Option C:
- [ ] Do all of Option B
- [ ] Antigravity-Prompts repo created and public
- [ ] All 007-210-*.md moved with full git history
- [ ] Main repo updated with links/references

---

## Related Files

- Full analysis: `.tmp/outbox-analysis.md`
- Executive summary: `.tmp/outbox-summary.txt`
- Current structure: `ψ/outbox/`
- Existing .gitignore: `.gitignore` (line 37-42)
- Reference: `CLAUDE.md` (Marie Kondo rules for file placement)

---

## Why This Matters (Philosophy)

The Oracle philosophy says:
- "Nothing is Deleted" ≠ "Version all ephemeral files"
- "90/10 Balance" ≠ "16M prompts, 1M knowledge"
- "External Brain, Not Command" ≠ "Store all commands permanently"

This task realigns the filesystem with the philosophy.

---

## Success Looks Like

After completing chosen option:
1. Git is cleaner (16M→100K tracked)
2. Prompts still locally available for generation
3. Structure scales to 1000+ prompts without breaking
4. Team understands: ψ/ is internal brain, outbox is external handoff
5. Decision made: when to move to separate repos (January vs later)

---

**Owner**: Nat (decision required)  
**Blocker**: None (can start anytime)  
**Next Step**: Review `.tmp/outbox-analysis.md` and choose Option A, B, or C
