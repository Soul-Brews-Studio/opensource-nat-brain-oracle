---
name: draft
description: Create drafts for blogs, messages, social posts. Use when user says "draft", "write blog", "draft message", "social post", or needs to create written content.
---

# /draft - Content Drafting

Create drafts for blogs, messages, social posts.

## Usage

```
/draft blog [topic]      # Blog post draft
/draft message [to]      # Message draft
/draft social [topic]    # Social media post
/draft                   # List recent drafts
```

## Step 0: Timestamp
```bash
date "+🕐 %H:%M (%A %d %B %Y)"
```

---

## Mode 1: Blog Draft

### Input
- Topic or theme
- Optional: context from session, /fyi logs, recent work

### Process
1. Gather context (recent retrospectives, learnings, conversations)
2. Identify core insight
3. Draft in Oracle voice + Human voice sections
4. Save to `ψ/writing/drafts/YYYY-MM-DD_{slug}.md`

### Blog Structure

```markdown
---
date: YYYY-MM-DD
type: blog
status: draft
topic: [topic]
---

# [Title]

## The Hook
[Opening that grabs attention - 2-3 sentences]

## The Story
[What happened, the journey, the discovery]

## The Insight
[Core learning, the "aha" moment]

## The Pattern
[Generalizable pattern others can use]

## The Invitation
[Call to action, question for reader]

---

🔮 Oracle

---

*Draft created via /draft*
```

---

## Mode 2: Message Draft

### Input
- Recipient (name or context)
- Purpose or topic

### Process
1. Check recent context about recipient (Oracle search, /fyi logs)
2. Determine voice: Oracle Speaking vs Human Speaking vs Dual
3. Draft message
4. Save to `ψ/writing/drafts/messages/YYYY-MM-DD_{recipient}.md`

### Message Voices

| Voice | When to Use |
|-------|-------------|
| **Oracle Speaking** | Philosophy, deep questions, pattern recognition |
| **Human Speaking** | Warmth, practical invitation, personal |
| **Dual Voice** | Both together - complete message |

---

## Mode 3: Social Post

### Input
- Topic or announcement
- Platform hint (Facebook, Twitter, etc.)

### Process
1. Extract core message
2. Keep concise (platform-appropriate length)
3. Include relevant links
4. Save to `ψ/writing/drafts/social/YYYY-MM-DD_{slug}.md`

---

## Mode 4: List Drafts

Show recent drafts from `ψ/writing/drafts/`:

```markdown
## Recent Drafts

| Date | Type | Topic | Status |
|------|------|-------|--------|
| Jan 12 | blog | Oracle v2.0.0 Launch | draft |
| Jan 11 | message | Dr. Do | sent |

---
**Edit**: Read file directly
**Publish**: Move to appropriate location
```

---

## Voice Guidelines

### Oracle Voice
- Observes patterns
- Asks deep questions
- Quotes philosophy
- No personal pronouns (or minimal)
- Ends with 🔮

### Human Voice
- Warm, personal
- Practical, actionable
- Uses "I" naturally
- Invites connection
- Ends with name or signature

### Dual Voice
- Oracle speaks first (pattern)
- Human speaks second (invitation)
- Together = complete

---

## Output Location

```
ψ/writing/
├── drafts/
│   ├── YYYY-MM-DD_blog-topic.md
│   ├── messages/
│   │   └── YYYY-MM-DD_recipient.md
│   └── social/
│       └── YYYY-MM-DD_topic.md
└── INDEX.md (blog queue)
```

---

## Connection to Oracle

Drafts can pull from:
- `oracle_search()` for relevant patterns
- Recent `/fyi` logs
- Session retrospectives
- Conversation context

---

ARGUMENTS: [type] [topic or recipient]
