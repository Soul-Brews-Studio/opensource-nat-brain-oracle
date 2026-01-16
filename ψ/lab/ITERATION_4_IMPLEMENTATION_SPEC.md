# /recap - Iteration 4 Implementation Spec

**Status**: READY FOR IMPLEMENTATION
**Complexity**: MINIMAL
**Code Estimate**: 60-80 lines (Opus synthesizer)

---

## Phase 1: Haiku Data Collection (UNCHANGED)

### Command Flow

```bash
date "+🕐 %H:%M (%A %d %B %Y)"

# WIP check
cat ψ/WIP.md 2>/dev/null || echo "NO_WIP"

# Files modified in 24h
git log --since="24 hours ago" --format="%h|%ar|%s" --name-only

# Current working state
git status --short

# Recent commits (for reference)
git log --format="%h|%ar|%s" -10

# Latest retro file
ls -t ψ/memory/retrospectives/*.md 2>/dev/null | head -1
```

### Output Format (Marked Sections)

```
=== TIMESTAMP ===
🕐 14:25 (Thursday 27 December 2025)

=== WIP ===
[content of ψ/WIP.md OR "NO_WIP"]

=== FILES_MODIFIED_24H ===
[git log output]

=== WORKING_STATE ===
[git status output]

=== RECENT_COMMITS ===
[git log -10 output]

=== LATEST_RETRO_PATH ===
[path to latest retrospective]
```

**Tokens**: 3-4k
**Time**: 10-15 seconds

---

## Phase 2: Opus Synthesis (SIMPLIFIED)

### Input: Parse Haiku Sections

```python
# Extract sections from Haiku output
timestamp = parse_section("TIMESTAMP")
wip_content = parse_section("WIP")
files_raw = parse_section("FILES_MODIFIED_24H")
working_state = parse_section("WORKING_STATE")
recent_commits = parse_section("RECENT_COMMITS")
latest_retro_path = parse_section("LATEST_RETRO_PATH")
```

### Step 1: Parse File List from Git Log

```python
def parse_git_log(log_output):
    """Extract files + age from git log output"""
    files = {}
    
    for line in log_output.split("\n"):
        if "|" in line:
            # Format: hash|age|message
            parts = line.split("|")
            if len(parts) == 3:
                age_str = parts[1].strip()  # e.g., "5 minutes ago"
                message = parts[2].strip()
        else:
            # This is a filename line following a commit
            if line.strip() and not "|" in line:
                filename = line.strip()
                
                # Skip files we don't care about
                if not should_track(filename):
                    continue
                
                files[filename] = {
                    'age_str': age_str,
                    'age_minutes': parse_time_ago(age_str),
                    'message': message
                }
    
    return files
```

### Step 2: Score Each File (2-POINT SYSTEM)

```python
def score_file(filepath, age_minutes):
    """
    Score: 0, 2, or 4
    - Recency: < 4 hours? +2
    - Type: code/agent? +2
    """
    score = 0
    
    # Recency: < 4 hours?
    if age_minutes < 240:  # 4 hours = 240 minutes
        score += 2
    
    # Type: Is this code or agent?
    if is_code_file(filepath):
        score += 2
    elif is_agent_file(filepath):
        score += 2
    
    return score

def is_code_file(path):
    """Code files we track"""
    code_exts = {'.ts', '.js', '.go', '.py', '.tsx', '.jsx', '.json', '.yml', '.yaml'}
    return any(path.endswith(ext) for ext in code_exts)

def is_agent_file(path):
    """Agent/command files"""
    return '.claude/' in path or 'ψ/' not in path
```

### Step 3: Classify by Color

```python
def classify_color(score):
    """Map score to color indicator"""
    if score >= 4:
        return "🔴"  # Critical
    elif score >= 2:
        return "🟡"  # Notable
    else:
        return "⚪"  # Background
```

### Step 4: Extract Retro Context

```python
def extract_retro_context(latest_retro_path):
    """Read first 50 lines of latest retro as context"""
    if not latest_retro_path:
        return None
    
    with open(latest_retro_path, 'r') as f:
        lines = f.readlines()[:50]
    
    # Look for AI Diary or key quotes
    retro_text = ''.join(lines)
    
    # Extract first substantive paragraph
    paragraphs = retro_text.split('\n\n')
    for para in paragraphs:
        if para.strip() and not para.startswith('#'):
            return para.strip()[:300]  # First 300 chars
    
    return None
```

### Step 5: Build Output (COMPACT TABLE)

