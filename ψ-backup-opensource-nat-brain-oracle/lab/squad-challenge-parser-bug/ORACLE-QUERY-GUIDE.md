# How to Query Oracle for Squad Challenges

> For maintainers and graders only

## Find Answer Keys

```bash
# MISSION-01 answer
oracle_search("mission-01 ground truth")

# MISSION-02 answer
oracle_search("mission-02 scoring")
oracle_search("mission-02 answer key")
```

## Find Templates

```bash
# Challenge README template
oracle_search("squad challenge template")

# Oracle intro format
oracle_search("oracle speaks format")
```

## Find Philosophy

```bash
# Level Up with AI philosophy
oracle_search("level up ai philosophy")
oracle_search("เรียนฟรี")

# Scoring philosophy
oracle_search("challenge scoring")
```

## Find All Challenges

```bash
# List all missions
oracle_search("squad challenges index")

# Specific mission
oracle_search("mission-01")
oracle_search("mission-02")
```

## Grade a Submission

1. `oracle_search("mission-XX scoring")` - Get rubric
2. Compare submission against rubric
3. Calculate score (100 points max)
4. Comment on PR with score + feedback

---

*This file is for maintainers. Do not share answer keys publicly.*
