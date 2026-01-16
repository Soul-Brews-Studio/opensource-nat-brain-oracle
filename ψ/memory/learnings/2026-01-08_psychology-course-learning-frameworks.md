---
title: Psychology Course Learning Frameworks - Existing Infrastructure
tags: [psychology, course-design, learning-progression, framework, teaching-methodology]
created: 2026-01-08
source: Context search - learning/growth patterns in repo memory
---

# Psychology Course Learning Frameworks

## What Exists Now

The repo has **course design infrastructure ready for psychology adaptation**. This is NOT a blank slate.

### 1. **Course Template Infrastructure** (Ready to Use)

**Location**: `/agents/1/courses/` (templates from SkillLane work)

**Existing Formats**:
- Workshop format: 3h morning + 3.5h afternoon (SIIT Dec 2025 template)
- Video course: 6-9h total, Thai/English bilingual (SkillLane model)
- Demo-driven intensive: 2-day immersive (Build Your Oracle pattern)

**Progressive Learning Path Already Defined**:
```
000 (Foundations) → 001 (Core) → 002 (Advanced) → 003 (Mastery)
```

### 2. **Teaching Methodology (Proven Pattern)**

**From Demo-Driven Course Design Learning (Jan 4, 2026)**:

#### Core Philosophy
- **Problem-first, not tool-first** - "Teach fishing, not give fish"
- **Student brings own problem** - Not hypothetical exercises
- **Independence is goal** - "สร้าง AI Tool ของตัวเอง ไม่ใช่ copy template"
- **Real output in 15 minutes** - Session → prototype → learning

#### Session → Course Pattern
```
Live session with real client
    ↓
Document what worked (retrospective)
    ↓
Extract pattern (learning capture)
    ↓
Design course around it (template creation)
```

#### Teaching Ratio
- **50/50 teaching/doing** - Not lecture-heavy
- Demo first, slides after
- Students leave with **working prototype**, not certificate

### 3. **Learning Progression Principles** (Implicit in Current Work)

From retrospectives and course design sessions, these emerge:

#### A. **Scaffolding Architecture** (from 2025-12-11 learning)
> "scaffolding creates better outputs. The category-first approach (defining 12 themes before prompt generation) felt like overhead initially. But the moment I laid out categories and showed them to the agents, the prompts became coherent rather than scattered."

**Key insight**: Sequencing matters. Creating containers (categories/frameworks) BEFORE content improves coherence.

#### B. **Mastery Progression** (from 2025-12-17 retrospective)
Session titled "maw-sync-patterns-mastery" shows:
- Pattern recognition → implementation → mastery loop
- Each cycle builds on previous (branching complexity)
- Multi-agent coordination requires "meditation-level focus" (deep presence)

#### C. **Active vs. Passive Learning** (from 90-10 dynamic)
From 2026-01-03 learning:
```
AI = acceleration zone (active)
Code = work (applied)
```

Students need BOTH active instruction + autonomous application.

#### D. **Session-as-Learning Unit** (Proven in SkillLane + SIIT)
- 60-90 minute sessions optimal (documented)
- Context switches at natural breaks
- Each session produces artifact (code, diagram, understanding)

### 4. **Psychology-Specific Courses (Outline Ready)**

**From 2026-01-08 course template learning**:

| Course | Duration | Format | Teaching Method |
|--------|----------|--------|-----------------|
| Self-Awareness Foundations | 3h | Workshop | Demo + reflection |
| Understanding Personality | 6h | Video | Conceptual + self-assessment |
| Emotional Intelligence | 4h | Workshop | Demo + role-play |
| Therapeutic Conversation | 2 days | Intensive | Practice + feedback loop |

**Note**: Each aligns with 50/50 teaching/doing model

---

## Missing Frameworks (What Psychology Adds)

Psychology education typically includes:

### 1. **Cognitive Development Models** (NOT yet in repo)
- Bloom's Taxonomy (knowledge → comprehension → application → analysis → synthesis → evaluation)
- ZPD (Zone of Proximal Development) - gap between what learner can do alone vs. with help
- Scaffolding stages (fading support as competence grows)

