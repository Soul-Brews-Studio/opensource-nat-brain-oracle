# Task: Repository Consolidation & Organization Cleanup

Status: BACKLOG (Not started)
Created: 2025-12-16 14:31
Priority: HIGH (2200 repos = cognitive overload)
Estimated effort: 4 weeks

---

## Context

Current state analysis: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/.tmp/repo-organization-analysis.md`

- 2,202 total repos across 32 organizations
- 873 forks (39.6%) - mostly unneeded
- Only 32 archived (1.45%) - should be 20-30%
- 1,236 personal repos scattered
- Disk usage: 8.3 GB
- Multiple personas with no clear structure (DustBoy, Soul-Brews, Stone-Meaw, Laris)

This is unsustainable for one person. Target: Reduce to ~300 active repos with clear taxonomy.

---

## Goal

Consolidate 2,200 repos → 300 active repos + archive

**By end of 2025:**
- 5 primary orgs (down from 32)
- 20-30% archived (up from 1.45%)
- <50 forks (down from 873)
- Clear decision process for new repos

---

## Phases (4 weeks)

### Phase 1: Assessment (Week 1)
- [ ] Generate full audit: `gh api user/repos --paginate` export
- [ ] Categorize repos by status (active/learning/archive)
- [ ] Identify duplicates & consolidation candidates
- [ ] Map personas to orgs (DustBoy, Soul-Brews, Stone-Meaw, Laris)
- [ ] Document findings in `.tmp/repo-audit-phase1.md`

### Phase 2: Prepare (Week 2)
- [ ] Create archive org: `laris-co/archive/`
- [ ] Create learning tracking: `NAT_INVENTORY.md`
- [ ] Update GitHub team descriptions
- [ ] Write migration checklist per org
- [ ] Create REPO_GUIDE.md with new structure
- [ ] Setup GitHub topic tagging system (status:active, status:archive, etc)

### Phase 3: Execute - Batch 1 (Week 3)
- [ ] Consolidate cmmakerclub (449 repos)
  - Keep 50 active → `laris-co/active-projects/`
  - Move 350 → `laris-co/archive/`
  - Delete/archive 49 (duplicates, junk)
- [ ] Consolidate personal (1236 repos)
  - Portfolio: 10 public → `nazt/portfolio/`
  - Learning: 20 → `ψ/learn/` (local, not GitHub)
  - Archive: 1206+ → `laris-co/archive/`

### Phase 4: Execute - Batch 2 (Week 4)
- [ ] Consolidate personas
  - Soul-Brews: Hub + Studio → Soul-Brews-Hub only
  - DustBoy: variants → DustBoy-Chain
  - Stone-Meaw: variants → StoneMeaw
- [ ] Archive shell orgs (11 minimal ones):
  - 3E-Workshop, alchemycat, Cat-Lab-System, chiangmaimakerclub
  - fermented-blockchain-cnx, flood-boy, hpcignite, Humanist-Design
  - humanist-us, JimmySoftware, OpenCNX
- [ ] Delete unused local clones from ~/Code/github.com/
- [ ] Update CLAUDE.md file placement rules

### Phase 5: Cleanup (Ongoing)
- [ ] Setup quarterly review process (Jan, Apr, Jul, Oct)
- [ ] Create checklist for new repos (7-question template)
- [ ] Document decision tree for "where does this repo go?"
- [ ] Celebrate reduced complexity!

---

## Quick Wins (Do First)

1. **Delete unused forks (2-3 hours)**
   - 873 forks → keep only 20-30 pinned dependencies
   - Reclaim 500MB+ disk space
   - Execute: `for repo in forks; do gh repo delete --force $repo; done`

2. **Archive inactive repos (4-5 hours)**
   - Find repos updated >12 months ago
   - Tag with `status:archived-pending`
   - Execute archival in batches

3. **Consolidate 32 orgs to 5 (1 week)**
   - cmmakerclub → laris-co/
   - Personal → nazt/
   - Personas (3) → one per
   - Shell orgs (11) → archive

4. **Setup intake checklist (2 hours)**
   - Before next repo, must answer 7 questions
   - Topic tagging required
   - Owner assignment required

---

## File Placement Rules (After Consolidation)

New standard for cloning/storing repos:

```
~/Code/github.com/          ACTIVE DEVELOPMENT (1-3 weeks)
├── laris-co/active-projects/[repo]
├── laris-co/experiments/[repo]
├── nazt/[repo]
└── persona-org/[repo]

ψ/incubate/                 SHORT EXPLORATION (2-4 weeks)
└── [project-name]/         POCs, prototyping

ψ/learn/                    STUDY/REFERENCE (read-only)
└── [source-org]/[repo]     Learning, not modifying
                            Delete after 6 weeks

ψ/lab/                      LOCAL SCRATCH (no source)
└── [project-name]/         POCs, experiments

ARCHIVED on GitHub (remote only)
- Use `gh repo archive [repo]`
- Keep for history, no local clone
- Move to `laris-co/archive/`
```

---

## Decision Tree (Copy to CLAUDE.md)

```
When cloning a repo, where does it go?

□ Working on feature RIGHT NOW?
  → ~/Code/github.com/[org]/[repo]

□ Planning to develop/evaluate (2-4 weeks)?
  → ψ/incubate/[project-name]/

□ Studying implementation (read-only)?
  → ψ/learn/[source-org]/[repo]

□ Creating local POC (no source)?
  → ψ/lab/[project-name]/

□ Inactive >3 months?
  → DELETE local clone (GitHub copy remains)

□ Not touched in 1 year?
  → ARCHIVE on GitHub (read-only)
```

---

## Dependencies

- [ ] Full GitHub API export (in progress)
- [ ] Access to all 32 orgs (verify permissions)
- [ ] Confirmation on: archive vs delete strategy
- [ ] Confirmation on: main persona (Laris primary?)
- [ ] Confirmation on: active repos per week (estimate)

---

## Success Criteria

- [ ] 2,200 repos → 300 active (86% reduction)
- [ ] 32 orgs → 5 structured (84% reduction)
- [ ] 873 forks → <30 (97% reduction)
- [ ] 32 archived → 300+ (9x increase)
- [ ] 0 repos in root directory (Marie Kondo happy)
- [ ] Clear decision process for next 50 repos
- [ ] Disk space: 8.3 GB → <5 GB
- [ ] New repos follow 7-question checklist 100%

---

## Related Docs

- Full analysis: `.tmp/repo-organization-analysis.md`
- File placement guide: `CLAUDE.md` (update ψ/ section)
- New repo checklist: `REPO_CREATION_CHECKLIST.md` (create)
- Quarterly review script: `.claude/commands/repo-audit.sh` (create)

---

## Next Steps

1. Read full analysis in `.tmp/repo-organization-analysis.md`
2. Answer 5 open questions at bottom of analysis
3. Approve phases 1-5 roadmap
4. Start phase 1 (assessment) this week

---

**Oracle Principle:** Nothing is deleted. Archive = historical preservation.
