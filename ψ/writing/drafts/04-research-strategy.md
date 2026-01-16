# Blog Writing Research: Nat's Agents Project

**Research Date**: 2025-12-10
**Status**: Complete
**Purpose**: Strategy for writing blog posts about the Nat's Agents project

---

## EXISTING BLOG ASSETS

### Found: Plugin Debugging Blog Draft
**File**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ-context/001_plugin-debugging/blog-draft.md` (8.5 KB)

**Current State**: COMPLETE AND PUBLICATION-READY
- 507 lines of structured content
- Real debugging timeline (25 minutes actual work + 2+ hours documentation)
- Problem-Solution format with code examples
- Key discoveries documented with evidence
- Lessons for future plugin developers

**Unique Angle**: 
> "How comparing a working plugin to a broken one reveals pattern design, and why Claude Code's auto-discovery convention is actually smarter than explicit configuration."

**Target Audience**: Developers building Claude Code plugins

**Recommended Topics**: Plugin development best practices

---

## NAT'S WRITING STYLE

### Core Voice
- **Direct**: Say what needs to be said (no fluff)
- **Concise**: No unnecessary words
- **Technical when needed**: Precise terms, exact code examples
- **Human always**: Conversational, never robotic

### Language Mix
- Thai for: Casual moments, emotional context, cultural references
- English for: Technical content, code, universal concepts
- Natural blend as conversation flows

### Formatting Signature
- Tables for comparison/data
- Code blocks for commands
- Bullet points for lists
- Minimal emojis (only when requested)

### Communication Patterns
- Ask clarifying questions early
- Show work in progress
- Admit uncertainty honestly
- Celebrate small wins quietly

**Source**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/plugins/nat-data-personal/knowledge/writing-style.md`

---

## KEY PROJECT TOPICS READY FOR BLOG CONTENT

### Topic 1: Oracle Philosophy (The Mindset)
**File**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/plugins/nat-data-personal/knowledge/oracle-philosophy.md`

**Core Pillars**:
1. Nothing is Deleted - Append only, timestamps = truth
3. Patterns Over Intentions - Observe what happens, not what's meant
4. External Brain, Not Command - Mirror reality, don't decide

**Blog Angle**: "Why Your AI Shouldn't Try to Clone Your Consciousness"
- Explains the philosophical foundation
- Addresses common misconceptions about AI knowledge capture
- Shows what can/can't be preserved about humans in systems

**Target Audience**: Founders, AI practitioners, anyone building personal knowledge systems

---

### Topic 2: Knowledge Distillation Loop (The System)
**File**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ-learnings/007-knowledge-distillation-loop.md`

**Three-Layer Architecture**:
- Layer 1: Retrospectives (Exhaustive, 20-50KB) - `ψ-retrospectives/`
- Layer 2: Logs (Snapshots, 3-5KB) - `ψ-logs/`
- Layer 3: Learnings (Distilled, 1-2KB) - `ψ-learnings/`
- Final: CLAUDE.md (Crystallized Wisdom)

**Blog Angle**: "How to Build a Self-Improving Documentation System"
- Shows the information flow: noise → signal → wisdom
- Demonstrates human confirmation at key points
- Makes knowledge reusable, not just archived

**Target Audience**: Project managers, documentation engineers, knowledge workers

---

### Topic 3: Modular CLAUDE Documentation (The Reference)
**File**: `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE.md`

**Key Sections**:
- File Access Rules (user must know about file ops)
- Context Folder Convention (ψ-context/)
- Subagent Rules (Haiku for search, Opus for decisions)
- Philosophy (Oracle/Shadow)
- Tool Preferences (uv for Python, gh for GitHub)

**Blog Angle**: "Instruction Files as Living Documentation"
- How to write project rules that AI actually follows
- The philosophy behind modular, nested instructions
- Why CLAUDE.md is different from README.md

**Target Audience**: AI practitioners, project leads, open-source maintainers

---

### Topic 4: ψ Convention (The Structure)
**Folder Structure**: 
```
ψ-context/        (gitignored context work)
  NNN_project/
    name.md

ψ-retrospectives/ (exhaustive session notes)
  YYYY-MM/DD/
    HH.MM_slug.md

ψ-learnings/      (reusable insights)
  NNN-topic.md

ψ-logs/           (quick snapshots)
  YYYY-MM/DD_HH.MM_slug.md
```

**Blog Angle**: "ASCII Folder Naming: How to Organize 100+ Context Files"
- Why sequential numbering matters
- How the ψ symbol helps humans find AI-related work quickly
- Demonstrates: convention > configuration

**Target Audience**: Knowledge workers, researchers, documentation teams

---

### Topic 5: Subagent Pattern (The Architecture)
**Reference**: CLAUDE.md section on "Subagent Rules"

**Pattern**:
- Haiku (context-finder) reads widely, summarizes
- Opus reads summaries, makes decisions
- Main agent doesn't read files directly for context

