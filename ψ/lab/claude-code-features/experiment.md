---
title: "Claude Code Features Experiment"
tags: [lab, experiment, claude-code, skills]
created: 2025-12-11
status: complete
parent: "[[lab|Lab]]"
---

# Claude Code Features Experiment

**Created**: 2025-12-11 10:50 GMT+7
**Completed**: 2025-12-11 11:05 GMT+7
**Status**: Complete
**Goal**: Test new Claude Code features and measure effectiveness

---

## Features Tested

| # | Feature | What it does | Result |
|---|---------|--------------|--------|
| 1 | Skills | Model-invoked modular capabilities | ✅ Pass |
| 2 | /standup command | Daily standup via context-finder | ✅ Pass |
| 3 | Explore subagent | Built-in Haiku read-only agent | ✅ Pass |
| 4 | Resume Agent | Continue agent with previous context | ✅ Pass |

---

## Experiment 1: Skills Auto-load

### Hypothesis
Skills จะโหลดได้และพร้อมใช้ทันที

### Test Case
Created 4 skills and tested loading:
1. oracle-philosophy
2. five-pillar-structure
3. security-first
4. subagent-dispatch

### Result
```
[x] Pass / [ ] Fail
Notes: All 4 skills loaded successfully via Skill tool
       Skills appear in session and provide context when invoked
```

---

## Experiment 2: /standup Command

### Hypothesis
Command จะ dispatch ไปยัง context-finder และได้ผลลัพธ์ถูกต้อง

### Test Case
Ran /standup command to get daily standup report

### Result
```
[x] Pass / [ ] Fail
Notes: Command works perfectly
       Returns: Done, In Progress, Pending Issues, Appointments, Next Action
       Uses context-finder (Haiku) - token efficient
```

---

## Experiment 3: Built-in Explore Agent

### Hypothesis
Explore agent (Haiku) จะหาไฟล์ได้เร็วและถูกต้อง

### Test Case
Asked Explore agent to find all skill files in project

### Result
```
[x] Pass / [ ] Fail
Notes: Found all 4 managed skills + 1 plugin skill
       Fast response, accurate results
       Thoroughness levels: quick, medium, very thorough
```

---

## Experiment 4: Resume Agent

### Hypothesis
Agent ที่ resume ได้จะจำ context เดิมและทำงานต่อได้โดยไม่ต้องเริ่มใหม่

### Test Case

**Step 1**: Start agent, search for retrospectives
```
agentId: 1ba1a732
Result: Found 36 retrospective files
```

**Step 2**: Resume with same agentId
```yaml
resume: "1ba1a732"
prompt: "Do you remember the files from step 1?"
```

### Result
```
[x] Pass / [ ] Fail
Notes: Agent remembered context from step 1!
       Correctly reported: 36 files total
       Correctly identified: most recent file (10.00-psi-5-pillar-restructure.md)

       This is powerful for multi-step research tasks
```

---

## Summary

| Feature | Works? | Useful for us? | Action |
|---------|--------|----------------|--------|
| Skills | ✅ Yes | ✅ Very | Already implemented 4 skills |
| /standup | ✅ Yes | ✅ Very | Use daily |
| Explore agent | ✅ Yes | ✅ Yes | Alternative to context-finder |
| Resume Agent | ✅ Yes | ✅ Yes | Use for multi-step research |

---

## Key Learnings

1. **Skills** - Different from subagents
   - Skills = reusable knowledge (model-invoked)
   - Subagents = isolated workers (explicitly spawned)

2. **Resume Agent** - Game changer for research
   - No need to re-explain context
   - Agent remembers previous search results

3. **Explore vs context-finder**
   - Explore = built-in, standard
   - context-finder = customized for our workflow

4. **Token Efficiency**
   - Skills load on-demand (progressive disclosure)
   - Haiku subagents for heavy lifting

---

## Next Steps
1. Skills implemented
2. /standup command created
3. Write blog post with findings
4. Consider permissionMode testing later

---

## See Also

- [[HOME|Home]] - Brain navigation
- [[lab/agent-sdk|Agent SDK]] - Related SDK documentation
- [[memory/retrospectives/2025-12/11/10.00-psi-5-pillar-restructure|Session: PSI Restructure]] - Related session
- [[memory/retrospectives/2025-12/11/11.19_skills-experiments-github-scan|Session: Skills Experiments]] - Follow-up session
