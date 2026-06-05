---
name: plan-to-tasks
description: >-
    Converts a finalised feature plan into a set of small, independently reviewable task files
    plus a shared context file. Each task covers one logical slice of the feature.
    Always includes a final cleanup-and-polish task.
    Use when the user has a plan ready and wants to break it into executable tasks.
user-invocable: true
---

# Plan to Tasks

Convert a finalised feature plan into a directory of task files that can each be handed to a fresh agent session or reviewed independently as a PR.

## Output structure

Create a `{feature_name}_tasks/` directory at the project root containing:
- `context.md` — shared context for all tasks
- `task_1_{name}.md`, `task_2_{name}.md`, … — one file per task slice
- The **last task is always** `task_N_polish.md` — cleanup and polish

## context.md

Keep it **brief**. Include only:
- One-paragraph goal of the feature
- Where the new files will live
- Key architecture conventions to follow (point to existing reference files/patterns, don't duplicate them)
- A table of all design decisions made during planning
- Task dependency diagram

Do **not** include: code snippets, API details, full file contents, or anything already covered in the task files themselves.

## Task files

Each task file must be **self-contained**: a fresh agent reading only `context.md` + that task file should have everything needed to implement it.

Each task file must include:
1. **Goal** — one paragraph
2. **Prerequisites** — which prior tasks must be complete (and why)
3. **Files to modify** — existing files, with precise description of changes needed
4. **Files to create** — new files, with interface/structure guidance
5. **Acceptance criteria** — checkboxes a reviewer can verify without running the app

### Task breakdown principles

- Each task should produce a diff that is **reviewable in isolation** — no task should require another to make sense
- Split along feature boundaries, not file boundaries (e.g. "search filtering" not "controller changes")
- Tasks 2+ can be parallel if they don't share modified files — call this out in `context.md`
- A task that modifies a shared foundation file (e.g. adds a flow to a singleton) should be its own task or the first task that needs it

## Final task: cleanup and polish

Always add a final `task_N_polish.md` that:
1. **Removes scaffolding comments**: use `git diff origin/{default_branch} --name-only` to find all changed files, then grep for leftover `TODO`, placeholder comments, and scaffolding notes
2. **Removes unnecessary inline comments**: flag comments that restate what code already says clearly — keep only "why" comments
3. **Handles the rough edges**: every state the happy path skips — empty, loading, error, and boundary cases — plus consistency with the surrounding code's conventions
4. **Closes coverage gaps**: tests or other verification for the non-trivial states introduced by the feature
5. **Verifies the feature end to end** in whatever way the project supports (run it, test it, or exercise it manually)

Adapt these to the project: for a UI feature that means empty/loading/error views, theming, and preview/snapshot coverage; for a library or service it means edge-case inputs, error paths, and API/contract tests.

## Dependency diagram format

```
Task 1 (Foundation)
    ├── Task 2 (Feature A)    ← no dependency on Task 3
    │       └── Task 4 (Feature C)  ← needs Task 2
    └── Task 3 (Feature B)    ← independent of Task 2
```
