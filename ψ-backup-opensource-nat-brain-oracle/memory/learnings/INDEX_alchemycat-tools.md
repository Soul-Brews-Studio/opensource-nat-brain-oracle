# AlchemyCat Analysis Tools - Complete Index

## Summary

Three production-ready analysis tools for tracking AI-human collaboration patterns in git repositories.

**Created**: 2026-01-09  
**Location**: `/Users/nat/Code/github.com/alchemycat/AI-HUMAN-COLLAB-CAT-LAB/tools/`  
**Size**: 791 LOC total (245 + 289 + 257)  
**Dependencies**: Node.js stdlib only

---

## Documents in This Knowledge Base

### 1. Main Inventory (Complete Reference)
**File**: `2026-01-09_alchemycat-analysis-tools.md`  
**Length**: 431 lines  
**Best for**: Understanding what each tool does + how it works

Contents:
- Tool-by-tool breakdown (what, how, data output)
- Data structures (Day, Commit, Stats objects)
- Cross-tool reusable patterns
- Integration points
- Usage examples

### 2. Reusable Code Patterns (Copy-Paste Ready)
**File**: `2026-01-09_alchemycat-reusable-patterns.md`  
**Best for**: Implementing your own analyzers

Contents:
- 8 production-ready JavaScript functions
- Copy-paste snippets with inline docs
- Complete class example
- Integration guide

---

## The 3 Tools at a Glance

| Tool | Purpose | Input | Output | Key Metric |
|------|---------|-------|--------|-----------|
| **Working Hours Analyzer** | Git commits + AI sessions → human/AI patterns | `.git/` + diary file | JSON + console report | hours/day, time preferences |
| **Git Timeline Generator** | Commits → blog posts (Thai, Docusaurus) | `.git/` | Markdown blog posts | commit types, daily timeline |
| **External Repo Analyzer** | Multi-repo comparison | GitHub URLs | JSON + console report | cross-project patterns, AI % |

---

## Key Takeaways

### What Gets Extracted
- Total commits | Human vs AI splits (%)
- Working days | Commits per day
- Hour distribution (0-23) | Time period binning (night/morning/afternoon/evening)
- Weekday patterns | Weekend work detection
- Author count | Commit types (feat/fix/refactor/docs)

### How It Works (Universal Pattern)
```
1. Clone or access .git/
2. Execute: git log --pretty=format:"%h|%ad|%s|%an"
3. Parse pipe-delimited output
4. Filter AI commits (contains "🤖", "Claude", "noreply@anthropic")
5. Group by date/hour/weekday
6. Calculate statistics
7. Output: console + JSON
```

### Data Structures (Reuse These)
```javascript
// Day object
{ hours: Set, commits: number, authors: Set, weekday: string }

// Commit object
{ hash, date, message, author, email? }

// Stats object
{ totalCommits, humanCommits, aiCommits, uniqueAuthors, 
  workingDays, mostActiveHour, mostActiveWeekday }
```

---

## Use Cases

### 1. Track Team Working Patterns
Use Tool #1 (Working Hours Analyzer) to understand:
- When humans typically work
- How long AI sessions typically run
- Busiest times of day
- Weekend work frequency

### 2. Generate Development Documentation
Use Tool #2 (Git Timeline Generator) to:
- Create blog posts from commits
- Show daily progress
- Categorize changes by type
- Support multiple languages (Thai built-in)

### 3. Compare Cross-Project Patterns
Use Tool #3 (External Repo Analyzer) to:
- Compare work patterns across projects
- Identify human vs AI contribution ratios
- Find consistent patterns
- Detect outliers

### 4. Build Your Own Tool
Use code patterns from this inventory to:
- Extend with custom metrics
- Integrate with other systems
- Build dashboards
- Create Oracle knowledge entries

---

## Integration With Your Stack

### Recommended Pipeline
```
Commits (git log)
    ↓
Working Hours Analyzer
    ↓ (humanHours JSON)
Git Timeline Generator
    ↓ (blog posts + stats)
Oracle Knowledge Base
    ↓ (patterns + learnings)
Dashboards / Reports
```

### Data Portability
- All tools output JSON (no proprietary formats)
- ISO timestamps for standardization
- Set objects serializable (convert when needed)
- File paths configurable

---

## Quick Start (Implement Yourself)

### Option A: Copy Working Hours Analyzer Approach
```javascript
1. getCommits()          // Pattern 1 from guide
2. separateCommits()     // Pattern 2
3. analyzeWorkingHours() // Pattern 3
4. generateStats()       // Pattern 6
5. generateReport()      // Pattern 8
```

### Option B: Copy Git Timeline Approach
```javascript
1. getCommits()          // Pattern 1
2. groupByDate()         // Pattern 4
3. getCommitType()       // Pattern 5
4. formatThaiDate()      // (in tool, customize as needed)
5. generateBlogPost()    // Write to file
```

### Option C: Copy External Repo Approach
```javascript
1. Clone repo (temp dir)
2. getCommits()          // Pattern 1
3. separateCommits()     // Pattern 2
4. analyzeWorkingHours() // Pattern 3
5. generateStats()       // Pattern 6
6. Cleanup temp dir
7. generateReport()      // Pattern 8
```

---

## Implementation Checklist

- [ ] Read main inventory (2026-01-09_alchemycat-analysis-tools.md)
- [ ] Identify which tool pattern suits your need
- [ ] Copy relevant code patterns from patterns document
- [ ] Adapt paths/repos to your projects
- [ ] Test with sample git repo
- [ ] Integrate JSON output into your pipeline
- [ ] Document any custom metrics you add
- [ ] Save learnings to your knowledge base

---

## Notes & Gotchas

1. **AI Detection**: Uses string matching ("🤖", "Claude", "noreply@anthropic") - may miss some cases
2. **Timezone**: Tool #1 hardcodes UTC+7 (Bangkok) - make parameterizable
3. **Date Formats**: Mix of ISO strings and Date objects - standardize if extending
4. **Temp Files**: Tool #3 cleans up properly; Tool #1 reads external file (could improve)
5. **No Dependencies**: All tools use Node.js stdlib only - great for portability
6. **Console Output**: Uses emoji headers - may need adjustment for non-emoji terminals

---

## Author Notes

These tools are production-ready and used in the AlchemyCat AI-Human Collaboration Lab. They demonstrate solid patterns for:
- Git data extraction
- Statistical analysis
- Multi-format output (console + JSON)
- Error handling
- Temporal analysis
- Language support (Thai)

Patterns here are battle-tested and can be safely copied into your projects.

---

## Files in This Learning

1. `2026-01-09_alchemycat-analysis-tools.md` (Main reference - 431 lines)
2. `2026-01-09_alchemycat-reusable-patterns.md` (Copy-paste code - 300+ lines)
3. `INDEX_alchemycat-tools.md` (This file - navigation guide)

Total: 760+ lines of documented knowledge ready to use

---

**Created**: 2026-01-09  
**Status**: Complete & tested  
**Reusability**: High - all patterns modular and independently useful
