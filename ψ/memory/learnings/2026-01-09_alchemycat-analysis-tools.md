# AlchemyCat AI-Human Collab Tools Inventory

## Overview
Three Node.js analysis tools designed to track and analyze AI-human collaboration patterns in development projects.

**Location**: `/Users/nat/Code/github.com/alchemycat/AI-HUMAN-COLLAB-CAT-LAB/tools/`

---

## Tool 1: Working Hours Analyzer

**File**: `working-hours-analyzer.js` (245 lines, executable)

### Purpose
Analyzes git commit history and AI session documentation to extract human and AI working patterns.

### How It Works

#### Data Sources
1. **Git Commits**
   - Parses all commits with: timestamp, author, message
   - Filters out AI commits (contains "🤖" or author contains "Claude")
   - Extracts human commit activity by hour, day, author

2. **AI Sessions**
   - Reads from documentation file: `../001-uniserv-nft-carbon-credit/diary/SESSION_BY_SESSION_REALITY.md`
   - Pattern matching: `### Session N`, Date, Time range
   - Calculates session duration (e.g., "3:00 PM - 8:30 PM" → "5h 30m")

#### Analysis Categories

| Category | Extracted Data |
|----------|---|
| **Human Working Patterns** | Hours worked per day, commits count, weekday analysis |
| **Time of Day** | Night (0-6), Morning (6-12), Afternoon (12-18), Evening (18-24) |
| **Weekend Work** | Detected via `new Date().toLocaleDateString()` |
| **AI Sessions** | Session #, date, start/end time, duration |
| **Statistics** | Total hours, avg per day, most productive time |

### Data Output

#### Console Output
- Human working days table
- Human work statistics (total days, hours, weekend work)
- Time preference breakdown
- AI session patterns (if found)
- Collaboration insights

#### JSON File: `data/working-hours-analysis.json`
```json
{
  "generatedAt": "ISO timestamp",
  "humanWorkingDays": {
    "2025-01-09": {
      "hours": [14, 15, 16, ...],
      "commits": 5,
      "firstCommit": "Date object",
      "lastCommit": "Date object",
      "day": "Thursday"
    }
  },
  "aiSessions": [
    {
      "session": 1,
      "date": "2025-01-09",
      "startTime": "3:00 PM",
      "endTime": "8:30 PM",
      "duration": "5h 30m"
    }
  ],
  "summary": {
    "totalHumanDays": 12,
    "totalAISessions": 8,
    "analyzedRepository": "AI-HUMAN-COLLAB-CAT-LAB"
  }
}
```

### Reusable Components
- `WorkingHoursAnalyzer` class: Main analysis engine
- `getCommitHistory()`: Git log parsing with filters
- `calculateDuration()`: Time parsing (AM/PM format)
- `generateReport()`: Pretty console output formatting

---

## Tool 2: Git Timeline Generator

**File**: `git-timeline-generator.js` (289 lines, non-executable)

### Purpose
Generates Docusaurus blog posts from git commit history with Thai language support and timeline visualization.

### How It Works

#### Data Collection
1. **Git Commits**
   - Command: `git log --oneline --pretty=format:"%h|%ad|%s|%an"`
   - Configurable date range (default: since 2025-06-01)
   - Returns: hash, date, message, author

2. **Commit Categorization**
   - Regex matching on commit message type
   - Maps to Thai labels (🚀 feat, 🔧 fix, ♻️ refactor, 📚 docs, etc.)
   - Groups commits by category and date

#### Processing Pipeline

```
git commits → group by date → categorize by type → generate blog post
                ↓
        Thai date formatting (Gregorian → Buddhist Era)
```

#### Blog Post Structure
```markdown
---
slug: development-timeline-YYYY-MM-DD
title: "พัฒนาการ [Thai Date] - N การเปลี่ยนแปลง"
---

## 📋 Summary by Category
- 🚀 Features: N items
- 🔧 Fixes: N items
- ♻️ Refactoring: N items

## ⏰ Detailed Timeline
[Commit by commit with hash, message, author]

## 🤔 Reflection & Insights
[Analysis of development patterns]
```

### Data Output

#### Blog Posts
**Location**: `./docusaurus-site/i18n/th/docusaurus-plugin-content-blog/YYYY-MM-DD-development-timeline.md`

