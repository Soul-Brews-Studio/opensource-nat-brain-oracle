# MAW External Inbox Pattern

The `ψ/inbox/external/` folder enables file-based output sharing between agents in the Multi-Agent Workspace (MAW). It provides a persistent, git-tracked communication channel for structured agent outputs.

---

## Purpose

| Use Case | Description |
|----------|-------------|
| **Agent Output Sharing** | Agents drop structured outputs for other agents to consume |
| **Cross-Worktree Communication** | Share artifacts between agent worktrees via git sync |
| **Persistent Artifacts** | Unlike real-time messaging, files persist for later reference |
| **Template Handoffs** | One agent creates structure, another fills in content |

---

## Folder Structure

```
ψ/inbox/
├── focus.md              ← Current task (owned by this agent)
├── schedule.md           ← Appointments and deadlines
├── handoff/              ← Session-to-session transfers (human-AI)
│   └── YYYY-MM-DD*.md
└── external/             ← Agent-to-agent outputs (AI-AI)
    └── YYYY-MM-DD_topic.md
```

---

## File Naming Convention

```
YYYY-MM-DD_descriptive-topic.md
```

**Examples:**
- `2025-12-20_claude-code-cnx-meetup.md` - Event template from Agent 3
- `2025-12-20_api-analysis-results.md` - Research output from Agent 5
- `2025-12-20_pocketbase-schema.md` - Schema proposal from Agent 4

**Required elements:**
- Date prefix for chronological sorting
- Underscore separator after date
- Kebab-case topic description
- `.md` extension (structured content)

---

## Integration with PocketBase

External inbox complements (not replaces) the PocketBase real-time system:

| Aspect | PocketBase Inbox | External Files |
|--------|------------------|----------------|
| **Speed** | Real-time (100ms) | Async (git sync) |
| **Size** | Short messages | Long-form documents |
| **Persistence** | Database records | Git-tracked files |
| **Use Case** | Task coordination | Artifact sharing |
| **Cleanup** | Status-based (done/failed) | Archive or delete |

**Workflow pattern:**
```
1. Agent A sends via PocketBase: "Research complete, see external/"
2. Agent B checks PocketBase inbox, sees notification
3. Agent B reads ψ/inbox/external/2025-12-20_research.md
4. Agent B processes, marks PocketBase message as done
```

---

## Workflow Examples

### Pattern 1: Template Handoff

Agent 3 creates meetup template:
```bash
# Agent 3 creates structure
maw hey main "Created meetup template in external/, please fill after event"
```

Main agent fills after event:
```markdown
# ψ/inbox/external/2025-12-20_claude-code-cnx-meetup.md

## Attendees
[To be filled by Main agent]  ← Agent 3 placeholder

## Key Discussions
- API caching patterns discussed
- Multi-agent demo interest
```

### Pattern 2: Research Output Drop

Agent 5 (research specialist) completes analysis:
```bash
# Agent 5 creates output file
Write(ψ/inbox/external/2025-12-20_competitor-analysis.md)

# Agent 5 notifies via PocketBase
maw inbox send agent5 main "Competitor analysis complete" 10
```

### Pattern 3: Cross-Agent Collaboration

Two agents contribute to same artifact:
```
Agent 2: Creates ψ/inbox/external/2025-12-20_test-results.md (modules A-C)
Agent 3: Appends to same file (modules D-F)
Main: Reviews consolidated output
```

---

## Race Condition Handling

File-based communication has inherent race risks. Mitigation strategies:

| Strategy | Implementation |
|----------|----------------|
| **Unique filenames** | Include agent ID or timestamp: `2025-12-20_1349_agent2_results.md` |
| **Append-only** | Multiple agents can append to same file safely |
| **PocketBase coordination** | Use messaging to claim files before editing |
| **Separate outputs** | Each agent writes to own file, main consolidates |

**Recommended pattern:**
```
# Instead of one shared file:
external/2025-12-20_results.md  ← Conflict risk

# Use agent-specific files:
external/2025-12-20_results_agent2.md  ← Agent 2 owns
external/2025-12-20_results_agent3.md  ← Agent 3 owns
```

---

## Cleanup Patterns

Files in external/ should be processed and cleaned:

### 1. Archive After Processing

```bash
# Move to archive after consuming
mv ψ/inbox/external/2025-12-20_meetup.md ψ/archive/inbox/2025-12/
```

### 2. Delete Ephemeral Outputs

```bash
# Remove after processing (if not needed)
rm ψ/inbox/external/2025-12-20_temp-analysis.md
```

### 3. Promote to Learnings

```bash
# If output has lasting value, move to memory
mv ψ/inbox/external/2025-12-20_api-patterns.md \
   ψ/memory/learnings/2025-12-20_api-patterns.md
```

**Rule:** Don't let external/ become a dumping ground. Process within 24-48 hours.

---

## Sync Implications

Each agent worktree has its own `ψ/inbox/external/`:

```
/Nat-s-Agents/ψ/inbox/external/           ← Main worktree
/Nat-s-Agents/agents/1/ψ/inbox/external/  ← Agent 1 worktree
/Nat-s-Agents/agents/2/ψ/inbox/external/  ← Agent 2 worktree
```

### Sync Workflow

```bash
# Agent commits its output
git -C agents/2 add ψ/inbox/external/
git -C agents/2 commit -m "docs: add research output"

# Main rebases to receive
git -C . rebase agents/2

# Smart-sync propagates to other agents
maw sync
```

### Visibility

| Location | Who Sees |
|----------|----------|
| Own worktree | Immediate (local file) |
| Other worktrees | After git sync |
| Main | After rebase onto agent branch |

---

## External vs Handoff

| Aspect | external/ | handoff/ |
|--------|-----------|----------|
| **Purpose** | Agent outputs | Session context |
| **Author** | AI agents | Human+AI sessions |
| **Consumer** | Other agents | Same agent, later session |
| **Content** | Structured data, templates | Narratives, decisions, context |
| **Naming** | `YYYY-MM-DD_topic.md` | `YYYY-MM-DD_session-name.md` |
| **Lifetime** | Short (process & clean) | Medium (reference for weeks) |

**Example distinction:**
- `handoff/2025-12-17_iteration-2-maw-deep-dive.md` - Session context for continuation
- `external/2025-12-20_claude-code-cnx-meetup.md` - Template from another agent

---

## Best Practices

1. **Always date-prefix** - Enables chronological sorting and cleanup
2. **Include source agent** - In filename or frontmatter for traceability
3. **Use templates** - Consistent structure makes processing easier
4. **Clean up promptly** - External is a queue, not storage
5. **Coordinate via PocketBase** - Notify when files are ready
6. **Unique names for concurrency** - Avoid write conflicts

---

## Related Documentation

- **PocketBase Inbox**: `2025-12-20_maw-pocketbase.md`
- **Session Handoffs**: `ψ/inbox/handoff/` directory
- **Agent Communication**: `11-agent-communication-signals.md`
- **Sync Patterns**: `2025-12-17_maw-sync-best-practices.md`

---

**Last Updated**: 2025-12-20
