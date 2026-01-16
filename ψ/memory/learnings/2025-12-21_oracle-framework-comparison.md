# Oracle Framework vs Nat-s-Agents Comparison

**Date**: 2025-12-21
**Context**: Comparing public oracle-framework with local full implementation

## Repo Overview

| Repo | URL | Purpose | Visibility |
|------|-----|---------|------------|
| oracle-framework | Soul-Brews-Studio/oracle-framework | Public template | Public |
| oracle-philosophy | Soul-Brews-Studio/oracle-philosophy | Minimal philosophy | Public |
| Nat-s-Agents | laris-co/Nat-s-Agents | Full implementation | Private |
| nat-agents-core | laris-co/nat-agents-core | Core plugin | Private |
| nat-data-personal | laris-co/nat-data-personal | Personal plugin | Private |

## Architecture Comparison

### oracle-framework (Public Template)

```
oracle-framework/
├── CLAUDE.md           # ~50 lines, basic
├── .claude/
│   ├── commands/       # 3 commands (oracle, rrr, snapshot)
│   ├── agents/         # 2 agents
│   └── knowledge/      # Philosophy + style
├── ψ/                  # 5 pillars (basic)
└── templates/          # Basic templates
```

### Nat-s-Agents (Full Implementation)

```
Nat-s-Agents/
├── CLAUDE.md           # ~200 lines, comprehensive
├── CLAUDE_safety.md    # Git safety rules
├── CLAUDE_workflows.md # Short codes, context
├── CLAUDE_subagents.md # 15+ agents documented
├── CLAUDE_lessons.md   # Patterns learned
├── CLAUDE_templates.md # All templates
├── .claude/
│   ├── commands/       # Project-specific
│   ├── skills/         # 8 skills
│   └── agents/         # Many agents
├── plugins/            # Symlinks to ghq repos
├── .agents/            # MAW toolkit
└── ψ/                  # 5 pillars + incubate + learn
```

## Feature Matrix

| Feature | oracle-framework | Nat-s-Agents |
|---------|------------------|--------------|
| CLAUDE.md modular docs | 2 files | 5+ files |
| Golden Rules | 5 | 9 |
| Commands | 3 | 12+ (plugins) |
| Agents | 2 | 15+ |
| Skills | 0 | 8 |
| Multi-agent (MAW) | ❌ | ✅ Full |
| Subagent patterns | ❌ | ✅ Documented |
| Activity logging | ❌ | ✅ focus.md + logs |
| ψ/ pillars | 5 | 5 + incubate + learn |
| ghq integration | ❌ | ✅ Symlink pattern |
| Plugin system | ❌ | ✅ 2 private plugins |

## Key Differences

### 1. Documentation Depth

**oracle-framework**: Minimal, "just enough to start"
**Nat-s-Agents**: Comprehensive, "everything documented"

### 2. Multi-Agent Support

**oracle-framework**: Single agent assumed
**Nat-s-Agents**: Full MAW with 5 worktrees, sync patterns

### 3. Project Management

**oracle-framework**: No external repo handling
**Nat-s-Agents**: ghq + symlink pattern for learn/incubate

### 4. Plugin Architecture

**oracle-framework**: Commands in .claude/commands/
**Nat-s-Agents**: Separate plugin repos, symlinked

## The Pattern

```
oracle-philosophy (minimal)
      ↓ expand
oracle-framework (template)
      ↓ customize
Nat-s-Agents (full implementation)
      ↓ extract reusable
nat-agents-core + nat-data-personal (plugins)
```

## When to Use What

| Use Case | Recommended |
|----------|-------------|
| Learning Oracle philosophy | oracle-philosophy |
| Starting new project | oracle-framework |
| Full personal workflow | Fork Nat-s-Agents |
| Reusable agents/commands | nat-agents-core plugin |

## Relationship

```
Public (Soul-Brews-Studio)     Private (laris-co)
─────────────────────────      ─────────────────────
oracle-philosophy
       ↓
oracle-framework ─────────────→ Nat-s-Agents (full)
                                      ↓
                               nat-agents-core
                               nat-data-personal
```

## Quote

> "oracle-framework is the seed, Nat-s-Agents is the tree"

---

*Reference for maintaining sync between public templates and private implementation*
