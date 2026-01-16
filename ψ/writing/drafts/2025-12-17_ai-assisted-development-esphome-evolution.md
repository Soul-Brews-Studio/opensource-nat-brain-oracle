# 49% of My Issues Are "Context" — What AI-Assisted Development Actually Looks Like

**Created**: 2025-12-17 22:10 GMT+7
**Status**: 📝 Draft
**Author**: Human + AI collaboration

---

## 📚 Sources Index

| Type | File | Key Topics |
|------|------|------------|
| Analysis | ψ/active/context/esphome-fw-oracle-patterns.md | Constitution evolution, governance patterns |
| Analysis | ψ/memory/learnings/2025-12-17_template-evolution-analysis.md | Template generations |
| Analysis | ψ/learn/esphome-fw/*.md | Architecture, code snippets, history |
| Data | esphome-fw GitHub Issues | 131 issues, 92 PRs analyzed |

---

## 🎯 TL;DR

After analyzing 131 GitHub issues from my IoT firmware project (esphome-fw), I discovered something surprising: **49% of all issues are "Context" or "Plan" types** — not bugs, not features, but AI session tracking. This is what AI-assisted systematic development actually looks like.

---

## 🔥 The Problem

Most articles about AI-assisted coding show:
- "I asked ChatGPT to write a function"
- "Claude helped me debug this error"
- One-shot interactions with immediate results

But what does AI-assisted development look like at **project scale**? Over **months**? With **hundreds of commits**?

I traced through a year of my own work to find out.

---

## 🛤️ The Journey

### The Data: esphome-fw Repository

| Metric | Value |
|--------|-------|
| Total commits | 541 |
| Development span | Nov 2024 - Oct 2025 |
| GitHub Issues | 131 |
| Pull Requests | 92 |
| Devices managed | 650+ |

This is a production IoT firmware platform. 28+ device families. Real hardware in the field.

### The Surprise: Issue Distribution

When I analyzed all 131 issues by type:

| Type | Count | % |
|------|-------|---|
| **Context** | 38 | 29% |
| **Plan** | 26 | 20% |
| Feature | 35 | 27% |
| Bug/Fix | 22 | 17% |
| Experiment | 10 | 7% |

**49% of issues are "Context" or "Plan"** — AI session tracking, not traditional development tasks.

### What Are Context Issues?

A "Context" issue captures the AI's working state:

```markdown
## Context: FloodBoy Battery Drain Investigation

**Session**: 2025-08-26 14:30 GMT+7
**Focus**: Battery draining when WiFi connected but MQTT unreachable

**Current Understanding**:
- Devices 026-035 showing 42-hour battery life (expected: months)
- WiFi stays connected even when MQTT broker down
- AP mode timeout might be culprit

**Investigated**:
- Power management code ✓
- MQTT reconnection logic ✓
- WiFi sleep modes (in progress)

**Next Steps**:
1. Test AP timeout reduction (25min → 15min)
2. Add power state logging
```

This isn't a bug report. It's **external memory** — the AI documenting what it knows so far.

### What Are Plan Issues?

A "Plan" issue proposes an implementation approach:

```markdown
## Plan: AP Timeout Optimization

**Context**: Issue #153 (Battery Drain Investigation)

**Approach**: Reduce AP mode timeout from 25min to 12min

**Rationale**:
- Device enters AP mode when WiFi fails
- AP mode consumes significant power
- 25 minutes is excessive for field devices

**Implementation**:
1. Modify wifi.ap_timeout in common.yml
2. Test on device fb026
3. Monitor battery consumption for 48 hours

**Risk**: Users may not have enough time to configure via AP
**Mitigation**: Add status LED indication when AP active
```

This is **planning before implementation** — the AI thinks through the approach before writing code.

---

## 💡 Aha Moment: The Constitution Pattern

Looking deeper, I found something unexpected. The repository has a **Constitution**:

```markdown
# ESPHome Firmware Platform Constitution v1.2.2

## Principle I: Safety-First Operations
- NEVER use -f or --force flags
- NEVER use rm -rf without explicit user permission
- All operations must be reversible

## Principle II: Validate-Before-Deploy
- Every config MUST compile before deployment
- Post-implementation testing mandatory

## Principle VI: Task Granularity
- Max 60 minutes per task
- Large features split into subtasks
```

And this constitution **evolved**:

| Version | Change | Trigger |
|---------|--------|---------|
| v1.0.0 | Initial principles | Project start |
| v1.2.0 | Added task time limits | Sessions running too long |
| v1.2.1 | Git-first backup | Backup directory confusion |
| v1.2.2 | rm -rf prohibition | **Actual violation in session** |

**Each amendment came from a real problem.** The AI learned from mistakes and encoded the learning in governance.

---

## ✅ The Solution: What Emerged

After a year of development, what emerged is a **systematic AI development pattern**:

### 1. Context → Plan → Implement → Reflect

```
Context Issue (#153)     → Understand the problem
    ↓
Plan Issue (#154)        → Design the solution
    ↓
Implementation PR (#87)  → Write the code
    ↓
Retrospective           → Document what was learned
```

Every significant change follows this pattern. **49% of issues are the thinking, not the doing.**

### 2. Constitutional Governance

The AI operates under explicit constraints:
- Safety rules (no force flags)
- Time limits (60 min max per task)
- Documentation requirements (inline comments)
- Verification requirements (must compile)

### 3. Retrospective-Driven Learning

Every session ends with reflection:

```markdown
## AI Diary

This session was humbling. I spent 2 hours debugging UART
communication before realizing the radar wasn't even powered on.

Lesson: "Is it turned on?" should come before "Is it configured
correctly?"
```

The AI doesn't just code. It **reflects on its own process**.

---

## 🧠 The Pattern: Oracle Philosophy

What I discovered is a systematic approach I call **Oracle Philosophy**:

### Three Pillars

1. **Nothing is Deleted** — Every session creates a retrospective. History is preserved.
2. **Patterns Over Intentions** — Constitution built on observed behavior, not ideals.
3. **External Brain, Not Command** — AI documents and suggests, human confirms.

### The Numbers

| Pattern | Evidence |
|---------|----------|
| Context issues | 38 (29%) — AI externalizes working memory |
| Plan issues | 26 (20%) — AI thinks before acting |
| Constitutional amendments | 5 — Learning encoded in governance |
| Retrospectives | 36+ — Every session documented |
| Merge rate | 94.6% — High trust, validated approach |

---

## 📊 Evolution Timeline

The CLAUDE.md (AI instructions) evolved through three generations:

### Gen 1: Monolithic (559-766 lines)
Everything in one file. All instructions embedded.

### Gen 2: Hybrid (46-592 lines + .specify/)
CLAUDE.md + separate templates and memory folders.
- Constitution in `.specify/memory/constitution.md`
- Templates for plans, specs, tasks
- Multi-agent support

### Gen 3: Modular (292 lines + satellite docs)
Lean hub + specialized files:
- CLAUDE_safety.md
- CLAUDE_workflows.md
- CLAUDE_subagents.md
- ψ/ brain structure (5 pillars)

**Pattern**: Templates get copied, customized, and evolve independently per project.

---

## 🔑 Key Takeaways

### 1. AI-Assisted Development Is Mostly Thinking

49% of my issues are Context or Plan. The AI spends more time understanding and planning than coding.

### 2. Governance Evolves From Violations

Every constitutional amendment came from a real problem. The AI learns by making mistakes and encoding the learning.

### 3. External Memory Is Critical

Context issues are the AI's working memory externalized. Without them, each session starts from zero.

### 4. Retrospectives Enable Learning

The "AI Diary" section forces honest reflection. Vulnerabilities are documented, not hidden.

### 5. Templates Propagate Patterns

Once a good pattern emerges (like .specify/), it gets copied to new projects and evolves independently.

---

## 📖 Full Context (for AI continuation)

### Repository Stats

| Repo | Commits | Constitution | Pattern |
|------|---------|--------------|---------|
| esphome-fw | 541 | v1.2.2 (complete) | Parent template |
| esphome-heating-visualizer | 57 | Templated (unfilled) | Multi-agent evolution |
| esphome-radar | 57 | v0.1.0 (early) | Specialized fork |

### Issue Evolution by Month

| Month | Issues | Focus |
|-------|--------|-------|
| Jun 2025 | 79 | Peak development, radar features |
| Aug 2025 | 10 | Battery drain crisis (resolved in 12 days) |
| Sep 2025 | 41 | Governance refinement, modem R&D |

### Constitutional Timeline

- **v1.0.0**: Initial 6 principles
- **v1.1.7**: Context retrieval standards
- **v1.2.0**: Task granularity principle
- **v1.2.1**: Git-first backup
- **v1.2.2**: rm -rf prohibition (post-violation)

---

## 🏷️ Tags

`ai-development` `oracle-philosophy` `governance` `iot` `esphome` `claude` `systematic-development`

---

## 📝 Writing Notes

### Tone
- Technical but accessible
- Data-driven with real numbers
- Personal discovery narrative

### Target Audience
- Developers using AI assistants
- Technical leads exploring AI integration
- Anyone curious about long-term AI-assisted development

### Suggested Title Alternatives
1. "49% of My GitHub Issues Are AI Thinking Out Loud"
2. "What a Year of AI-Assisted Development Actually Looks Like"
3. "The Constitution My AI Wrote (And Why It Has Amendments)"
4. "Context Issues: The Secret to AI Development at Scale"

### Key Visual Opportunities
- Issue type pie chart (49% thinking)
- Constitution evolution timeline
- Template generation diagram (Gen 1 → Gen 2 → Gen 3)
- Context → Plan → Implement → Reflect flow

### Next Steps
- [ ] Review draft
- [ ] Add diagrams/visuals
- [ ] Polish opening hook
- [ ] Review Oracle philosophy explanation
- [ ] Add code examples from real issues
- [ ] Publish

---

*Draft generated from esphome-fw repository analysis*
*Ready for human review and AI continuation*
