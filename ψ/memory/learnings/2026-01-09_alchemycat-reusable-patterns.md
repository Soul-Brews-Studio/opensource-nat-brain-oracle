# AlchemyCat Tools - Reusable Code Patterns

## Quick Start: Copy-Paste Ready Snippets

### Pattern 1: Standard Commit Parser

Use in any project needing to analyze git history:

```javascript
const { execSync } = require('child_process');

function getCommits(repoPath = '.', since = '2025-01-01') {
  try {
    const cmd = 'git log --pretty=format:"%h|%ad|%s|%an" --date=iso';
    const since_flag = since ? `--since="${since}"` : '';
    const gitLog = execSync(
      `${cmd} ${since_flag}`,
      { cwd: repoPath, encoding: 'utf8' }
    );
    
    return gitLog
      .split('\n')
      .filter(line => line.trim())
      .map(line => {
        const [hash, date, message, author] = line.split('|');
        return {
          hash: hash.trim(),
          date: date.trim(),
          message: message.trim(),
          author: author.trim()
        };
      });
  } catch (error) {
    console.error('Error reading commits:', error.message);
    return [];
  }
}

// Usage:
const commits = getCommits('/path/to/repo', '2025-01-01');
console.log(`Found ${commits.length} commits`);
```

### Pattern 2: AI vs Human Commit Separator

Instantly categorize commits:

```javascript
function isAICommit(commit) {
  const aiIndicators = [
    '🤖',
    'claude',
    'anthropic',
    'noreply@anthropic'
  ];
  
  const text = `${commit.message} ${commit.author} ${commit.email || ''}`.toLowerCase();
  return aiIndicators.some(indicator => text.includes(indicator));
}

function separateCommits(commits) {
  const aiCommits = [];
  const humanCommits = [];
  
  commits.forEach(commit => {
    if (isAICommit(commit)) {
      aiCommits.push(commit);
    } else {
      humanCommits.push(commit);
    }
  });
  
  return { humanCommits, aiCommits };
}

// Usage:
const commits = getCommits();
const { humanCommits, aiCommits } = separateCommits(commits);
console.log(`Human: ${humanCommits.length}, AI: ${aiCommits.length}`);
```

### Pattern 3: Hour-of-Day Analytics

Extract working hour patterns:

```javascript
function analyzeWorkingHours(commits) {
  const hourDistribution = {};
  const dayDistribution = {};
  const weekdayDistribution = {};
  
  commits.forEach(commit => {
    const date = new Date(commit.date);
    const hour = date.getHours();
    const day = commit.date.split('T')[0];
    const weekday = date.toLocaleDateString('en-US', { weekday: 'long' });
    
    // Count by hour (0-23)
    hourDistribution[hour] = (hourDistribution[hour] || 0) + 1;
    
    // Count by day
    dayDistribution[day] = (dayDistribution[day] || 0) + 1;
    
    // Count by weekday
    weekdayDistribution[weekday] = (weekdayDistribution[weekday] || 0) + 1;
  });
  
  // Bin into time periods
  const timePeriods = {
    night: 0,      // 0-6
    morning: 0,    // 6-12
    afternoon: 0,  // 12-18
    evening: 0     // 18-24
  };
  
  Object.entries(hourDistribution).forEach(([hour, count]) => {
    const h = parseInt(hour);
    if (h >= 0 && h < 6) timePeriods.night += count;
    else if (h >= 6 && h < 12) timePeriods.morning += count;
    else if (h >= 12 && h < 18) timePeriods.afternoon += count;
    else timePeriods.evening += count;
  });
  
  return {
    hourDistribution,
    dayDistribution,
    weekdayDistribution,
    timePeriods
  };
}

// Usage:
const analysis = analyzeWorkingHours(humanCommits);
console.log('Most active hour:', 
  Object.entries(analysis.hourDistribution)
    .sort(([, a], [, b]) => b - a)[0][0] + ':00'
);
console.log('Time period breakdown:', analysis.timePeriods);
```

### Pattern 4: Date Grouping (Day-by-Day Aggregation)

Organize commits by calendar date:

