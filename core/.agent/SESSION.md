# Agent session

> Cross-tool handoff state for Cursor, Claude Code, and Kiro. Update at session end (`/handoff`) or phase changes; read at session start (`/resume`).

## Meta

| Field | Value |
|-------|-------|
| **Updated** | 2026-06-17 |
| **Phase** | review |
| **Tool** | cursor |
| **Persona** | _(maintainer)_ |

## Goal

Maintain and ship **class-ai-agent** — production-grade AI agent scaffolding for Cursor, Claude Code, and Kiro — including agent continuity (`.agent/SESSION.md`, `/resume`, `/handoff`), CodeGraph usage rules, and vendored Supabase skills.

## Done

- Shipped **1.4.0** — Supabase Agent Skills, Supabase MCP, `npm run sync:supabase-skills`, `THIRD_PARTY_NOTICES.md` (see `README.md` release notes).
- Shipped **1.3.0** — Kiro support (`npm run sync:kiro`), CodeGraph rules/MCP, agent continuity commands, UI/UX Pro Max skill.
- Documented `codegraph_context` (`task`/`maxNodes`) vs `codegraph_search` (`query`/`limit`) in `.cursor/rules/codegraph.mdc` and synced `.kiro/` steering.
- Clarified agent-continuity: resume handoff = Read `SESSION.md`, not CodeGraph.
- Restored `.agent/SESSION.md` after accidental local deletion.
- Verified `npm run test:cli` passes on `main`.

## In progress

- _(none)_
- **Blockers:** none

## Next

1. Commit restored `SESSION.md` if the team wants handoff state in git.
2. Run `npm run test:cli` before any npm publish.
3. After `.cursor/` edits, run `npm run sync:all`; after Supabase upstream changes, run `npm run sync:supabase-skills`.
4. Run `/handoff` at each meaningful session end.

## Decisions

- Session resume uses **`.agent/SESSION.md` + `/resume`**, not `codegraph_context`.
- `codegraph_context` requires **`task`**; `codegraph_search` requires **`query`**.
- **Commit** `SESSION.md` for this repo when it reflects real team state; installer seeds from `SESSION.template.md` and does not overwrite existing `SESSION.md` unless `--force`.

## Gotchas

- Calling `codegraph_context` with `{ "query": "...", "limit": 15 }` → `task must be a non-empty string`.
- CodeGraph MCP may need `projectPath` if workspace root is not detected.
- CLI smoke test: `npm run test:cli`
- `npx class-ai-agent` runs CodeGraph init by default; set `CODEGRAPH_SKIP_INIT=1` to skip.

## Pointers

| Item | Location |
|------|----------|
| Spec | _(none — package maintenance)_ |
| Tasks | _(no `tasks/todo.md` yet)_ |
| Branch | `main` |
| Key files | `package.json`, `bin/class-ai-agent.cjs`, `.cursor/commands/resume.md`, `.cursor/commands/handoff.md`, `.cursor/rules/agent-continuity.mdc`, `.cursor/rules/codegraph.mdc`, `scripts/sync-kiro-from-cursor.mjs`, `scripts/sync-supabase-skills.mjs` |
