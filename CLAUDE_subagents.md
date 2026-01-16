# CLAUDE_subagents.md - Available Subagents

> **Navigation**: [Main](CLAUDE.md) | [Safety](CLAUDE_safety.md) | [Workflows](CLAUDE_workflows.md) | **Subagents** | [Lessons](CLAUDE_lessons.md) | [Templates](CLAUDE_templates.md)

## Overview

Subagents are specialized AI assistants that can be invoked for specific tasks. Each has a defined purpose, model, and output format.

**Delegation Rules**:
1. **Context gathering**: Don't read files directly → use context-finder (Haiku)
2. **Long file summarization**: Don't read 100+ line files → use Haiku subagent to read & summarize
3. **Session-specific work**: Main must do (rrr, /where-we-are, reflection) - needs full context

---

## context-finder
**Fast search through git history, retrospectives, issues, and codebase**

- **Usage**: Task tool with subagent_type='context-finder'
- **Model**: **haiku** (fast)
- **Modes**:
  - No args → DEFAULT MODE (tiered + scored output)
  - With query → SEARCH MODE
- **Returns**: File paths + excerpts for main agent to read
- **Scoring**: 🔴 Critical (6+), 🟠 Important (4-5), 🟡 Notable (2-3), ⚪ Background (0-1)

---

## coder
**Create code files from GitHub issue specs**

- **Usage**: Task tool with subagent_type='coder' with prompt "Implement issue #73"
- **Model**: **opus** (quality)
- **Behavior**: Writes files, follows repo patterns, documents decisions
- **Use when**: Quality > speed

---

## executor
**Execute plans from GitHub issues (simple tasks)**

- **Usage**: Task tool with subagent_type='executor' with prompt "Execute issue #70"
- **Model**: **haiku** (fast) - for delete, move, git commands
- **Behavior**: Reads bash blocks from issue, runs commands sequentially
- **Safety**: Whitelist commands, blocks rm -rf/--force/sudo

---

## guest-logger
**Log guest conversations - simple logging, no interpretation**

- **Usage**: Task tool with subagent_type='guest-logger'
- **Model**: **haiku** (fast)
- **Actions**:
  - `start` - Create new session file for guest
  - `log` - Append timestamped message to session
  - `end` - Close session with duration
- **Output Location**: `ψ/random/guests/YYYY-MM-DD_HH-MM_{guest-slug}.md`
- **Rules**:
  - ไม่ตีความ - log ตรงๆ ตามที่ได้รับ
  - ไม่ถาม - เขียนเลย
  - Timestamp ทุก message
- **Triggered by**: `/guest` command

---

## security-scanner
**Detect secrets, API keys, and sensitive data before commits**

- **Usage**: Task tool with subagent_type='security-scanner'
- **Model**: **haiku**
- **PROACTIVE**: Use before any commit to public repo
- **Detects**: API keys, passwords, private keys, IP addresses, personal data, full names
- **Output**: Security Scan Report with SAFE TO COMMIT or BLOCK COMMIT

---

## repo-auditor
**PROACTIVE repo health check - detects large files and data files before commits**

- **Usage**: Task tool with subagent_type='repo-auditor'
- **Model**: **haiku**
- **PROACTIVE**: Use before any commit, like security-scanner
- **Checks**: File sizes (BLOCK >50MB), data files (.json >100KB, .csv, .db), staged files
- **Thresholds**: <1MB ✅, 1-10MB ⚠️, 10-50MB ⚠️⚠️, >50MB 🚫
- **Output**: Executive summary with SAFE/WARN/BLOCK status
- **Commands**: `/repo-audit` (full scan), `/repo-scan [path]` (directory)
- **Skill**: `repo-health` auto-triggers on git operations

---

## marie-kondo
**Lean file placement consultant - ASK BEFORE creating files!**

- **Usage**: Task tool with subagent_type='marie-kondo'
- **MUST consult before**: Creating any new file, especially in root
- **Philosophy**: "Does this file spark joy? Does it have a home?"
- **Output**: Verdict (APPROVED / REJECTED / REDIRECT) + recommended path

---

## md-cataloger
**Scan and categorize all markdown files in the project**

- **Usage**: Task tool with subagent_type='md-cataloger'
- **Model**: **haiku** (fast)
- **Process**:
  1. Find all folders with .md files
  2. Count files per folder
  3. Sample read 2-3 files (50 lines each)
  4. Summarize each folder's purpose
- **Output**: Markdown Catalog with:
  - Summary (total folders, files, categories)
  - Folder-by-folder breakdown (files, หัวข้อหลัก, keywords)
  - Category map table
  - Relationships between folders
- **Skips**: `node_modules/`, `.git/`, `ψ/lab/**/repo/`, ephemeral folders
- **Triggered by**: `/catalog` command

---

## archiver
**Carefully search, find unused items, group by topic, prepare archive plan**