```javascript
function groupByDate(commits) {
  const grouped = {};
  
  commits.forEach(commit => {
    const date = commit.date.split('T')[0]; // YYYY-MM-DD
    if (!grouped[date]) {
      grouped[date] = {
        date,
        commits: [],
        authors: new Set(),
        hours: new Set(),
        commitCount: 0
      };
    }
    
    const dateGroup = grouped[date];
    dateGroup.commits.push(commit);
    dateGroup.authors.add(commit.author);
    dateGroup.hours.add(new Date(commit.date).getHours());
    dateGroup.commitCount++;
  });
  
  return grouped;
}

// Usage:
const dailyData = groupByDate(commits);
Object.entries(dailyData).forEach(([date, data]) => {
  console.log(`${date}: ${data.commitCount} commits by ${data.authors.size} authors`);
});
```

### Pattern 5: Commit Type Detection

Categorize by conventional commits:

```javascript
function getCommitType(message) {
  const types = {
    'feat': { label: 'Feature', emoji: '🚀' },
    'fix': { label: 'Bug Fix', emoji: '🔧' },
    'refactor': { label: 'Refactor', emoji: '♻️' },
    'docs': { label: 'Documentation', emoji: '📚' },
    'test': { label: 'Tests', emoji: '✅' },
    'chore': { label: 'Maintenance', emoji: '🧹' },
    'perf': { label: 'Performance', emoji: '⚡' }
  };
  
  const msg = message.toLowerCase();
  for (const [key, data] of Object.entries(types)) {
    if (msg.startsWith(key + ':') || msg.startsWith(key + '(')) {
      return data;
    }
  }
  
  return { label: 'Other', emoji: '📝' };
}

function analyzeCommitTypes(commits) {
  const types = {};
  
  commits.forEach(commit => {
    const type = getCommitType(commit.message);
    if (!types[type.label]) {
      types[type.label] = { emoji: type.emoji, count: 0, commits: [] };
    }
    types[type.label].count++;
    types[type.label].commits.push(commit);
  });
  
  return types;
}

// Usage:
const typeAnalysis = analyzeCommitTypes(commits);
Object.entries(typeAnalysis).forEach(([type, data]) => {
  console.log(`${data.emoji} ${type}: ${data.count} commits`);
});
```

### Pattern 6: Statistical Summary

Generate quick statistics from commits:

```javascript
function generateStats(commits) {
  const { humanCommits, aiCommits } = separateCommits(commits);
  const authors = new Set(humanCommits.map(c => c.author));
  const dates = new Set(commits.map(c => c.date.split('T')[0]));
  
  const firstDate = commits.length > 0 
    ? commits[commits.length - 1].date 
    : 'N/A';
  const lastDate = commits[0]?.date || 'N/A';
  
  const daysDiff = firstDate !== 'N/A' 
    ? Math.ceil((new Date(lastDate) - new Date(firstDate)) / (1000 * 60 * 60 * 24))
    : 0;
  
  return {
    totalCommits: commits.length,
    humanCommits: humanCommits.length,
    aiCommits: aiCommits.length,
    aiPercentage: ((aiCommits.length / commits.length) * 100).toFixed(1),
    uniqueAuthors: authors.size,
    authors: Array.from(authors),
    workingDays: dates.size,
    dateRange: {
      first: firstDate.split('T')[0],
      last: lastDate.split('T')[0],
      durationDays: daysDiff
    },
    commitsPerDay: (commits.length / Math.max(dates.size, 1)).toFixed(1)
  };
}

// Usage:
const stats = generateStats(commits);
console.log(`Total: ${stats.totalCommits} commits`);
console.log(`Human: ${stats.humanCommits} (${100-stats.aiPercentage}%)`);
console.log(`AI: ${stats.aiCommits} (${stats.aiPercentage}%)`);
console.log(`Authors: ${stats.uniqueAuthors}, Working days: ${stats.workingDays}`);
```

### Pattern 7: Weekend Work Detection

Identify non-standard work patterns:

```javascript
function analyzeWeekendWork(commits) {
  const weekendCommits = [];
  const nightCommits = [];
  
  commits.forEach(commit => {
    const date = new Date(commit.date);
    const weekday = date.getDay(); // 0 = Sunday, 6 = Saturday
    const hour = date.getHours();
    
    // Weekend (Saturday=6, Sunday=0)
    if (weekday === 0 || weekday === 6) {
      weekendCommits.push(commit);
    }
    
    // Night shift (0:00-6:00)
    if (hour < 6) {
      nightCommits.push(commit);
    }
  });
  
  return {
    weekendDays: new Set(weekendCommits.map(c => c.date.split('T')[0])).size,
    weekendCommits: weekendCommits.length,
    nightCommits: nightCommits.length,
    hasWeekendWork: weekendCommits.length > 0,
    hasNightWork: nightCommits.length > 0
  };
}

// Usage:
const patterns = analyzeWeekendWork(humanCommits);
console.log(`Weekend work: ${patterns.weekendDays} days, ${patterns.weekendCommits} commits`);
console.log(`Night shifts: ${patterns.nightCommits} commits`);
```