**Blog Angle**: "Divide and Conquer: How to Use Multiple AI Models Efficiently"
- Token efficiency (Haiku cheaper to run searches)
- Separation of concerns (search vs. decision)
- Why it's better than "one AI does everything"

**Target Audience**: AI engineers, SREs, anyone optimizing for cost/speed

---

## BLOG POST STRUCTURE TEMPLATE

Based on Nat's style and existing draft, here's the recommended structure:

### Header
```markdown
# Blog Title

**Author**: [Nat + Claude Opus]
**Date**: YYYY-MM-DD
**Read time**: ~X minutes
**Tags**: tag1, tag2
```

### Opening (2 paragraphs)
- Hook with the problem/insight
- Why this matters to the reader
- What they'll learn

### Body (3-5 sections)
- Problem/Context
- Discovery/Solution
- Code examples (when relevant)
- Tables for comparison
- Timeline if applicable

### Key Takeaways (Bullet points)
- 3-5 main lessons
- Actionable patterns

### Closing
- What's next
- Invitation to try/share
- Honest reflection on limitations

### Footer
- File references
- Related reading
- Tools used

---

## IMMEDIATE BLOG OPPORTUNITIES

### Priority 1: Publish Plugin Debugging Post (READY NOW)
- **File**: `ψ-context/001_plugin-debugging/blog-draft.md`
- **Status**: COMPLETE
- **Action**: Minor polish + publish to Medium/dev.to
- **Why**: Real story, concrete lessons, helps other developers
- **Time to publish**: 30 minutes

### Priority 2: Oracle Philosophy Explainer (MEDIUM EFFORT)
- **Source**: oracle-philosophy.md + distillation-loop.md
- **Structure**: Philosophy + why it works + practical application
- **Estimated length**: 1500-2000 words
- **Audience**: AI/automation founders
- **Time to write**: 2-3 hours

### Priority 3: Knowledge Distillation System (MEDIUM EFFORT)
- **Source**: 007-knowledge-distillation-loop.md + retrospectives
- **Structure**: The problem + 3-layer solution + benefits
- **Estimated length**: 1200-1500 words
- **Audience**: Knowledge workers, project managers
- **Time to write**: 2-3 hours

### Priority 4: ψ Convention Deep Dive (LOWER PRIORITY)
- **Source**: CLAUDE.md + folder structure
- **Structure**: Why naming matters + the system + examples
- **Estimated length**: 800-1000 words
- **Audience**: Technical documentation people
- **Time to write**: 1-2 hours

---

## WRITING TIPS FOR EACH TOPIC

### For Plugin Debugging Post
- Already complete, just needs:
  - Opening paragraph to hook readers
  - "Further reading" section linking to Claude Code docs
  - Maybe a "How to debug YOUR plugins" quick checklist

### For Oracle Philosophy Post
- Start with the quote: "The Oracle Keeps the Human Human"
- Use table comparing "what captures" vs "doesn't capture"
- Real example: How it worked for Nat's project
- Address: Why you might want an Oracle for YOUR project

### For Knowledge Distillation Post
- Visual diagram of the 3-layer flow
- Real session example: retrospective → log → learning
- Show file sizes shrinking (noise being removed)
- Benefits: Reusability, human confirmation, better decisions

### For ψ Convention Post
- Start with the problem: "100 context files, where do they go?"
- Show the folder tree
- Explain each convention choice
- Examples of what belongs where

---

## MEASUREMENT & DISTRIBUTION

### Where to Publish
- **Dev.to**: Technical audience (plugin developers, AI engineers)
- **Medium**: Broader audience (founders, knowledge workers)
- **Hashnode**: Developer community (alternative tech platform)
- **Project Blog**: If Laris Co has one (host all posts there)

### How to Share
- @NatLarsen Twitter/X
- Relevant Slack communities
- GitHub discussions
- Link from CLAUDE.md "Further Reading" sections

### Track Success
- Clicks/views
- Comments and feedback
- GitHub stars/interest
- New plugin developers citing the guide

---

## FILES TO REFERENCE IN POSTS

### For Internal Linking
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/CLAUDE.md` - Main project rules
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/plugins/nat-data-personal/knowledge/oracle-philosophy.md`
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ-learnings/007-knowledge-distillation-loop.md`
- `/Users/nat/Code/github.com/laris-co/Nat-s-Agents/plugins/nat-data-personal/knowledge/writing-style.md`

### For External Linking
- Claude Code documentation
- GitHub plugin development guides
- Medium/Dev.to other AI posts

---

## NEXT STEPS

1. **Polish Plugin Debugging Post** - Add intro, outro, checklist (30 min)
2. **Draft Oracle Philosophy Post** - Use existing content, add narrative (2-3 hrs)
3. **Draft Knowledge Distillation Post** - Add visuals, real example (2-3 hrs)
4. **Create publication timeline** - Map posts to Twitter/Medium/Blog
5. **Build "blog" folder** - Centralized location for all blog content

---

**Status**: Ready to write! Start with the debugging post since it's already 90% done.
