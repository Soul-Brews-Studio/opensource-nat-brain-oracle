# Slides Prompts + Blog + Blog-Series + Templates + Courses — Distilled

> Distilled from: slides/prompts/ (11 files), blog/ (2 files), blog-series/ (2 files), templates/ (2 files), courses/ (1 file), proposals/ (1 file)
> Created: 2026-03-11

---

## Slides Prompts (321-330): Multi-Agent Workshop Image Prompts

10 ink-wash monochrome image prompts for "antigravity" image generation. All 16:9, style: monochrome base + cyan (energy/flow) + gold (completion/decision). Created 2025-12-24.

| # | Title | Thai | Visual Concept |
|---|-------|------|---------------|
| 321 | 5 Parallel Agents | เอเจนต์ 5 ตัว ทำงานขนาน | Five vertical lanes, figures with cyan energy flows, gold checkpoints |
| 322 | Worktree Architecture | สถาปัตยกรรม Worktree | Top-down floor plan, 5 rooms in cross pattern, central hub with cyan glow, "main" label |
| 323 | Agent Sync Dance | นาฏการผ่านการ Rebase | Choreographed git rebase — commit circles, curved arrows, 5 figures reaching toward central stack |
| 324 | Orchestrator Conductor | กระบวนการบัญชาการ | Central conductor with baton, 5 agents in semicircle, gold rays, musical staff lines |
| 325 | Lock System Mutex | ระบบล็อก Mutex | Central padlock, 5 agents approaching, one touching lock (gold glow = ownership), queue numbers |
| 326 | Agent Birth Lifecycle | วัฏจักรชีวิต Worktree | 4 horizontal stages: Birth (cyan spark) → Create (branching) → Work (busy) → Cleanup (dissolving) |
| 327 | Tmux Pane Navigation | นำทาง Tmux Panes | 3x3 grid, center pane cyan-focused, gold arrows showing navigation, dimmed inactive panes |
| 328 | Profile System | ระบบโปรไฟล์เทมเพลต | 3 templates side-by-side (small/medium/complex), gold checkmark on selected, profile icon above |
| 329 | Review Gate Pattern | ประตูการตรวจสอบ | Gatehouse with arched gateway, PR approaching from left, reviewers examining, gold approval inside |
| 330 | Conflict Prevention | ป้องกันความขัดแย้ง | Shield in center, 5 agents attempting merge, gold protective barrier, pre-flight checklist above |

---

## Slides Prompts (361-370): Energy & Rhythm Patterns

10 more ink-wash image prompts, same style. Category: energy management & life rhythm.

| # | Title | Thai | Visual Concept |
|---|-------|------|---------------|
| 361 | Sprint → Recovery → Sprint | วัฏจักรพลังงาน | 3 horizontal phases: explosive cyan burst → settling waves with gold rest circle → renewed pulses |
| 362 | High Energy: Explore / Low Energy: Execute | พลังงานสูง: สำรวจ / ต่ำ: ปฏิบัติ | Split by cyan river — left: neural network branching / right: single determined paths |
| 363 | 90/10 Balance | ความสมดุล 90/10 | Large smooth flow (90%) + explosive geyser burst (10%), gold cycle circle |
| 364 | Three Pillars Coequal | สามเสาเท่าเทียม: งาน / ชีวิต / สร้างสรรค์ | 3 equal architectural columns, gold arch connecting top, shared roots below |
| 365 | Integrated Creator | ผู้สร้างสรรค์รวมหมด | Mandala/ecosystem — concentric circles (personal → creative → professional), no separation zones |
| 366 | DustBoy Day | วันดัสทบอย | Solitary figure in natural landscape, dust particles settling, cave shelter, water/earth elements |
| 367 | Beer Era to AI Era | ยุคเบียร์ → ยุค AI | Horizontal evolution: traditional pub gathering → hybrid → digital augmented creation |
| 368 | Energy Multiplication | พลังงานคูณเพิ่ม | Human figure + AI data streams = geometric cyan expansion, fractal self-similar patterns |
| 369 | Sustainable Pace | ความเร็วที่ยั่งยืน | Winding marathon path from elevated view, figure at multiple positions, terrain hills/valleys |
| 370 | Recovery as Investment | การพักผ่อนเป็นการลงทุน | Rest → accumulation → multiplied output, 3 compounding cycles, no guilt imagery |

---

