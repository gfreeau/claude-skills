# Claude Skills

Personal Claude Code skills for extending Claude's capabilities across all projects.

## Installation

```bash
./install.sh
```

This symlinks the skills to `~/.claude/skills/` so they're available globally.

To uninstall:
```bash
./install.sh --remove
```

## Prerequisites

- **yt-dlp**: Required for fetching YouTube transcripts
  ```bash
  pipx install yt-dlp
  ```

## Skills

### youtube-research

Research topics using YouTube video and podcast content. Two modes:

1. **Conversational research**: Bring expert opinions into engineering planning
   ```
   "What does this talk recommend for retry logic? https://youtube.com/watch?v=..."
   ```

2. **Structured summarization**: Create detailed summaries following a consistent methodology
   ```
   "Summarize this podcast: https://youtube.com/watch?v=..."
   ```

See `skills/youtube-research/SKILL.md` for full documentation.

## Adding New Skills

1. Create a directory under `skills/` with your skill name
2. Add `SKILL.md` with frontmatter (name, description, allowed-tools)
3. Add any supporting files (methodology docs, templates, etc.)
4. Run `./install.sh` to update symlinks

## Structure

```
claude-skills/
├── install.sh              # Symlink installer
├── README.md
└── skills/
    └── youtube-research/
        ├── SKILL.md        # Main skill definition
        └── METHODOLOGY.md  # Summarization methodology
```
