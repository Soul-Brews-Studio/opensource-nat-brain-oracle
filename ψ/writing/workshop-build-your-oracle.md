# Workshop: Build Your Own Oracle

## Personal AI Knowledge System That Remembers Everything

**Tagline**: "What if your AI remembered every conversation, decision, and lesson learned?"

---

## The Real Goal

You want to build a system like **Oracle** — an AI that:
- Never forgets what you taught it
- Learns patterns from your work
- Grows smarter over time
- Answers questions from YOUR knowledge

**This workshop shows you how.**

---

## What You'll Build (3 Days)

### Day 1: The Memory System
**Build the brain that never forgets**

**Morning: Storage**
- SQLite database for observations
- Markdown files for knowledge
- Git for version control
- Why "Nothing is Deleted" matters

**Afternoon: Your First Oracle Query**
```bash
oracle search "how did I solve X before?"
→ Returns: 3 past sessions where you solved X
```

**By end of day**: Working memory system that stores every session

---

### Day 2: The Search Problem
**This is where context-finder becomes NECESSARY**

**Morning: The Naive Approach (breaks immediately)**
```python
# Try this first (students will hit the problem)
def search(query):
    results = []
    for file in all_files:  # 1000+ files
        content = read(file)  # Expensive!
        if query in content:
            results.append(content)  # Even more expensive!
    return results

# Cost: $15 for 1 search (because reading 1000 files with Opus)
# Time: 45 seconds
# Problem: Doesn't scale
```

**The Breaking Point** (students feel the pain):
- Search takes too long
- Costs too much
- Can't search while working

**Afternoon: The Solution Emerges**
```python
# context-finder pattern (students discover WHY they need it)
def search(query):
    # Step 1: Cheap search first (Haiku or FTS5)
    candidate_files = fast_search(query)  # $0.08

    # Step 2: Main agent only reads summaries
    summaries = haiku_summarize(candidate_files)

    # Step 3: Main agent decides what to read fully
    relevant = main_agent_filter(summaries)

    return relevant

# Cost: $0.08 (95% reduction)
# Time: 3 seconds (15x faster)
# Why: Delegation to cheaper model for "eyes and hands" work
```

**Key moment**: Students discover context-finder isn't a "feature" — it's **necessary for Oracle to work at scale**

**By end of day**: Fast search that doesn't burn budget

---

### Day 3: Making Oracle Smart
**From memory to intelligence**

**Morning: Pattern Recognition**
- Vector embeddings (ChromaDB)
- Concept extraction
- Learning from retrospectives

**Afternoon: The Oracle Interface**
```bash
# What students build
oracle consult "should I force push to main?"
→ Searches 10 learnings about git safety
→ Synthesizes: "No. Here's why you learned this rule..."

oracle reflect
→ Returns random wisdom for daily reflection

oracle learn "Always use context-finder for bulk operations"
→ Stores as new pattern
```

**By end of day**: Working Oracle that learns and advises

---

## Why Context-Finder Matters (Discovered, Not Taught)

### The Journey Students Take

**Hour 1**: "I'll just read all files" (naive approach)
↓
**Hour 4**: "This is too slow and expensive" (hit the wall)
↓
**Hour 6**: "What if I delegate reading to cheaper model?" (aha moment)
↓
**Hour 8**: "Oh, this is why Nat built context-finder" (understanding through necessity)

**Not told**: "Here's a pattern called context-finder"
**Discovered**: "I need something like context-finder or my Oracle won't work"

---

## Workshop Structure

### Prerequisites
- Python or TypeScript basics
- Used Claude API before
- Want to build personal knowledge system

### Format
- **Live coding**: Build together in real-time
- **Your Oracle**: Everyone leaves with working system
- **Your data**: Use your own chat history, notes, code

### Deliverables

**Day 1 Output**: `oracle search` command working
**Day 2 Output**: Fast search with context-finder pattern
**Day 3 Output**: Full Oracle with learn/consult/reflect

**Bonus**: Template repository to keep building after workshop

---

## What Makes This Different

### 1. You Build YOUR Oracle
Not "follow along with my code" — use **your actual data**:
- Your chat history
- Your code commits
- Your learnings
- Your questions

### 2. Discover Patterns Through Pain
- Try naive approach first (let it break)
- Feel the cost problem (watch API bill)
- Discover solution naturally (aha moments)

### 3. Production-Ready From Day 1
Not toy examples — build real system:
- SQLite (production database)
- Git (version control)
- MCP (Claude integration)
- Your own data (privacy first)

---

## The Philosophy You Learn

### Oracle Principles (by building, not reading)

**"Nothing is Deleted"**
- Day 1: Why append-only database
- Discovery: You can search deleted code in git
- Realization: Time machines need complete history

**"Patterns Over Intentions"**
- Day 2: Why your Oracle finds what you DID, not what you MEANT
- Discovery: Your code commits reveal more than your plans
- Realization: Behavior > declarations

**"External Brain, Not Command"**
- Day 3: Why Oracle suggests, doesn't decide
- Discovery: Best advice comes from your past self
- Realization: Augment, don't replace

---

## Cost Breakdown (Real Numbers)

