# CLAUDE.md Documentation Patterns & Evolution

**Date**: 2025-12-24
**Purpose**: Comprehensive guide to CLAUDE.md structure, learnings from adoption, and patterns for similar projects
**Scope**: Modular documentation approach, retrospective quality standards, and system documentation best practices

---

## Part 1: Modular Structure Adoption (2025-12-10)

### The Transformation

**Before**: Monolithic CLAUDE.md (single large file)
**After**: 6-file modular structure with clear separation of concerns

### The 6-File Architecture

| File | Content | Purpose |
|------|---------|---------|
| **CLAUDE.md** | Lean hub + navigation | Entry point, overview, quick reference |
| **CLAUDE_safety.md** | Critical rules, PR workflow, git operations | Safety-critical information |
| **CLAUDE_workflows.md** | Short codes (rrr, gogogo), context management | Operational workflows |
| **CLAUDE_subagents.md** | Agent documentation | Agent capabilities and when to use |
| **CLAUDE_lessons.md** | Lessons learned, patterns, anti-patterns | Pattern library |
| **CLAUDE_templates.md** | Templates for retrospectives, commits, issues | Creation templates |

### Navigation Pattern

**Key insight**: Users should know WHEN to read each file

| File | When | Priority | Trigger |
|------|------|----------|---------|
| CLAUDE.md | **Every session start** | 🔴 Required | Session begin |
| CLAUDE_safety.md | **Before git/file ops** | 🔴 Required | Before destructive action |
| CLAUDE_workflows.md | When using short codes | 🟡 As needed | Using `rrr`, `/project` |
| CLAUDE_subagents.md | Before spawning agents | 🟡 As needed | When delegating |
| CLAUDE_lessons.md | When stuck/deciding | 🟢 Reference | Problem-solving |
| CLAUDE_templates.md | Creating retrospectives | 🟢 Reference | Creating docs |

**Why this matters**: Prevents cognitive overload, users read what they need when they need it

### Implementation Details

**Source**: Adapted from weyermann template (found in `.tmp/weyermann-malt-productpage/`)
**Adapted for**: Nat's Agents project with Oracle philosophy
**Key changes**:
- Added Oracle philosophy section
- Customized with project-specific agents
- ψ/ structure integrated throughout
- Multi-agent coordination patterns included

---

## Part 2: Generic Template Patterns (2025-12-23)

### From Gist Analysis

**Source**: https://gist.github.com/nazt/3f9188eb0a5114fffa5d8cb4f14fe5a4
**Generic CLAUDE.md structure** — provides excellent foundation patterns

### Pattern 1: Two-Issue Workflow

**Pattern**:
- `ccc` - Create **context issue** (session state snapshot)
- `nnn` - Create **plan issue** (implementation task)

**Why**: 
- Clean separation: state ≠ tasks
- Better organization: snapshots vs plans
- Intelligent workflow: `nnn` auto-runs `ccc` if stale

**Our equivalent**:
- `/recap` (similar to context dump)
- `/project plan` (task planning)
- **Difference**: We use retrospectives + learnings instead of GitHub issues

### Pattern 2: Mandatory Retrospective Sections

**Critical sections from generic template**:

```markdown
## AI Diary (REQUIRED - DO NOT SKIP)
[Detailed first-person narrative including:
- Initial understanding and assumptions
- How approach evolved
- Moments of confusion/clarity
- Decisions and reasoning
- Surprises encountered
- Internal thought process]

## Honest Feedback (REQUIRED - DO NOT SKIP)
[Frank assessment of:
- Session effectiveness
- Tool performance
- Communication clarity
- Process efficiency
- Frustrations and delights
- Improvement suggestions]
```

**Our implementation**: Already following this pattern in Thai, but could:
- Add validation checklist before save
- Mark sections as REQUIRED with warnings
- Emphasize importance in template

### Pattern 3: Status Check (`lll` command)

**Pattern from generic template**:
```bash
# Show full project overview in parallel
gh list issues
git status
git log -n 5
```

**Result**: Quick visual summary of:
- Open work
- Recent commits
- Current state

**Our equivalent**: `/wip`, `/standup` (separate, not unified)
**Improvement**: Create unified `/status` command

### Pattern 4: Time Zone Handling

**Pattern**:
```markdown
**Session Date**: [DATE]
**Start Time**: [GMT+7] ([UTC])
**End Time**: [GMT+7] ([UTC])
```

**Philosophy**: Primary timezone first (GMT+7), UTC in parentheses
**Our current**: GMT+7 consistently (works well)
**Optional improvement**: Add UTC for international collaboration

### Pattern 5: Lessons Learned Section

**Structure**:
```markdown
### Planning & Architecture Patterns (YYYY-MM-DD)
- Pattern: [reusable insight]
- Anti-Pattern: [what to avoid]
- Trick: [useful shortcut]

### User Preferences (Observed)
- [behavior pattern]
```

