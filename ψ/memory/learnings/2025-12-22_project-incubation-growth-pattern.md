# Lesson: Project Incubation = Growth Potential, Not Just Existence

**Date**: 2025-12-22
**Context**: Arthur demo → incubation decision
**Tags**: #project-management #incubation #growth

---

## The Pattern

Projects don't start as repos. They start as:
- A demo
- A conversation
- Context that accumulates
- An idea that keeps coming back

**The question isn't "does this exist elsewhere?"**
**The question is "will this grow beyond its current home?"**

---

## Arthur Example

| Stage | What it was | Where it lived |
|-------|-------------|----------------|
| 1. Idea | "Demo Arthur for DustBoy Day" | Conversation |
| 2. Demo | 5 audio scenes, 1 script | `ψ/active/arthur-demo/` |
| 3. Context grows | Image prompts, philosophy, capabilities | Same folder |
| 4. Recognition | "This will keep growing" | Decision point |
| 5. Incubation | Own repo with room to evolve | `laris-co/arthur` |

---

## The Decision Criteria

**Create separate repo when**:
- [ ] Has identity beyond the demo
- [ ] Will accumulate more context over time
- [ ] Might have its own issues/PRs
- [ ] Could be shared/referenced independently
- [ ] "We keep coming back to this"

**Keep in Nat-s-Agents when**:
- [ ] One-time demo, no evolution expected
- [ ] Tightly coupled to main project
- [ ] Just a folder/config, not a "project"

---

## Command Revision Needed

Current `/project incubate` asks:
> "Does this exist? If not, create repo?"

Should ask:
> "Will this grow? Does it deserve its own home?"

### New Flow

```
/project incubate [name]

1. Search existing locations
2. If found locally (ψ/active/, ψ/incubate/):
   → "Found [name] in [location]"
   → "This project has [N files, created X days ago]"
   → "Will it grow beyond Nat-s-Agents? [Y/n]"

3. If user says Y:
   → Create repo
   → Migrate files
   → Symlink back

4. If user says N:
   → Keep in current location
   → Maybe just register slug
```

---

## Key Insight

**"Incubation" is about growth potential, not current size.**

A 2-file demo that will evolve = create repo.
A 50-file tool that's done = keep in place.

---

## Related

- `/project` command: `.claude/commands/project.md`
- Arthur demo: `ψ/incubate/repo/arthur/`
- Oracle philosophy: projects are living, append-only

---

*Lesson extracted from Arthur incubation conversation, 2025-12-22*
