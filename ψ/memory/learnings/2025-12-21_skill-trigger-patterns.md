# Skill Trigger Patterns (2025-12-21)

Purpose
- Capture how skill triggering works in this repo's Codex setup.
- Document what makes a description field effective.
- Provide practical guidance for proactive invocation.
- Include a lightweight testing checklist for triggers.

Context
- Skills are discovered from local sources; the description is the primary trigger.
- Only the YAML frontmatter (name + description) is read before triggering.
- The SKILL.md body loads after the skill triggers.

How the description field triggers skills
- Description is the primary signal for automatic skill use.
- It must contain what the skill does and when to use it.
- If the user names a skill explicitly, that name also triggers.
- If the task clearly matches a description, the skill should be used.
- The body of SKILL.md cannot influence triggering; it is not loaded yet.
- Missing or vague description = missed trigger, or wrong trigger.

Proactive invocation patterns
- Match the user intent to the description, not the exact words.
- Trigger when the task is in-scope even if the user did not name the skill.
- Trigger immediately when a skill's description is a clean fit.
- If multiple skills overlap, choose the minimal set that covers the request.
- Announce which skill(s) are being used and why in one short line.
- Do not carry skills across turns unless the user re-mentions them.
- If a named skill is missing, say so briefly and continue.

Good description characteristics
- Includes both capability and explicit usage conditions.
- Uses concrete trigger phrasing like "Use when..." or "Use for...".
- Covers common task variations and synonyms.
- Is comprehensive but concise; it should fit in a short paragraph.
- Avoids promises that belong in the body or in reference files.
- Uses action language, not marketing language.

Bad description characteristics
- Only states the domain or name without trigger conditions.
- Vague claims like "general help" or "handles everything".
- Burying trigger info in the body instead of frontmatter.
- Overly long lists that dilute the primary scope.
- Ambiguous overlap that causes over-triggering.

Good vs bad examples
- Good: "Create and update skills. Use when a user wants to define a new skill, improve an existing skill, or package skills for reuse."
- Bad: "Skill helper for skills".
- Good: "Handle PDF rotation, extraction, and merging. Use when the user asks to modify PDFs or needs repeatable PDF tooling."
- Bad: "PDF stuff".
- Good: "Write and run Bash/Python data-cleaning scripts. Use when the user requests deterministic data cleanup or batch transforms."
- Bad: "Data assistant".

Specific trigger patterns to include
- Task verbs: create, update, install, package, analyze, transform, deploy.
- Artifacts: file types, formats, or systems the skill is designed for.
- Context: "use when" conditions, including scope boundaries.
- Exclusions: short notes on what is out of scope can prevent over-triggering.

Testing triggers (manual checklist)
- Write 5-10 example user prompts that should trigger the skill.
- Write 3-5 example prompts that should NOT trigger the skill.
- Check that explicit skill names are still recognized.
- Verify that the description alone is sufficient to decide.
- Confirm that common synonyms in real requests are covered.
- Ensure overlapping skills do not both trigger unnecessarily.
- Validate the "minimal set" rule when multiple skills could apply.
- Revise the description when false positives or negatives appear.

Testing triggers (fast sanity loop)
- Draft description.
- Generate or collect example prompts.
- Simulate: "Would I pick this skill from description alone?"
- Tighten or expand the description accordingly.

Notes on ambiguity and overlap
- Overlap is normal; the description should disambiguate.
- If two skills overlap, narrow one with explicit context or constraints.
- If a skill is a meta-skill, state that it is meta in the description.
- Use names and terms the user is likely to say.

Operational reminders
- Only load SKILL.md after triggering; do not front-load content.
- Follow progressive disclosure; keep the description short and dense.
- Prefer reference files for large supporting details.
- Prefer scripts or assets when deterministic outputs are needed.

Actionable guidance for future skill edits
- Start by tightening the description before changing the body.
- When adding new capabilities, update the description first.
- If the skill under-triggers, add clearer "use when" conditions.
- If the skill over-triggers, add exclusions or narrow scope.

End of note
