---
name: create-plan
description: >-
    Explores the codebase and produces a structured implementation plan for a feature or change —
    findings grounded in the code, a proposed approach, and a clear record of which design
    decisions are settled and which are still open. Use when the user describes a feature and
    wants a plan before writing any code.
user-invocable: true
---

# Create Plan

Explore the codebase and produce a structured implementation plan for a feature: what you found, how you propose to build it, and which decisions are settled versus still open.

## Step 1 — Explore before planning

Before writing a single line of the plan, explore the codebase to understand:

- **Relevant existing patterns**: find the closest analogous feature already in the codebase and read it fully (entry point, business logic, supporting utilities — whatever is relevant)
- **Affected files**: identify every existing file the feature will need to modify
- **Constraints**: note anything in the existing code that constrains the design (e.g. an event-driven vs. synchronous architecture, manual vs. framework dependency injection, no existing abstraction for X)
- **Gaps**: note anything the feature needs that does not yet exist (missing abstraction, missing dependency, missing configuration, etc.)

Use grep, glob, and view liberally. Do not guess — read the actual code.

## Step 2 — Write the plan

Structure the plan as follows:

### Findings

2–4 bullet points per area explored. Be specific — name files, class names, patterns. This section justifies the decisions made in the plan.

### Proposed approach

A prose description of the implementation strategy: what will be built, how it fits into the existing architecture, and what existing code it builds on. One paragraph per major concern (e.g. interface, data, integration).

### Open decisions

A numbered list of design decisions that are **not yet resolved**. For each, give a short title, one line on what's undecided and why it matters, and your current lean:

```
N. {Short title} — {what's undecided and why it matters}. Lean: {current preference and why}.
```

Only list decisions that are genuinely open. If the codebase or constraints make the answer obvious, make the call and state it as a resolved decision instead.

### Resolved decisions

A table of decisions already settled by the codebase, conventions, or obvious constraints:

| Decision | Choice | Reason |
|---|---|---|
| … | … | … |

## Quality bar

- Every claim in the plan must be grounded in code you actually read — no assumptions
- Open decisions must be genuinely open, not rhetorical
- Each open decision must be stated clearly enough that someone could resolve it without re-reading the whole plan
