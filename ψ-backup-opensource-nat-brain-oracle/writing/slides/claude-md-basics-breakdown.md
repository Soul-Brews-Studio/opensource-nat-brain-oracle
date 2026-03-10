# CLAUDE.md Basics - Workshop Slide

> **Teaching Material**: Generic CLAUDE.md breakdown for workshop participants
> **Source**: https://gist.github.com/nazt/3f9188eb0a5114fffa5d8cb4f14fe5a4

---

## SLIDE 1: What is CLAUDE.md? 📄

**CLAUDE.md = Instructions for AI**

Like a manual that tells Claude:
- How to work on YOUR project
- What to do and NOT do
- Your team's workflow patterns

**Analogy**: Chef's recipe card
- Ingredients = Project setup
- Steps = Workflows
- Warnings = Safety rules

---

## SLIDE 2: Why You Need It 🎯

**Without CLAUDE.md**:
- ❌ Claude guesses your preferences
- ❌ Makes unsafe changes
- ❌ Forgets project context

**With CLAUDE.md**:
- ✅ Claude follows YOUR rules
- ✅ Stays safe (no force push!)
- ✅ Remembers your workflow

**Result**: Claude becomes YOUR team member

---

## SLIDE 3: Basic Structure 🏗️

```
CLAUDE.md
├── 📋 Quick Start        ← Begin here
├── 🔴 Safety Rules       ← NEVER break these
├── 🔄 Workflows          ← How we work
├── 🛠️ Tools              ← What we use
└── 📚 Lessons Learned    ← Team knowledge
```

**Think of it as**:
- Quick Start = Onboarding guide
- Safety Rules = Company policies
- Workflows = Standard procedures
- Lessons = Team wiki

---

## SLIDE 4: Short Codes (Super Important!) ⚡

**Short codes = Quick commands for AI**

| Code | What It Does | Example |
|------|--------------|---------|
| `rrr` | Write session retrospective | After finishing work |
| `ccc` | Save context and compact | Before switching tasks |
| `nnn` | Create implementation plan | Start new feature |
| `gogogo` | Execute the plan | Build the feature |
| `lll` | Show project status | What's happening now? |

**Why short codes?**
- Fast communication
- No long explanations needed
- Consistent workflow

---

## SLIDE 5: The Two-Issue Pattern 🎫

**ccc → nnn workflow**

### Step 1: Create Context Issue (`ccc`)
```
What: Current state snapshot
Contains: Changed files, discoveries, next steps
Purpose: Save progress before switching
```

### Step 2: Create Plan Issue (`nnn`)
```
What: Implementation plan
Contains: Problem analysis, solution, steps
Purpose: Detailed roadmap for feature
```

**Why separate?**
- Context = "What happened"
- Plan = "What to do next"
- Clean task tracking

---

## SLIDE 6: Safety Rules 🔴

**3 NEVER Rules**:

1. ❌ **NEVER use `--force`**
   - No `git push --force`
   - No `rm -rf`
   - No forcing anything

2. ❌ **NEVER push to main**
   - Always create branch
   - Always create PR
   - Always wait for review

3. ❌ **NEVER merge PRs yourself**
   - Human reviews first
   - Human merges
   - AI only creates PRs

**Remember**: Safe > Fast

---

## SLIDE 7: Retrospective (`rrr`) 📝

**What happens when you type `rrr`**:

```
1. Gather session data
   - What files changed?
   - What commits made?
   - How long did it take?

2. Create retrospective document
   - What we did
   - What we learned
   - What to improve

3. Link to GitHub
   - Attach to issue/PR
   - Team can review
   - Knowledge preserved
```

**Key sections**:
- **AI Diary**: Claude's experience (first-person)
- **Honest Feedback**: What worked/didn't work
- **Lessons Learned**: Patterns to remember

---

## SLIDE 8: Workflow Example 🔄

**Complete feature workflow**:

```bash
# 1. Start: Create context
User: "Add login button"
Claude: Creates context issue with ccc

# 2. Plan: Analyze and design
Claude: Creates plan issue with nnn
- Research existing auth
- Design button component
- Plan implementation steps

# 3. Execute: Build the feature
Claude: Executes with gogogo
- Creates branch
- Writes code
- Tests feature
- Creates PR

# 4. Review: Human checks
Human: Reviews PR, approves

# 5. Document: Save learnings
Claude: Writes retrospective with rrr
```

