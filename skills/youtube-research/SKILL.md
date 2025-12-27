---
name: youtube-research
description: Research topics using YouTube video and podcast content. Use when user provides YouTube URLs and wants to (1) bring expert opinions into engineering planning discussions, (2) create structured podcast summaries, or (3) extract specific topics from longer podcasts. Handles transcript fetching, cleaning, and analysis.
allowed-tools: Bash(yt-dlp:*), Read, Write, Glob, Grep
---

# YouTube Research

Fetch, clean, and analyze YouTube video/podcast transcripts for engineering planning and knowledge extraction.

## When This Skill Applies

- User provides YouTube URL(s) with a question or request
- User wants expert opinions from talks/podcasts to inform engineering decisions
- User asks for podcast summaries or topic extraction
- User references "that video" or "that podcast" with a URL

## Two Modes of Operation

### Mode 1: Conversational Research

**Trigger**: User asks a question alongside YouTube URL(s)

Examples:
- "What does this talk say about retry logic? [url]"
- "I'm designing auth - here are two talks on the topic [url1] [url2]. What patterns do they recommend?"

**Behavior**:
1. Fetch and clean transcript(s) to temp directory
2. Read the content into context
3. Answer the user's question directly
4. Support follow-up questions naturally

The transcript becomes context for the conversation, not the output.

### Mode 2: Structured Summarization

**Trigger**: User asks to summarize or extract from a podcast

Examples:
- "Summarize this podcast"
- "Extract the section about US market entry from this video"
- "Create a summary of what they discuss about hiring"

**Behavior**:
1. Fetch and clean transcript to temp directory
2. Follow the methodology in `METHODOLOGY.md`
3. Produce a structured markdown document
4. Save summary to current working directory

---

## Working Directory Structure

Use `/tmp/yt-transcripts/` for intermediate files to avoid littering the user's directory.

```bash
mkdir -p /tmp/yt-transcripts
```

| File Type | Location |
|-----------|----------|
| Raw VTT | `/tmp/yt-transcripts/VIDEO_ID.en.vtt` |
| Cleaned transcript | `/tmp/yt-transcripts/VIDEO_ID_clean.txt` |
| Final summary | `./VIDEO_ID_title-slug_summary.md` |

---

## Transcript Fetching Process

### Step 1: Download VTT subtitles

```bash
mkdir -p /tmp/yt-transcripts
yt-dlp --write-auto-sub --sub-lang en --sub-format vtt --skip-download \
  -o "/tmp/yt-transcripts/VIDEO_ID" "YOUTUBE_URL"
```

This creates `/tmp/yt-transcripts/VIDEO_ID.en.vtt`.

If `en` fails, try `en-orig` or check available subtitles:
```bash
yt-dlp --list-subs "YOUTUBE_URL"
```

### Step 2: Clean the VTT file

Remove timestamps, metadata, HTML tags, and duplicate lines:

```bash
grep -v -E '^WEBVTT|^Kind:|^Language:|^$|^[0-9]{2}:[0-9]{2}:[0-9]{2}|-->' \
  /tmp/yt-transcripts/VIDEO_ID.en.vtt \
  | sed 's/<[^>]*>//g' \
  | awk '!seen[$0]++' \
  > /tmp/yt-transcripts/VIDEO_ID_clean.txt
```

### Step 3: Read the cleaned transcript

Read the full transcript to understand:
- Who is speaking (identify from intro/context)
- Structure of the conversation
- Key topics covered

---

## Troubleshooting

**yt-dlp errors**: The tool updates frequently to keep up with YouTube changes. If downloads fail, first try upgrading:
```bash
pipx upgrade yt-dlp
```

**No subtitles found**:
- Video may have captions disabled by the uploader
- Try `--sub-lang en-orig` for original English
- Some videos only have auto-generated captions in other languages

**Poor transcript quality**:
- Auto-captions struggle with accents, technical jargon, and multiple speakers
- May need manual correction for accuracy-critical work

---

## Output Naming Convention

Extract VIDEO_ID from YouTube URL (the part after `v=`) and fetch the video title:

```bash
yt-dlp --print title "YOUTUBE_URL"
```

Slugify the title (lowercase, hyphens for spaces, remove special characters).

- Full summary: `./VIDEO_ID_title-slug_summary.md`
- Topic-specific: `./VIDEO_ID_title-slug_topic.md`

Examples:
- `rmvDxxNubIg_building-agents-at-scale_summary.md`
- `1wxBY7m6zfI_startup-growth-tactics_us-market-entry.md`
