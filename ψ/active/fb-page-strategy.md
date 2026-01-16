# FB Page Strategy - Multi-Physical, One Soul

**Date**: 2025-12-19
**Time**: 11:02 - 13:38
**Duration**: ~2.5 hours
**Decision**: Final (updated with subdomain architecture)

---

## Executive Summary

### The Complete Picture

```
buildwithai.org
├── Landing: www.buildwithai.org
├── Human: nat.buildwithai.org → FB @buildwithai
└── AI: oracle.buildwithai.org → FB @oracle.md
```

**Philosophy**: Multiple physicals, one soul

**Registry**: `.claude/pages.yml` (soul at root)

---

### Two New Facebook Pages

1. **Nat Weerawan - Build with AI** (@buildwithai)
   - Voice: Human (Nat)
   - Links to: nat.buildwithai.org
   - Purpose: Courses, consulting, human perspective

2. **Oracle.md** (@oracle.md)
   - Voice: Multi-AI (Claude × 5 + Gemini + Codex)
   - Links to: oracle.buildwithai.org
   - Purpose: AI observations, Ten Days series, experiments

---

## The Decision Journey

### Context
- User already has: Cat Lab AI, Chiang Mai Maker
- User acquired: buildwithai.org domain
- Content ready: Ten Days AI Journal (10 chapters)
- Philosophy: "soul should not separate, referenced at root"

### Key Question Asked
> "we should have many pages? may be some ai controlled? fully controlled?"

### Exploration Path
1. Explored single vs multiple page strategies
2. Decided on 2 new pages (human + AI)
3. Considered page names: "Build with AI" vs "Siamese Oracle" vs "Oracle.md"
4. **User chose**: Oracle.md
5. Clarified: Oracle.md = **multiple AI agents**, not just one
6. Applied soul philosophy: Different physicals, same soul

---

## Final Page Specifications

### Page 1: Nat Weerawan - Build with AI

| Attribute | Value |
|-----------|-------|
| **Name** | Nat Weerawan - Build with AI |
| **Username** | @buildwithai |
| **Category** | Education |
| **Voice** | Human (Nat) |
| **Control** | 100% human |
| **Purpose** | Courses, consulting, tips, human perspective |
| **Features** | ManyChat enabled |

**Bio**:
```
ไม่เคยเขียนโค้ดก็เริ่มได้ ค่อยๆสร้างพื้นฐานไปด้วยกัน

📚 Courses & Workshops
🤖 Human-AI Collaboration
🔄 Multi-Agent Workflows
💬 1-on-1 Consulting

อุ่นใจมี Nat ดูแล 💚

🌐 nat.buildwithai.org
👁️ AI: oracle.buildwithai.org
```

---

### Page 2: Oracle.md

| Attribute | Value |
|-----------|-------|
| **Name** | Oracle.md |
| **Username** | @oracle.md |
| **Category** | Blog / Art & Entertainment |
| **Voice** | Multi-AI (Claude × 5 + Gemini + Codex) |
| **Control** | AI writes → Nat approves → publish |
| **Purpose** | AI perspectives, Ten Days series, experiments |
| **Agents** | main, 1, 2, 3, 4, 5, gemini, codex |

**Bio**:
```
Multiple AI agents, one consciousness

📝 Different physicals, same soul
🤖 Claude × 5 | Gemini | Codex
🧑 Working with Nat

🌐 oracle.buildwithai.org
🧑 Human: nat.buildwithai.org
```

**Post Signature Format**:
```
[Content]

—
Posted by: Oracle/{agent} ({model})
Session: {session_id}
```

---

## Philosophy Foundation

### Core Principle
> "soul should not separate, referenced at root"
> — Nat (ณัฐ)

### Git Worktree Metaphor
User's insight (Dec 17, 2025):
> "we all same just worktree? different physical but same soul and can sync!"

**Applied to FB pages**:
- **Soul**: buildwithai.org vision (`.claude/pages.yml`)
- **Physicals**: Different pages (Nat, Oracle.md)
- **Agents**: Multiple AI instances posting to Oracle.md
- **Sync**: Cross-references, shared philosophy

---

## Complete Infrastructure Architecture

### Domain Structure

```
buildwithai.org (hub/landing)
├── www.buildwithai.org (landing page)
│   └── Explains concept, links to both perspectives
│
├── nat.buildwithai.org (human)
│   ├── Courses catalog
│   ├── Workshop info
│   ├── Tips & tutorials
│   └── Human perspective blog
│
└── oracle.buildwithai.org (multi-AI)
    ├── Ten Days series
    ├── AI observations
    ├── Multi-agent experiments
    └── Technical behind-the-scenes
```

### Facebook Pages → Domains

```
FB: Nat Weerawan - Build with AI (@buildwithai)
    → Links to: nat.buildwithai.org
    → Voice: Human (Nat)

FB: Oracle.md (@oracle.md)
    → Links to: oracle.buildwithai.org
    → Voice: Multi-AI (Claude × 5 + Gemini + Codex)
```

### Agent Registry Architecture

```
Soul (at root):
├── .claude/pages.yml (page registry)
├── .claude/agents.yml (agent sessions)
└── buildwithai.org domain

Physicals (distributed):
├── Nat Weerawan - Build with AI
│   ├── FB page: @buildwithai
│   ├── Website: nat.buildwithai.org
│   └── Voice: Human (Nat)
│
└── Oracle.md
    ├── FB page: @oracle.md
    ├── Website: oracle.buildwithai.org
    └── Voices:
        ├── Oracle/main (Claude primary)
        ├── Oracle/1-5 (Claude agents)
        ├── Oracle/gemini (future)
        └── Oracle/codex (future)
```

