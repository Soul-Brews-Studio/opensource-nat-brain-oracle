# CLAUDE_lessons.md - Lessons Learned

> **Navigation**: [Main](CLAUDE.md) | [Safety](CLAUDE_safety.md) | [Workflows](CLAUDE_workflows.md) | [Subagents](CLAUDE_subagents.md) | **Lessons** | [Templates](CLAUDE_templates.md)

*(This section should be continuously updated with project-specific findings)*

> **See also**: `ψ-learnings/` directory for distilled meta-summaries

---

## Key Learnings (2025-12-10)

### Hooks & Plugin Architecture
- **001-hook-duplication**: Hooks can be registered in BOTH settings.json AND plugin hooks.json - causes double execution. Always check both sources when debugging.
- **002-cleanup-discipline**: Temporary workarounds become permanent bugs. Track workarounds and clean them up after the fix is confirmed working.
- **003-counter-is-diagnostic**: "(0/2 done)" literally told us there were 2 hooks. Symptoms often contain the diagnosis - read them carefully.

### Oracle Philosophy
- **004-frequency-reveals-priority**: "สิ่งที่พูดซ้ำบ่อย = สิ่งที่สำคัญ" - What you repeat frequently reveals what matters. Analyzed 73 files to discover Nat's true priorities.
- **005-rules-are-starting-points**: Rules exist as starting points for understanding, not rigid constraints. As understanding deepens, strict adherence becomes unnecessary.

### Delegation & Token Efficiency
- **007-delegate-to-haiku**: Main agent (Opus) should NOT read files directly for exploration. Use context-finder (Haiku) to search and summarize. Cost ratio: Opus ~15x more than Haiku.
- **008-subagent-for-heavy-lifting**: Use subagents for data gathering, Opus for review and decision-making.

---

## Plugin Development (2025-12-10)
- **Pattern: Plugin hooks don't merge** - Plugin hooks.json and settings.json hooks don't merge automatically. If you need both, you'll get duplicates.
- **Pattern: Use plugin for shareable, settings.json for personal** - Plugin hooks travel with the project, settings.json stays on your machine.
- **Anti-Pattern: Workaround without tracking** - Adding hooks to settings.json as "quick fix" then forgetting about them.

---

## Context Management
- **Pattern: ψ/ unified brain structure** - `ψ/memory/retrospectives/`, `ψ/memory/learnings/`, `ψ/memory/logs/` - keeps working context separate from production code.
- **Pattern: Subfolders by date** - `ψ/memory/retrospectives/YYYY-MM/DD/HH.MM_slug.md` - easy to find, chronological order.
- **Discovery: context-finder scoring system** - Score files by recency + type + impact. 🔴 6+ Critical, 🟠 4-5 Important, 🟡 2-3 Notable, ⚪ 0-1 Background.

---

## Common Mistakes to Avoid
- **Forgetting to clean up workarounds** - Temporary fixes become permanent bugs
- **Reading files directly in Opus** - Expensive tokens, use Haiku subagents instead
- **Skipping AI Diary and Honest Feedback** - These sections provide crucial self-reflection
- **Not checking both settings.json AND plugin hooks** - Causes duplicate behavior
- **Jumping to workarounds before root cause** - When something fails, investigate WHY before suggesting alternatives. Example: `/plugin install X@marketplace` fails → first check how the plugin system discovers skills, don't immediately try manual clone or different syntax
- **Direct database queries over MCP/API** - NEVER query SQLite/databases directly. Always use MCP tools (oracle_search, oracle_list) or APIs. Reasons: proper abstraction, consistent access patterns, respects tool boundaries

---

## Data Query Patterns (2026-01-13)

| Data Source | Query Method | Example |
|-------------|--------------|---------|
| GitHub CSV | `gh api \| duckdb` | Location data, history |
| Markdown tables | `duckdb` can parse | schedule.md tables |
| Oracle knowledge | Oracle MCP tools | `oracle_search`, `oracle_list` |
| SQLite databases | **NEVER direct** | Use MCP/API only |

**Pattern**: `gh api | duckdb` for CSV, Oracle MCP for knowledge, Read tool for markdown

---

## Bash Tool Anti-Patterns (2025-12-23)

### 009-no-newlines-in-bash
**Problem**: Bash tool does NOT support newlines. Use single-line syntax only.

**Bad**: `for i in 1 2 3; do\n  echo "$i"\ndone` → parse error

**Good**: `for i in 1 2 3; do echo "$i"; done` → single line with `;`

**Alt**: Separate tool calls for each command (cleaner for complex ops)

### 010-git-C-over-cd
**Pattern**: Use `git -C /path` instead of `cd /path && git`. Respects worktree boundaries, no shell state pollution.

**Good**: `git -C /path/agents/1 rebase main && git -C /path/agents/2 rebase main`

---

## User Preferences (Observed)
- **Prefers Thai for casual/emotional, English for technical**
- **Values Oracle Philosophy** - "The Oracle Keeps the Human Human"
- **Time zone preference: GMT+7 (Bangkok/Asia)**
- **Likes /recap for fresh starts**
- **Appreciates quick, direct communication**

---

**See also**: [CLAUDE.md](CLAUDE.md) for quick reference, [CLAUDE_workflows.md](CLAUDE_workflows.md) for workflow patterns

## Install oracle-skills (Symlink Pattern)

```bash
ghq get -u Soul-Brews-Studio/oracle-proof-of-concept-skills && \
for s in $(ghq root)/github.com/Soul-Brews-Studio/oracle-proof-of-concept-skills/skills/*/; do \
  mkdir -p ~/.claude/skills && ln -sf "$s" ~/.claude/skills/; \
done
```

> Plugin discovery doesn't work yet. Use symlink to `~/.claude/skills/` instead.
