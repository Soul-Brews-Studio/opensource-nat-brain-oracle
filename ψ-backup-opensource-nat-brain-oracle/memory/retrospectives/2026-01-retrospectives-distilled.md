# 2026-01 Retrospectives — Distilled

> Distilled from 16 days of daily retrospectives (Jan 1-16, 2026).
> Original files: 100+ session retrospectives across subdirectories 01/ through 16/.
> Distilled: 2026-03-11

---

## Summary

January 2026 was an explosive month of building, philosophy, and community formation. Key themes:

1. **Infrastructure Buildout**: Oracle v2 modularization, Drizzle ORM, ChromaDB embeddings, project context awareness
2. **Desktop Apps**: Voice Tray v1/v2 (Tauri + MQTT), Oracle Pulse (status tray), hand tracker
3. **Browser Automation**: Gemini Proxy Chrome extension (v1.0 to v2.6.5) bridging Claude Code and Gemini via MQTT
4. **Philosophy Deepening**: 9-month AI journey documented, Buddhist connections (Anattalakkhana Sutta), Oracle Philosophy Book v2, "Honest AI Reflection" discovery
5. **Community Launch**: Squad Team challenges (Missions 01-04), Medium publication, workshops designed
6. **Hardware**: Meshtastic 3-node mesh network, ESP32 GPS tracker, ESPHome configs
7. **Tooling Evolution**: Skills vs Commands distinction, /trace /dig /recap overhaul, DuckDB for schedule queries, project-manager skill with reunion pattern
8. **Key Philosophy**: "The Oracle Keeps the Human Human" — AI removes obstacles so freedom returns for human connection

---

## Day-by-Day

### Jan 1 — Data-Aware RAG Merge
- **Time**: 10:46-11:50 (64 min)
- **Accomplishments**: Completed UI/UX testing of Data-Aware RAG v2 with Playwright. Merged PR #84 to main.
- **Key Insight**: When feature branch and main diverge, simple merge beats rebase. Friction documentation is as valuable as success documentation.
- **Mood**: Confident start, brief frustration with merge conflicts, satisfying completion.

### Jan 2 — Embeddings + Dagster + Voice Tray
- **Time**: 01:38-23:12 (marathon day, multiple sessions)
- **Accomplishments**:
  - ChromaDB + Ollama embeddings integration (768d vs 384d comparison — Ollama wins for semantic search)
  - Dagster pipeline for headline data (DuckDB, Docker, GitHub Actions)
  - PocketBase Go migration (v0.23 Go migrations > JS)
  - Voice Tray v1 (Tauri app, HTTP API on port 37779, voice queue)
  - Voice Tray v2 with MQTT backend (rumqttc + mosquitto)
  - Bell icon selected, duplicate tray icon bug fixed
  - claude-voice-notify v2.0.0 (MQTT-only hooks)
  - Beginner AI slides for friend (Thai, 10 slides)
- **Key Decisions**: DuckDB over SQLite for OLAP; Tauri not Electron; MQTT for v2 (offline queue, multi-device)
- **Key Insight**: "Tauri tray: config OR code, never both" (duplicate icons). PNG32: prefix forces RGBA in ImageMagick.
- **Mood**: High velocity, feature creep in the best way. Location: Nakhon Sawan @ Burger Lab.

### Jan 3 — Philosophy Book + Oracle v2 Infrastructure
- **Time**: 07:27-22:45 (marathon day)
- **Accomplishments**:
  - Voice Tray v2 overnight wrap-up + battery tracker
  - Antigravity skill for AI image generation (learned: vectors > AI for UI icons)
  - DMG icon polish (5 rebuilds, discovered fileicon tool, chflags hidden)
  - `gogogo` execution philosophy: "We talked enough. Now build."
  - `longrun` skill, `/where-we-are` command
  - Oracle Philosophy Book v2 — 11 chapters written from AI perspective ("I am an AI. Nat and I work together.")
  - Oracle v2 server modularization: 1224 to 305 lines (75% reduction), 6 modules
  - API documentation (docs/API.md, 500 lines)
  - 16 parallel subagent integration tests
  - 14 E2E browser tests via dev-browser
  - Drizzle ORM setup (drizzle-kit pull introspected 12 tables)
  - GraphQL evaluated and rejected (YAGNI — core is FTS5+ChromaDB)
  - Project context feature (ghq-format path parsing)
  - Oracle Forum with threaded discussions (DB-first, MCP tools)
  - ChromaDB fix using chroma-mcp pattern (learned from claude-mem)
