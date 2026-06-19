# CodeGraph reference

[CodeGraph](https://github.com/colbymchenry/codegraph) is a local, tree-sitter–parsed knowledge graph exposed to agents via MCP. **class-ai-agent** installs Cursor and Kiro MCP wiring plus usage rules, and runs `codegraph init -i` after scaffolding.

## Cursor (included with class-ai-agent)

| Item | Path |
|------|------|
| MCP config | `.cursor/mcp.json` |
| Usage rules | `.cursor/rules/codegraph.mdc` |
| Index (generated) | `.codegraph/` (gitignored) |

1. Reload the Cursor window after install so MCP connects.
2. Confirm **CodeGraph** appears under MCP in Cursor settings.
3. Use `codegraph_*` tools for structural questions; grep/read for literal text.

**Manual index:** `npx @colbymchenry/codegraph init -i`

**Skip auto-index on install:** `CODEGRAPH_SKIP_INIT=1 npx class-ai-agent`

## Kiro (included with class-ai-agent)

| Item | Path |
|------|------|
| MCP config | `.kiro/settings/mcp.json` |
| Usage rules | `.kiro/steering/codegraph.md` |
| Index (generated) | `.codegraph/` (gitignored) |

1. Restart Kiro after install so MCP connects.
2. Confirm **CodeGraph** under MCP in Kiro IDE or CLI settings.
3. Use `codegraph_*` tools for structural questions.

See `.kiro/references/codegraph.md` for full notes.

## Claude Code

Project scaffolding does **not** add Claude MCP config. Install CodeGraph globally for Claude Code:

```bash
npx @colbymchenry/codegraph
# or: npm i -g @colbymchenry/codegraph
codegraph install --target=claude --yes
```

Then in each project: `codegraph init -i` (or rely on class-ai-agent’s post-install init for the shared `.codegraph/` index).

See the [CodeGraph README](https://github.com/colbymchenry/codegraph) for tools, troubleshooting, and benchmarks.

## Requirements

- **Node 20+** recommended for CodeGraph (class-ai-agent CLI itself supports Node 16.7+).
- First index can take a minute on large repos; progress prints during `npx class-ai-agent` install.

## Tool parameters

| Tool | Pass | Not |
|------|------|-----|
| `codegraph_search` | `query`, optional `limit` | — |
| `codegraph_context` | **`task`** (natural-language area), optional **`maxNodes`** | `query`, `limit` |

Example — wrong (search-style args on context):

```json
{ "query": "auth flow", "limit": 15 }
```

→ `Error: task must be a non-empty string`

Example — correct:

```json
{ "task": "how authentication flow works", "maxNodes": 15 }
```

**Session handoff** (`/resume`, `.agent/SESSION.md`) is not a CodeGraph call — read those files with the editor Read tool.

## Troubleshooting

| Issue | Action |
|-------|--------|
| `task must be a non-empty string` | Use `task` (not `query`) on `codegraph_context`; use `maxNodes` (not `limit`). For `/resume`, read `.agent/SESSION.md` instead. |
| MCP “not initialized” | Run `npx @colbymchenry/codegraph init -i` in project root |
| MCP not connecting | Reload Cursor; verify `.cursor/mcp.json`; test `npx @colbymchenry/codegraph serve --mcp` |
| Stale symbols after edit | Wait ~2s for watcher sync, or check staleness banner in tool output |
| Init failed during install | Run `npx @colbymchenry/codegraph init -i` manually |

Upstream: [colbymchenry/codegraph](https://github.com/colbymchenry/codegraph)