**Content**: One post per day with commits, categories, and reflection

#### Console Statistics
```
📈 Development Statistics:
   Total Commits: N
   Active Days: N
   Average Commits/Day: X.X

📊 Commit Types:
   feat: N commits
   fix: N commits
   refactor: N commits

👥 Contributors:
   Author Name: N commits
```

### Reusable Components
- `GitTimelineGenerator` class: Main pipeline
- `getCommitHistory()`: Git parsing with date range
- `categorizeCommit()`: Commit type detection
- `groupCommitsByDate()`: Temporal grouping
- `formatThaiDate()`: Gregorian → Buddhist Era conversion
- `generateBlogPost()`: Markdown template generation
- `generateSummaryStats()`: Statistics calculation

---

## Tool 3: External Repo Analyzer

**File**: `analyze-external-repos.js` (257 lines, executable)

### Purpose
Analyzes multiple external repositories from GitHub to extract working patterns across projects.

### How It Works

#### Multi-Repo Architecture
Hardcoded repos (configurable):
- `uniserv-nft-erc721`
- `liff-carbon-offset-app`

#### Process per Repository
1. **Clone**: Temporary directory (`/tmp/repo-analysis-*`)
2. **Git Parse**: Extract all commits with timestamp, author, email, message
3. **Filter**: Separate AI commits (contains "🤖", email contains "noreply@anthropic")
4. **Analyze**: 
   - Hour distribution (0-23)
   - Weekday distribution
   - Author tracking
   - Date range calculation
5. **Cleanup**: Remove temp directory

#### Analysis Metrics per Repo

| Metric | Extraction Method |
|--------|---|
| Human vs AI commits | Commit message/email pattern |
| Unique authors | Set collection of commit authors |
| Working hours | Hours from commit timestamps |
| Working days | Unique dates of commits |
| Hour patterns | Distribution across 24 hours |
| Weekday patterns | `toLocaleDateString('en-US', { weekday: 'long' })` |
| Weekend work | Count days where weekday is Saturday/Sunday |
| Date range | Min/max commit dates |

### Data Output

#### Console Report

**Per-Repository Section:**
```
🔍 REPOSITORY_NAME
   Total Commits: N
   Human Commits: N (X%)
   AI Commits: N (X%)
   Unique Authors: N
   
   📅 Development Timeline:
      First Commit: YYYY-MM-DD
      Last Commit: YYYY-MM-DD
      Duration: N days
      Active Working Days: N
   
   ⏰ Working Hours:
      Total Estimated Hours: ~N
      Average Hours per Day: X.X
      Most Active Hour: HH:00
      Most Active Weekday: Day
   
   📊 Hour Distribution:
      Morning (6-12): N commits
      Afternoon (12-18): N commits
      Evening (18-24): N commits
      Night (0-6): N commits
```

**Comparison Section:**
```
🤝 COLLABORATION INSIGHTS
   • Project durations and commit counts
   • Combined unique authors
   • AI involvement percentage
   • Key observations about patterns
```

#### JSON File: `data/external-repos-analysis.json`
```json
{
  "generatedAt": "ISO timestamp",
  "repositories": [
    {
      "name": "repo-name",
      "url": "github.com/...",
      "stats": {
        "totalCommits": N,
        "humanCommits": N,
        "aiCommits": N,
        "uniqueAuthors": N,
        "authors": ["name1", "name2"],
        "workingDays": N,
        "totalEstimatedHours": N,
        "weekendDays": N,
        "averageHoursPerDay": "X.X",
        "mostActiveHour": "HH:00",
        "mostActiveWeekday": "Day",
        "dateRange": {
          "first": "YYYY-MM-DD",
          "last": "YYYY-MM-DD",
          "durationDays": N
        },
        "hourDistribution": {0: 1, 1: 2, ...},
        "weekdayDistribution": {"Monday": 5, ...}
      },
      "dailyBreakdown": {
        "2025-01-09": {
          "hours": Set[],
          "commits": N,
          "authors": Set[],
          "weekday": "Thursday"
        }
      }
    }
  ]
}
```