### 2. **Behavioral Learning Models**
- Behavioral objectives (what observable change students demonstrate)
- Reinforcement (positive feedback, challenge calibration)
- Habit loop (cue → routine → reward)

### 3. **Affective/Emotional Development**
- Safety/belonging before learning (Maslow hierarchy assumed)
- Growth mindset cultivation
- Emotional regulation for learning

### 4. **Assessment Models**
- Formative (during learning) vs. summative (at end)
- Self-assessment (metacognition)
- Peer feedback loops

### 5. **Adaptation Mechanisms**
- Learner profiling (personality, learning style)
- Just-in-time support (when learner gets stuck)
- Pacing adjustments

---

## Recommended Integration Path

### Phase 1: Foundation (Weeks 1-2)
1. Map existing course structure to Bloom's Taxonomy
2. Define learning objectives for each psychology course (observable outcomes)
3. Identify scaffolding points (where demo → student practice)
4. Create "zone of proximal development" checkpoints

### Phase 2: Structure (Weeks 3-4)
1. Build assessment rubrics (self-check, peer, facilitator)
2. Design feedback loops (immediate, actionable, psychological-safe)
3. Create progression markers (when student ready for next concept)
4. Document adaptation rules (if learner struggles with X, provide Y support)

### Phase 3: Delivery (Weeks 5+)
1. Pilot with early courses (Self-Awareness Foundations first)
2. Capture student learning curves (retrospectives)
3. Refine scaffolding based on actual learning data
4. Build psychology-specific lesson learned library

---

## Key Alignment: Psychology Applied to Learning Design

### Self-Awareness Course → Teaches Metacognition
Students learn "how they learn" while learning self-awareness. Double layer of learning.

### Personality Course → Uses Student's Own Personality
Framework-agnostic design, but use personality assessment AS learning tool (not just content).

### Emotional Intelligence → Safety-First Teaching
Implement psychological safety in every session:
- Normalize struggle
- Celebrate small wins
- Peer learning before public presentation

### Therapeutic Conversation → Mirror Your Teaching
If teaching "active listening," use active listening in the course. Model therapy principles.

---

## Implementation Artifacts Ready

| Artifact | Status | Location |
|----------|--------|----------|
| Course template | Ready | `/agents/1/courses/` |
| Demo-driven pattern | Ready | `/ψ/memory/learnings/2026-01-04_demo-driven-course-design.md` |
| Scaffolding insight | Ready | `/ψ/memory/retrospectives/2025-12/11/22.00-mass-image-suno-prompts.md` |
| Progression model | Ready | `000→001→002→003` (documented) |
| Assessment patterns | **Needs creation** | Create `/ψ/lab/psychology-assessment/` |
| Adaptation rules | **Needs creation** | Create `/ψ/lab/psychology-adaptation/` |
| Psychological safety checklist | **Needs creation** | Create `.claude/skills/psychology-safety/` |

---

## Estimated Effort

- **Mapping existing → psychology frameworks**: 8-10 hours
- **Creating assessment + adaptation system**: 12-15 hours
- **Pilot course (Self-Awareness Foundations)**: 20-25 hours
- **Iteration + learning capture**: 10-15 hours

**Total first course**: ~50-65 hours (aligns with earlier estimate of ~75h for first psychology course)

---

## Quick Start Commands

```bash
# View existing course structure
ls -la /Users/nat/Code/github.com/laris-co/Nat-s-Agents/agents/1/courses/

# Read demo-driven pattern
cat /Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/learnings/2026-01-04_demo-driven-course-design.md

# View progression model
grep -r "000.*001.*002.*003" /Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/memory/learnings/

# Create psychology-specific lab
mkdir -p /Users/nat/Code/github.com/laris-co/Nat-s-Agents/ψ/lab/psychology-{assessment,adaptation,safety}
```

---

## Related Learning Files

- `2026-01-04_skilllane-course-format-pattern-structure.md` - Course structure
- `2026-01-04_demo-driven-course-design.md` - Teaching methodology
- `2025-12-21_project-manager-skill.md` - Course management
- `005-repo-organization-criteria.md` - Learning org structure

---

*Added via Oracle Learn. This learning bridges existing course infrastructure with psychology education frameworks.*
