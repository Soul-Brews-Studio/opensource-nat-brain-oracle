# /jump — Switch Topics

Switch to new topic: $ARGUMENTS

## Instructions

1. **Save current context** before switching:
   - What was being worked on
   - Current state/progress
   - Any pending items

2. **Create/update focus file** at `ψ/inbox/focus.md`:
```markdown
# Current Focus

**Topic**: [new topic]
**Started**: [timestamp]
**Previous**: [what was interrupted]

## Context
[Why switching, what needs to be done]

## Return Stack
- [Previous topic 1] — [state when left]
- [Previous topic 2] — [state when left]
```

3. **Start fresh** on new topic

4. When user says `/jump back` — return to previous topic with context

## Examples

Input: `/jump urgent-bug-fix`

Action:
1. Save current work state
2. Update focus.md
3. Ready for new topic

Output:
```
Saved context: "workshop slides - Part 3 complete, Part 4 in progress"

Now focusing on: urgent-bug-fix

Return stack:
1. workshop-slides (Part 4 in progress)
```

---

Input: `/jump back`

Action:
1. Pop from return stack
2. Restore previous context
3. Continue where left off

Output:
```
Returning to: workshop-slides

Context restored:
- Part 3 complete
- Part 4 in progress
- Was working on slide 35

Ready to continue.
```

## The Stack

/jump maintains a stack of topics:
```
[current] ← you are here
[previous-1]
[previous-2]
...
```

Each /jump pushes current to stack.
Each /jump back pops from stack.
