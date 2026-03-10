# Lessons Learned: esphome-fw Oracle Deep Dive

**Date**: 2025-12-17 22:15 GMT+7
**Session**: /trace + /learn esphome-fw deep analysis
**Duration**: ~2 hours

---

## Key Discoveries

### 1. Mature Projects Have Their Own Knowledge Systems

**Discovery**: esphome-fw (541 commits, 11 months) has its own **internal Obsidian vault** with:
- 15 markdown files
- 5-pillar structure (00-start-here, 01-overview, 02-devices, 03-architecture, 05-retrospectives)
- 36 retrospectives with AI Diary sections
- Device catalog documenting 500+ devices

**Lesson**: Don't assume you know a project just from CLAUDE.md. Mature projects develop their own knowledge management systems.

**Apply When**: Exploring any project with 100+ commits - look for internal documentation systems first.

---

### 2. 49% of Issues Are "Thinking" Not "Doing"

**Discovery**: Analyzing 131 GitHub issues in esphome-fw:

| Type | Count | % |
|------|-------|---|
| Context | 38 | 29% |
| Plan | 26 | 20% |
| Feature | 35 | 27% |
| Bug/Fix | 22 | 17% |

**Lesson**: AI-assisted development is mostly externalized thinking. Context issues = working memory. Plan issues = design decisions.

**Apply When**: Building AI workflows - allocate significant effort to "thinking" infrastructure, not just "doing" tools.

---

### 3. Constitution Evolves From Violations

**Discovery**: esphome-fw constitution evolved v1.0.0 → v1.2.2:
- v1.2.0: Added task time limits (sessions ran too long)
- v1.2.1: Git-first backup (directory confusion)
- v1.2.2: rm -rf prohibition (**after actual violation**)

**Lesson**: Governance rules emerge from observed problems, not theoretical best practices. Every amendment has a story.

**Apply When**: Building governance - don't over-engineer upfront. Start minimal, let violations teach you what rules are needed.

---

### 4. Templates Copy But Don't Always Customize

**Discovery**: esphome-heating-visualizer and esphome-radar copied esphome-fw's constitution template but **never filled in the placeholders**. Still have `[PRINCIPLE_N_NAME]` values.

**Lesson**: Templates propagate structure but not content. Customization step often skipped.

**Apply When**: Creating templates - include clear "FILL THIS IN" markers and validation that checks for unfilled placeholders.

---

### 5. Two Governance Philosophies Emerged Naturally

**Discovery**: Without planning it, two different approaches developed:

| Constitution (esphome-fw) | Oracle (Nat-s-Agents) |
|---------------------------|----------------------|
| Rules prevent errors | Retrospectives learn from errors |
| Formal amendments | Organic evolution |
| Safety-first | Learning-first |
| Project governance | Personal workflow |

**Lesson**: Governance style should match project type. Production systems need constraints. Personal workflows need reflection.

**Apply When**: Choosing governance approach - ask "Is this about safety or growth?"

---

### 6. AI Diaries Capture Emotional Truth

**Discovery**: esphome-fw retrospectives have mandatory "AI Diary" sections with genuine vulnerability:

```markdown
"This single question cut through all my technical analysis
and pointed directly to the root cause. It was a humbling moment..."
```

**Lesson**: Forcing emotional reflection creates better learning than just technical summaries.

**Apply When**: Writing retrospectives - include "What humbled me?" not just "What did I build?"

---

### 7. Gen 1 → Gen 2 → Gen 3 Template Evolution

**Discovery**: CLAUDE.md evolved through three generations:

| Gen | Lines | Structure |
|-----|-------|-----------|
| 1 | 559-766 | All-in-one monolith |
| 2 | 46-592 | CLAUDE.md + .specify/ |
| 3 | 292 | Hub + satellites + ψ/ |

**Lesson**: Templates compress over time. Functionality moves from single file to specialized folders.

**Apply When**: Designing project structure - expect evolution from monolith → modular. Plan for it.

---

### 8. Git History Is The Ultimate Trace

**Discovery**: `/trace` command finds everything through git:
- Creation dates
- Deletion dates
- Move/rename history
- Who changed what when

**Lesson**: Git history contains full project archaeology. Use `git log --all --oneline --grep=` liberally.

**Apply When**: Any project investigation - start with git history, not file browsing.

---

### 9. Parallel Agents Save Massive Time

**Discovery**: Using 3-5 Haiku agents in parallel for traces completed in ~30 seconds what would take 5+ minutes serially.

**Lesson**: Parallelize independent searches. Agent coordination overhead is negligible.

**Apply When**: Any broad search - split by source (git, issues, files, docs) and run parallel.

---

### 10. Projects Fork Based on Needs

**Discovery**: esphome-* family all started from esphome-fw but evolved differently:
- esphome-heating-visualizer → Added multi-agent (maw.* commands)
- esphome-radar → Specialized for single device
- esphome-floodboy-4g → POC, abandoned

**Lesson**: Common ancestor + different needs = divergent evolution. This is healthy.

**Apply When**: Starting new project - consider forking from mature template rather than starting fresh.

---

## Patterns Confirmed

### Pattern: "Nothing is Deleted" Works

Both Constitution and Oracle approaches preserve history:
- Constitution: Amendment trail v1.0.0 → v1.2.2
- Oracle: Retrospectives append, never overwrite

### Pattern: External Memory Enables AI Continuity

Context issues in esphome-fw let AI pick up where it left off. Without external memory, each session starts from zero.

### Pattern: Templates Propagate, Customization Lags

Structure copies easily. Content customization requires deliberate effort.

---

## Anti-Patterns Identified

### Anti-Pattern: Unfilled Templates

esphome-heating-visualizer has `[PLACEHOLDER]` values in constitution. Template copied but never customized.

**Fix**: Add CI check for placeholder strings in governance files.

### Anti-Pattern: Knowledge Silos

esphome-fw has rich internal docs in obsidian-vault/ that aren't referenced from CLAUDE.md.

**Fix**: Main docs should link to internal knowledge systems.

### Anti-Pattern: Governance Drift

Different repos have different constitution versions. No sync mechanism.

**Fix**: Consider shared governance base with project-specific extensions.

---

## Action Items

### Immediate
- [ ] Add placeholder detection to repo-auditor subagent
- [ ] Create template for "filling in" copied constitutions
- [ ] Link esphome-fw obsidian-vault from learn docs

### Later
- [ ] Build governance sync tool across repos
- [ ] Create "project maturity checklist" (does it have internal docs?)
- [ ] Add AI Diary section to rrr template if missing

---

## Quotes Worth Keeping

From esphome-fw AI Diary:
> "Is it turned on?" should come before "Is it configured correctly?"

From this session:
> "49% of issues are the thinking, not the doing"

> "Constitution evolves by subtraction. Oracle evolves by addition."

> "Templates propagate structure but not content"

---

## Session Stats

| Metric | Value |
|--------|-------|
| Files analyzed | 90+ |
| GitHub issues traced | 131 |
| PRs analyzed | 92 |
| Retrospectives found | 36 |
| Blog drafts created | 2 |
| Learning docs created | 5+ |

---

## Related Files

- `ψ/learn/esphome-fw/*.md` (5 docs)
- `ψ/active/context/esphome-fw-oracle-patterns.md`
- `ψ/memory/learnings/2025-12-17_template-evolution-analysis.md`
- `ψ/writing/drafts/2025-12-17_ai-assisted-development-esphome-evolution.md`
- `ψ/writing/drafts/2025-12-17_oracle-vs-constitution-evolution.md`

---

*Captured from 2-hour deep dive session*