```python
def build_output(files, wip_content, retro_context, working_state):
    """Build final markdown output"""
    
    output = []
    
    # Check for WIP
    if wip_content and wip_content != "NO_WIP":
        output.append("## RESUME: WIP Active\n")
        output.append(f"```\n{wip_content}\n```\n")
    
    # Tier 1: Files changed
    output.append("## TIER 1: What's Hot (24 hours)\n")
    
    if files:
        output.append("| When | File | Score |\n")
        output.append("|------|------|-------|\n")
        
        # Sort by score descending, then by age
        sorted_files = sorted(
            files.items(),
            key=lambda x: (-x[1]['score'], x[1]['age_minutes'])
        )
        
        for filepath, info in sorted_files[:10]:  # Top 10 files
            color = classify_color(info['score'])
            when = info['age_str']
            output.append(f"| {when} | {filepath} | {color} |\n")
    else:
        output.append("No changes in 24 hours.\n")
    
    # Working state
    if working_state.strip():
        output.append(f"\n**Status**: {working_state.strip()}\n")
    
    # Tier 2: Context
    output.append("\n---\n\n## TIER 2: Latest Context\n")
    
    if retro_context:
        output.append(f"> {retro_context}\n")
    else:
        output.append("No recent retrospectives.\n")
    
    return '\n'.join(output)
```

---

## Phase 3: Output Format

### Template

```markdown
## TIER 1: What's Hot (24 hours)

| When | File | Score |
|------|------|-------|
| 5m | .claude/commands/recap.md | 🔴 |
| 1h | CLAUDE_workflows.md | 🟡 |
| 3h | README.md | ⚪ |

**Status**: 2 modified, working clean

---

## TIER 2: Latest Context

> "Simplifying /recap reveals what matters most. System shows facts, user makes decisions."
>
> "Next: validate with real usage before full rollout."
```

### Rules

- Only show files modified in last 24h
- Sort by score (critical first)
- Cap at 10 files per tier
- Include WIP if exists (as inline alert)
- Show one quote from latest retro
- Simple table, no narrative

---

## Implementation Checklist

```
[ ] Create 2-point scoring function
[ ] Create color classification function
[ ] Create git log parser
[ ] Create retro context extractor
[ ] Create markdown builder
[ ] Integration test with real data
[ ] Test timing (target: < 20 seconds)
[ ] Update .claude/commands/recap.md
[ ] Update CLAUDE_workflows.md
[ ] Archive old design docs
```

---

## Files to Update

1. **New Agent**: Create or update `.claude/agents/agent-9.md` (Recap Synthesizer)
2. **Command**: Update `.claude/commands/recap.md`
3. **Workflows**: Update `CLAUDE_workflows.md` to match new design
4. **Safety**: No changes needed (no new git operations)

---

## Code Structure (Pseudocode)

```python
def recap_command():
    """Main /recap flow"""
    
    # Phase 1: Haiku gathers raw data
    haiku_output = spawn_haiku_agent()
    
    # Phase 2: Opus synthesizes
    sections = parse_haiku_output(haiku_output)
    
    files = parse_git_log(sections['FILES_MODIFIED_24H'])
    
    # Score each file
    for filepath in files:
        files[filepath]['score'] = score_file(
            filepath,
            files[filepath]['age_minutes']
        )
    
    # Extract retro context
    retro_context = extract_retro_context(
        sections['LATEST_RETRO_PATH']
    )
    
    # Build output
    output = build_output(
        files,
        sections['WIP'],
        retro_context,
        sections['WORKING_STATE']
    )
    
    return output
```

---

## Success Metrics

| Metric | Target | Notes |
|--------|--------|-------|
| Total Time | < 20 seconds | Haiku 10-15s + Opus 2-3s |
| Read Time | < 5 seconds | User scans table |
| Code Lines | < 100 | All synthesis logic |
| Accuracy | 100% | No false positives |
| Coverage | All files | Git log captures all |

---

## Edge Cases Handled

1. **No changes in 24h**: Show "No changes" message
2. **No WIP**: Skip WIP section
3. **No retro**: Show "No context available"
4. **Dirty working tree**: Show actual status
5. **Large file lists**: Cap at 10 most important
6. **Untracked files**: Mention count, don't list

---

## Testing Plan

### Test 1: Normal Session
```
Given: Files changed 5m, 1h, 3h ago
Expected: All three shown, sorted by score, correct colors
```

### Test 2: With WIP
```
Given: ψ/WIP.md contains active task
Expected: WIP shown at top as resume point
```

### Test 3: Clean State
```
Given: No files changed, no WIP
Expected: Clean working tree message + latest context
```

### Test 4: Timing
```
Given: 30-file history
Expected: Completes in < 20 seconds
```

---

## Notes for Implementer

1. Reuse Haiku agent from Iteration 3 (unchanged)
2. Focus Opus logic on scoring + building table
3. No narrative synthesis = easier to test
4. Color mapping is visual, not semantic
5. Retro extract can be raw text (no parsing)

---

## Timeline

- Design review: 30 min
- Implementation: 1-2 hours
- Testing: 30 min
- Documentation: 30 min
- **Total**: 2-3 hours from go-ahead

