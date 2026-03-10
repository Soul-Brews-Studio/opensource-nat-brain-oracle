# Handoff: Context Awareness + PR #73

**Date**: 2025-12-30 11:07-11:45
**Duration**: ~38 minutes
**Context at handoff**: 78% (125k/160k usable)

---

## Session Timeline (12 jumps)

| Time | Topic |
|------|-------|
| 11:07 | /recap - caught up on Arthur, PR #73 |
| 11:12 | JUMP: "context left?" → traced to statusline.json |
| 11:20 | JUMP: Built Pre/Post hooks for Bash/Task/Read |
| 11:22 | JUMP: Format "Opus 4.5 XX% (XXk/160k usable)" |
| 11:24 | JUMP: Handoff at 90% + urgency levels |
| 11:25 | JUMP: Auto-compact 20% → recalc usable = 160k |
| 11:26 | Added SessionStart hook → show-latest-handoff.sh |
| 11:27 | Committed: feat(hooks): AI context awareness |
| 11:31 | JUMP: PR #73 → resolved package.json conflict |
| 11:35 | JUMP: statusline.json gitignore fix |
| 11:37 | User merged PR #73 |
| 11:42 | Discussed /trace + Oracle MCP enhancement |

---

## Done This Session

1. **Context awareness hooks**
   - Pre/Post hooks on Bash, Task, Read
   - Shows: `📊 Opus 4.5 XX% (XXk/160k usable)`
   - Urgency: 70% finish, 80% prepare, 90% HANDOFF NOW

2. **Auto-handoff system**
   - 90% threshold triggers handoff message
   - SessionStart hook reads latest handoff

3. **PR #73 merged** (Jarvis-Oracle integration)
   - Resolved package.json conflict via rebase
   - User merged via GitHub

4. **statusline.json gitignored**
   - Prevents git conflicts during branch switches

---

## Files Changed

| File | Change |
|------|--------|
| `.claude/scripts/token-check.sh` | Context % with usable calc |
| `.claude/scripts/show-latest-handoff.sh` | NEW - session pickup |
| `.claude/settings.json` | Pre/Post hooks added |
| `.gitignore` | Added statusline.json |
| `ψ/memory/learnings/workflow/2025-12-30_ai-context-awareness-hooks.md` | Documentation |

---

## Pending / Ideas

1. **Picovoice wake word** - need AccessKey from console.picovoice.ai
2. **Spec 050** - Arthur UI on Oracle v2 server
3. **/trace + Oracle MCP** - Oracle-first pattern for better search
4. **/jump auto-sync** - connect /now jumps with track files

---

## Key Learnings

- `ψ/active/statusline.json` = shared AI context (must gitignore)
- Usable = 160k (80% of 200k when auto-compact on)
- Hook may show stale data (timing issue) - acceptable
- Never force push (user reminder)

---

## Next Session Prompt

```
Read handoff first, then follow speckit flow for any implementation work.
```

---

## Speckit Usage Guide (IMPORTANT)

### When to Use Speckit

| Situation | Action |
|-----------|--------|
| New feature request | Start with /speckit.specify |
| Bug fix (simple) | Skip speckit, just fix |
| Bug fix (complex) | Use /speckit.specify to document |
| Refactor | /speckit.plan first |
| Research/exploration | Skip speckit |

### Complete Flow

```
Step 1: SPECIFY (what)
────────────────────────
/speckit.specify [feature description]

Example:
  /speckit.specify add voice wake word detection for Arthur

Auto-generates:
- Short name from description
- Branch: NNN-short-name
- specs/NNN-short-name/spec.md

No .sh script needed!

Step 2: CLARIFY (optional)
────────────────────────
/speckit.clarify

Asks up to 5 questions to fill gaps in spec

Step 3: PLAN (how)
────────────────────────
/speckit.plan

Creates:
- plan.md (architecture, approach)
- research.md (if needed)
- data-model.md (if needed)

Step 4: TASKS (checklist)
────────────────────────
/speckit.tasks

Creates: tasks.md
- Dependency-ordered tasks
- Each task has acceptance criteria
- Checkboxes for tracking

Step 5: IMPLEMENT (do)
────────────────────────
/speckit.implement

For each task:
1. Read the task
2. Check acceptance criteria exist (add if missing!)
3. Implement
4. Test against criteria
5. Mark ✅ complete
6. Commit with task reference

Step 6: ANALYZE (verify)
────────────────────────
/speckit.analyze

Cross-check all artifacts for consistency
```

### Rules

1. **NEVER code without reading tasks.md first**
2. **ALWAYS verify acceptance criteria before implementing**
3. **If criteria missing → add them before coding**
4. **One task at a time, mark complete immediately**
5. **Use Oracle MCP to search for related patterns first**

### Quick Commands

| Command | When |
|---------|------|
| `/speckit.specify` | Start new feature |
| `/speckit.plan` | Design implementation |
| `/speckit.tasks` | Generate checklist |
| `/speckit.implement` | Execute tasks |
| `/speckit.clarify` | Fill spec gaps |
| `/speckit.analyze` | Verify consistency |
| `/speckit.taskstoissues` | Create GitHub issues |
| `/speckit.checklist` | Custom checklist |

### Oracle Integration

Before any speckit step:
```
oracle_search("feature keywords")  # Find related learnings
oracle_consult("approach question") # Get guidance
```

After completing feature:
```
oracle_learn("pattern discovered", concepts=["tag1", "tag2"])
```

---

## Priority Tasks

1. ~~Picovoice wake word~~ **CANCELLED** (ยกเลิก)
2. Spec 050 - Arthur UI on Oracle v2
3. /trace + Oracle MCP enhancement

---

## Speckit Workflow (Quick Reference)

```
/speckit.specify [description]  → spec.md (auto-creates branch + folder)
/speckit.plan                   → plan.md, research.md, data-model.md
/speckit.tasks                  → tasks.md
/speckit.implement              → execute tasks

# Optional
/speckit.clarify   → ask questions
/speckit.analyze   → consistency check
```

**All slash commands - no scripts needed!**

---

## How to Consult Oracle MCP

```
# Search for any topic
oracle_search("topic keywords", limit=10)

# Get guidance on decisions
oracle_consult("should I do X or Y?", context="situation")

# Random wisdom
oracle_reflect()

# Add new learning
oracle_learn("pattern description", concepts=["tag1", "tag2"])

# List all docs
oracle_list(type="learning", limit=20)
```

**Oracle-first pattern for /trace**:
1. Query Oracle MCP first → get file paths, dates, concepts
2. Pass hints to subagents → targeted search
3. Merge results

---

*Generated at 81% context (131k/160k usable)*
