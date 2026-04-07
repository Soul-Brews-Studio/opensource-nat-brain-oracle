# Courses Catalog — Distilled

> Distilled from 82 files across `courses/` directory
> Original: 18 workshops, 205+ slides, 3 starter kits
> Distilled: 2026-03-11

---

## Table of Contents

1. [Workshop Catalog Overview](#workshop-catalog-overview)
2. [Course Genealogy & Inheritance](#course-genealogy--inheritance)
3. [Core Series (v1 Legacy)](#core-series-v1-legacy)
   - [000 Setup](#000-setup--1h--everyone)
   - [001 Imagination](#001-imagination--2h--intermediate)
   - [002 Control](#002-control--3h--advanced)
   - [003 AI Life Buddy](#003-ai-life-buddy--4h--intermediate)
4. [Flagship Workshops (v2)](#flagship-workshops-v2-jan-2026)
   - [AI Life Buddy Workshop](#ai-life-buddy-workshop)
   - [Build Your Oracle (3 Days)](#build-your-oracle-workshop--3-days)
   - [Psychology + AI (2 Days)](#psychology--ai-workshop--2-days)
5. [Business Courses](#business-courses)
   - [Claude Code Masterclass for Business](#claude-code-masterclass-for-business)
   - [AI Automation Thai](#ai-automation-thai--2-days)
   - [AI Builder 2-Day](#ai-builder-2-day-workshop)
6. [FREE Funnel Courses](#free-funnel-courses)
   - [Git + Codespaces](#git--github-codespaces--free)
   - [Git Workflow for AI Builders](#git-workflow-for-ai-builders--free)
   - [Multi-Agent Orchestra](#multi-agent-orchestra--free)
7. [Delivered: SIIT Dec 2025](#delivered-siit-dec-2025)
8. [Starter Kits](#starter-kits)
   - [AI Life Buddy Starter Kit](#ai-life-buddy-starter-kit)
   - [Build Your Oracle Starter Kit (Code)](#build-your-oracle-starter-kit)
   - [Psychology + AI Starter Kit](#psychology--ai-starter-kit)
9. [Templates & Tools](#templates--tools)
10. [Gemini Slide Prompts](#gemini-slide-generation-prompts)
11. [Revenue & Pricing Summary](#revenue--pricing-summary)

---

## Workshop Catalog Overview

| Metric | Count |
|--------|-------|
| Total Workshops | 18 |
| Ready to Deliver | 3 |
| In Development | 9 |
| Ideas | 3 |
| FREE (Funnel) | 3 |

### By Audience

| Audience | Workshops |
|----------|-----------|
| Developers | Build Your Oracle, 002-control |
| Knowledge Workers | AI Life Buddy, 001-imagination |
| Academics | Psychology + AI |
| Business | Claude Code Masterclass, AI Automation Thai |
| Everyone | 000-setup, FREE Git courses |

### Workshop Generations

| Generation | Created | Format |
|------------|---------|--------|
| v1 (Legacy) | Dec 2025 | Markdown outlines |
| v2 (Current) | Jan 8, 2026 | Slide outlines + Modules + Starter Kits |
| FREE (Funnel) | Jan 10, 2026 | Lead generation |

---

## Course Genealogy & Inheritance

```
000-setup (root)
|
+-- 001-imagination (inherits: 000)
|   +-- 002-control (inherits: 001)
|   +-- skilllane/01-ai-builder (remix: 001 + pricing)
|
+-- siit-2025-12 (remix: 000 + 001, workshop format)
    +-- ai-builder-2day (inherits: siit delivery style)
    |   +-- tingting-friends (inherits: ai-builder-2day)
    +-- skilllane/02-masterclass (remix: siit + online format)
```

### DNA Registry Summary

| Course | Format | Duration | Level | Pricing |
|--------|--------|----------|-------|---------|
| 000-setup | online | 1h | everyone | free |
| 001-imagination | online | 2h | intermediate | free |
| 002-control | online | 3h | advanced | free |
| siit-2025-12 | workshop | 6h (2 days) | intermediate | institutional |
| ai-builder-2day | workshop | 2 days | intermediate | custom |
| skilllane/01 | online video | 8h 45m | beginner | B1,590 |
| skilllane/02 | online video | 7h 20m | advanced | B2,490 |

### Genes That Spread Across Courses
- "Demo -> Try -> Review" cycle (from SIIT)
- "45-min learning blocks" (from SIIT)
- "Build something real" philosophy (from 001)

---

## Core Series (v1 Legacy)

### 000 Setup | 1h | Everyone

**Status**: Idea | **Thai Title**: เตรียมเครื่องเพื่อใช้ Claude Code

**Core Concept**: "ก่อนจะวิ่งได้ ต้องผูกเชือกรองเท้าให้เป็นก่อน"

**Target**: Non-technical, anyone wanting to start

**Topics**: Terminal basics, install Homebrew/Node.js, install Claude Code, API key setup, first `claude` run (Mac + Windows paths)

**Success Criteria**: Non-technical person can type `claude` and see the prompt

---

### 001 Imagination | 2h | Intermediate

**Status**: Idea | **Thai Title**: เปิดจินตนาการไปกับ Claude Code

**Core Concept**: "Claude Code ไม่ใช่แค่ tool แต่เป็น thinking partner"

**Topics**: Oracle/Shadow philosophy setup, personal knowledge system (psi/ structure), retrospectives, subagent design, AI "memory" and learning

**Target**: People wanting AI beyond Q&A, building personal "thinking systems"

---

### 002 Control | 3h | Advanced

**Status**: Idea | **Thai Title**: ควบคุม AI สั่งงานให้ได้ดั่งใจ

**Core Concept**: "รู้วิธีสื่อสาร = ได้ผลลัพธ์ที่ต้องการ"

**Topics**: CLAUDE.md design, subagent architecture, command design, timestamp rules, safety rules, model tier strategy (Haiku vs Opus)

**Target**: Developers already using Claude Code, teams wanting consistent AI workflow

---

### 003 AI Life Buddy | 4h | Intermediate

**Thai Title**: ให้ AI เป็นเพื่อนคู่คิด

**Outcome**: Personal AI system that knows you

**5-Part Structure**:

| Part | Duration | Content |
|------|----------|---------|
| 1. Philosophy | 30 min | Oracle principles, "AI keeps human human" |
| 2. Folder Structure | 45 min | psi/ 5 pillars: active, inbox, writing, lab, memory |
| 3. Custom Commands | 60 min | /feel, /fyi, /jump, /rrr |
| 4. Life Tracking | 45 min | Work patterns, feelings, AI pattern discovery |
| 5. Retrospectives | 60 min | Session retrospectives, handoffs, compound effect |

**Key psi/ Structure**:
```
psi/
+-- active/     <- Current research
+-- inbox/      <- Communication
+-- writing/    <- Creative output
+-- lab/        <- Experiments
+-- memory/
    +-- resonance/      WHO I am
    +-- learnings/      PATTERNS I found
    +-- retrospectives/ SESSIONS I had
    +-- logs/           MOMENTS captured
```

**Takeaways**: Personal AI system, 4 custom commands, life tracking templates, retrospective habit, customized CLAUDE.md

---

## Flagship Workshops (v2, Jan 2026)

### AI Life Buddy Workshop

50 slides, 4 hours. Full slide outline covering all 5 parts (see 003 above).

**Design Notes**: Minimal text per slide, code blocks for technical, Thai headings + English code, hands-on at slides 18/23/26/36/46.

---

### Build Your Oracle Workshop | 3 Days

> "Build an AI Knowledge System That Survives Its Own Success"

**Pricing**: $1,200 solo | $4,000 team (5) | $400 self-paced bundle

**The Journey**:

| Day | Module | Focus | Core Insight |
|-----|--------|-------|--------------|
| 1 | Memory | SQLite + FTS5 + Markdown + Git | Nothing is Deleted |
| 2 | Survival | context-finder, cost optimization | Scale or Die |
| 3 | Intelligence | ChromaDB, hybrid search, oracle commands | External Brain |

**95 slides total** (30/day + 5 closing), 12 hands-on sessions

#### Module 1: Memory (1 day, $400 live / $150 self-paced)

Build personal knowledge system with SQLite + Markdown dual storage.

**Key Schema**:
```sql
CREATE TABLE observations (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  content TEXT NOT NULL,
  type TEXT DEFAULT 'observation',
  source_file TEXT,
  concepts TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE VIRTUAL TABLE observations_fts
USING fts5(content, source_file, content=observations, content_rowid=id);
```

**Triggers for FTS sync** (INSERT, DELETE, UPDATE all handled).

**Deliverables**: Working SQLite DB, FTS5 index, indexed markdown files, CLI search tool

#### Module 2: Survival (1 day, $500 live / $200 self-paced)

**The Death Spiral**:
```
100 files  -> $0.15/search -> Fine
1,000 files -> $1.50/search -> Hmm
4,000 files -> $6.00/search -> DYING
```

**Discovery-based**: Students experience the pain, then discover context-finder themselves.

**Three-Tier Search**:
| Tier | Tool | Cost | Purpose |
|------|------|------|---------|
| 1 | FTS5 | Free | Keyword match |
| 2 | Haiku | $0.08 | Summarize/filter |
| 3 | Opus | $0.15 | Deep understanding |

**Result**: 85-98% cost reduction, Oracle scales forever

#### Module 3: Intelligence (1 day, $400 live / $150 self-paced)

**Four Oracle Commands**:

```python
# consult - Get advice from your past self
def consult(question):
    context = hybrid_search(question)
    answer = opus_synthesize(question, context)
    return answer

# reflect - Daily wisdom surfacing
def reflect():
    wisdom = random_observation(type='learning')
    return wisdom

# learn - Add new knowledge
def learn(pattern):
    store_observation(pattern, type='learning')
    index_vectors(pattern)
    extract_concepts(pattern)

# supersede - Knowledge evolution (Nothing is Deleted)
def supersede(old_id, new_id, reason):
    # Mark old as outdated, link to new
    db.execute("UPDATE observations SET superseded_by=?, supersede_reason=? WHERE id=?",
               [new_id, reason, old_id])
```

**MCP Integration** (bonus):
```typescript
server.setRequestHandler(CallToolRequestSchema, async (request) => {
  switch (request.params.name) {
    case 'oracle_search': return hybrid_search(request.params.query);
    case 'oracle_consult': return consult(request.params.decision);
    case 'oracle_learn': return learn(request.params.pattern);
  }
});
```

**Emotional Arc**: Day 1 excitement -> Day 2 AM frustration -> Day 2 PM relief -> Day 3 mastery

---

### Psychology + AI Workshop | 2 Days

> "AI ทำให้มนุษย์เป็นมนุษย์มากขึ้น"

**Target**: Psychologists, counselors, educators, therapists
**60 slides**, 50% concept / 30% demo / 20% discussion

#### Day 1: AI as Mirror

- Oracle Philosophy: AI reflects, doesn't replace
- Three Principles mapped to psychology
- **Khandha 5 + AI Framework** (Buddhist psychology meets AI):

| Khandha | Pali | AI Application | AI Capability |
|---------|------|----------------|---------------|
| Rupa (Form) | Rupa | Activity logs, behaviors | Can track |
| Vedana (Feeling) | Vedana | Feeling logs, sentiment | Can track |
| Sanna (Perception) | Sanna | Pattern recognition | Can analyze |
| Sankhara (Formations) | Sankhara | Habit/tendency tracking | Can track |
| Vinnana (Consciousness) | Vinnana | Awareness itself | HUMAN DOMAIN |

**Key Insight**: "Consciousness can't be cloned -- only patterns can be recorded"

#### Day 2: AI in Practice

- 4 application areas: Assessment support, AI-assisted journaling, educational psychology, therapy support
- Ethical boundaries: "AI Guidance, Not AI Therapy"
- Custom workflow creation, implementation roadmap
- Bloom's Taxonomy + AI mapping

---

## Business Courses

### Claude Code Masterclass for Business

**7 hours** (1 full day) | 4 Modules | For business owners, developers, team leads

| Module | Duration | Focus |
|--------|----------|-------|
| 1. Sub Agents | 2h | Delegation, Haiku vs Opus, parallel tasks, 60%+ cost savings |
| 2. Skills | 1.5h | SKILL.md, trigger phrases, email drafter, report generator |
| 3. Commands | 1.5h | Slash commands, chaining, /daily-report, /client-summary |
| 4. MCP | 2h | External integrations, CRM/DB/Slack, custom MCP servers |

**Key Sub Agent Pattern**:
```
Main (Opus) = Manager
Sub Agents (Haiku) = Workers

Search 50 files: Opus only = $3.50, With Haiku = $1.15 (67% savings)
```

**Business Command Examples**: /standup, /invoice-draft, /meeting-prep, /follow-up, /eod, /weekly, /onboard

**MCP Config Example**:
```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-github"],
      "env": { "GITHUB_TOKEN": "${GITHUB_TOKEN}" }
    }
  }
}
```

**Custom MCP Server** (TypeScript):
```typescript
import { Server } from "@modelcontextprotocol/sdk/server";
const server = new Server({ name: "my-custom-mcp", version: "1.0.0" });
server.setRequestHandler("tools/list", async () => ({
  tools: [{ name: "get_customer", description: "Get customer by ID",
    inputSchema: { type: "object", properties: { customerId: { type: "string" } } }
  }]
}));
```

**Landing page structure** and **social media post templates** (Facebook/LinkedIn long form, Twitter thread, IG stories) were included.

---

### AI Automation Thai | 2 Days

> "สร้างระบบ Automation ของตัวเอง ไม่ใช่ copy ของคนอื่น"

**Price**: B4,900 (Early Bird B3,900) | 15 max | Online live

**Competitive Position**: Counter to Sadhu Framework (template-based)

**Philosophy**: "ให้ปลา vs สอนตกปลา" -- skill-based, not template-based

**Day 1**: Automation Mindset + First Build
- 3 Questions Framework: INPUT -> PROCESS -> OUTPUT
- AI Capabilities: READ / THINK / CREATE
- Project levels: A (simple) / B (multi-step) / C (complex)

**Day 2**: Independence + Advanced
- Advanced patterns: Conditional Logic, Data Transformation, Human-in-the-Loop
- Scale & Maintain: Performance, maintenance, reliability, handoff
- Demo Day presentations

**Competitive Analysis vs Sadhu Framework**: Sadhu = B2,900, template lock-in, one niche (Buddhist). Ours = B3,900-4,900, skills transfer, any domain, independence.

---

### AI Builder 2-Day Workshop

> "จากปัญหาของคุณ สู่ Prototype ที่ใช้ได้จริง"

**Price**: B15,000-25,000/person | 8-12 recommended with 1 TA

**Day 1**: Foundation -- Demo in 15 min, first contact, context concepts, define project, MVP build + iterate
**Day 2**: Independence -- System engineering, project structure, git basics, complete MVP, Demo Day

**Also includes 3h mini-workshop** variant (for Tingting's friends) and **1-day workshop** variant with Track A (No-Code) / Track B (Low-Code) / Track C (With Code)

---

## FREE Funnel Courses

### Git + GitHub Codespaces | FREE

**4 hours** | Browser-only, zero install | ~36 slides

**Key**: Press "." in any repo = VS Code in browser. Free 60h/month.

**Structure**: GitHub Setup (30m) -> Codespaces Magic (60m) -> Build HTML page (60m) -> AI + Practice (45m)

**Commit via UI**: Source Control tab -> + to Stage -> type message -> checkmark Commit -> Sync

### Git Workflow for AI Builders | FREE

**4 hours** | Local install | ~35 slides

**3 Commands Only**: `git add .` -> `git commit -m "msg"` -> `git push`

**Funnel Strategy**: FREE Git (4h) -> Trust + Email -> Paid AI Workshop (B15-25k) -> Community

### Multi-Agent Orchestra | FREE

**2 hours** | Beginner-Intermediate

**Tool**: `oracle.sh` -- bash script for inter-agent communication via tmux

```bash
oracle list              # List all agents (tmux sessions)
oracle hey <name> <msg>  # Send message to agent
oracle see <name>        # View agent's terminal
```

**Exercises**: Create agents via tmux, send parallel tasks, orchestrator + workers pattern

**Upsell**: Build Your Oracle ($1,200, 3 days)

---

## Delivered: SIIT Dec 2025

**2-day workshop** at Thammasat Rangsit Campus for Hub of Talents AI

**Day 1**: Foundation + Agent Crafting
- From AI Agent to Agentic AI
- Setup Claude Code CLI
- CLAUDE.md = Your DNA
- Craft Your Agent (Digital Twin)
- Subagents & Multi-Agent Workflow

**Day 2**: Voice + Knowledge Patterns
- Voice commands (STT)
- Hooks & Voice Output
- 5 Patterns: Delegate Reading, Context-Finder FIRST, Human Confirmation, Plugin Architecture, Knowledge Distillation

**Reference Material** (from 48 retrospectives):
- 8 Teaching Topics ranked
- 11 Golden Learnings (delegate reading, context-finder first, STT ambiguity, human confirms, etc.)
- 4 Case Studies (Verification Tax, Options Pattern, Silent Hook Conflict, Multi-AI File Orchestration)
- 5 Anti-Patterns (Assumption Escalation, Context Leakage, Silence as Noise, Lesson Forgetting, Perfect-First Fallacy)

---

## Starter Kits

### AI Life Buddy Starter Kit

**No-code kit** for personal AI system.

**Contents**:
- `CLAUDE.md.example` -- personal AI config template
- `psi-template/` -- folder structure (active, inbox, writing, lab, memory)
- **4 Custom Commands**:
  - `/feel` -- log emotions with context, pattern check, timestamped files
  - `/fyi` -- log information with cross-references, categories
  - `/jump` -- topic switching with return stack (push/pop)
  - `/rrr` -- session retrospective with AI diary, seeds (incremental/transformative/moonshot)
- **3 Templates**: feeling-log, handoff, retrospective

### Build Your Oracle Starter Kit

**Working Python code** for the 3-day workshop.

**Files**:
- `schema.sql` -- Full DB schema with FTS5, triggers, concepts table, views
- `init_db.py` -- Database initialization script
- `oracle.py` -- Day 1-2 CLI (180 lines): init, search, add, index, stats, smart_search
- `oracle_smart.py` -- Day 3 CLI: hybrid search, consult (with Anthropic API), reflect, learn, supersede, stats
- `docs/` -- Quick guides for each day
- `knowledge/example.md` -- Sample knowledge entry
- `templates/` -- learning.md and observation.md templates

**Quick Start**:
```bash
pip install click chromadb
python init_db.py
python oracle.py search "test"
# Day 3:
pip install chromadb anthropic
python oracle_smart.py consult "should I force push?"
python oracle_smart.py reflect
python oracle_smart.py learn "new pattern"
```

### Psychology + AI Starter Kit

**No-code kit** for psychologists, counselors, educators.

**Contents**:
- `frameworks/khandha-5-ai.md` -- Khandha 5 + AI mapping (see above)
- `ethics/guidelines.md` -- Full ethical guidelines ("AI Guidance, Not AI Therapy")
- **2 Prompt Templates**:

**Reflection Analysis Prompt** (uses Khandha 5):
```
Analyze for: 1) Emotional Themes (Vedana), 2) Behavioral Patterns (Sankhara),
3) Cognitive Patterns (Sanna), 4) Potential Blind Spots, 5) Strengths Observed
```

**Pattern Discovery Prompt**:
```
Analyze for: 1) Recurring Patterns, 2) Triggers Identified, 3) Response Patterns,
4) Time-based Patterns, 5) Correlations, 6) Anomalies
```

**Ethics Key Rules**:
- AI CAN: Track patterns, summarize data, surface insights, support research
- AI CANNOT: Diagnose, provide therapy, replace judgment, override consent
- Required: Informed consent, data ownership, local processing preference, human review

---

## Templates & Tools

### Course Template

Standard template for new course design with sections: DNA (format/duration/level/style/pricing), Genealogy, Overview, Target Audience, Learning Outcomes, Modules, Materials, Delivery Notes, Pricing, Success Metrics, Changelog.

### oracle.sh (Multi-Agent Script)

Bash script for mother-child Oracle communication via tmux:
```bash
oracle hey <child> <message>  # Send message
oracle see <child> [lines]    # View terminal
oracle list                   # List sessions
```
Handles long messages via tmux load-buffer, short messages via send-keys.

---

## Gemini Slide Generation Prompts

Three complete prompts for generating slide decks in Gemini:

1. **AI Life Buddy** (50 slides): Thai + English, orange/blue accents, minimal text
2. **Build Your Oracle** (95 slides): Technical, dark mode code blocks, pain-to-solution narrative, blue/purple
3. **Psychology + AI** (60 slides): Academic but accessible, Thai primary, earth tones, Buddhist aesthetic, Khandha 5 diagram

Each prompt includes complete slide-by-slide structure with speaker notes instructions.

---

## Revenue & Pricing Summary

| Workshop | Solo | Team (5) | Self-paced |
|----------|------|----------|------------|
| AI Life Buddy | $400 | $1,500 | $150 |
| Build Your Oracle | $1,200 | $4,000 | $400 |
| Psychology + AI | $800 | $3,000 | $300 |
| **Bundle (all 3)** | **$2,000** | **$7,000** | **$700** |

| Thai Market Course | Price |
|-------------------|-------|
| AI Automation (2 day) | B3,900-4,900 |
| AI Builder (1 day) | B5,000-20,000 |
| AI Builder (2 day) | B15,000-25,000 |
| Claude Code Masterclass | TBD |
| Git Courses | FREE (funnel) |
| Multi-Agent | FREE (funnel) |

---

*Distilled from courses/ directory (82 files)*
*"Create new, not delete." -- but we're distilling, which is creating new from many.*
