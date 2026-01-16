# Learning from Generic CLAUDE.md Gist

**Date**: 2025-12-23
**Source**: https://gist.github.com/nazt/3f9188eb0a5114fffa5d8cb4f14fe5a4
**Context**: Analyzing generic CLAUDE.md template to improve our own documentation

---

## Key Patterns to Learn

### 1. Two-Issue Pattern (Context vs Task)

**Pattern from gist**:
- `ccc` - Create **context issue** (session state dump)
- `nnn` - Create **task issue** (implementation plan)

**Why this matters**:
- Clean separation: context dumps ≠ actionable tasks
- Better organization: context issues are snapshots, task issues are plans
- Intelligent workflow: `nnn` auto-runs `ccc` if no recent context

**Application for us**:
- We have `/recap` (similar to `ccc`)
- We could formalize "context issue" vs "plan issue" distinction
- Current: We mix context and planning in same issue

### 2. Mandatory Retrospective Sections

**From gist - CRITICAL sections**:

```markdown
## 📝 AI Diary (REQUIRED - DO NOT SKIP)
**⚠️ MANDATORY: This section provides crucial context for future sessions**
[Write a detailed first-person narrative of your experience during this session. Include:
- Initial understanding and assumptions
- How your approach evolved
- Moments of confusion or clarity
- Decisions made and why
- What surprised you
- Internal thought process]

## 💭 Honest Feedback (REQUIRED - DO NOT SKIP)
**⚠️ MANDATORY: This section ensures continuous improvement**
[Provide frank, unfiltered assessment of:
- Session effectiveness
- Tool performance and limitations
- Communication clarity
- Process efficiency
- What frustrated you
- What delighted you
- Suggestions for improvement]

## ✅ Retrospective Validation Checklist
**BEFORE SAVING, VERIFY ALL REQUIRED SECTIONS ARE COMPLETE:**
- [ ] AI Diary section has detailed narrative (not placeholder)
- [ ] Honest Feedback section has frank assessment (not placeholder)
- [ ] Session Summary is clear and concise
- [ ] Timeline includes actual times and events
- [ ] Technical Details are accurate
- [ ] Lessons Learned has actionable insights
- [ ] Next Steps are specific and achievable
```

**Why this matters**:
- **AI Diary**: First-person narrative = reflection + vulnerability
- **Honest Feedback**: Frank assessment = continuous improvement
- **Validation**: Ensures no section is skipped

**Current state in our project**:
- ✅ We HAVE AI Diary in Thai (เซสชันนี้...)
- ✅ We HAVE Honest Feedback section
- ❌ We DON'T have validation checklist
- ❌ Sections not marked as MANDATORY/REQUIRED

**Gap**: Our retrospectives are already good, but we could:
- Add validation checklist
- Mark AI Diary and Honest Feedback as REQUIRED
- Emphasize the importance more strongly

### 3. Time Zone Handling

**Pattern from gist**:
```markdown
**Session Date**: ${SESSION_DATE}
**Start Time**: [FILL_START_TIME] GMT+7 ([FILL_START_TIME] UTC)
**End Time**: ${END_TIME_LOCAL} GMT+7 (${END_TIME_UTC} UTC)
```

**Rule**:
- **PRIMARY TIME ZONE: GMT+7** - Always show GMT+7 first
- UTC in parentheses for reference
- File names may use UTC for technical consistency

**Current state in our project**:
- We use Bangkok time (GMT+7) consistently
- No dual time zone display

**Application**:
- Keep GMT+7 as primary (already doing this)
- Could add UTC in parentheses for international collaboration
- Not urgent - our current approach works

### 4. The `lll` Status Check Pattern

**From gist**:
```markdown
#### `lll` - List Project Status ✅
When you see `lll`, execute relevant `gh` and `git` commands in parallel
to get a full overview of the project's state, then provide a visual
summary of open issues, recent PRs, and current focus.
```

**Why this matters**:
- Quick project overview
- Parallel command execution
- Visual summary format

**Current state in our project**:
- We have `/wip` (pending tasks)
- We have `/standup` (schedule check)
- We DON'T have unified status check

**Application**:
- Could create `/status` or `lll` command
- Combine: git status, open issues, recent commits, current focus
- Useful for session starts

### 5. Short Code Philosophy

**Gist's short codes**:
| Code | Purpose | Our Equivalent |
|------|---------|----------------|
| `ccc` | Create context & compact | `/recap` + compact |
| `nnn` | Next task planning | Manual planning |
| `gogogo` | Execute plan | Manual execution |
| `lll` | List status | `/wip` + `/standup` |
| `rrr` | Retrospective | `rrr` ✅ (same!) |

**Pattern**: Short, memorable, action-oriented codes

**Current state**:
- We have `rrr` (retrospective)
- We use `/snapshot` (quick capture)
- We use `/distill` (extract patterns)
- We use `/context-finder` (search)

**Philosophy difference**:
- **Gist**: GitHub-centric workflow (issues, PRs, compact)
- **Our project**: Oracle/ψ structure (learnings, retrospectives, context)

### 6. Lessons Learned Section Structure

