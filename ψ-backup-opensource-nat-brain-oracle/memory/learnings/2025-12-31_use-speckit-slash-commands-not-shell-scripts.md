---
title: **Use Speckit Slash Commands, Not Shell Scripts**
tags: [speckit, workflow, commands, best-practice]
created: 2025-12-31
source: Oracle Learn
---

# **Use Speckit Slash Commands, Not Shell Scripts**

**Use Speckit Slash Commands, Not Shell Scripts**

When practicing speckit workflow, use the slash commands:
- `/speckit.specify` - Creates branch + spec (not `.specify/scripts/bash/create-new-feature.sh`)
- `/speckit.plan` - Creates plan artifacts (not `setup-plan.sh`)
- `/speckit.tasks` - Creates tasks.md (not `check-prerequisites.sh`)

The slash commands:
1. Handle all the scripting internally
2. Provide validation and quality checks
3. Are the intended interface for the workflow
4. Show the proper user experience

Shell scripts are internal implementation - commands are the API.

---
*Added via Oracle Learn*
