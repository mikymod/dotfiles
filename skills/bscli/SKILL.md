---
name: bscli
description: BookStack wiki CLI (bscli) for searching, reading, creating, updating, and deleting pages, listing books/chapters/shelves, browsing book trees, and uploading attachments. Use when the user mentions BookStack, the wiki, or bscli.
---

# bscli — BookStack CLI

`bscli` is a dependency-free Python 3 CLI for the [BookStack](https://bookstackapp.com) REST API
(shipped in this skill directory as `bscli`). Search, read, create, update, move, delete content;
browse books; upload attachments; or call any endpoint raw.

## Setup

Config lookup order (first match wins): `$BSCLI_CONFIG`, `$XDG_CONFIG_HOME/bscli/config.rc`,
`~/.config/bscli/config.rc`. Env vars `BOOKSTACK_URL`, `BOOKSTACK_TOKEN_ID`, `BOOKSTACK_TOKEN_SECRET`
override it.

```ini
# ~/.config/bscli/config.rc
[bookstack]
url = https://wiki.example.com
token_id = XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX
token_secret = YYYYYYYY...
```

The token pair is created in the BookStack web UI: **profile icon → Edit Profile → API Tokens**
(admin must enable API access). Never paste tokens into chat logs unnecessarily; if config is
missing, ask the user to create the file themselves or have them provide the values.

Run it as `python3 <skill-dir>/bscli` (or symlink it into `~/bin/bscli`).

## Commands

```bash
bscli search "kubernetes ingress"          # full-text search across all content
bscli search 'book:Networking tag:dns'     # BookStack search syntax works (--count N)
bscli ls book|chapter|page|bookshelf [--name regex] [--count N] [--offset N] [--sort name]
bscli tree "My Book"                       # chapters + pages of a book (id or name)
bscli show page 42                         # full metadata JSON of one item
bscli read 42 [--format markdown|html|plaintext]   # page content (markdown if the page uses it)
bscli create --name "Title" --book "My Book" --file note.md --markdown
bscli create --name "Title" --chapter 7 --stdin --markdown --tag ops --changelog "added"
bscli update 42 --file note.md --markdown  # replace content; --name to rename
bscli mv 42 --book "Other Book"            # move page to another book
bscli rm page 42 | rm book 3 | rm chapter 9 | rm bookshelf 2   # -> recycle bin
bscli attach --page 42 ./report.pdf [--name "Q3 report"]
bscli users
bscli raw GET search 'query=foo'           # any endpoint, query params as k=v
bscli --json ls page                       # raw JSON on any command
```

## Notes for agents

- `create`/`update` send `html` by default; pass `--markdown` when the content is Markdown.
  BookStack stores both; `read` fails gracefully with a hint if a page has no markdown.
- `--book`/`--chapter` accept a numeric id or a name (exact-ish filter match; ambiguous names error
  with the match count — then use the id).
- `rm` is a soft delete (recycle bin) but has **no confirmation prompt**.
- Search supports BookStack's term syntax: `tag:foo`, `book:Name`, `page:Name`, `-term`, `"exact"`.
- Updates replace the whole body; there is no patching. Read first (`bscli read`), edit, write back.
- Rate limit is 180 requests/minute/user; plain HTTP errors are reported as `bscli: HTTP <code>: <msg>`.
- Full endpoint reference: any instance serves its own live docs at `<url>/api/docs` (HTML) and
  `<url>/api/docs.json` (JSON, needs the token).
