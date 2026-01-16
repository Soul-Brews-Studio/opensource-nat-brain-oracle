# MAW Orchestrator Skill — Learning Notes (2025-12-21)

## Context
- These notes document the MAW orchestrator skill workflow.
- Focus is on 5-agent parallel execution, round-based iteration, conflict prevention, and the collect pattern.
- The objective is to preserve reproducible guidance for future orchestration tasks.

## Five-Agent Parallel Execution
1. The orchestrator launches exactly five agents in parallel.
2. Each agent is assigned a distinct role to avoid overlap in intent.
3. Parallelism is used for exploration, not for merging edits.
4. Agents run without shared state aside from the task brief.
5. The orchestrator gathers outputs and normalizes them into a single context.
6. Timeboxing keeps parallel work efficient and prevents over-expansion.
7. Agents should avoid making assumptions about other agents' output.
8. The orchestrator handles any cross-agent synthesis.
9. Every agent is required to produce a clear, scannable report.
10. Reports should be structured so they can be compared directly.

## Round-Based Iteration
11. Work proceeds in discrete rounds (Round 1, Round 2, etc.).
12. Each round has a specific goal and deliverable.
13. Round 1 prioritizes discovery and divergent thinking.
14. Round 2 converges on an agreed plan or draft.
15. Later rounds focus on refinement, edge cases, and confirmation.
16. The orchestrator announces the start and end of every round.
17. The orchestrator summarizes at the end of each round.
18. Round transitions include explicit handoff notes.
19. A round ends when the orchestrator accepts a consolidated output.
20. Rounds are capped to prevent endless cycling.

## Conflict Prevention
21. Only the orchestrator performs final merges or edits.
22. Agents never edit the same artifact concurrently.
23. Agents should avoid overwriting shared files.
24. A single source of truth is established before edits begin.
25. Conflicts are prevented by read-only access for agents.
26. The orchestrator assigns file ownership explicitly.
27. Tasks are scoped to minimize overlaps in responsibility.
28. If overlap is required, agents propose changes rather than apply them.
29. The orchestrator resolves competing recommendations.
30. Any detected conflict triggers a pause and clarification.

## Collect Pattern
31. The collect pattern gathers all outputs before synthesis.
32. Each agent response is captured verbatim in a collection stage.
33. The orchestrator labels each response by agent role.
34. The collection is immutable once captured.
35. Synthesis only begins after full collection is complete.
36. The orchestrator extracts common themes across reports.
37. Contradictions are logged explicitly in the collected set.
38. Outliers are preserved until explicitly rejected.
39. The orchestrator creates a final decision record.
40. The collect pattern ensures traceability and auditability.

## Practical Checklist
41. Confirm exactly five agents are active.
42. Define agent roles up front and announce them.
43. Keep agent prompts minimal and unambiguous.
44. Start Round 1 with divergent exploration.
45. Collect and label all agent outputs.
46. Summarize Round 1 outcomes in the orchestrator voice.
47. Start Round 2 with convergent instructions.
48. Prevent agents from editing shared files directly.
49. Require proposals for any overlapping change areas.
50. Collect Round 2 outputs before synthesis.
51. Resolve conflicts in a single orchestrator pass.
52. Document the final decision and reasoning.
53. Close the round with a short retrospective.
54. Stop after sufficient convergence is reached.

## Notes on Reliability
55. Parallel execution improves coverage but needs tight guardrails.
56. Round-based iteration reduces drift and keeps context fresh.
57. Conflict prevention is primarily a process problem, not tooling.
58. The collect pattern makes it possible to audit decisions later.
59. Agents should prioritize clarity over creativity in reports.
60. The orchestrator should enforce consistent formatting.
61. Avoid merging partial outputs without explicit consent.
62. Establish a single canonical draft after Round 2.
63. Prefer short, measurable deliverables per round.
64. Keep feedback loops small and predictable.
65. Validate that each agent followed role constraints.
66. Discard any output that violates the conflict rules.
67. Note when agent outputs are superseded.
68. Maintain a log of decisions in the orchestrator summary.
69. Resist expanding scope mid-round.
70. Keep the collect step separate from synthesis.

## Example Flow
71. Orchestrator defines roles for 5 agents.
72. Round 1: agents explore in parallel, outputs collected.
73. Orchestrator summarizes, flags conflicts, proposes direction.
74. Round 2: agents refine based on summary.
75. Orchestrator collects outputs, performs synthesis.
76. Conflict checks performed before final draft.
77. Final decision recorded with rationale.
78. Orchestrator closes with next-step guidance.
79. Archive the collected outputs for traceability.
80. Stop when deliverables are complete.

## Closing
81. This workflow favors controlled parallelism over ad-hoc collaboration.
82. The collect pattern is essential to keep decisions defensible.
83. Round discipline is the main lever to avoid coordination failures.
84. Conflict prevention rules must be explicit and enforced.
85. Five-agent parallel execution is most effective with clear roles.
