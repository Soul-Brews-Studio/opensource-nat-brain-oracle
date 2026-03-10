---
title: Lab Index
tags: [lab, experiments, pocs]
created: 2025-12-11
parent: "[[ψ/]]"
---

# Lab Index

> **Question**: กำลังทดลองอะไร? (What experiments are running?)

Hands-on experiments and proof-of-concepts (POCs). This is where we build, test, and learn by doing.

---

## Projects Overview

| Project | Status | Focus | Last Updated |
|---------|--------|-------|--------------|
| [[agent-sdk]] | 🟢 Active | Claude Agent SDK deep dive, v2 API, sandboxing | 2025-12-11 |
| [[claude-code-features]] | 🟡 Complete | Skills, /standup, Resume Agent, Explore agent testing | 2025-12-11 |
| [[github-profile-analysis]] | 🟡 Complete | Nat's GitHub ecosystem scan (500+ repos, 30 orgs) | 2025-12-11 |

---

## Quick Links

### 1. Agent SDK

**Location**: `ψ/lab/agent-sdk/`

**Contents**:
- [INDEX.md](agent-sdk/INDEX.md) - SDK reference and labs
- [typescript-api.md](agent-sdk/typescript-api.md) - Full TypeScript API docs
- [v2-interface.md](agent-sdk/v2-interface.md) - New send/receive pattern (preview)
- [sandboxing.md](agent-sdk/sandboxing.md) - Filesystem & network isolation
- [001-basic-sdk-learning/](agent-sdk/001-basic-sdk-learning/) - Hands-on learning lab

**What we're learning**:
- V2 API pattern (simplified `send()` → `receive()`)
- 1M context window support
- Sandboxing and tool execution
- Multi-turn sessions

**Lab 001 Status**: ✅ Complete
- Tested query() API
- Tested V2 interfaces
- Results: `001-basic-sdk-learning/results/final-judge-report.md`

### 2. Claude Code Features

**Location**: `ψ/lab/claude-code-features/`

**Contents**:
- [experiment.md](claude-code-features/experiment.md) - Feature test results

**Features Tested**:
1. **Skills** - Modular capabilities ✅ Pass
2. **/standup command** - Daily standup via context-finder ✅ Pass
3. **Explore subagent** - Built-in Haiku read-only agent ✅ Pass
4. **Resume Agent** - Continue agent with previous context ✅ Pass

**Key Finding**: Resume Agent is game-changing for multi-step research tasks!

### 3. GitHub Profile Analysis

**Location**: `ψ/lab/github-profile-analysis/`

**Contents**:
- [INDEX.md](github-profile-analysis/INDEX.md) - Full analysis

**Subject**: nazt (Nat)

**Key Stats**:
- 500+ personal repos
- 30+ organizations
- Polymath developer: IoT (30%), Blockchain (25%), AI/LLM (15%), Full-stack web (15%)
- Languages: TypeScript, Python, C++, Go, JavaScript, Solidity
- Life phases: Maker → Blockchain → Brewing → AI/Oracle (current)

**Analysis Includes**:
- Organization ecosystem map
- Technology distribution
- Personality patterns from code
- Next steps for deep dive

---

## Folder Structure

```
ψ/lab/
├── INDEX.md                      ← This file
├── agent-sdk/                    ← Claude Agent SDK reference + labs
│   ├── INDEX.md
│   ├── typescript-api.md
│   ├── v2-interface.md
│   ├── sandboxing.md
│   ├── TIMELINE.md
│   ├── 001-basic-sdk-learning/  ← Learning lab
│   └── repo/                      ← Cloned agent-sdk repo
│
├── claude-code-features/          ← Feature experiments
│   └── experiment.md
│
└── github-profile-analysis/       ← Profile scanning POC
    └── INDEX.md
```

---

## Workflow

```
Idea → Hypothesis → Experiment → Results → Analysis → rrr (retrospective)
       (lab/)       (lab/)       (lab/)    (lab/)     (memory/)
```

1. **Hypothesis**: What are we testing?
2. **Experiment**: Write code, run tests
3. **Results**: Document what happened
4. **Analysis**: Extract patterns and learnings
5. **Retroactive**: Create retrospective in `ψ/memory/retrospectives/`

---

## See Also

- [[ψ/writing/]] - Blog drafts and published articles
- [[ψ/memory/learnings/]] - Distilled patterns from experiments
- [[ψ/memory/retrospectives/]] - Session summaries
- [[ψ/active/]] - Research in progress
- [[ψ/inbox/]] - Current communication & focus

---

**Last Updated**: 2025-12-11
**View Index**: [[ψ/]] | [[HOME]]
