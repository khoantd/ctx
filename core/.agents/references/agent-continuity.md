# Agent continuity — quick reference

## Files

| Path | Role |
|------|------|
| `.agent/SESSION.md` | Live handoff (commit to git) |
| `.agent/SESSION.template.md` | Schema reference |
| `.agent/README.md` | Human overview |
| `tasks/todo.md` | Task checklist (workflow) |
| `SPEC.md` | Feature spec (workflow) |

## Commands

| Command | When |
|---------|------|
| **`/resume`** | Start of session — read SESSION, summarize, continue |
| **`/handoff`** | End of session — write SESSION, sync tasks |

## Read order (resume)

1. `.agent/SESSION.md`
2. `tasks/todo.md`
3. Linked spec from SESSION Pointers

## Install

```bash
npx class-ai-agent
```

Creates `.agent/` and seeds `SESSION.md` from template.

## Rules

- **Cursor:** `.cursor/rules/agent-continuity.mdc` (`alwaysApply`)
- **Claude:** `.claude/rules/agent-continuity.md`
- **Kiro:** `.kiro/steering/agent-continuity.md` (`inclusion: always`)

## Skill

`.cursor/skills/agent-continuity/SKILL.md` — full handoff/resume checklists.
