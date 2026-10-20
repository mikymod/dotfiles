# Issue tracker: Gitea

Issues and PRDs for this repo live as Gitea issues. Use the [`tea`](https://about.gitea.com/products/tea/) CLI for all operations.

## Conventions

- **Create an issue**: `tea issue create --title "..." --description "..."`. Use a heredoc for multi-line descriptions.
- **Read an issue**: `tea issue <number> --comments` (or `tea issue view <number>` — `tea issue <number>` shows the detail). Filter with `-o json` for machine-readable output.
- **List issues**: `tea issue list --state open -o json` with appropriate `--labels`, `--author`, `--assignee` filters. Fields: `index,title,state,author,milestone,labels,owner,repo` (default) or custom via `--fields`.
- **Comment on an issue**: `tea comment <number> "<body>"` (shorthand) or `tea comment add <number> --description "..."`. Gitea calls comments "comments".
- **Apply labels**: `tea issue edit <number> --add-labels "label1,label2"`. Remove: `tea issue edit <number> --remove-labels "label1"`.
- **Close**: `tea issue close <number>`. To include a closing comment, add it first with `tea comment <number> "<reason>"` then close.

Infer the repo from `git remote -v` — `tea` does this automatically when run inside a clone. `tea` also reads `$XDG_CONFIG_HOME/tea` for login config (set up via `tea login`).

## Pull requests as a triage surface

**PRs as a request surface: no.** _(Set to `yes` if this repo treats external PRs as feature requests; `/triage` reads this flag.)_

When set to `yes`, PRs run through the same labels and states as issues, using the `tea pull` equivalents:

- **Read a PR**: `tea pull <number> --comments` and `tea pull diff <number>` (or `tea pull view <number> -o json` for structured output).
- **List external PRs for triage**: `tea pull list --state open -o json`, then keep only PRs whose author is not a repo owner/maintainer (a contributor's PR, not a maintainer's in-flight work).
- **Comment / label / close**: `tea comment`, `tea pull edit --add-labels`/`--remove-labels`, `tea pull close`.

Gitea shares one number space across issues and PRs (they are distinct but can overlap), so a bare `#42` may be either — resolve with `tea pull view 42` and fall back to `tea issue view 42`.

## When a skill says "publish to the issue tracker"

Create a Gitea issue.

## When a skill says "fetch the relevant ticket"

Run `tea issue <number> --comments`.

## Wayfinding operations

Used by `/wayfinder`. The **map** is a single issue with **child** issues as tickets.

- **Map**: a single issue labelled `wayfinder:map`, holding the Notes / Decisions-so-far / Fog body. `tea issue create --title "..." --description "..." --labels wayfinder:map`.
- **Child ticket**: an issue carrying `Part of #<map>` at the top of its description and labels `wayfinder:<type>` (`research`/`prototype`/`grilling`/`task`). Once claimed, the ticket is assigned to the driving dev.
- **Blocking**: Gitea's **native blocking relationships** — the canonical, UI-visible representation. Add a dependency with `tea api POST /repos/{owner}/{repo}/issues/{child}/dependencies -f key="blocked_by" -f value="{blocker}"` (or via `tea api` with the raw JSON body). Gitea supports `blocked_by` and `depends_on` relationships. Where dependencies aren't available, fall back to a `Blocked by: #<n>, #<n>` line at the top of the child body. A ticket is unblocked when every blocker is closed.
- **Frontier query**: `tea issue list --state open -o json` scoped to the map's children, drop any with an open blocker (a native dependency link to an open issue, or an open issue in the `Blocked by` line) or an assignee; first in map order wins.
- **Claim**: `tea issue edit <number> --add-assignees @me` (or `--set-assignees "@me"`) — the session's first write.
- **Resolve**: `tea comment <number> "<answer>"`, then `tea issue close <number>`, then append a context pointer (gist + link) to the map's Decisions-so-far.