### Pattern 8: JSON Report Generation

Save analysis to portable JSON:

```javascript
function generateReport(commits, filename = 'analysis.json') {
  const { humanCommits, aiCommits } = separateCommits(commits);
  const stats = generateStats(commits);
  const hours = analyzeWorkingHours(humanCommits);
  const types = analyzeCommitTypes(humanCommits);
  const weekend = analyzeWeekendWork(humanCommits);
  
  const report = {
    generatedAt: new Date().toISOString(),
    summary: stats,
    analysisDetails: {
      workingHours: hours,
      commitTypes: Object.entries(types).map(([type, data]) => ({
        type,
        emoji: data.emoji,
        count: data.count
      })),
      weekendPatterns: weekend
    },
    dailyBreakdown: groupByDate(humanCommits),
    sampleCommits: humanCommits.slice(0, 10) // For verification
  };
  
  const fs = require('fs');
  fs.writeFileSync(filename, JSON.stringify(report, null, 2));
  console.log(`Report saved to: ${filename}`);
  
  return report;
}

// Usage:
generateReport(commits, 'git-analysis.json');
```

---

## Building a Complete Analyzer

Combine patterns 1-8 to create your own tool:

```javascript
const { execSync } = require('child_process');
const fs = require('fs');

class SimpleAnalyzer {
  constructor(repoPath = '.') {
    this.repoPath = repoPath;
  }
  
  analyze(since = '2025-01-01') {
    // Use Pattern 1
    const commits = this.getCommits(since);
    
    // Use Pattern 2
    const { humanCommits, aiCommits } = separateCommits(commits);
    
    // Use Patterns 3-8
    const stats = generateStats(commits);
    const hours = analyzeWorkingHours(humanCommits);
    const types = analyzeCommitTypes(humanCommits);
    const weekend = analyzeWeekendWork(humanCommits);
    
    // Print report
    this.printReport(stats, hours, types, weekend);
    
    // Save JSON
    generateReport(commits, 'analysis.json');
  }
  
  getCommits(since) {
    try {
      const cmd = 'git log --pretty=format:"%h|%ad|%s|%an" --date=iso';
      const gitLog = execSync(
        `${cmd} --since="${since}"`,
        { cwd: this.repoPath, encoding: 'utf8' }
      );
      return gitLog.split('\n')
        .filter(line => line.trim())
        .map(line => {
          const [hash, date, message, author] = line.split('|');
          return { hash: hash.trim(), date: date.trim(), 
                   message: message.trim(), author: author.trim() };
        });
    } catch (error) {
      console.error('Error:', error.message);
      return [];
    }
  }
  
  printReport(stats, hours, types, weekend) {
    console.log('\n=== GIT ANALYSIS REPORT ===\n');
    console.log(`Total Commits: ${stats.totalCommits}`);
    console.log(`Human: ${stats.humanCommits} (${100-stats.aiPercentage}%)`);
    console.log(`AI: ${stats.aiCommits} (${stats.aiPercentage}%)`);
    console.log(`Authors: ${stats.uniqueAuthors}`);
    console.log(`Duration: ${stats.dateRange.durationDays} days`);
    console.log(`Avg Commits/Day: ${stats.commitsPerDay}`);
    console.log(`\nTime Periods:`, hours.timePeriods);
    console.log(`Weekend Work: ${weekend.weekendDays} days`);
    console.log(`\nCommit Types:`);
    Object.entries(types).forEach(([type, data]) => {
      console.log(`  ${data.emoji} ${type}: ${data.count}`);
    });
  }
}

// Usage:
const analyzer = new SimpleAnalyzer('/path/to/repo');
analyzer.analyze('2025-01-01');
```

---

## Integration with Your Oracle/Projects

These patterns are designed to feed into:

1. **Data Collection** → JSON files in `data/` directory
2. **Processing** → Extract patterns, aggregate statistics
3. **Knowledge Base** → Store learnings about team patterns
4. **Visualization** → Use data for dashboards/insights

All AlchemyCat tools follow this same pattern - you can now replicate them!

---

Generated: 2026-01-09