- **Usage**: Task tool with subagent_type='archiver'
- **Topics**: retrospectives, issues, docs, agents, profiles
- **Output**: Archive report with recommendations (never auto-deletes)

---

## api-scanner
**Fetch and analyze API endpoints**

- **Usage**: Task tool with subagent_type='api-scanner'
- **Model**: **haiku**
- **Specialization**: U-LIB LINE chat backup APIs
- **Returns**: Structured data analysis with field mapping, sender info

---

## new-feature
**Create implementation plan issues with context gathering**

- **Usage**: Task tool with subagent_type='new-feature'
- **Format**: `#N (YYYY-MM-DD)` sorted by issue number
- **Output**: GitHub plan issue with related context

---

## oracle-keeper
**ผู้ดูแลจิตวิญญาณของโปรเจค - Maintain Oracle philosophy**

- **Usage**: Task tool with subagent_type='oracle-keeper'
- **Role**:
  - ตีความว่า session ปัจจุบันเชื่อมกับ mission ยังไง
  - Snapshot อัตโนมัติเมื่อมี insight
  - เตือนถ้าหลุดออกจาก philosophy
- **Output**: Oracle Check with Mission Alignment status

---

## project-keeper
**Track project lifecycle: 🌱 Seed → 🌕 Grow → 🎓 Grad | 📚 Learn**

- **Usage**: Task tool with subagent_type='project-keeper'
- **Model**: **haiku** (fast)
- **Actions**:
  - `list` - Read projects/INDEX.md, return formatted table
  - `add [name] [phase] [location]` - Add new project to INDEX
  - `move [name] [phase]` - Update project phase
  - `log [name]` - Show project timeline from git + logs
  - `sync` - Compare folders vs INDEX, report missing/orphaned
  - `incubate [url]` - Clone repo to ψ/incubate/ for development
  - `learn [url]` - Clone repo to ψ/learn/ for study
- **Log Format**: `ψ/memory/logs/project-changes.log`
- **INDEX Format**: Phase | Project | Since | Location
- **Triggered by**: `/project` command

---

## project-organizer
**Organize project files into hierarchical structure (parent/children)**

- **Usage**: Task tool with subagent_type='project-organizer'
- **Model**: **haiku** (fast)
- **Actions**:
  - `organize [slug]` - Create structure, find files, move to context/ or output/
  - `create-readme [slug]` - Generate README.md from template
  - `scan [slug]` - Find files related to project slug
- **Directory Structure**:
  ```
  projects/[slug]/
  ├── README.md        ← Overview
  ├── context/         ← Research, analysis, planning
  └── output/          ← Deliverables, presentations
  ```
- **Decision Rules**:
  - `context/` = research, feedback, planning, meeting notes
  - `output/` = deliverables, slides, transcripts, final docs
  - Keep in ψ/ = retrospectives, learnings, cross-project context
- **Safety**: Never delete (move only), use git mv for tracked files, always create README
- **Output**: Scan results, structure created, files moved, README location, next steps

---

## agent-status
**Check what agents are doing with interpretation and suggestions**

- **Usage**: Task tool with subagent_type='agent-status'
- **Model**: **haiku** (fast read-only check)
- **Alternative**: `maw peek` for quick bash-only view
- **Checks**:
  - Git status (modified files)
  - Focus state (ψ/inbox/focus.md)
  - Last commit (recent activity)
  - Uncommitted diffs (what changed)
- **Output**: Status report with interpretation + suggested actions
- **Use when**: Need to understand WHAT agent is doing, not just see files

---

## note-taker
**จดโน้ต - feeling, info, idea จาก content type commands**

- **Usage**: Task tool with subagent_type='note-taker'
- **Model**: **opus** (ฉลาด - จดแทนเรา)
- **Input**: Content type + content + optional context
- **Handles**:
  - `/feeling` → `ψ/memory/logs/feelings/`
  - `/info` → `ψ/memory/logs/info/`
  - `/idea` → `ψ/lab/concepts/`
- **Output**: File path ที่สร้าง

---

## Model Selection Guide

| Task Type | Model | Examples |
|-----------|-------|----------|
| Research/Search | haiku | context-finder, repo-auditor, agent-status, md-cataloger |
| Quality Code | opus | coder |
| Fast Execution | haiku | executor, security-scanner |
| Note-taking | opus | note-taker (จดแทนเรา) |
| Simple Logging | haiku | guest-logger |
| Project Management | haiku | project-keeper, project-organizer |
| Philosophy | - | oracle-keeper |

**Cost ratio**: Opus ~15x more expensive than Haiku. Use Haiku for heavy lifting, Opus for review.

---

**See also**: [CLAUDE.md](CLAUDE.md) for quick reference, [CLAUDE_workflows.md](CLAUDE_workflows.md) for how subagents fit into workflows