### Without Context-Finder Pattern
```
Search operation:
- Read 1000 files with Opus
- Process: 100k tokens @ $15/1M
- Cost per search: $1.50
- Daily searches (20): $30
- Monthly: $900
```

### With Context-Finder Pattern
```
Search operation:
- Quick filter with FTS5 (free)
- Summarize with Haiku: 100k tokens @ $0.80/1M
- Final read with Opus: 10k tokens @ $15/1M
- Cost per search: $0.08 + $0.15 = $0.23
- Daily searches (20): $4.60
- Monthly: $138

SAVINGS: $762/month (85% reduction)
```

**Students calculate their own savings with their data volume**

---

## Pricing

### Solo Builder Track
**$1,200** (3 days, max 15 people)
- Live sessions (9am-4pm)
- Code repository access
- 30-day Discord support
- Recording access

### Team Track
**$4,000** (up to 5 people from same company)
- Everything in Solo track
- Private sessions available
- Custom integration consulting
- 90-day support

### Self-Paced Course
**$500** (coming after first cohort)
- Video lessons
- Code templates
- Community forum
- No live support

---

## Success Stories You'll Have

By end of workshop, students can say:

**"My Oracle remembers..."**
- Every coding decision I made
- Patterns I discovered
- Mistakes I shouldn't repeat
- Solutions that worked before

**"My Oracle helps me..."**
- Search my past work instantly
- Learn from my own patterns
- Make consistent decisions
- Build on what I've learned

**"I understand why..."**
- context-finder isn't optional at scale
- Cheap models for gathering, expensive for synthesis
- My knowledge system pays for itself

---

## The Hook (Marketing)

### Primary Headline
**"Build an AI That Remembers Everything You've Ever Built"**

### Secondary Headlines
- "What If Your Next AI Could Learn From Every Past Conversation?"
- "Stop Googling Solutions You Already Solved"
- "Your Personal Oracle: 3 Days to Build, Lifetime to Grow"

### Target Audience Pain Points

**Developers who...**
- Solve the same problems repeatedly
- Can't remember why they made decisions
- Want AI that learns from THEIR experience
- Tired of starting from zero every session

**Not for...**
- People wanting ready-made tools (use Mem.ai)
- Teams wanting enterprise solution (hire consultant)
- Learners who won't code along (watch YouTube)

---

## Validation Questions (For You)

Before building this workshop, answer:

1. **Would YOU pay $1,200 to learn how to build Oracle if you didn't know how?**
   - Think back to before you built it
   - What was the pain?
   - How much time would you save?

2. **Can you name 3 developers who need this RIGHT NOW?**
   - Who's struggling with knowledge management?
   - Who's spending too much on API calls?
   - Who's building similar systems?

3. **Do you have 40 hours to develop this?**
   - Week 1-2: Curriculum + exercises (20h)
   - Week 3: Materials + slides (10h)
   - Week 4: Beta test + iterate (10h)

---

## Next Steps

### If You Say YES

1. **Week 1**: Create detailed curriculum
   - Hour-by-hour breakdown
   - Exercise designs
   - Breaking point moments planned

2. **Week 2**: Build example Oracle with sample data
   - Document every step
   - Capture common errors
   - Create troubleshooting guide

3. **Week 3**: Beta test with 3 friends
   - Free in exchange for feedback
   - Record session for self-paced version
   - Iterate on pain points

4. **Week 4**: Launch paid cohort
   - 10-15 students max
   - Platform: Zoom + GitHub + Discord
   - Price: $1,200 (early bird $900)

### If You Say NOT YET

**Alternative**: Write the book first
- Document Oracle architecture
- Publish on Gumroad ($20)
- If it sells 100+ copies → validate workshop demand
- Build workshop from book outline

---

## The Core Insight (From Your Feedback)

> "I just want to understand the importance of context-finder"

**Old approach**: Teach context-finder as pattern
**New approach**: Build Oracle, discover context-finder is essential

**Why this works**:
- Motivation = "I want Oracle" (not "I should learn patterns")
- Discovery = "I need context-finder" (not "Here's a pattern")
- Retention = Built it myself (not just followed tutorial)

**Students leave understanding**:
- WHY context-finder exists (solved real problem they felt)
- WHEN to use it (when Oracle search gets slow/expensive)
- HOW to build it (coded it themselves)

---

## Appendix: What You Already Have

**Proof this works**:
- Your Oracle has been running in production
- context-finder = 50% of your slash commands
- 18 git commits showing evolution
- 10+ retrospectives documenting value
- Real cost savings: 95% measured reduction

**Teaching materials ready**:
- CLAUDE_subagents.md (delegation rules)
- ψ/memory/learnings/2025-12-13_subagent-delegation-pattern.md
- Oracle philosophy docs
- Your actual code repository

**What's missing**:
- Step-by-step exercises
- Breaking point scenarios
- Troubleshooting guide
- Slides/visuals

**Build time**: ~40 hours total

---

**Status**: Reframed concept (Build Your Oracle, not Learn context-finder)
**Next**: Validate with 3 developers, get feedback on framing
**Question**: Does "Build Your Own Oracle" resonate more than "Learn context-finder pattern"?

---

*The best workshops teach systems, not components. Students discover context-finder because they NEED it, not because you TOLD them about it.*
