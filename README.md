# skills

A collection of reusable [agent skills](https://docs.claude.com/en/docs/claude-code/skills) for planning and breaking down software work. The skills are designed to chain together into a single workflow:

```
create-plan  →  grill-me  →  plan-to-tasks
 (draft a       (stress-test    (split into small,
  plan from      the open        independently
  the codebase)  decisions)      reviewable tasks)
```

## Skills

| Skill | What it does |
|---|---|
| [`create-plan`](skills/create-plan/SKILL.md) | Explores the codebase and produces a structured implementation plan for a feature — findings, proposed approach, open vs. resolved decisions, and a rough task breakdown. |
| [`grill-me`](skills/grill-me/SKILL.md) | Interviews you relentlessly about a plan or design, one question at a time, resolving every branch of the decision tree until there's shared understanding. |
| [`plan-to-tasks`](skills/plan-to-tasks/SKILL.md) | Converts a finalised plan into a directory of small, self-contained task files plus a shared `context.md`, always ending with a cleanup-and-polish task. |

## Install

Pick whichever fits — the two methods are independent.

### Option A — `npx skills` (no clone)

The [`skills`](https://github.com/vercel-labs/skills) CLI installs these into Claude Code, Cursor, Codex, and other agents. It auto-discovers the `skills/` folder, so the command is just `owner/repo`:

```bash
npx skills@latest add teunklijn/skills            # prompts you to pick
npx skills@latest add teunklijn/skills --list     # list skills first
npx skills@latest add teunklijn/skills --skill grill-me   # install one
```

### Option B — clone + install script

Clone the repo, then run the install script. By default it **symlinks** each skill into `~/.claude/skills`, so a `git pull` keeps every machine up to date.

```bash
git clone https://github.com/teunklijn/skills.git
cd skills
./scripts/install.sh
```

Options:

```bash
./scripts/install.sh --list            # show available skills
./scripts/install.sh --copy            # copy instead of symlinking
./scripts/install.sh --target DIR      # install somewhere other than ~/.claude/skills
```

`~/.claude/skills` is the user-level skills directory Claude Code reads. To install into a single project instead, point `--target` at that project's `.claude/skills`:

```bash
./scripts/install.sh --target /path/to/project/.claude/skills
```

After installing, restart your agent (or reload skills) and invoke a skill by name, e.g. `create-plan`.

## Adding a skill

Create a new folder under `skills/` containing a `SKILL.md` with YAML frontmatter:

```markdown
---
name: my-skill
description: >-
    One or two sentences on what the skill does and when to use it.
user-invocable: true
---

# My Skill

Instructions for the agent...
```

The install script picks up any folder under `skills/` that contains a `SKILL.md` — no further configuration needed.

## License

[MIT](LICENSE)
