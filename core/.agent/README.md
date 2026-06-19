# Agent continuity and Antigravity rules (`.agent/`)

Committed handoff state so **Cursor**, **Claude Code**, **Kiro**, and **Antigravity** agents can continue the same work without re-discovering context.

## Files

| File / folder | Purpose |
|---------------|---------|
| **`SESSION.md`** | Live handoff — read at session start, update at session end |
| **`SESSION.template.md`** | Schema reference (do not edit for handoff; copy to `SESSION.md` on fresh install) |
| **`rules/`** | Antigravity supplement rules (synced from `.cursor/rules/`; see `GEMINI.md`) |
| **`history/`** | _(optional)_ milestone snapshots, e.g. `2025-06-02-feature-x.md` |

## Workflow

1. **Start** — Run `/resume` (or read `SESSION.md` first). Then `tasks/todo.md`, then linked `SPEC.md`.
2. **Work** — Follow your tool's hub (`.cursor/`, `.claude/`, `.kiro/`, or `GEMINI.md` / `/build`, etc.).
3. **End** — Run `/handoff` to refresh `SESSION.md` before closing the chat or switching tools.

## What to put in `SESSION.md`

- Goal, done / in progress / next steps
- Decisions and gotchas the next agent must know
- Pointers to spec, tasks, branch, key files

## What NOT to put here

- API keys, passwords, tokens, or credentials
- PII or customer data
- Long logs (link to issues or commits instead)

## Commit to git

`SESSION.md` is meant to be **committed** so the whole team and any IDE can resume. Keep it concise and current.

## Antigravity note

Antigravity also reads **`.agent/rules/*.md`** as supplement rules (after `AGENTS.md` and `GEMINI.md`). Workflows and skills live in **`.agents/`** — see **`GEMINI.md`**.
