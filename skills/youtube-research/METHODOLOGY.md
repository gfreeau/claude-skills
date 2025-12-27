# Podcast Summary Methodology

A replicable process for creating high-fidelity podcast summaries from YouTube transcripts.

Use this methodology when the user asks to **summarize a podcast** or **extract a specific topic** from a video. The goal is that reading the document equals listening to the podcast for that topic.

---

## Identifying Scope

### Full podcast summary
- Process the entire transcript
- Identify the major themes/topics discussed (let the content dictate how many)

### Topic-specific extraction
- User provides a starting quote, timestamp reference, or topic description
- Search the transcript for that quote to find the starting point
- Extract from that point to a logical ending point

---

## Document Structure

```markdown
# [Topic]: Insights from [Speaker Name] ([Role], [Company])

**Source:** [Podcast/session name] with [speaker], hosted by [host]
**Context:** [Brief context on speaker's credentials and why they're authoritative]

---

## [First Major Theme]

[Brief setup paragraph if needed]

> "Direct quote from transcript"

[Explanation or context for the quote]

> "Another supporting quote"

---

## [Second Major Theme]

[Continue pattern...]

---

## Summary: [Checklist or Key Takeaways]

1. **[Point]:** [One-line explanation]
2. **[Point]:** [One-line explanation]
...
```

---

## Formatting Rules

1. **Quotes**: Use blockquotes (`>`) for direct quotes. Preserve exact words with light cleanup only (remove "um", "uh", "like" filler words, fix obvious transcription errors).

2. **Attribution**: When the interviewer/host makes a valuable observation (not just asking a question), include it with attribution: "James Cameron (interviewer) observes..."

3. **Headers**: Use H2 (`##`) for major themes. Keep them descriptive but concise.

4. **Context paragraphs**: Add brief setup before quotes when the quote alone wouldn't make sense. Keep these minimal.

5. **Subheadings**: Use H3 (`###`) for subtopics within a theme.

6. **Bold labels**: Use `**Label:**` to introduce ideas before quotes or explanations. Examples:
   - `**Core principle:**` followed by explanation
   - `**Red flag:**` or `**Green flags:**` for evaluation criteria
   - `**Why this works:**` before a list of reasons

   This creates scannable structure without requiring a full subheading.

7. **Lists**: Use for tactical/actionable items, specific recommendations, or checklists.

8. **Concrete credentials**: When describing speaker authority, include specific numbers where available (e.g., "$100M+ ARR", "scaled team from 10 to 1,000").

9. **No detail loss**: Include all substantive points, not just highlights.

---

## Quality Checklist

Before finalizing, verify:

- [ ] All speakers identified with name and role
- [ ] Context paragraph explains why this person is worth listening to
- [ ] Every major point has at least one direct quote
- [ ] Quotes are accurate to the transcript (not paraphrased)
- [ ] Logical flow from theme to theme
- [ ] Summary section captures actionable takeaways
- [ ] Someone unfamiliar with the podcast could understand everything

---

## Example: Topic-Specific Extraction

**User request:** "I want to understand US market entry. Around 36 minutes in, Stevie says 'the right time is when there is opportunity for your product'—start from there."

**Process:**
1. Search transcript for the quote to find starting line
2. Read from that point to identify where US entry discussion ends
3. Extract all content within that range
4. Organize into themes (timing, location, tactics, hiring, etc.)
5. Pull direct quotes for each theme
6. Add context where quotes need setup
7. End with summary checklist

---

## Example: Full Podcast Summary

**User request:** "Summarize this entire podcast."

**Process:**
1. Read full transcript
2. Identify the major themes/topics discussed
3. For each theme, extract key quotes and insights
4. Note any interviewer contributions worth preserving
5. Create one H2 section per major theme
6. End with comprehensive summary

---

## Output Naming Convention

- Full summary: `./VIDEO_ID_title-slug_summary.md`
- Topic-specific: `./VIDEO_ID_title-slug_topic.md`

Examples:
- `rmvDxxNubIg_building-agents-at-scale_summary.md`
- `1wxBY7m6zfI_startup-growth-tactics_us-market-entry.md`