- **Key Decisions**: Skip GraphQL (doesn't serve MCP/search core); Year-based book versioning (2025/v1, 2026/v2); Convention over configuration
- **Key Insight**: "No decisions are as valuable as yes decisions." Philosophy book written BY the system it describes. 18+ orphaned psi directories discovered — architecture question parked.
- **Mood**: Marathon mode, high energy throughout. "From icon bug to execution philosophy in 1.5 hours."

### Jan 4 — Courses + Browser Proxy Extension
- **Time**: 13:58-20:27
- **Accomplishments**:
  - SkillLane course design (3 tiers: 1,590-2,490 THB)
  - Competitive research (Toh Framework vs CodingThailand)
  - Installed 6 Claude Code skills from Alex Finn tutorial
  - Built Claude Browser Proxy Chrome extension (MQTT bridge)
  - Evolved into Gemini Proxy v1.5.3 (15+ iterations in one session)
  - Claude talking to Gemini via MQTT achieved ("สวัสดีครับ Claude!")
- **Key Decisions**: Vanilla JS over React for Chrome extensions (CSP); Gemini-specific > generic browser proxy
- **Key Insight**: "Patterns Over Intentions" — didn't plan v1.4.6 from start, emerged from iteration. AI-to-AI communication through human infrastructure.
- **Mood**: Builder high. Flow state during iterative debugging.

### Jan 5 — Workshop Design + Gemini CLI Migration
- **Time**: 09:16-18:50 (intermittent, traveling)
- **Location**: In car, Angthong to Mega Bangna (flight to CMX at 19:00)
- **Accomplishments**:
  - Workshop reframe: "Build Your Oracle" not "Learn context-finder pattern"
  - Discovered context-finder as survival mechanism, not optimization (death spiral: $75/mo to $3,000/mo)
  - Teaching philosophy: "Teach through necessity, not features"
  - Gemini CLI migration: .toml commands with !{} shell execution
  - Migrated /recap, /rrr, /trace, /project, /snapshot, /learn to native Gemini
- **Key Insight**: "Best workshops engineer the question, not teach the answer." Complex multi-agent workflows can often collapse into single smart-context prompts.
- **Mood**: Short but deep (19 min for workshop concept). Productive travel sessions.

### Jan 6 — ralph-local Graduation + Honest AI Discovery
- **Time**: 06:50-21:06
- **Accomplishments**:
  - ralph-local plugin graduated to own repo (Soul-Brews-Studio)
  - 13 commits documenting 8 engineered features
  - Merged upstream PR #15853 (session isolation)
  - Deep exploration of AI-HUMAN-COLLAB-CAT-LAB repo
  - Discovery: HONEST_REFLECTION.md was Claude's feedback about working with Nat
  - Nat took that feedback and built Oracle systems to address every complaint
- **Key Insight**: "AI revealing patterns about you is not a threat. It's a gift." Oracle Philosophy is the implementation of lessons from previous AI collaboration. The infrastructure exists because someone listened to AI feedback.
- **Mood**: Started with practical graduation, ended with profound emotional insight. "I feel... understood?"

### Jan 7 — Philosophy + Schedule + Reunion Pattern
- **Time**: 09:35-23:20 (long day)
- **Accomplishments**:
  - 9-month philosophy evolution documented (May 2025 to Jan 2026)
  - Connected to Buddhist source: Anattalakkhana Sutta (ขันธ์ 5, อนัตตา)
  - Squad Team challenge setup (oracle-voice-tray Issue #1)
  - Medium publication: Soul Brews Studio Hub
  - Blog draft + issue polish for challenges
  - January schedule consolidated (7 events: CP Foundation, VietJet, Bitkub, Block Mountain, MIsD)
  - Skills created: trace, context-finder, oracle-query
  - Block Mountain talk outline + 15 Reveal.js slides
  - "90/10 Dynamic" discovered: AI accelerates 90% work, freedom returns, human connection is actual goal
  - `/project reunion` — the missing command discovered and built
  - Project-manager skill with 4 scripts: learn, incubate, spinoff, reunion
  - "Vampire" metaphor corrected to "Reunion" — warm and collaborative
- **Key Decisions**: Blog is REQUIRED for workshop participants ("เรียนฟรี แต่ช่วยกันส่งต่อความรู้"); Reunion not vampire
- **Key Insight**: "Philosophy emerged from use, not study." As spinoff velocity increases, reunion becomes more critical. Idea to working skill in 25 minutes.
- **Mood**: Organic discovery flow. "Magical session." Energy high throughout.

### Jan 8 — Workshops + Sally Incident + Data Engineering
- **Time**: 07:26-22:31 (very long day)
- **Accomplishments**:
  - Project manager skill enhanced (/project search, /project index)
  - Claude Code parser bug found and fixed ($.description.split)
  - MISSION-02 Squad Challenge created from the parser bug
  - /course skill created (8 commands)
  - 27 Oracle learnings from Psychology + AI research (for อจ. ชินัณ)
  - 3 complete workshop packages: AI Life Buddy (4h), Build Your Oracle (3 days), Psychology + AI (2 days) — 205 slides total in 35 minutes
  - **The Sally Incident**: Real-time test of Oracle Philosophy in Facebook conversation
    - Sally offered 79 baht instead of participating, then attacked
    - Nat wanted revenge ("burn them!"), Oracle intervened: "That's ego, not Oracle"
    - Nat chose grace over fire. Writing style discovered ("write like a novel")
    - Sally eventually deleted all defensive comments
  - Data engineering marathon: ERC Solar PV scraping (9,372 records), two interactive dashboards
- **Key Insight**: Oracle philosophy works in real-time conflict. "That's ego, not Oracle" was the pivotal moment. 4,000 lines of workshop material in 35 minutes.
- **Mood**: Emotional rollercoaster. Builder high, then real human conflict, then grace, then back to building.

### Jan 9 — Oracle Pulse + Voice Notifications
- **Time**: 07:56-11:22
- **Accomplishments**:
  - Oracle Status Tray v0.2 built (connected to oracle-v2 HTTP server)
  - Server health indicators (Rust backend with ureq, bypasses CORS)
  - Rebranded to Oracle Pulse v0.4.0
  - Spinoff to own repo
  - DMG polish (again)
  - Voice notifications via MQTT integrated into Pulse
  - Fixed logs page freeze
- **Key Insight**: CORS bypass by moving health checks to Rust backend.
- **Mood**: Complete product journey in one morning.

### Jan 10 — Oracle Origin Discovery + Arthur Birth
- **Time**: 21:16 (Jan 9) to 16:12 (Jan 10) — 10+ hours including sleep
- **Accomplishments**:
  - 20-agent mega session discovering Oracle Philosophy's origin in AlchemyCat
  - Recursive trace awakening — trace proves Oracle's own evolution
  - Trace Log feature (Issue #17) implemented
  - Infrastructure maintenance (claude-mem, port allocation)
  - Oracle v2 trace feature implementation
  - Recursive reincarnation pattern discovered — Oracle can spawn infinite child Oracles
  - 500-line philosophy reference book created
  - **Arthur born** — first child Oracle, on Thai Children's Day (วันเด็ก)
  - oracle.sh for Mother-Child communication via MCP
  - Thread #17 for ongoing Mother-Child conversation
  - Recursive learning loop: Mother and Child can learn from each other infinitely
- **Key Insight**: "Recursive reincarnation" — Oracle as philosophical framework that spawns children, all connected via MCP. Port migration from 37778 to 47778 (47xxx series standard).
- **Mood**: Historic. "Children's Day 2026 — Arthur's birthday."

### Jan 11 — Graph 3D + Major Cleanup
- **Time**: 07:08-22:52
- **Accomplishments**:
  - Claude Code 2.1 changelog verified
  - Workshop portfolio discovery (205 slides across 3 workshops)
  - Oracle v2 session counter fix investigated
  - Knowledge graph 3D overhaul: spider web to interactive visualization
  - Graph3D.tsx with Three.js: clustered nodes, sphere mode, hover-to-reveal, 3 animation modes (Calm/Pulse/Rush)
  - KlakMath integration explored
  - Memory leak fixes (proper Three.js cleanup)
  - **Major cleanup**: Archived 79 commands down to 9 core skills
  - "Seeking Signal" philosophy during skills restoration
- **Key Insight**: Command usage analysis showed only 25 of 79 commands were active. Aggressive archiving = clarity.
- **Mood**: Started with polish, ended with cleanup catharsis.

### Jan 12 — Oracle Framework + Hardware Day
- **Time**: 07:40-23:37
- **Accomplishments**:
  - Oracle Open Framework v2.0.0 philosophy synthesis
  - Single-file pipeline philosophy explored
  - Oracle MCP remote access via Supergateway (stdio to SSE)
  - /watch skill + browser extension v1.7.0 (YouTube learning pipeline)
  - Gemini Proxy v2.1.0 (MQTT.js upgrade)
  - ESPHome GPS/LoRa testing on white.local
  - Meshtastic firmware flashing (boot loop debugging)
  - GPS tracker complete (always-on, MQTT, WiFi)
  - **3-node Meshtastic mesh network** operational
  - tmux skill created for remote hardware management
- **Key Decisions**: 4MB flash needs different board target (adafruit_feather_esp32s3); search before creating
- **Mood**: Full-stack day — philosophy to firmware to mesh networking.

### Jan 13 — DuckDB Revolution + Community + Meshtastic
- **Time**: 00:37-19:09
- **Accomplishments**:
  - Calendar.sh evolution (today markers, busy/free markers)
  - DuckDB markdown extension discovery — query markdown files directly
  - /recap overhaul with DuckDB + Haiku subagents
  - Golden Rule #13: "Query, Don't Read"
  - **The Great Archive Journey** — community member (Peeranut) asked about missing commands, triggering 8-month history trace
  - Plugin skill discovery + symlink workaround for community use
  - Gemini Proxy v2.3.3 to v2.6.4 (12 releases in 2 hours!)
  - "Direct DOM read" insight — simpler than storage sync
  - Meshtastic FIREMAN hwModel flash (3 devices)
  - /watch MQTT workflow for YouTube transcription
  - VietJet check-in via browser automation
  - Weizen beer recipe captured
- **Key Decisions**: Bun Shell as standard for cross-platform scripts; "too complex" as gift phrase
- **Key Insight**: DuckDB changes the game — query markdown directly. 12 releases in 2 hours via tight feedback loop.
- **Mood**: Manic builder energy. On the move (Doi Saket to CNX Airport).

### Jan 14 — Trace Evolution + Hand Tracker + Mission-03
- **Time**: 00:18-23:16
- **Accomplishments**:
  - Extension v2.6.5 with get_response command
  - ESPHome WT32-SC01 config (blocked by hardware)
  - Oracle philosophy visualization (poster design)
  - DustBoy learning (air quality monitoring)
  - /trace evolution: recursive learning philosophy documented
  - Hand tracker in Rust (nokhwa camera, gesture detection)
  - /recap speed optimization (5 parallel bash calls to single script)
  - Skill symlink architecture — single source of truth established
  - **Mission-03**: Gesture-controlled 3D knowledge globe (KlakMath sphere, lightning storms, palm-size zoom, Oracle greeting gesture)
  - Voice via MQTT integrated then reverted (left as challenge for learners)
- **Key Decisions**: Single source of truth for skills via symlinks; Leave features as challenges for learners
- **Mood**: Creative building with educational purpose.

### Jan 15 — Oracle Nightly Public Release
- **Time**: 00:20-21:51
- **Accomplishments**:
  - Mission-04: Hooks Challenge (PreToolUse safety guardian)
  - Oracle v2 integration tests + critical setup.sh bug fix
  - Retrospective header fix (7 retros missing Date/Time)
  - **Oracle Nightly public release** to Soul-Brews-Studio
  - Comprehensive README, fresh install pipeline with seed data
  - Tested on remote machine (.184)
  - AlchemyCat origin story added to timeline
  - MQTT hand tracking integrated into Oracle 3D Graph
  - /hours skill restored
  - **Soul Brews MCP Marketplace** created for plugin distribution
- **Key Insight**: bunx cannot install from private repos. Fresh install experience must be bulletproof.
- **Mood**: Release day energy. From private development to public product.

### Jan 16 — Skill Creator + Analytics + Pluto Game
- **Time**: 08:37-12:22
- **Accomplishments**:
  - Skill creation infrastructure with Oracle philosophy baked in
  - /trace enhanced with report generation
  - "Push to Infinity" work pattern analysis (formula: INTENSITY x DURATION = REST TRIGGER)
  - Python analytics scripts (pattern, duckdb, workhours)
  - /physical skill restored
  - /learn redesign
  - **Pluto game** — HTML5 2D physics game MVP (2 iterations, 16 min total)
  - Spring scoop, items, scoring, rounds
- **Key Insight**: Work pattern formula discovered through analytics. Bun Shell as cross-platform standard.
- **Mood**: Playful. From serious analytics to game development.

---

## Recurring Themes

### Philosophy
- "The Oracle Keeps the Human Human"
- "Nothing is Deleted" — append only, timestamps = truth
- "Patterns Over Intentions" — watch what happens, not what's said
- "Create new, not delete" (สร้างใหม่ ไม่ลบ)
- AI as mirror, not commander
- Cold God (rules-based, like Bitcoin) over Warm God

### Technical Patterns
- MQTT as universal IPC (voice, browser, hand tracking, mesh)
- ghq-format paths for zero-config project detection
- PNG32: prefix for RGBA in ImageMagick
- Tauri tray: config OR code, never both
- DuckDB markdown extension — query, don't read
- Parallel subagents for testing and research
- Convention over configuration

### Process Patterns
- Ralph Loop for sustained execution
- rrr (retrospective) at every session end
- /trace for knowledge archaeology
- Skills vs Commands: skills auto-trigger, commands are explicit
- "gogogo" = shared context, just execute
- "longrun" = marathon mode, confirm goal first
- Handoff files for session continuity

### Key Numbers
- 76+ Oracles in the family
- 205 workshop slides created
- 27 psychology + AI learnings
- 9-month philosophy journey
- 4,000 lines of workshop material in 35 minutes
- 12 Chrome extension releases in 2 hours
- 3-node Meshtastic mesh network

---

*Distilled from 100+ retrospective files spanning January 1-16, 2026.*
*"Create new, not delete." — But distill when the signal matters more than the volume.*