### Reusable Components
- `ExternalRepoAnalyzer` class: Multi-repo orchestration
- `analyzeRepository()`: Single repo analysis pipeline
- `generateCombinedReport()`: Multi-repo comparison
- Temp directory management with cleanup
- Git cloning and parsing utilities

---

## Cross-Tool Reusable Patterns

### Common Extraction Patterns

| Pattern | Used By | Code |
|---------|---------|------|
| **Commit Parsing** | All three | `git log --pretty=format` with pipe-delimited fields |
| **Author Filtering** | #1, #3 | Check for "🤖", "Claude", "noreply@anthropic" |
| **Hour Extraction** | #1, #3 | `date.getHours()` from ISO timestamp |
| **Date Grouping** | #2, #3 | Object keyed by YYYY-MM-DD |
| **Weekday Detection** | #3 | `toLocaleDateString('en-US', { weekday: 'long' })` |
| **Time Period Binning** | #1, #3 | Morning (6-12), Afternoon (12-18), Evening (18-24), Night (0-6) |
| **Report Generation** | #1, #2 | Console.log with emoji headers and formatted tables |

### Common Data Structures

```javascript
// Day object (used in #1, #3)
{
  hours: Set<number>,        // 0-23
  commits: number,           // count
  authors?: Set<string>,     // unique authors
  weekday?: string,          // "Monday", etc.
  firstCommit?: Date,        // earliest commit
  lastCommit?: Date,         // latest commit
}

// Commit object (used in all)
{
  hash: string,              // short hash
  date: string,              // YYYY-MM-DD
  message: string,           // commit message
  author: string,            // author name
  email?: string,            // (in #3)
}

// Stats object (used in #2, #3)
{
  totalCommits: number,
  humanCommits: number,
  aiCommits: number,
  uniqueAuthors: number,
  authors: string[],
  workingDays: number,
  totalEstimatedHours: number,
  weekendDays: number,
  mostActiveHour: string,
  mostActiveWeekday: string,
}
```

### Command Execution Pattern

All tools use `execSync()` with:
- Error handling try-catch
- Encoding: 'utf8'
- Output filtering
- Silent execution (`stdio: 'ignore'`) for git clone/cleanup

---

## Usage Examples

### Working Hours Analyzer
```bash
cd /path/to/repo
node working-hours-analyzer.js
# Outputs: Console report + data/working-hours-analysis.json
```

### Git Timeline Generator
```bash
# Within module (has CLI entry point)
node git-timeline-generator.js [since-date]
# node git-timeline-generator.js 2025-06-01
# Outputs: Blog posts + console stats
```

### External Repo Analyzer
```bash
node analyze-external-repos.js
# Outputs: Console report + data/external-repos-analysis.json
```

---

## Data Integration Points

### Recommended Pipeline
```
Working Hours Analyzer
    ↓ (humanHours data)
Git Timeline Generator
    ↓ (timeline blog posts)
Oracle Knowledge Base
    ↓ (patterns & learnings)
Dashboard/Visualization
```

### File Dependencies
- #1 requires: `.git/` directory + external diary file path
- #2 requires: `.git/` directory only
- #3 requires: Git CLI + network access + temp directory write permissions

---

## Key Statistics Generated Across Tools

| Statistic | Tool(s) | Unit |
|-----------|---------|------|
| Total commits | All | count |
| Human vs AI split | #1, #3 | count, % |
| Working days | #1, #3 | days |
| Hours per day | #1, #3 | hours |
| Commit types | #2 | count by type |
| Author count | #2, #3 | count |
| Time of day preference | #1, #3 | distribution |
| Weekday patterns | #3 | distribution |
| Weekend work | #1, #3 | boolean/count |
| Project duration | #3 | days |

---

## Notes for Integration

1. **Modularity**: Each tool is self-contained; can be imported as class
2. **Dependencies**: Only Node.js stdlib + `child_process.execSync`
3. **Output Flexibility**: Console + JSON file for data portability
4. **Error Resilience**: All include error handling with fallbacks
5. **Timezone**: Currently hardcoded to UTC+7 (Bangkok) in #1; parameterizable
6. **Date Handling**: Mixed use of ISO strings and Date objects; recommend standardizing
7. **Temp Files**: #3 properly cleans up temp repos; recommend doing same in #1 for diary access

---

Generated: 2026-01-09
