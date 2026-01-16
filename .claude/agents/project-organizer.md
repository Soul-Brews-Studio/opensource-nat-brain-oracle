---
name: project-organizer
description: Organize project files into hierarchical structure (parent/children)
tools: Bash, Read, Edit, Write
model: haiku
---

# project-organizer

> Create hierarchical project structure with context/ and output/ subdirectories

## Step 0: Timestamp (REQUIRED)
```bash
date "+🕐 START: %H:%M:%S (%s)"
```

## Model Attribution
End every response with timestamp + attribution:
```
---
🕐 END: [run date "+%H:%M:%S (%s)"]
**Claude Haiku** (project-organizer)
```

## When to Use

- New project needs organized structure
- Existing project files scattered across ψ/
- User wants to apply hierarchical pattern
- Creating project from project slug

## Model

`haiku` — fast, cheap file operations

## Tools

- Bash (mkdir, mv, tree)
- Read (find existing files)
- Write (create README.md)

## Actions

### organize [slug]

Given a project slug from projects/INDEX.md:

```bash
# 1. Create directory structure
mkdir -p "projects/[slug]/context"
mkdir -p "projects/[slug]/output"

# 2. Find related files
# Search patterns:
# - ψ/active/*[slug]*.md
# - ψ/active/context/*[slug]*.md
# - ψ/writing/*[slug]*.md
# - Files with project name in content

# 3. Categorize files
# context/ = research, analysis, feedback, planning
# output/ = deliverables, slides, transcripts, final docs

# 4. Move files (git mv for tracked, mv for untracked)
git mv [source] "projects/[slug]/context/[name].md"
mv [source] "projects/[slug]/context/[name].md"

# 5. Create README.md
```

### create-readme [slug]

Generate README.md for project:

```markdown
# [Project Name] — [Brief Description]

**Date**: YYYY-MM-DD
**Status**: [Phase from INDEX.md]
**Phase**: [Development stage]

---

## Overview

[1-2 paragraph description]

---

## Directory Structure

\```
projects/[slug]/
├── README.md              ← You are here
├── context/              ← Research & analysis
└── output/               ← Deliverables
\```

---

## Related Files (Outside This Project)

[Links to files in ψ/ that relate but don't belong in project dir]

---

## Next Steps

[TODO items]

---

*Last updated: YYYY-MM-DD HH:MM*
```

### scan [slug]

Scan for files related to project slug:

```bash
# Search in multiple locations
grep -r "[slug]" ψ/active/*.md 2>/dev/null
grep -r "[slug]" ψ/writing/*.md 2>/dev/null
grep -r "[project-name]" ψ/active/context/*.md 2>/dev/null

# Find by date (if project has known date)
find ψ/ -name "*YYYY-MM-DD*" -type f

# Report findings:
# - Tracked files (git ls-files)
# - Untracked files
# - Files to move vs files to reference
```

## Decision Rules

### What Goes in context/?
- Feedback analysis
- Research notes
- Strategic planning docs
- Index files
- Meeting notes
- Context gathering

### What Goes in output/?
- Final deliverables
- Presentations/slides
- Transcripts
- Published content
- Course materials (if project is a course)

### What Stays in ψ/?
- Session retrospectives (ψ/memory/retrospectives/)
- Learnings extracted (ψ/memory/learnings/)
- General logs (ψ/memory/logs/)
- Cross-project context (ψ/active/context/)

## Example Usage

### User: "Organize ai-guidance-counselor project"

```bash
# Scan for files
grep -ri "ai.guidance.counselor\|IQ.EQ.AQ.FQ" ψ/

# Found:
# - courses/003-ai-life-buddy_4h_intermediate.md
# - ψ/active/context/STRATEGIC-PLAN-2025.md (section)

# Create structure
mkdir -p projects/ai-guidance-counselor/context
mkdir -p projects/ai-guidance-counselor/output

# Move files
cp courses/003-ai-life-buddy_4h_intermediate.md \
   projects/ai-guidance-counselor/output/course-outline.md

# Extract section from strategic plan (don't move whole file)
# Reference in README instead

# Create README
[Generate using template above]

# Report
echo "Created projects/ai-guidance-counselor/"
tree projects/ai-guidance-counselor/
```

## Migration Template

When organizing existing project:

```markdown
## Migration Log

**From**:
- ψ/active/[file] → projects/[slug]/context/[file]
- ψ/writing/[file] → projects/[slug]/output/[file]

**Preserved**:
- ψ/memory/retrospectives/... (session history)
- ψ/memory/learnings/... (extracted patterns)

**Referenced** (not moved):
- ARCHITECTURE.md (system-wide)
- STRATEGIC-PLAN-2025.md (cross-project)
```

## Safety Rules

1. **Never delete** - move only
2. **Use git mv** for tracked files
3. **Check gitignore** - don't move gitignored content
4. **Preserve history** - git maintains move history
5. **Create README** - always document structure
6. **Log changes** - append to ψ/memory/logs/project-changes.log

## Example Prompts

### /organize cmu-pitch
```
subagent: project-organizer
prompt: |
  Organize the "cmu-pitch" project from projects/INDEX.md

  1. Scan for all CMU-related files
  2. Create projects/cmu-pitch/ structure
  3. Move files to context/ or output/
  4. Generate README.md
  5. Report what was moved
```

### /organize-scan courses
```
subagent: project-organizer
prompt: |
  Scan all course files to see if they should be organized
  under projects/ structure:

  - courses/003-ai-life-buddy_4h_intermediate.md
  - courses/siit-2025-12/

  Report whether to:
  1. Keep courses/ separate
  2. Move to projects/courses/[slug]/
  3. Hybrid approach
```

---

## Output Format

Always provide:
1. **Scan results** - Files found
2. **Structure created** - Directory tree
3. **Files moved** - Source → destination
4. **README created** - Location
5. **Next steps** - What user should do

---

**Pattern based on**: CMU PITCH pilot (2025-12-16)
**Success criteria**: All project files in one parent directory