**Time**: ~1 hour for focused feature

---

## SLIDE 9: Customizing for Your Project 🎨

**What to fill in CLAUDE.md**:

### 1. Project Context
```markdown
## Project Overview
- What: E-commerce website
- Stack: Next.js + PostgreSQL
- Team: 3 developers
```

### 2. Your Workflows
```markdown
## Development Flow
1. Create issue on Linear
2. Branch from main
3. PR review (2 approvals)
4. Deploy to staging first
```

### 3. Your Tools
```markdown
## Tools We Use
- Package manager: pnpm
- Database: Supabase
- Deployment: Vercel
```

### 4. Your Lessons
```markdown
## Lessons Learned
- Always test on Safari
- Database migrations need review
- API rate limits at 1000/hour
```

---

## SLIDE 10: Quick Start Guide 🚀

**For participants**:

### Step 1: Copy the template
```bash
# Download generic template
curl -o CLAUDE.md https://gist.githubusercontent.com/nazt/3f9188eb0a5114fffa5d8cb4f14fe5a4/raw/CLAUDE.md
```

### Step 2: Customize it
- Add your project name
- Fill in your stack
- Add your tools
- Define your workflows

### Step 3: Test it
```bash
# Start Claude with your CLAUDE.md
# Try short codes:
lll     # Check status
nnn     # Create plan for a task
gogogo  # Execute the plan
rrr     # Write retrospective
```

### Step 4: Improve it
- Add lessons as you learn
- Update workflows as they change
- Keep it simple and clear

---

## SLIDE 11: Benefits Summary ✨

**What you gain**:

| Before CLAUDE.md | After CLAUDE.md |
|------------------|-----------------|
| Claude guesses | Claude knows |
| Unsafe operations | Safety enforced |
| No memory | Documented learnings |
| Inconsistent work | Repeatable workflow |
| Lost context | Preserved knowledge |

**Key insight**: CLAUDE.md turns Claude into a team member who:
- Follows YOUR rules
- Learns YOUR patterns
- Documents YOUR knowledge
- Works YOUR way

---

## SLIDE 12: Next Steps 🎯

**After this workshop**:

1. **Create your CLAUDE.md** (15 min)
   - Copy template
   - Fill basic info
   - Add 1-2 safety rules

2. **Try short codes** (30 min)
   - Use `lll` to check status
   - Create plan with `nnn`
   - Write retrospective with `rrr`

3. **Grow it over time** (ongoing)
   - Add lessons learned
   - Update workflows
   - Share with team

**Remember**: Start simple, improve gradually

---

## SLIDE 13: Common Questions ❓

**Q: How long should CLAUDE.md be?**
A: Start with 1 page, grow to 3-5 pages. Don't over-engineer.

**Q: Can multiple people use same CLAUDE.md?**
A: Yes! It's team knowledge. Commit to your repo.

**Q: What if my project changes?**
A: Update CLAUDE.md. It should evolve with your project.

**Q: Do I need all sections?**
A: No. Start with: Safety Rules, Short Codes, Project Context.

**Q: How often to update?**
A: After major changes, or when you learn important lessons.

---

## SLIDE 14: Resources 📚

**Links**:
- Template: https://gist.github.com/nazt/3f9188eb0a5114fffa5d8cb4f14fe5a4
- Examples: [Add your repo examples]
- Workshop materials: [Add workshop repo]

**Support**:
- Questions? Ask in workshop chat
- Need help? Ping the instructor
- Share your CLAUDE.md with the group!

---

## Summary Card (Print-Friendly) 📇

```
╔════════════════════════════════════════╗
║      CLAUDE.md QUICK REFERENCE         ║
╠════════════════════════════════════════╣
║ Short Codes:                           ║
║  rrr    → Write retrospective          ║
║  ccc    → Save context                 ║
║  nnn    → Create plan                  ║
║  gogogo → Execute plan                 ║
║  lll    → Check status                 ║
║                                        ║
║ Safety Rules:                          ║
║  ❌ NEVER use --force                  ║
║  ❌ NEVER push to main                 ║
║  ❌ NEVER merge PRs                    ║
║                                        ║
║ Workflow:                              ║
║  ccc → nnn → gogogo → rrr              ║
║  (context → plan → execute → document) ║
╚════════════════════════════════════════╝
```

**Print this and keep on your desk!**