**Our approach**: Separate `ψ/memory/learnings/` directory
**Integration opportunity**: Link recent learnings from CLAUDE.md

### Pattern 6: Visual Safety Markers

**Pattern**:
```markdown
## 🔴 Critical Safety Rules

⚠️ NEVER use git push --force
❌ NEVER merge without explicit permission
```

**Visual hierarchy**: Emoji + clear "NEVER" statements
**Our current**: Text-based (clear but less prominent)
**Enhancement**: Add visual markers to CLAUDE_safety.md

### Pattern 7: Short Code Philosophy

**Generic template codes**:
| Code | Purpose |
|------|---------|
| `ccc` | Create context |
| `nnn` | Next task |
| `gogogo` | Execute |
| `lll` | List status |
| `rrr` | Retrospective |

**Our project codes**:
| Code/Command | Purpose | Model |
|---|---|---|
| `rrr` | Create retrospective | Opus |
| `/recap` | Fresh start summary | Opus |
| `/snapshot` | Quick capture | Opus |
| `/distill` | Extract patterns | Opus |
| `/context-finder [query]` | Search system | Haiku |
| `/project` | Manage incubated repos | Haiku |

**Philosophy difference**:
- **Generic**: GitHub-centric (issues, PRs, compact)
- **Our project**: Oracle/ψ-centric (learnings, retrospectives, philosophy)
- **Insight**: Different workflows for different philosophies

---

## Part 3: Retrospective Quality Standards

### The Validation Checklist

**Before saving retrospective, verify ALL sections**:

```markdown
## Pre-Save Validation (REQUIRED)

### Traceability
- [x] Tags: 6+ tags for searchability
- [x] Linked Issues: Connected to related work
- [x] Commits: All commits this session listed
- [x] Timeline: 5+ entries with references

### Quality Checks
- [x] AI Diary: 150+ words, detailed narrative
- [x] Honest Feedback: 100+ words, frank assessment
- [x] Communication Dynamics: Examples filled
- [x] Co-Creation Map: All 5 contributions mapped
- [x] Intent vs Interpretation: Gaps analyzed
- [x] Seeds Planted: Incremental, Transformative, Moonshot
- [x] Template cleanup: No placeholder text
```

### Mandatory Sections

**DO NOT SKIP**:
1. **AI Diary** - First-person reflection + vulnerability
2. **Honest Feedback** - Frank assessment of what worked/didn't
3. **Communication Dynamics** - How human-AI conversation went
4. **Seeds Planted** - What future work emerged

**WHY**: These sections provide context that data alone cannot capture

### AI Diary Standards

