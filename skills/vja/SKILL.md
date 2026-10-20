---
name: vja
description: Vikunja task manager CLI (vja) for adding, listing, editing, completing, deferring, and deleting tasks, plus managing projects, labels, and kanban buckets. Use when managing Vikunja tasks or when the user mentions vja or Vikunja.
---

# vja — Vikunja CLI

`vja` is a Python CLI for [Vikunja](https://vikunja.io), the open-source todo app. It adds, lists,
edits, completes, defers, clones, and deletes tasks, manages projects, labels, and kanban buckets,
and emits JSON for scripting.

**vja >= 6.0.0 requires Vikunja server >= 2.5.0 with `api_url` ending in `/api/v2`.**

## Installation

```bash
pipx install vja                    # recommended
python -m pip install --user vja    # alternative
```

## Configuration

Config lookup order (first match wins):

1. `$VJA_CONFIGDIR/config.rc`
2. `$XDG_CONFIG_HOME/vja/config.rc`
3. `$HOME/.config/vja/config.rc`
4. `$HOME/.vjacli/vja.rc` (deprecated legacy path)

Minimal `config.rc`:

```ini
[application]
frontend_url=https://my.domain/
api_url=https://my.domain/api/v2
```

### Authentication

On first run vja prompts interactively for username/password (plus TOTP if enabled on the server)
and stores the token in `token.json` next to `config.rc`. Ask the user to run `vja ls` once to log
in; avoid passing credentials via `-u`/`-p`/`-t` yourself.

Non-interactive alternative — create `token.json` next to `config.rc`:

```json
{ "token": "YOUR-API-TOKEN" }
```

The API token needs at least Labels, Projects, Tasks, User, and relation permissions.

## Tasks

Short form (`vja add`) and explicit form (`vja task add`) are equivalent.

### Add

```bash
vja add "Buy milk" -o 1 -p 3 -d "tomorrow 11:00" -r -l @work -n "note" -f
```

Options: `-o/--project` (id or title-regex; defaults to user setting then first favorite project),
`-n/--note`, `-p/--priority`, `-d/--due`, `--start`, `--end`, `-f/--favorite`, `-l/--label`
(repeatable), `-A/--assignee` (username), `-r/--reminder`, `--force-create` (create missing
labels), `-q` quiet / `-v` verbose.

### List

```bash
vja ls                # active tasks; default sort: done, -urgency, due_date, -priority, project.title, title
vja ls --all          # include completed tasks
vja ls 10 13          # only the given task ids
vja ls --jsonvja      # machine-readable output (see Output)
```

Filters can be combined (logical AND):

| Flag | Meaning |
|---|---|
| `-o/--project <id\|regex>` | project |
| `-t/--base-project <id\|regex>` | ancestor project |
| `-l/--label <id\|regex>` | label |
| `-i/--title <regex>` | title |
| `-d/--due "<op> <value>"` | due date |
| `-p/--priority "<op> <value>"` | priority |
| `-f/--favorite True` | favorite flag |
| `-u <n>` / `--urgency <n>` | minimum urgency |
| `-b/--bucket <id>` | kanban bucket |
| `--filter "<field> <op> <value>"` | general filter, repeatable |

Operators: `eq`, `ne`, `gt`, `lt`, `ge`, `le`, `before`, `after`, `contains`.

```bash
vja ls --due-date="ge in 0 days" --due-date="before 5 days"
vja ls --filter="created after 2 days ago" --project=1
vja ls --filter="labels ne @work" --urgent
vja ls --sort='-urgency,due_date'          # prefix - for reverse order
```

### Show

```bash
vja show 1 2 3        # details; add --json / --jsonvja for JSON
```

### Edit / complete / defer / clone

```bash
vja edit 1 --title="new title" --due="friday" -p 1 --star
vja edit 1 --done="true"        # mark completed
vja check 1                     # toggle done (aliases: toggle, click, done)
vja defer 1 1d                  # push due_date and reminders ahead by a timedelta
vja clone 1 "Copy of task"
vja edit 1 -l @work             # toggle a single label (--force/--force-create to create it)
vja edit 1 -r "1h before due"   # set first reminder; -r "" removes it; bare -r = due date
```

`vja edit <id>` with no options opens the task in the browser — always pass at least one option.
Batch edits and defers accept multiple ids and have **no confirmation**:
`vja edit 1 5 8 --due="next monday 14:00"`.

### Delete

```bash
vja delete 1 2 3    # permanent, no confirmation
```

### Relations

```bash
vja relation add 1 subtask 2
vja relation remove 1 subtask 2
```

Kinds: `subtask`, `parenttask`, `related`, `duplicateof`, `duplicates`, `blocking`, `blocked`,
`precedes`, `follows`, `copiedfrom`, `copiedto`. The inverse relation is maintained by the server.

## Projects, labels, buckets

```bash
vja project ls
vja project add "New Project" -o "Parent"   # -o parent project (id or title)
vja project show 1
vja project open 1

vja label ls
vja label add "Next action"

vja bucket ls -o 1                # first kanban view of the project (required)
vja bucket add "Doing" -o 1
```

## Other

```bash
vja open [TASK_ID...]   # open task(s) or the Vikunja start page in the browser
vja user show
vja logout              # remove local access token
```

Run `vja <command> --help` for the full option list.

## Dates and reminders

`--due`, `--start`, `--end`, and `--reminder` accept natural-language parsedatetime expressions:
`tomorrow`, `friday`, `in 4 days at 15:00`, `next sunday at 11:00`. Reminders also accept
timedelta expressions relative to the due date: `"1h30m before due_date"`. `vja defer` accepts only
timedeltas (`2d`, `1h30m`).

The `due` **filter** requires an operator: `--due="eq tomorrow"` (a bare `--due=tomorrow` fails).

## Output

- Default: fixed-column text table (`id; priority; favorite; title; due_date; ...; urgency`).
- `--jsonvja`: vja application JSON (stable, recommended for parsing).
- `--json`: raw Vikunja JSON.
- `--custom-format <name>`: template from the `[output]` section of `config.rc`; templates are
  executed with Python `eval()` — only use with configs you trust.

## Notes for agents

- Check `vja --version` first; vja < 6 does not support Vikunja >= 2.5 / `/api/v2`.
- If vja is not configured, guide the user through `config.rc` and a one-time interactive login;
  do not attempt the interactive login yourself.
- Prefer `--jsonvja` and narrow filters over parsing the text table.
- `vja delete`, batch `edit`, and `defer` have no confirmation step.
- Urgency is a weighted blend of due date, priority, favorite flag, and project/label keywords;
  weights and keywords live under `[urgency_coefficients]` / `[urgency_keywords]` in `config.rc`.
- Optional MCP server (shares the same config): `pipx install "vja[mcp]"`, then register `vja-mcp`
  as a stdio MCP server.
