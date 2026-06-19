# CodeGraph reference

[CodeGraph](https://github.com/colbymchenry/codegraph) is a local, tree-sitter–parsed knowledge graph exposed to agents via MCP.

## Claude Code (included with class-ai-agent)

| Item | Path |
|------|------|
| Usage rules | `.claude/rules/codegraph.md` |
| Index (generated) | `.codegraph/` (gitignored) |

1. Install CodeGraph for Claude Code globally (see below).
2. Confirm CodeGraph MCP is available in Claude Code.
3. Use `codegraph_*` tools for structural questions; grep/read for literal text.

**Global install** (project scaffolding does not add Claude MCP config):

```bash
npx @colbymchenry/codegraph
# or: npm i -g @colbymchenry/codegraph
codegraph install --target=claude --yes
```

**Manual index:** `codegraph init -i` (class-ai-agent may run this on install)

## Cursor (via class-ai-agent)

- `.cursor/mcp.json` — CodeGraph MCP server
- `.cursor/rules/codegraph.mdc` — when to use `codegraph_*` tools

Reload Cursor after install. See `.cursor/references/codegraph.md`.

## Kiro (via class-ai-agent)

- `.kiro/settings/mcp.json` — CodeGraph MCP server
- `.kiro/steering/codegraph.md` — when to use `codegraph_*` tools

Restart Kiro after install. See `.kiro/references/codegraph.md`.

## Requirements

- **Node 20+** recommended for CodeGraph (class-ai-agent CLI itself supports Node 16.7+).
- Index data lives in `.codegraph/` — add to `.gitignore` (class-ai-agent does this automatically).

## Tool parameters

| Tool | Pass | Not |
|------|------|-----|
| `codegraph_search` | `query`, optional `limit` | — |
| `codegraph_context` | **`task`** (natural-language area), optional **`maxNodes`** | `query`, `limit` |

**Session handoff** (`/resume`, `.agent/SESSION.md`) is not a CodeGraph call — read those files with the editor Read tool.

## Troubleshooting

| Issue | Action |
|-------|--------|
| `task must be a non-empty string` | Use `task` (not `query`) on `codegraph_context`; use `maxNodes` (not `limit`). For `/resume`, read `.agent/SESSION.md` instead. |
| MCP "not initialized" | Run `npx @colbymchenry/codegraph init -i` in project root |
| Stale symbols after edit | Wait ~2s for watcher sync, or check staleness banner in tool output |

See [CodeGraph README](https://github.com/colbymchenry/codegraph) for full troubleshooting.
