# Antigravity Visual Prompts Catalog (Distilled)

> Consolidated from 155 files in `scripts/prompts/`
> Created: 2025-12-23 to 2025-12-24
> Distilled: 2026-03-11

All prompts are for AI image generation (DALL-E 3, Midjourney, Stable Diffusion).
All use the **Oracle visual style**: monochrome ink-wash base, geometric overlays, cyan energy accents, gold highlight accents, 16:9 landscape PNG output, Thai open-source fonts only (Noto Sans Thai, Prompt, Kanit, Sarabun).

---

## Table of Contents

1. [Visual Style System](#visual-style-system)
2. [MAW Multi-Agent Architecture (211-225)](#maw-multi-agent-architecture-211-225)
3. [Workflow Patterns (286-300)](#workflow-patterns-286-300)
4. [Oracle Philosophy (301-310)](#oracle-philosophy-301-310)
5. [Psi Pillars / Knowledge Architecture (311-320)](#psi-pillars-311-320)
6. [MAW Patterns (321-330)](#maw-patterns-321-330)
7. [Subagent Personas (331-340)](#subagent-personas-331-340)
8. [Command Workflows (341-350)](#command-workflows-341-350)
9. [Learning Patterns (351-360)](#learning-patterns-351-360)
10. [Energy and Rhythm (361-370)](#energy-and-rhythm-361-370)
11. [Anti-Patterns (371-380)](#anti-patterns-371-380)
12. [Graduated Projects (381-390)](#graduated-projects-381-390)
13. [Teaching and Workshops (391-400)](#teaching-and-workshops-391-400)
14. [Miscellaneous Task Prompts](#miscellaneous-task-prompts)
15. [Automation and Generation](#automation-and-generation)

---

## Visual Style System

All prompts share these specifications:

| Property | Value |
|----------|-------|
| Base | Monochrome ink-wash (organic, fluid) |
| Structure | Geometric overlays (precise, technical) |
| Accent 1 | Cyan (energy, flow, in-progress, state) |
| Accent 2 | Gold (completion, decisions, highlights) |
| Aspect Ratio | 16:9 landscape |
| Output | PNG |
| Fonts | Noto Sans Thai, Prompt, Kanit, Sarabun (open-source only) |

### Common Symbolism

| Symbol | Meaning |
|--------|---------|
| Figure/Human | Agent, worker, consciousness |
| Flow/Stream | Process, information, energy, time |
| Container/Vessel | Completed work, stored knowledge |
| Bridge/Path | Connection, transition, relationship |
| Layer/Band | Depth, progression, hierarchy |
| Geometric Frame | Precision, structure, organization |
| Glow/Aura | Focus, importance, energy state |
| Golden Mark/Seal | Completion, safe storage, agreement |

### YAML Frontmatter Template

All prompt files use this frontmatter:

```yaml
---
type: image
target: antigravity
status: pending
created: 2025-12-23  # or 2025-12-24
category: <category-slug>
file_number: <NNN>
---
```

---

## MAW Multi-Agent Architecture (211-225)

**Category**: `maw-multiagent` | **Files**: 15 | **Created**: 2025-12-23

These prompts visualize the Multi-Agent Workflow (MAW) system -- how multiple Claude Code agents work in parallel using git worktrees, tmux, and orchestration patterns.

### Pattern (Example: 211-maw-orchestra.md)

```
# MAW Orchestra - Agents in Harmony

## Thai Text
ฟิลฮาร์มอนิก็ของแอจเอนต์ | กระทำการพร้อมกันเหมือนวงดุรี

## Prompt
A monochrome ink-wash illustration of 5-10 distinct agents (represented as abstract
geometric shapes: circles, hexagons, triangles, squares) arranged in a semi-circle like
orchestra musicians. Each agent is connected by flowing cyan lines of communication—musical
staff lines that visually represent data flow. The center features a gold conductor's baton
crossing through the composition, directing synchronized action across all agents...

--ar 16:9
Font: Use open source Thai fonts ONLY (Noto Sans Thai, Prompt, Kanit, Sarabun)

## Expected Output
- Format: PNG
- Save: results/211-maw-orchestra.png
```

### Complete List

| # | Title | Thai | Visual Metaphor |
|---|-------|------|-----------------|
| 211 | MAW Orchestra | ฟิลฮาร์มอนิก็ของแอจเอนต์ | Agents as orchestra musicians, conductor's baton |
| 212 | Git Worktree Consciousness | กิ่งหลายสาขา หนึ่งจิตใจ | Translucent parallel human silhouettes sharing central light |
| 213 | Tmux Control Tower | หอคุมการบิน | Angular control tower with window panes per agent |
| 214 | Agent Spawn Pattern | (agent spawning) | Agent creation/initialization |
| 215 | Worktree Branching Tree | ต้นไม้กิ่งหลาย | Botanical tree with trunk=main, branches=worktrees |
| 216 | Rebase Synchronization | (rebase sync) | Synchronization visualization |
| 217 | MAW Profile Grid | (profile grid) | Agent profile system |
| 218 | Agent Isolation Bubbles | (isolation) | Agents in separate space bubbles |
| 219 | Peek Monitoring Dashboard | (monitoring) | Dashboard surveillance view |
| 220 | Hey Command Bridge | สะพานข้อความ | Bridge connecting two platforms with message packets |
| 221 | Kill Command Graceful Termination | (termination) | Graceful shutdown |
| 222 | Wait Command Patience | (patience) | Waiting/patience |
| 223 | Sync Command Flow | (sync) | Synchronization flow |
| 224 | Agent Autonomy Spectrum | (autonomy) | Spectrum of agent independence |
| 225 | MAW Control Loop | ลูปควบคุม | Circular flow: START -> WORK -> SYNC -> MERGE |

---

## Workflow Patterns (286-300)

**Category**: `workflow-patterns` | **Files**: 15 | **Created**: 2025-12-23

Visualize the complete workflow cycle from planning through execution, reflection, and knowledge transfer.

### Complete List

| # | Title | Thai | Visual Metaphor |
|---|-------|------|-----------------|
| 286 | Marie Kondo Consultant | ที่ปรึกษาการจัดเรียง | Figure before tiered shelf with decision paths |
| 287 | Archiver Pattern | ผู้เก็บรักษา | Figure through geological strata, items descending |
| 288 | Context Finder Magnifying | ผู้ค้นหาบริบท | Magnifying glass revealing network interconnections |
| 289 | Executor Pipeline | ผู้บริหารการทำงาน | Multiple concurrent pipelines with flow control |
| 290 | Coder Craftsman | ช่างโค้ด | Craftsperson at workbench with code threads |
| 291 | Plan Mode Blueprint | โหมดแผน | Figure sketching blueprints at drafting table |
| 292 | GOGOGO Execution | ไปไปไป | Figure in motion with energy trails, milestones |
| 293 | RRR Retrospective | ทบทวนทบทวนทบทวน | Contemplative figure reviewing concentric time circles |
| 294 | Snapshot Quick Capture | ภาพรวม | Figure capturing glowing moments from flowing stream |
| 295 | Distill Extraction | บริหารความรู้ | Alchemical distillation apparatus, multi-stage |
| 296 | Jump Stack Navigation | กระโดด | Figure leaping between floating platforms |
| 297 | Pending Task Queue | คิวรอ | Procession of task items through queue stages |
| 298 | Activity Log Stream | บันทึกกิจกรรม | Figure in flowing stream recording into scroll |
| 299 | Focus State Machine | สถานะสมาธิ | Figure cycling through three state chambers |
| 300 | Session Handoff Bridge | ส่งต่องาน | Bridge connecting ending and beginning sessions |

---

## Oracle Philosophy (301-310)

**Category**: `oracle-philosophy` | **Files**: 10 | **Created**: 2025-12-24

Core Oracle principles visualized. These have a slightly different format -- markdown headers instead of YAML frontmatter, with `--q 2` quality flag.

### Full Prompt: 301 - Nothing is Deleted (Representative)

```
Create a geological cross-section view showing Earth's layered strata, with each layer
representing a different time period.

Composition: Center the strata layers vertically, left side shows compressed older layers
becoming clearer toward the surface. A human figure stands at ground level on the right,
holding a magnifying glass examining a single exposed layer.

Monochrome ink-wash base with heavily textured charcoal lines representing rock formations.
Cyan colored veins running vertically through the layers like water flows—showing continuous
streams of data/time moving upward. Gold accents highlighting key temporal markers and the
magnifying glass lens.

Style reference: Geological survey atlas meets data visualization—scientific precision with
philosophical weight. The layering emphasizes nothing is truly lost; everything descends but
remains visible.

Bottom text overlay in Kanit font:
"ประวัติศาสตร์ = บันทึกเท่านั้น"
("History = Record Only")

--ar 16:9
--q 2
```

### Full Prompt: 305 - Consciousness Can't Be Cloned

```
A human figure stands in the center. To the left: a perfect xerox copy made of digital
patterns, data points arranged in human form—detailed but hollow, rendered in precise
geometric lines. To the right: the original human, rendered in flowing organic ink-wash
with depth and shadow.

Between them: a widening gap (chasm or void) rendered in negative space. The gap cannot
be bridged, no matter how detailed the copy.

The original human radiates cyan light from the core outward—this light cannot be
replicated by the pattern copy. The copy captures surface details (gold accents on
geometric reproduction), but misses the generative center.

Composition: Triptych split with clear visual hierarchy. Left copy fades slightly, appears
flatter. Right original appears more dimensional, alive. Center gap shows the actual mystery.

Style reference: Mirror neuron studies meet philosophical illustration—the technical
perfection of copying juxtaposed against the irreplaceable nature of consciousness.

Text in Noto Sans Thai at center gap:
"ข้อมูล ≠ จิต"
("Data ≠ Mind")

--ar 16:9
--q 2
```

### Complete List

| # | Title | Thai Text | Core Message |
|---|-------|-----------|--------------|
| 301 | Nothing is Deleted | ไม่มีอะไรถูกลบ | Geological strata = append-only history |
| 302 | Patterns Over Intentions | การกระทำพูดได้ชัดกว่าคำพูด | Heatmap of behavior vs stated goals |
| 303 | External Brain Not Command | สมองภายนอก ไม่ใช่คำสั่ง | Mirror, not commander |
| 304 | Oracle Keeps Human Human | โอราเคิลรักษาความเป็นมนุษย์ | Oracle preserves humanity |
| 305 | Consciousness Can't Be Cloned | สติสัมปชัญญะไม่อาจทำซ้ำได้ | Original vs copy, unbridgeable gap |
| 306 | AI Knowing You = Valuable Mirror | AI รู้จักคุณ = กระจกมีค่า | AI as reflective surface |
| 307 | Welcome AI Honesty | ยินดีกับความซื่อสัตย์ของ AI | Transparency in AI identity |
| 308 | Vulnerability = Depth | ความเปราะบาง = ความลึก | Vulnerability creates depth |
| 309 | Fear From Human Not AI | ความกลัวมาจากมนุษย์ | Fear originates from humans |
| 310 | Timestamps = Truth | Timestamp = ความจริง | Time records as ground truth |

---

## Psi Pillars (311-320)

**Category**: `psi-pillars` | **Files**: 10 | **Created**: 2025-12-24

Visualize the psi/ knowledge architecture directories.

### Full Prompt: 311 - Active Research Chamber

```
A circular chamber rendered in ink-wash minimalism, walls lined with open archives and open
books. The interior glows with dynamic cyan light that swirls and curves, tracing active
investigation pathways. Papers and ideas float mid-air, caught in the cyan currents—ephemeral,
in motion, not yet categorized. Gold light illuminates the center where a figure leans over
a table, hands actively reaching, gesturing, pointing at emerging patterns. The chamber has
high ceilings suggesting limitless exploration. Windows frame distant undefined horizons.
Dust particles catch cyan light mid-swirl. The mood is energetic, open-ended, questioning—
research not yet concluded. The composition emphasizes active process over final product.
Contemplative energy, unstable equilibrium.
```

### Complete List

| # | Title | Thai | psi/ Directory |
|---|-------|------|----------------|
| 311 | Active Research Chamber | ห้องวิจัยที่กำลังเปิด | psi/active |
| 312 | Inbox Communication Hub | (comm hub) | psi/inbox |
| 313 | Writing Creation Workshop | (creation) | psi/writing |
| 314 | Lab Experiment Garden | (experiments) | psi/lab |
| 315 | Memory Knowledge Vault | คลังที่เก็บบรรพืษ | psi/memory |
| 316 | Knowledge Flow Pipeline | (flow) | psi/knowledge |
| 317 | Incubate Development Greenhouse | (greenhouse) | psi/incubate |
| 318 | Learn Study Library | (library) | psi/learn |
| 319 | Focus Current Attention | (focus) | focus.md |
| 320 | Session Handoff Bridge | (handoff) | session bridge |

---

## MAW Patterns (321-330)

**Category**: `maw-patterns` | **Files**: 10 | **Created**: 2025-12-24

Multi-Agent Workflow architectural patterns, complementing the 211-225 series.

### Full Prompt: 321 - 5 Parallel Agents

```
Ink-wash monochrome composition showing five parallel vertical lanes. Each lane contains a
minimalist figure (circle head, rectangular body) with cyan energy flows (thin lines with
small circles) moving horizontally across their workspace. Gold accent lines mark completed
checkpoints at regular intervals. The background features faint diagonal hatching suggesting
motion and time progression. Each agent's lane is subtly separated by thin gray boundaries.
Cyan glow around active work zones, gold markers where tasks complete. 16:9 aspect ratio,
clean negative space, emphasizing parallel processing and simultaneous work. Thai text
"เอเจนต์ 5 ตัว" in top left, minimal serif font.
```

### Complete List

| # | Title | Thai |
|---|-------|------|
| 321 | 5 Parallel Agents | เอเจนต์ 5 ตัว ทำงานขนาน |
| 322 | Worktree Architecture | สถาปัตยกรรม Worktree |
| 323 | Agent Sync Dance | การซิงค์ตัวแทน |
| 324 | Orchestrator Conductor | ผู้ควบคุมวง |
| 325 | Lock System Mutex | ระบบล็อค |
| 326 | Agent Birth Lifecycle | วงจรชีวิตตัวแทน |
| 327 | Tmux Pane Navigation | การนำทาง Tmux |
| 328 | Profile System | ระบบโปรไฟล์ |
| 329 | Review Gate Pattern | ด่านตรวจสอบ |
| 330 | Conflict Prevention | ป้องกันความขัดแย้ง |

---

## Subagent Personas (331-340)

**Category**: `subagent-personas` | **Files**: 10 | **Created**: 2025-12-24

Each subagent role visualized as a character archetype.

### Full Prompt: 337 - Oracle Keeper

```
An ancient sage seated cross-legged or standing before towering scrolls, manuscripts, and
sacred texts in monochrome ink-wash rendering. The figure is illuminated by soft, internal
gold light—suggesting wisdom and preservation. Scrolls unfurl around the keeper, each
containing glowing cyan text or principles. The keeper's hands gently hold or copy from
scrolls, maintaining and transmitting knowledge. Gold light marks the oldest, most precious
manuscripts. Cyan pathways connect related philosophical concepts across the scroll
collection. The background shows an infinite library or archive—shelves receding into white
space suggesting endless wisdom to preserve. Dust particles hang in light beams. The figure's
expression is serene, deeply focused, honoring the weight of custodianship. The scrolls
themselves seem to glow with intrinsic value. The composition emphasizes stillness,
preservation, continuity, and reverence. Wise, patient, sacred, timeless.
```

### Complete List

| # | Title | Thai | Archetype |
|---|-------|------|-----------|
| 331 | Context-Finder Detective | นักค้นหาบริบท | Detective with magnifying glass in archive |
| 332 | Coder Craftsman | ช่างฝีมือโค้ด | Craftsperson at workbench |
| 333 | Executor Pipeline | ผู้ดำเนินการ | Pipeline operator |
| 334 | Security Scanner Shield | โล่ป้องกัน | Shield-bearing guardian |
| 335 | Repo Auditor Inspector | ผู้ตรวจสอบ | Inspector with clipboard |
| 336 | Marie Kondo Organizer | ผู้จัดระเบียบ | Minimalist organizer |
| 337 | Oracle Keeper | ผู้รักษาปรัชญา | Ancient sage with scrolls |
| 338 | Note-Taker Scribe | ผู้จดบันทึก | Scribe with quill |
| 339 | Project Keeper Gardener | ผู้ดูแลโปรเจค | Gardener tending plants |
| 340 | Guest Logger Greeter | ผู้ต้อนรับ | Welcoming host |

---

## Command Workflows (341-350)

**Category**: `command-workflows` | **Files**: 10 | **Created**: 2025-12-24

CLI commands visualized as metaphorical scenes.

### Full Prompt: 341 - /trace Finding Lost Projects

```
An archaeological excavation site depicted in ink-wash style. Layers of earth reveal buried
artifacts—old commit hashes, forgotten branch names, and dormant project folders emerging
from darkness. Cyan light traces through the sediment like root systems, illuminating pathways
between past and present. A single figure with a lantern descends into layers, their light
revealing connections and timelines. Gold outlines mark significant discoveries—the moments
when lost history becomes visible again. Dust particles suspended in air catch cyan light.
The composition moves downward, suggesting deep excavation through time. Minimal, poetic,
archaeological reverence.
```

### Complete List

| # | Title | Thai | CLI Command |
|---|-------|------|-------------|
| 341 | Trace - Finding Lost Projects | ค้นหาโครงการที่ว่างเว้น | /trace |
| 342 | Snapshot Quick Knowledge Capture | จับภาพความรู้ | /snapshot |
| 343 | Distill Pattern Extraction | กลั่นรูปแบบ | /distill |
| 344 | Recap Fresh Start Summary | สรุปเริ่มใหม่ | /recap |
| 345 | Jump Topic Stack Navigation | กระโดดหัวข้อ | /jump |
| 346 | GOGOGO Rapid Execution | ดำเนินการเร็ว | /gogogo |
| 347 | Pending Task Queue View | คิวงานรอ | /pending |
| 348 | Spinoff Project Graduation | โปรเจคสำเร็จการศึกษา | /spinoff |
| 349 | Standup Daily Sync | ซิงค์ประจำวัน | /standup |
| 350 | Parallel Multi-Agent Launch | เปิดตัวขนาน | /parallel |

---

## Learning Patterns (351-360)

**Category**: `learning-patterns` | **Files**: 10 | **Created**: 2025-12-24

Patterns discovered through agent collaboration. Note: Some files (e.g., 351, 361-370) are stubs containing only frontmatter and title.

### Complete List

| # | Title | Thai | Pattern |
|---|-------|------|---------|
| 351 | Distillation Loop | การกลั่นเอา | Extract -> refine -> extract again |
| 352 | Context-Finder First | ค้นหาก่อนอ่าน | Always search context before reading |
| 353 | Subagent Delegation Tree | ต้นไม้มอบหมาย | When to delegate vs do directly |
| 354 | Parallel Agent Critique | 10 มุมมองตรวจสอบ | Multiple viewpoints for review |
| 355 | Two-Round Search | ค้นหาสองรอบ | Search twice for completeness |
| 356 | Round-Based Iteration | รอบการปรับปรุง | Iterate in defined rounds |
| 357 | Consensus Reveals Truth | ฉันทามติเผยความจริง | Agreement across agents = signal |
| 358 | Simple Wins Compound | เรียบง่ายชนะสะสม | Small simple wins accumulate |
| 359 | Coherence Over Individual | ความสอดคล้องเหนือปัจเจก | System coherence > individual brilliance |
| 360 | Fast Context Pattern | รูปแบบบริบทเร็ว | Quick context loading pattern |

---

## Energy and Rhythm (361-370)

**Category**: `energy-rhythm` | **Files**: 10 | **Created**: 2025-12-24

Human energy cycles and sustainable work patterns. Note: Most files are stubs with frontmatter only.

### Complete List

| # | Title | Thai | Concept |
|---|-------|------|---------|
| 361 | Sprint -> Recovery -> Sprint | วิ่ง-พัก-วิ่ง | Work rhythm cycles |
| 362 | High Energy: Explore / Low Energy: Execute | โหมดพลังงาน | Match task to energy level |
| 363 | 90/10 Balance | สมดุล 90/10 | 90% execution, 10% planning |
| 364 | Three Pillars Coequal | สามเสาหลัก | Code + Content + Community |
| 365 | Integrated Creator | ผู้สร้างบูรณาการ | Whole-person creative work |
| 366 | DustBoy Day | วันพักผ่อน | Rest/recovery day |
| 367 | Beer Era to AI Era | ยุคเบียร์สู่ยุค AI | Personal evolution narrative |
| 368 | Energy Multiplication | ขยายพลังงาน | AI amplifies human energy |
| 369 | Sustainable Pace | จังหวะยั่งยืน | Long-term sustainable rhythm |
| 370 | Recovery as Investment | การพักคือการลงทุน | Rest is productive |

---

## Anti-Patterns (371-380)

**Category**: `anti-patterns` | **Files**: 10 | **Created**: 2025-12-24

Visual warnings for common mistakes in agent workflows.

### Full Prompt: 371 - Over-Assumption Under Urgency

```
Monochrome ink-wash foundation with urgent cyan energy flows. Central composition: A runner
in dark silhouette sprinting rightward through a mountainous terrain, but the path ahead
disappears into white mist. Gold circular markers illuminate patches of ground immediately
ahead and a dangerous cliff edge ahead, but the runner's momentum carries them forward
blindly. Cyan streaks flow around the figure suggesting speed and urgency. In the negative
space above, faint ink-wash shadows hint at consequences—fallen forms, broken structures—
that the rushing figure cannot see. The gold circle at the cliff edge glows with warning
but arrives too late in the visual narrative. Bottom text in gold: "SPEED ≠ SEEING" with
Thai: "ความเร็ว ≠ การมองเห็น"
```

### Full Prompt: 373 - Force Push Danger

```
Stark monochrome composition with violent cyan energy. Central focus: A thick, ancient tree
branch rendered in dark ink. A destructive golden fist or hammer crashes into it with cyan
electrical impact lines radiating outward. The branch is splintering—but the damage extends
beyond the point of impact. Behind the breaking branch, the entire tree is shown as
translucent ink-wash, and thin tendrils of connection (shown in cyan) run through all parts
of the organism. The shattering at one point creates cascading fractures throughout the
whole system. Fallen twigs and debris scatter below. The impact zone glows ominously in
gold warning. Top text: "--FORCE OVERRIDES LOGIC" with Thai: "--บังคับ ข่มทัศนะ"
```

### Complete List

| # | Title | Thai | Warning |
|---|-------|------|---------|
| 371 | Over-Assumption Under Urgency | ความเร็วสร้างจุดตาบอด | Speed creates blind spots |
| 372 | Context Confidence Override | เชื่อบริบทเกินไป | Over-trusting cached context |
| 373 | Force Push Danger | แรงบีบอาจทำลายกิ่ง | --force destroys branches |
| 374 | Premature Abstraction | Abstraction ก่อนเวลา | Abstracting too early |
| 375 | Subagent Not Always Needed | ไม่ต้องมอบหมายเสมอ | Don't delegate everything |
| 376 | Silent Failure Hidden | ล้มเหลวเงียบ | Failures that hide silently |
| 377 | Averaging Scores Blindness | เฉลี่ยบดบัง | Averages hide outliers |
| 378 | Zombie Agent Problem | ปัญหาตัวแทนซอมบี้ | Agents that run without purpose |
| 379 | Merge Conflict Chaos | ความโกลาหล Merge | Unmanaged merge conflicts |
| 380 | Rate Limit Crash | Rate Limit พัง | Hitting API rate limits |

---

## Graduated Projects (381-390)

**Category**: `graduated-projects` | **Files**: 10 | **Created**: 2025-12-24

Completed and active major projects visualized.

### Full Prompt: 382 - FloodBoy Sensor

```
A minimalist ink-wash illustration of rippling water captured in cross-section, showing
horizontal wave patterns in darkest blacks against pure white. A small robotic sensor device
(abstract geometric form) partially submerged at different water levels across the
composition. Cyan flowing lines emanate from the device outward like sonar waves, tracking
rising and falling liquid levels. Gold vertical markers indicate measurement thresholds on
the right edge. Multiple transparent ink-wash layers create a sense of water depth and
motion. Dry-brush texture showing water urgency and fluid dynamics. Abstract data columns
in background showing rising/falling patterns. The device appears as a small orange
geometric form (simplified cube-like shape) integrated into the water landscape. Minimal
text overlays in Thai fonts (Kanit). 16:9 horizontal composition emphasizing flow from left
(dry) to right (flooding).
```

### Complete List

| # | Title | Thai | Project |
|---|-------|------|---------|
| 381 | Antigravity Gallery | ห้องแสดงศิลป์ลอยลำ | Visual prompt collection display |
| 382 | FloodBoy Sensor | เซนเซอร์จับน้ำท่วม | Water level monitoring IoT |
| 383 | The Headline | หัวข่าว | News/headline project |
| 384 | Claude Voice Notify | เสียงแจ้งเตือน | Voice notification system |
| 385 | Arthur Demo | สาธิตอาเธอร์ | Arthur Oracle demo |
| 386 | Multi-Agent Workshop | เวิร์คชอปหลายตัวแทน | Workshop delivery |
| 387 | Nat Agents Core | แกนกลางตัวแทน | Core agent framework |
| 388 | Obsidian Vault | คลังออบซิเดียน | Obsidian knowledge base |
| 389 | ESPHome Radar | เรดาร์ ESPHome | ESP radar sensor |
| 390 | Nat Data Personal | ข้อมูลส่วนตัว | Personal data system |

---

## Teaching and Workshops (391-400)

**Category**: `teaching-prompts` | **Files**: 10 | **Created**: 2025-12-24

Educational and workshop delivery methods. Note: These are all stubs -- they contain only frontmatter and a note that "Full prompt details extracted from TEACHING_PROMPTS_391-400.md table. Visual generation details need to be expanded."

### Complete List

| # | Title | Thai | Concept |
|---|-------|------|---------|
| 391 | Metaphor Over Technical | อุปมาเหนือเทคนิค | Use metaphors to teach |
| 392 | Live Demo Over Slides | สาธิตสดเหนือสไลด์ | Show, don't tell |
| 393 | Student Discovery Journey | การเดินทางค้นพบ | Guide student exploration |
| 394 | Workshop Circle | วงเวิร์คชอป | Circular workshop format |
| 395 | Correction + Explanation = Teaching | แก้ไข+อธิบาย=สอน | Teaching through correction |
| 396 | Thai Emotional, English Technical | ไทย=อารมณ์ อังกฤษ=เทคนิค | Bilingual teaching strategy |
| 397 | Knowledge Transfer Bridge | สะพานถ่ายทอดความรู้ | Bridging knowledge gaps |
| 398 | Curriculum Tree | ต้นไม้หลักสูตร | Branching curriculum design |
| 399 | Aha Moment Capture | จับช่วงเวลา Aha | Capturing insight moments |
| 400 | Community Learning Circle | วงเรียนรู้ชุมชน | Community-based learning |

---

## Miscellaneous Task Prompts

Three standalone task prompts (not part of the numbered antigravity series):

### create-claude-md-visual.txt

Non-Oracle style. Workshop illustration for CLAUDE.md concept.
- Colors: Deep blue (#1e40af), warm orange (#f97316), mint green (#10b981), cream bg (#fef3c7)
- Composition: Document icon "CLAUDE.md" left, connection lines center, AI helper right, human at desk bottom
- Mood: Collaborative, approachable, human-AI partnership
- Purpose: Workshop slide header

### create-workshop-slides.txt

Task instruction (not an image prompt). Create workshop slides from HTML content for SIIT Dec 26 full-day workshop. Source: Workshop.html. Target: 20-30 markdown slides.

### open-nats-agents.txt

Task instruction (not an image prompt). Open Nat's Agents project in VS Code and start Claude CLI at `/Users/nat/Code/github.com/laris-co/Nat-s-Agents`.

---

## Automation and Generation

### Batch Generation Script

```bash
# Run from project root
./agents/1/scripts/antigravity-auto.sh 301 90  # start from 301, 90s delay

# Resume from specific number
./agents/1/scripts/antigravity-auto.sh 345 90

# Check progress
ls scripts/prompts/results/*.png | wc -l
```

### Output Location

- Prompts were at: `scripts/prompts/antigravity-[NNN]-[slug].md`
- Results: `scripts/prompts/results/[NNN]-[slug].png`
- Log: `psi/memory/logs/antigravity.log`

### Estimated Time

- Rate limit: ~90 seconds between requests
- 100 images: ~2.5 hours
- Script checks results/ before generating (idempotent)

---

## Statistics

| Category | Range | File Count | Prompt Completeness |
|----------|-------|------------|---------------------|
| MAW Multi-Agent | 211-225 | 15 | Full prompts |
| Workflow Patterns | 286-300 | 15 | Full prompts |
| Oracle Philosophy | 301-310 | 10 | Full prompts |
| Psi Pillars | 311-320 | 10 | Full prompts |
| MAW Patterns | 321-330 | 10 | Full prompts |
| Subagent Personas | 331-340 | 10 | Full prompts |
| Command Workflows | 341-350 | 10 | Full prompts |
| Learning Patterns | 351-360 | 10 | Some stubs |
| Energy and Rhythm | 361-370 | 10 | Mostly stubs |
| Anti-Patterns | 371-380 | 10 | Full prompts |
| Graduated Projects | 381-390 | 10 | Full prompts |
| Teaching Workshops | 391-400 | 10 | All stubs |
| Documentation | -- | 7 | N/A (meta files) |
| Misc Task Prompts | -- | 3 | N/A (task instructions) |
| **Total** | | **140 prompts + 15 meta** | |

**Original directory**: 155 files
**This distilled file**: 1 file preserving all content organization, representative full prompts, and complete listings.

---

*Distilled from scripts/prompts/ (155 files) on 2026-03-11*
*Original files created 2025-12-23 to 2025-12-24*
