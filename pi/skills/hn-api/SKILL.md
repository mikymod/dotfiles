---
name: hn-api
description: Query the Hacker News APIs (official Firebase + Algolia search) to fetch stories, comments, users, live feeds, and search results.
---

# Hacker News API

Query the two public, read-only Hacker News APIs:

- **Official Firebase API** — near-real-time raw item/user/live data. No rate limit.
  Base: `https://hacker-news.firebaseio.com/v0/`
- **Algolia Search API** — full-text search over ~44M items (powers hn.algolia.com).
  Base: `https://hn.algolia.com/api/v1/`

A helper CLI is provided at `{baseDir}/hn.sh`.

## Setup

The helper needs `curl` and `python3`. No install required.

```bash
chmod +x {baseDir}/hn.sh
```

## Helper CLI — quick reference

```bash
{baseDir}/hn.sh top           # top 10 stories (title, points, comments)
{baseDir}/hn.sh new           # newest stories
{baseDir}/hn.sh best          # best stories
{baseDir}/hn.sh ask           # Ask HN
{baseDir}/hn.sh show          # Show HN
{baseDir}/hn.sh job           # Job posts
{baseDir}/hn.sh item <id>     # one item (story/comment/poll)
{baseDir}/hn.sh user <name>   # user profile (karma, submitted count)
{baseDir}/hn.sh max           # current max item id
{baseDir}/hn.sh search "rust" # Algolia relevance search
{baseDir}/hn.sh search "rust" --tags=story --min-points=100
{baseDir}/hn.sh search "rust" --tags=story --since=24h   # last 24h, newest first
{baseDir}/hn.sh search "rust" --tags=author_<user>       # one user's posts
{baseDir}/hn.sh comments <story-id> # full nested comment thread (Algolia)
```

## Firebase API reference

### Items — `/v0/item/<id>.json`

Stories, comments, jobs, Ask HNs, polls, pollopts are all "items". Key fields:
`id`, `type` (`story|comment|job|poll|pollopt`), `by`, `time` (Unix), `score`,
`kids` (child comment ids), `descendants` (comment count), `title`, `text` (HTML),
`url`, `parent`, `parts`, `deleted`, `dead`.

Gotcha: `descendants` ≠ exact tree size — traverse `kids` to count comments.

### Users — `/v0/user/<username>.json`

Fields: `id` (case-sensitive), `created` (Unix), `karma`, `about` (HTML),
`submitted` (ids). Only active users are exposed.

### Live endpoints

| Endpoint | Content |
|----------|---------|
| `/v0/maxitem` | largest item id — walk backwards to enumerate all items |
| `/v0/topstories` `/v0/newstories` `/v0/beststories` | 500 ids (top includes jobs) |
| `/v0/askstories` `/v0/showstories` `/v0/jobstories` | 200 ids each |
| `/v0/updates` | changed `items` (ids) + `profiles` (names) since last poll |

**Live pattern:** poll `maxitem` + `updates` to discover new/changed items, then fetch them. Firebase supports streaming change notifications instead of polling.

## Algolia reference

### Endpoints

| Endpoint | Purpose |
|----------|---------|
| `/api/v1/search` | relevance-sorted search |
| `/api/v1/search_by_date` | chronological search (newest first) |
| `/api/v1/items/<id>` | item + full nested comment tree |
| `/api/v1/users?query=<u>` | user profile lookup |

Only these four exist — `/pools`, `/comments`, `/users` return 404.

### Parameters

- `query` — full-text search
- `tags` — `story`, `comment`, `poll`, `author_<user>`, `story_<id>`, `front_page`; combinable: `tags=story,author_dhouston`
- `numericFilters` — `points>100`, `created_at_i>TIMESTAMP`
- `hitsPerPage`, `page` — pagination

### Filtering examples (verified)

```text
/api/v1/search?query=rust&tags=story&numericFilters=points>100
/api/v1/search?tags=author_jl
/api/v1/search?tags=front_page
/api/v1/search_by_date?tags=story&numericFilters=created_at_i>UNIX_TS
/api/v1/search?tags=comment
```

Gotchas:
- `dateRange` / `createdAt` params do **not** work — use `numericFilters=created_at_i>TIMESTAMP`.
- No user-search endpoint — use `tags=author_<username>`.
- Algolia lags slightly behind Firebase for brand-new content; Firebase is the source of truth for freshness.

## Rules

- Both APIs are **read-only** — nothing posts, comments, or votes.
- Firebase has no official rate limit; still poll `maxitem`/`updates` cheaply.
- `text`, `title`, `about` fields are **HTML** — strip tags for plain text.
- Versioning: only field removal/alteration is breaking — tolerate extra fields.
- When the user wants the full API spec details, reference:
  `{baseDir}/../../research/hacker-news-api.md` (the research writeup).
