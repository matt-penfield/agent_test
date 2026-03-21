---
name: skill-creation
description: '**WORKFLOW SKILL** — Create, update, and validate GitHub Copilot skills (SKILL.md files). USE FOR: packaging repeatable workflows into on-demand skills; writing keyword-rich descriptions for discovery; structuring skill folders with scripts, references, and assets; progressive loading design; writing step-by-step procedures; choosing skills vs prompts vs instructions vs agents. DO NOT USE FOR: creating prompts (.prompt.md), instructions (.instructions.md), or custom agents (.agent.md) — use the agent-customization skill for those.'
argument-hint: 'Describe the domain or workflow the new skill should cover'
---

# Skill Creation

Create high-quality, discoverable GitHub Copilot skills that follow VS Code conventions.

## When to Use

- Packaging a repeatable, multi-step workflow into an on-demand capability
- Bundling scripts, templates, or reference docs alongside instructions
- Building a skill that other agents or users can invoke via `/` slash commands
- Improving an existing skill's description, structure, or procedures

## Decision: Is a Skill the Right Primitive?

Before creating a skill, confirm it's the right choice:

| Need | Right Primitive |
|------|----------------|
| Always-on guidance for every interaction | **Workspace Instructions** (`copilot-instructions.md`) |
| Guidance scoped to specific file types | **File Instructions** (`*.instructions.md` with `applyTo`) |
| Single focused task with parameterized inputs | **Prompt** (`*.prompt.md`) |
| Multi-step workflow with bundled assets | **Skill** ← you are here |
| Context isolation or different tool restrictions per stage | **Custom Agent** (`*.agent.md`) |

**Key differentiator:** Skills are *on-demand workflows with bundled resources*. If there are no procedures, scripts, or reference docs to bundle, a prompt or instruction is simpler.

## Procedure

### Step 1 — Define the Skill's Purpose

Identify:
- **What** the skill accomplishes (the outcome)
- **When** it should be triggered (specific keywords, scenarios)
- **What resources** it needs (scripts, templates, reference docs)

### Step 2 — Choose a Location

| Path | Scope | Use When |
|------|-------|----------|
| `.github/skills/<name>/` | Project, team-shared | Default for most project skills |
| `.agents/skills/<name>/` | Project, team-shared | Alternative convention |
| `~/.copilot/skills/<name>/` | Personal, all workspaces | Personal workflow you use everywhere |

### Step 3 — Create the Folder Structure

```
.github/skills/<skill-name>/
├── SKILL.md           # Required — instructions and procedures
├── scripts/           # Optional — executable code the skill invokes
├── references/        # Optional — docs loaded on demand
└── assets/            # Optional — templates, boilerplate, examples
```

The folder name **must** match the `name` field in SKILL.md frontmatter.

### Step 4 — Write the Frontmatter

```yaml
---
name: my-skill-name
description: 'Concise, keyword-rich description. Max 1024 chars.'
argument-hint: 'Optional hint shown when user types /my-skill-name'
---
```

**Required fields:**
- `name` — 1-64 chars, lowercase alphanumeric + hyphens, must match folder name
- `description` — The discovery surface. This is how the agent decides whether to load the skill

**Optional fields:**
- `argument-hint` — Shown in the slash command UI to guide user input
- `user-invocable: false` — Hide from slash commands (still auto-loaded by model)
- `disable-model-invocation: true` — Only manual `/` invocation, never auto-loaded

### Step 5 — Write the Description

The description is the single most important field. It controls whether the agent discovers and loads the skill.

**Rules:**
1. **Lead with the category** — Start with a bold tag like `**WORKFLOW SKILL**` or `**DOMAIN SKILL**`
2. **Include trigger keywords** — Every word a user might say to invoke this skill should appear in the description
3. **Use USE FOR / DO NOT USE FOR** — Explicit inclusion/exclusion prevents false matches
4. **Stay under 1024 characters** — That's the hard limit
5. **Quote the value** — Descriptions with colons must be wrapped in quotes to avoid YAML parse failures

**Template:**
```
'**CATEGORY SKILL** — One-sentence summary. USE FOR: keyword1; keyword2; keyword3. DO NOT USE FOR: anti-keyword1; anti-keyword2.'
```

