# CLAUDE.md Starter Template

Copy this template and customize for your project.

---

```markdown
# [Project Name] - AI Assistant Guide

> Quick reference for AI assistants working on this project.

## Golden Rules

1. NEVER [dangerous action for your project]
2. NEVER [another dangerous action]
3. Always [required practice]
4. Ask before [action needing approval]

## Project Overview

**Stack:**
- [Framework/Language]
- [Database]
- [Key libraries]

**Purpose:** [One sentence describing what this project does]

## Project Structure

```
[your-project]/
├── src/           # [Description]
├── tests/         # [Description]
├── docs/          # [Description]
└── [other]/       # [Description]
```

## Conventions

### Naming
- Files: [pattern] (e.g., kebab-case)
- Components: [pattern] (e.g., PascalCase)
- Functions: [pattern] (e.g., camelCase)

### Code Style
- [Style guide or linter used]
- [Key formatting rules]

## Git Workflow

1. Create branch: `[prefix]/[name]`
2. Make changes
3. Run [tests/lint command]
4. Create PR
5. Wait for review

**Branch prefixes:**
- `feature/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation

## Key Files

| File | Purpose | Notes |
|------|---------|-------|
| [file] | [purpose] | [notes] |
| [file] | [purpose] | [notes] |

## Common Commands

```bash
# Development
[command]          # [description]

# Testing
[command]          # [description]

# Build
[command]          # [description]
```

## Environment Variables

| Variable | Purpose | Required |
|----------|---------|----------|
| [VAR] | [purpose] | Yes/No |

**Note:** Never commit `.env` files!

## Quick Start

```bash
# Clone and setup
git clone [repo]
cd [project]
[install command]

# Start development
[dev command]
```

---

*Last updated: [date]*
```

---

## Customization Checklist

After copying, fill in:

- [ ] Project name
- [ ] Golden rules (3-5 specific to your project)
- [ ] Tech stack
- [ ] Folder structure
- [ ] Naming conventions
- [ ] Git workflow
- [ ] Key files table
- [ ] Common commands
- [ ] Environment variables

## Optional Additions

As your project grows, consider adding:

### Navigation (when splitting into multiple files)
```markdown
## Navigation

| File | Content |
|------|---------|
| [CLAUDE_safety.md](CLAUDE_safety.md) | Security rules |
| [CLAUDE_api.md](CLAUDE_api.md) | API documentation |
```

### ψ/ Knowledge Base
```markdown
## Knowledge Base

| Location | Content |
|----------|---------|
| ψ/memory/retrospectives/ | Session history |
| ψ/memory/learnings/ | Patterns found |
| ψ/WIP.md | Current work |
```

### Subagent Rules
```markdown
## AI Agents

| Agent | Purpose | When to Use |
|-------|---------|-------------|
| context-finder | Search codebase | Research tasks |
| coder | Write code | Implementation |
```

---

## Quick Setup Script

```bash
# Create CLAUDE.md from template
cat > CLAUDE.md << 'EOF'
# [Project Name] - AI Guide

## Golden Rules
1. Never push to main
2. Run tests before commit
3. Ask before deleting files

## Structure
- src/ - Source code
- tests/ - Test files

## Commands
- `npm run dev` - Start dev
- `npm test` - Run tests
EOF

echo "Created CLAUDE.md - now customize it!"
```