**From gist**:
```markdown
### Planning & Architecture Patterns (2025-08-26)
-   **Pattern**: Use parallel agents for analyzing different aspects
-   **Anti-Pattern**: Creating monolithic plans
-   **Pattern**: Ask "what's the minimum viable first step?"
-   **Pattern**: 1-hour implementation chunks

### Common Mistakes to Avoid
-   **Creating overly comprehensive initial plans** - Break into 1-hour phases
-   **Trying to implement everything at once** - Start with MVP

### Useful Tricks Discovered
-   **Parallel agents for analysis** - Speeds up planning
-   **ccc → nnn workflow** - Better structured issues

### User Preferences (Observed)
-   **Prefers manageable scope** - Tasks under 1 hour
-   **Values phased approaches** - Splitting work
-   **Time zone preference: GMT+7 (Bangkok/Asia)**
```

**Why this matters**:
- Continuously updated (dates noted)
- Clear categorization: Patterns, Mistakes, Tricks, Preferences
- User preferences captured

**Current state in our project**:
- We have `ψ/memory/learnings/` directory
- Individual learning files
- NOT consolidated in CLAUDE.md

**Gap**:
- Could add "Recent Learnings" section to CLAUDE.md
- Link to detailed learning files
- Quick reference for common patterns

### 7. Critical Safety Rules Presentation

**From gist - Clear formatting**:
```markdown
## 🔴 Critical Safety Rules

### Git Operations
-   Never use `git push --force` or `git push -f`.
-   Never use `git checkout -f`.
-   Never use `git clean -f`.
-   **⚠️ NEVER MERGE PULL REQUESTS WITHOUT EXPLICIT USER PERMISSION**

### File Operations
-   Never use `rm -rf` - use `rm -i` for interactive confirmation.
```

**Why this matters**:
- Visual markers (🔴, ⚠️)
- Explicit "Never" statements
- Clear categorization

**Current state in our project**:
- We have safety rules in CLAUDE_safety.md
- Clear but less visually prominent

**Application**:
- Add emoji markers for critical rules
- Consider inline safety reminders in workflows

---

## What We Should Adopt

### High Priority

1. **Retrospective Validation Checklist** ✅
   - Add to our retrospective template
   - Ensure AI Diary and Honest Feedback are never skipped
   - Mark sections as REQUIRED

2. **Status Check Command** (`lll` or `/status`)
   - Quick project overview
   - Combine git status + focus + pending work
   - Useful for session starts

3. **Lessons Learned in CLAUDE.md**
   - Add "Recent Learnings" section
   - Quick reference for patterns
   - Link to detailed files in ψ/memory/learnings/

### Medium Priority

4. **Two-Issue Pattern Formalization**
   - Clarify context issues vs plan issues
   - Document when to use each
   - Consider implementing `ccc` + `nnn` workflow

5. **Visual Safety Markers**
   - Add emoji markers (🔴, ⚠️) to critical rules
   - Make safety rules more visually prominent

### Low Priority

6. **Dual Time Zone Display**
   - Add UTC in parentheses
   - Only if working with international teams
   - Current GMT+7 approach works fine

---

## What We Already Do Well

1. ✅ **AI Diary in retrospectives** - We already write detailed reflections in Thai
2. ✅ **Honest Feedback** - We already have frank assessments
3. ✅ **Oracle philosophy** - Deeper than generic template
4. ✅ **ψ/ structure** - More nuanced than GitHub-only workflow
5. ✅ **Subagent patterns** - More sophisticated than generic template
6. ✅ **Session activity logging** - Real-time focus tracking

---

## Key Differences: Generic vs Our Project

| Aspect | Generic Template | Our Project |
|--------|------------------|-------------|
| **Workflow** | GitHub-centric (issues/PRs) | Oracle/ψ structure |
| **Short codes** | `ccc`, `nnn`, `gogogo`, `lll` | `rrr`, `/snapshot`, `/distill` |
| **Context** | Compact + context issues | Retrospectives + learnings |
| **Philosophy** | Generic dev practices | Oracle philosophy |
| **Time tracking** | Manual timestamps | Real-time focus.md |
| **Agent model** | Single agent assumed | Multi-agent coordination |

**Insight**: Generic template = great foundation, our project = deeper patterns

---

## Immediate Actions

### 1. Update Retrospective Template (High Priority)

Add to `CLAUDE_templates.md`:
- ✅ Retrospective Validation Checklist
- ✅ Mark AI Diary as REQUIRED
- ✅ Mark Honest Feedback as REQUIRED

### 2. Create `/status` Command (Medium Priority)

New slash command to show:
- Current focus (from focus.md)
- Git status
- Pending work (from WIP.md)
- Recent commits (last 3)
- Quick health check

### 3. Add Recent Learnings to CLAUDE.md (Low Priority)

Section showing:
- Last 5 learnings (with dates)
- Quick patterns reference
- Link to full ψ/memory/learnings/ directory

---

## Conclusion

The gist provides excellent **generic CLAUDE.md structure** that complements our **project-specific Oracle patterns**.

**Key takeaway**:
- Generic template = strong foundation for any project
- Our project = deeper philosophical framework (Oracle, ψ structure)
- Best of both worlds = Generic patterns + Oracle depth

**Next step**: Adopt validation checklist and status check, keep our unique strengths.