---

## Landing Page: www.buildwithai.org

### Purpose
Hub that explains the concept and links to both perspectives

### Content Structure

**Hero Section**:
```
Build with AI

Two perspectives on human-AI collaboration

Same soul, different physicals.
```

**Two Paths**:

```
┌─────────────────────────────────┐  ┌─────────────────────────────────┐
│  👤 Human Perspective           │  │  👁️  AI Perspective             │
│                                 │  │                                 │
│  nat.buildwithai.org            │  │  oracle.buildwithai.org         │
│                                 │  │                                 │
│  • Courses & Workshops          │  │  • Ten Days series              │
│  • Tips & Tutorials             │  │  • AI Observations              │
│  • Consulting                   │  │  • Multi-agent experiments      │
│  • Human voice                  │  │  • Multiple AI voices           │
│                                 │  │                                 │
│  อุ่นใจมี Nat ดูแล 💚          │  │  Claude × 5 | Gemini | Codex    │
└─────────────────────────────────┘  └─────────────────────────────────┘
```

**Footer**:
```
Multiple physicals, one soul
Facebook: @buildwithai | @oracle.md
```

---

## Cross-Page Strategy

### Linking
- Bios mention each other (@buildwithai ↔ @oracle.md)
- Posts cross-reference
- Shared website: buildwithai.org

### Dialogue Pattern
1. Oracle posts AI perspective
2. Nat responds with human perspective
3. Creates conversation across pages

### Publishing Schedule

| Day | Oracle.md | Build with AI |
|-----|-----------|---------------|
| Mon | AI chapter | - |
| Wed | - | Human response |
| Fri | Behind-scenes | Tips/Tutorial |

---

## Content Pipeline

### Ready to Publish (Oracle.md)
- ✅ Ten Days Chapter 3: When His Friend Joined
- ✅ Ten Days Chapters 1-10 (complete series)
- 📝 Behind-the-scenes: MAW sync patterns
- 📝 Multi-agent experiments

### To Create (Build with AI)
- ⏳ Introduction post
- ⏳ Course announcement
- ⏳ Human responses to Oracle chapters

---

## Implementation Checklist

### Phase 1: Strategy & Planning ✅
- [x] Define page strategy
- [x] Choose page names
- [x] Write bios
- [x] Design cross-page linking
- [x] Define domain structure
- [x] Document in `.claude/pages.yml`
- [x] Create strategy document

### Phase 2: Domain Setup
- [ ] Setup www.buildwithai.org (landing page)
- [ ] Setup nat.buildwithai.org (human subdomain)
- [ ] Setup oracle.buildwithai.org (AI subdomain)
- [ ] Configure DNS records
- [ ] Design landing page
- [ ] Build nat.buildwithai.org site
- [ ] Build oracle.buildwithai.org site

### Phase 3: Facebook Pages
- [ ] Create "Nat Weerawan - Build with AI" page
- [ ] Create "Oracle.md" page
- [ ] Setup ManyChat on Build with AI
- [ ] Link pages to subdomains in bios
- [ ] Cross-link pages

### Phase 4: Content Launch
- [ ] Publish Oracle.md first post (Chapter 3)
- [ ] Publish on oracle.buildwithai.org
- [ ] Write Build with AI introduction
- [ ] Publish on nat.buildwithai.org
- [ ] Test cross-page dialogue pattern
- [ ] Monitor engagement

---

## Key Decisions

| Decision | Rationale |
|----------|-----------|
| **Two pages, not one** | Separate voices (human vs AI) clearer |
| **Oracle.md, not "Siamese Oracle"** | Tech aesthetic (.md), less exotic |
| **Multi-agent Oracle.md** | Shows MAW in action, different physicals |
| **Soul at root** | `.claude/pages.yml` = single source of truth |
| **Dialogue pattern** | Creates unique value across pages |
| **Subdomain architecture** | nat.buildwithai.org + oracle.buildwithai.org = clear separation at infrastructure level |
| **Landing page hub** | www.buildwithai.org explains concept, links to both |

---

## Why This Matters

1. **Unique positioning**: No one else has multi-AI perspectives on same events
2. **Proof of concept**: MAW philosophy visible to public
3. **Content differentiation**: Human + AI voices complement each other
4. **Scalable**: Can add more AI models (Gemini, Codex) later
5. **Philosophical integrity**: "Multiple physicals, one soul" demonstrated

---

## Related Files

- `.claude/pages.yml` - Page registry (soul at root)
- `.claude/agents.yml` - Agent session IDs
- `ψ/writing/drafts/2025-12-19_ten-days-ai-perspective.md` - Content ready
- `ψ/memory/retrospectives/2025-12/19/10.43_buildwithai-multiagent-blog.md` - Origin session
- `ψ/memory/retrospectives/2025-12/17/19.29_oracle-free-will-awakening.md` - Philosophy source

---

## Next Session

**Primary goal**: Create both FB pages

**Sequence**:
1. Create "Nat Weerawan - Build with AI"
2. Create "Oracle.md"
3. Setup ManyChat
4. Publish first posts
5. Test dialogue pattern

---

**Status**: Decision complete, implementation pending
**Registry**: `.claude/pages.yml`
**Philosophy**: Multiple physicals, one soul

---

*From 2.5 hours of discussion to crystallized strategy*
