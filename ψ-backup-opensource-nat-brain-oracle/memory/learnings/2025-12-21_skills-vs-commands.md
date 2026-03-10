# Skills vs Slash Commands in Claude Code

> Understanding when to use each mechanism for extending Claude Code behavior

## Quick Reference

| Aspect | Skills | Slash Commands |
|--------|--------|----------------|
| Invocation | `Skill` tool | `SlashCommand` tool |
| Syntax | `skill: "name"` | `/command-name` |
| Execution | In-conversation, full context | Expands to prompt |
| Discovery | `<available_skills>` in system | Available Commands list |
| Location | Multiple sources | `.claude/commands/*.md` |
| Arguments | None (skill name only) | Can include arguments |

---

## Skills

### What They Are

Skills execute within the main conversation with full context access. They're specialized capabilities that run in-place, not as expanded prompts.

### How to Invoke

```
Skill tool: { "skill": "skill-name" }
```

Important: Skills take NO arguments - only the skill name.

### Discovery Mechanism

Skills appear in the `<available_skills>` section of the system prompt:

```xml
<skill>
  <name>skill-name</name>
  <description>What it does</description>
  <location>user|managed|plugin</location>
</skill>
```

### Source Locations

| Location | Source | Example |
|----------|--------|---------|
| `user` | User's personal config | `notebooklm` |
| `managed` | Project `.claude/skills/` | `five-pillar-structure` |
| `plugin` | Installed plugins | `claude-mem:mem-search` |

### Frontmatter Format (SKILL.md)

```markdown
# Skill Name

Brief description for the Available Skills list.

## Instructions

What to do when this skill is invoked.

## Triggers

When to use this skill automatically.
```

### Examples from This Project

| Skill | Source | Purpose |
|-------|--------|---------|
| `five-pillar-structure` | managed | Navigate psi folder structure |
| `security-first` | managed | Apply git safety rules |
| `oracle-philosophy` | managed | Oracle principles |
| `jump` | managed | Topic navigation |
| `repo-health` | managed | File size checks |
| `subagent-dispatch` | managed | Agent selection |
| `claude-mem:mem-search` | plugin | Cross-session memory |
| `claude-voice-notify:thai-voice` | plugin | Thai TTS |

### When Skills Run

Skills can be:
1. **Explicitly invoked** - User/AI calls the Skill tool
2. **Triggered by description** - "Use when user asks..." patterns
3. **PROACTIVE** - Some skills should trigger automatically

---

## Slash Commands

### What They Are

Slash commands are macros that expand into full prompts. The command file contents become the user's message.

### How to Invoke

```
SlashCommand tool: { "command": "/command-name args" }
```

### Discovery Mechanism

Commands appear in "Available Commands" section:

```
- /command-name: Description (location)
```

### Source Location

All slash commands come from `.claude/commands/`:

```
.claude/
└── commands/
    ├── rrr.md          → /rrr
    ├── snapshot.md     → /snapshot
    └── feel.md         → /feel
```

### Command File Format

```markdown
# Command Title

$ARGUMENTS (optional - substituted at runtime)

Prompt content here...
```

### Examples from This Project

| Command | Purpose |
|---------|---------|
| `/rrr` | Create session retrospective |
| `/snapshot` | Quick knowledge capture |
| `/feel` | Log emotions/feelings |
| `/idea` | Log concepts |
| `/fyi` | Log information |
| `/jump` | Topic navigation |
| `/pending` | Show WIP tasks |
| `/catalog` | Index markdown files |

### How Expansion Works

```
User types: /snapshot

System sends: <command-message>snapshot is running...</command-message>
Then: Contents of commands/snapshot.md appear as user message
```

---

## Decision Matrix

### Use Skills When:

- You need full conversation context
- The action runs IN the current flow
- No arguments needed
- Behavior is triggered by patterns
- Plugin provides the capability

### Use Slash Commands When:

- You want to inject a prompt/workflow
- Arguments are needed (`$ARGUMENTS`)
- User explicitly triggers action
- Creating reusable prompt templates
- Simpler implementation (just markdown)

---

## Naming Patterns

### Skills

```
simple-name          # project skill
plugin:skill-name    # plugin skill (fully qualified)
```

### Commands

```
/simple-name                      # project command
/plugin-name:command-name         # plugin command
```

---

## Important Notes

1. **No Overlap** - Skills and commands can have the same name (e.g., `/jump` command AND `jump` skill) - they're separate systems

2. **Plugin Prefix** - Plugin skills use `:` separator: `claude-mem:mem-search`

3. **Context Difference** - Skills have full context; commands expand to prompts

4. **Built-in vs Custom** - Don't use these tools for built-in CLI commands like `/help`, `/clear`

5. **Running State** - Don't invoke a skill/command that's already running (watch for `<command-message>xxx is running...`)

---

## Creating New Skills

### 1. Create SKILL.md

```bash
mkdir -p .claude/skills/my-skill
cat > .claude/skills/my-skill/SKILL.md << 'EOF'
# My Skill

Short description for Available Skills list.

## When to Use

Use when user asks about [topic].

## Instructions

[What to do when invoked]
EOF
```

### 2. Verify Discovery

Check `<available_skills>` in next conversation.

---

## Creating New Commands

### 1. Create command file

```bash
cat > .claude/commands/my-cmd.md << 'EOF'
# My Command

Do something with $ARGUMENTS.
EOF
```

### 2. Verify Discovery

Check "Available Commands" section.

---

*Learned: 2025-12-21*
*Source: Claude Code system analysis*
*Tags: skills, commands, claude-code, extension-points*