**Bad example:**
```
'A helpful skill for testing things'
```

**Good example:**
```
'**WORKFLOW SKILL** — Run end-to-end tests for React components using Playwright. USE FOR: UI testing; screenshot comparison; accessibility checks; form validation tests. DO NOT USE FOR: unit tests (use Jest directly); API tests (use the api-testing skill).'
```

### Step 6 — Write the Body

Structure the SKILL.md body with these sections:

1. **Title** — `# Skill Name` (matches the purpose)
2. **When to Use** — Bullet list of trigger scenarios
3. **Procedure** — Numbered, step-by-step instructions the agent follows
4. **References** — Links to bundled resources using relative paths (`./references/`, `./scripts/`)

**Body guidelines:**
- Keep SKILL.md under 500 lines total
- Use progressive loading: put detailed docs in `./references/` and link to them
- Write procedures as imperative instructions the agent can execute
- Include decision points ("If X, do Y; otherwise do Z")
- Reference scripts and assets with relative paths: `[validation script](./scripts/validate.sh)`

### Step 7 — Add Supporting Resources (Optional)

If the skill needs bundled assets:

- **`scripts/`** — Executable code the agent runs (test runners, validators, generators)
- **`references/`** — Detailed documentation loaded only when needed (keeps SKILL.md lean)
- **`assets/`** — Templates, boilerplate files, example configs

Keep file references one level deep from SKILL.md for progressive loading.

### Step 8 — Validate

Run through this checklist:

- [ ] Folder name matches `name` field exactly
- [ ] Description is under 1024 characters
- [ ] Description contains trigger keywords users would actually say
- [ ] YAML frontmatter has no unescaped colons, no tabs, uses `---` delimiters
- [ ] Procedures are step-by-step and imperative
- [ ] All resource references use relative `./` paths
- [ ] SKILL.md is under 500 lines
- [ ] Skill is self-contained — includes all knowledge needed to complete the task

## Anti-Patterns to Avoid

| Anti-Pattern | Why It's Bad | Fix |
|---|---|---|
| Vague description | Agent can't discover the skill | Add specific trigger keywords and USE FOR clauses |
| Monolithic SKILL.md | Burns context window on every load | Split into `./references/` files, link from body |
| Name mismatch | Skill silently fails to load | Ensure folder name === `name` field |
| Missing procedures | Agent doesn't know what to do | Add numbered step-by-step instructions |
| No decision guidance | Skill gets used when it shouldn't | Add "When to Use" and "DO NOT USE FOR" sections |
| Unquoted colons in description | YAML parse failure, silent error | Always wrap description in single quotes |
| `applyTo: "**"` on instructions | Loads into every interaction | Use specific globs — but note: skills don't use `applyTo` |

## Progressive Loading Design

Skills load in three stages — design for this:

1. **Discovery** (~100 tokens) — Agent reads only `name` and `description` from frontmatter
2. **Instructions** (<5000 tokens) — Agent loads the full SKILL.md body when the skill is relevant
3. **Resources** (variable) — Additional files in `scripts/`, `references/`, `assets/` load only when explicitly referenced

**Implication:** Put the critical "what to do" in SKILL.md. Put the detailed "how exactly" in reference files.

## Example: Complete Skill

```
.github/skills/api-testing/
├── SKILL.md
├── scripts/
│   └── run-tests.sh
├── references/
│   └── assertion-patterns.md
└── assets/
    └── test-template.ts
```

```markdown
---
name: api-testing
description: '**WORKFLOW SKILL** — Test REST APIs with automated validation. USE FOR: endpoint testing; response validation; auth flow testing; status code checks. DO NOT USE FOR: UI testing (use playwright-testing skill); load testing (use k6 directly).'
argument-hint: 'Describe the API endpoint or flow to test'
---

# API Testing

## When to Use
- Validating REST API endpoints
- Testing authentication flows
- Checking response schemas and status codes

## Procedure
1. Identify the target endpoint and expected behavior
2. Generate test file from [template](./assets/test-template.ts)
3. Run tests with [test runner](./scripts/run-tests.sh)
4. Validate responses using [assertion patterns](./references/assertion-patterns.md)
5. Report results with pass/fail summary
```
