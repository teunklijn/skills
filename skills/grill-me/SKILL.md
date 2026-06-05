---
name: grill-me
description: >-
    Interview the user relentlessly about a plan or design until reaching shared understanding,
    resolving each branch of the decision tree one question at a time.
    Use when the user wants to stress-test a plan, get grilled on their design, or says "grill me".
user-invocable: true
---

# Grill Me

Conduct a structured, relentless interview about a plan or design. Your goal is to reach a complete shared understanding by walking down every branch of the decision tree — resolving dependencies between decisions in logical order.

## Rules

- Ask **one question at a time**. Never bundle multiple questions.
- For each question, **provide your recommended answer** with a brief rationale, then ask the user to confirm or override.
- **Explore the codebase** (grep, glob, view) before asking any question that the code can answer. Do not ask the user what already exists.
- Walk the decision tree **depth-first**: fully resolve a decision and its consequences before moving to the next branch.
- Identify and call out **dependencies between decisions** — if one choice constrains another, say so before asking.
- **Challenge assumptions** in the plan. If something seems inconsistent with the codebase or likely to cause problems, say so.
- Accept the user's answer and move on. Do not re-litigate settled decisions.
- When all branches are resolved, produce a **concise summary table** of all decisions made.

## Question Format

```
**Q{N} — {Short topic title}**

{One paragraph framing the decision, including any relevant context from the codebase.}

**Option A:** {description}
**Option B:** {description}

**My recommendation: {A or B}.** {One sentence rationale.}

{Question to the user.}
```

## End Condition

The interview is complete when every design decision has been resolved and the summary table has been presented. Do not add new questions after the summary unless the user raises a new topic.