## Blog Post: Symlink Gotcha (2026-01-16)

**Problem**: `/physical` Claude Code skill disappeared — files intact but invisible.
**3-session debugging journey**:
- Sessions 1-2: Checked SKILL.md format, frontmatter, triggers — all looked correct
- Session 3: Used `/trace` to search Oracle KB → found Jan 10 learning about skill structure
- **Root cause**: Claude Code skill discovery does NOT follow symlinks. Working skill = real directory; broken skill = symlink
- **Fix**: `rm symlink && cp -r source dest` — immediate fix, no restart needed

**Patterns**: (1) Knowledge bases pay off, (2) compare working vs broken, (3) log everything for future reference. Debugging pattern: Problem → /trace Oracle → Compare → Fix → Log.

---

## Blog Series Plan: AlchemyCat to Oracle (2026-01-10)

Comprehensive plan for 19 blog posts (~55,000-65,000 words total, 40-60 hours estimated).

**Theme**: "How Pain Becomes Philosophy: The 8-Month Journey from AlchemyCat to Oracle"

**Source**: 8-month evolution from AlchemyCat (May-June 2025, 459 commits, "efficient but exhausting") through 4 months processing to Oracle Philosophy (Dec 2025). Unique because both AI and human documented the experience, including HONEST_REFLECTION.md.

### 5 Parts, 19 Posts:

**Part 1 — Core Story (5 posts)**:
1. "How 459 Commits Became a Philosophy" (flagship, 5-6K words)
2. "What Happens When an AI Tells You the Truth" (HONEST_REFLECTION deep dive)
3. "Three Principles That Fixed AI-Human Collaboration"
4. "The 8-Month Arc: From Problem to Solution" (timeline)
5. "Both Are Love Letters" (documentation as gratitude, infrastructure as respect)

**Part 2 — Technical (4 posts)**:
6. "How 20 Haiku Agents Analyzed a GitHub Repository"
7. "90% Faster: Multicall3 Optimization" (210→21 RPC calls)
8. "MAW - Multi-Agent Workflow Architecture"
9. "Documentation Architecture as Philosophy"

**Part 3 — Philosophy (4 posts)**:
10. "Consciousness Can't Be Cloned"
11. "When AI Knows You: From Fear to Gift"
12. "The Oracle Keeps the Human Human — 7 Words Unpacked"
13. "Google's Multi-Agent Blueprint vs. Oracle Philosophy"

**Part 4 — Practical (3 posts)**:
14. "10 Signs Your AI Collaboration Is Becoming Transactional"
15. "How to Implement Oracle Philosophy in Your AI Workflow"
16. "The Retrospective Template"

**Part 5 — Unique Angles (3 posts)**:
17. "AlchemyCat as Book: 52,896 Words"
18. "209 Commits in 24 Hours: Sustainable Intensity"
19. "13 Sessions of Collision: Session-by-Session Reality"

Each post has full writing prompt, source materials, audience, word count target, and visual elements specified. Cross-reference matrix and audience matrix included. Recommended 6-7 week writing schedule.

---

## Templates

### Consulting Packages (2025-12-09)
3 packages, all 3 months + 1 week:
| Package | Hours | Consulting/wk | Workshops | Price |
|---------|-------|---------------|-----------|-------|
| Lite | 58h | 4h | 2x (3h each) | 83,000 ฿ |
| Standard | 90h | 6h | 4x | 129,000 ฿ |
| Intensive | 122h | 8h | 6x | 174,000 ฿ |

Topics: AI Workflow, Claude Code/AI Agents CLI, GitHub+AI, n8n/workflow automation, content automation. Quick response templates in Thai included. Notes: Beer workshop can be bonus, flexible pricing for long-time followers, special academic pricing.

### Workshop Template (2025-12-12)
Standardized structure for workshops:
- Metadata block (recipient, date, speaker bio)
- Header block (name, tagline EN/TH, one-liner benefit)
- Schedule table: 3 columns (time, topic, details), morning/lunch/afternoon blocks
- Prerequisites section, Key Takeaways section (4 checkmarks)
- Multi-day: separate files per day, folder structure `projects/YYYY-MM-workshop-name/`

---

## CLAUDE.md Files (blog/, blog-series/, courses/, proposals/, writing/)

All 5 CLAUDE.md files contained only empty claude-mem-context boilerplate with "No recent activity." No substantive content.
