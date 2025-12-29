# Claude Skills & Agents

Personal Claude Code skills and agents for extending Claude's capabilities across all projects.

## Installation

```bash
./install.sh
```

This symlinks skills to `~/.claude/skills/` and agents to `~/.claude/agents/`.

To uninstall:
```bash
./install.sh --remove
```

Restart Claude Code after installing for changes to take effect.

## Skills

### youtube-research

Research topics using YouTube video and podcast content.

**Requires:** yt-dlp
```bash
pipx install yt-dlp
```

Two modes:

1. **Conversational research**: Bring expert opinions into engineering planning
   ```
   "What does this talk recommend for retry logic? https://youtube.com/watch?v=..."
   ```

2. **Structured summarization**: Create detailed summaries following a consistent methodology
   ```
   "Summarize this podcast: https://youtube.com/watch?v=..."
   ```

## Agents

### docs-research

Subagent that fetches up-to-date technical documentation via context7 MCP, keeping the main context clean.

**Requires:** context7 MCP + API key

1. Get an API key from [context7.com](https://context7.com)

2. Add the MCP globally:
   ```bash
   claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp --api-key YOUR_CONTEXT7_API_KEY
   ```

3. Add this to `~/.claude/CLAUDE.md`:
   ```markdown
   ## MCP versus agent use preferences

   Never use mcp__context7__* tools directly. Always use the docs-research subagent for documentation lookups.
   ```

**Why the CLAUDE.md config?** Claude Code doesn't yet support scoping MCPs to specific agents ([#6915](https://github.com/anthropics/claude-code/issues/6915), [#6587](https://github.com/anthropics/claude-code/issues/6587)). Without this instruction, Claude calls context7 directly which pollutes the main context. When agent-scoped MCPs ship, this workaround won't be needed.

Examples:
- "How do I create a tool in the Claude Agent SDK?"
- "Show me the React Query mutation documentation"
- "What's the streaming API for Anthropic SDK in TypeScript?"

## Structure

```
claude-skills/
├── install.sh              # Symlink installer
├── README.md
├── skills/
│   └── youtube-research/
│       ├── SKILL.md        # Main skill definition
│       └── METHODOLOGY.md  # Summarization methodology
└── agents/
    └── docs-research.md    # Subagent that fetches docs via context7
```