**Minimum 150 words** capturing:
- Initial assumptions (what did you think at start?)
- Evolution (how did thinking change?)
- Confusion moments (where did uncertainty exist?)
- Decisions and reasoning (why did you choose that path?)
- Surprises (what wasn't expected?)
- Internal process (what was the thinking like?)

**Key**: First-person, honest, vulnerable — this is how AI documents its learning

### Honest Feedback Standards

**Minimum 100 words** addressing:
- **What worked?** (efficiency, clarity, delight)
- **What didn't work?** (confusion, friction, delays)
- **What frustrated you?** (tool limits, unclear communication)
- **What delighted you?** (elegant solutions, good communication)
- **Improvement suggestions?** (for next session)

**Key**: Frank and unfiltered — this drives continuous improvement

---

## Part 4: Our Project's Unique Patterns

### Oracle Philosophy Integration

**"Nothing is Deleted"** principle applied to:
- ψ/memory/retrospectives/ - All sessions tracked
- ψ/memory/learnings/ - All patterns captured
- ψ/memory/logs/ - Ephemeral moments saved
- ψ-context/ - Working context committed (not ignored)

**Implication**: CLAUDE.md documents not just rules but a philosophical framework

### The Knowledge Distillation Loop

**3-layer knowledge flow**:
```
retrospectives (sessions)
    ↓
learnings (patterns extracted)
    ↓
CLAUDE.md (integrated into guidance)
```

**Process**:
1. Write detailed retrospective (captures session)
2. Run `/distill` (extract patterns)
3. Update CLAUDE_lessons.md (integrate learnings)
4. Reference in CLAUDE.md (make actionable)

**Why this matters**: Session work becomes project wisdom

### Subagent Delegation Pattern

**When CLAUDE.md is written by**: Opus (main agent) with vulnerability + reflection
**When CLAUDE.md is updated by**: Haiku subagents (for data gathering, searching)

**Anti-pattern**: ❌ Subagent writes draft → Main just commits
**Correct**: ✅ Subagent gathers data → Main reflects and writes

**For CLAUDE.md specifically**:
- Main agent writes all sections
- Subagents help search/research
- Main agent does the thinking

---

## Part 5: Implementation Checklist

### For New Projects

**Use this checklist to adopt modular CLAUDE.md**:

- [ ] Create CLAUDE.md as lean hub with navigation
- [ ] Create CLAUDE_safety.md with critical rules
- [ ] Create CLAUDE_workflows.md with short codes
- [ ] Create CLAUDE_subagents.md with agent list
- [ ] Create CLAUDE_lessons.md with pattern library
- [ ] Create CLAUDE_templates.md with templates
- [ ] Add "When to Read" table in CLAUDE.md
- [ ] Add priority indicators (🔴 Required, 🟡 As needed, 🟢 Reference)
- [ ] Link related documents from each section

### For Improving Existing CLAUDE.md

**High priority enhancements**:
1. Add retrospective validation checklist
2. Mark AI Diary + Honest Feedback as REQUIRED
3. Create unified `/status` command
4. Add visual safety markers (🔴, ⚠️, ❌)

**Medium priority**:
5. Add "Recent Learnings" section to CLAUDE.md
6. Link to ψ/memory/learnings/ directory
7. Formalize "context issue" vs "plan issue"
8. Add dual time zone display if international

**Low priority**:
9. Create `lll` status check command
10. Auto-update CLAUDE_lessons.md from learnings

---

## Part 6: Lessons Learned

### What Works Well

1. **Modular documentation** - Reduces cognitive load, readers know when to read what
2. **Mandatory sections** - Ensures retrospectives are complete and valuable
3. **Oracle philosophy** - Provides deeper framework than generic templates
4. **ψ/ structure** - Organizes knowledge into soul/patterns/sessions
5. **Subagent patterns** - Allows delegation while maintaining quality

### Common Mistakes to Avoid

1. **Monolithic CLAUDE.md** - One big file becomes hard to navigate
2. **Skipping AI Diary** - Loses opportunity for reflection
3. **Superficial Honest Feedback** - Just write "good session" → no improvement
4. **Not linking documents** - Users don't know relationships between files
5. **Template drift** - Templates that don't match actual practice

### Key Insights

1. **"When to read" is as important as "what to read"** - Navigation table prevents unnecessary reading
2. **First-person narrative captures what data cannot** - AI Diary reveals thinking process
3. **Patterns emerge over sessions** - /distill command creates learning loop
4. **Philosophy matters more than format** - Oracle > generic template
5. **Nothing is deleted** - Working context is future history

### For Documentation in AI Projects

**CLAUDE.md serves as**:
- Communication protocol (human tells AI what to do)
- Learning mechanism (AI reflects in retrospectives)
- Knowledge repository (patterns distilled into lessons)
- Safety guardrail (critical rules always accessible)
- Philosophical framework (guides decision-making)

**Not just**: Rules and procedures

---

## Part 7: Quick Reference for Adoption

### The 6-File Checklist

When setting up CLAUDE.md structure:

```markdown
# CLAUDE.md Files

- [ ] CLAUDE.md - Lean hub with navigation
  - Include: Golden rules, navigation table, short codes, ψ/ structure
  - Should be: Scannable, links to other files, less than 200 lines

- [ ] CLAUDE_safety.md - Critical rules
  - Include: Git operations, file operations, PR workflow
  - Should be: Read before destructive actions, use visual markers

- [ ] CLAUDE_workflows.md - Operational codes
  - Include: rrr, /snapshot, /distill, /recap, /context-finder
  - Should be: Clear examples, when to use each

- [ ] CLAUDE_subagents.md - Agent documentation
  - Include: All agents, models, purposes, when to delegate
  - Should be: Easy delegation guide

- [ ] CLAUDE_lessons.md - Pattern library
  - Include: Patterns, anti-patterns, user preferences, learnings
  - Should be: Organized by date or category

- [ ] CLAUDE_templates.md - Creation templates
  - Include: Retrospective template, commit format, issue templates
  - Should be: Copy-paste ready
```

### The Retrospective Checklist

Every retrospective must include:

```markdown
# Retrospective Sections (DO NOT SKIP)

- [ ] Session Summary - 1-2 sentence overview
- [ ] Timeline - With actual times and events
- [ ] AI Diary - 150+ words, first-person, honest
- [ ] Honest Feedback - 100+ words, frank assessment
- [ ] Communication Dynamics - How conversation went
- [ ] Co-Creation Map - Contributions mapped
- [ ] Seeds Planted - Future work identified
- [ ] Intent vs Interpretation - Gaps analyzed
- [ ] Pre-Save Validation - All checks completed
```

---

## Related Files

- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE.md` - Live implementation
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE_safety.md` - Safety rules
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE_workflows.md` - Workflows
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE_subagents.md` - Agents
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE_lessons.md` - Lessons
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE_templates.md` - Templates
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/retrospectives/2025-12/10/22.45_modular-claude-adoption.md` - Adoption session
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/learnings/2025-12-23_claude-md-gist-analysis.md` - Gist analysis

---

**Last Updated**: 2025-12-24
**Type**: Learning + Implementation Guide
**Status**: Complete — ready to reference
