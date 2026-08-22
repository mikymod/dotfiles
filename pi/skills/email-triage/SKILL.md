---
name: email-triage
description: Triage a Gmail inbox toward zero via gmcli — read every inbox email, label and archive it, and write draft replies (never sent) where a response is needed. The user reviews and clicks Send.
disable-model-invocation: true
---

# Email Triage

Drive the Gmail inbox toward zero. Every email in the inbox gets **read → labelled → archived** (removed from `INBOX`). Where a reply is needed, write a **draft** — never send it. The user reviews drafts and clicks Send themselves.

Uses the [gmcli skill](../gmcli/SKILL.md) for all Gmail access.

## Hard rules

1. **Never send.** Do not run `gmcli <email> send` or `gmcli <email> drafts send`. Drafts only — the user is the only one who clicks Send.
2. **Never trash.** Do not move anything to `TRASH` (i.e. `--add TRASH`) unless the user explicitly asks for that specific thread. Archive, don't destroy.
3. **Never touch mail outside the inbox** unless asked. Triage targets `in:inbox`.

## Prerequisites

- gmcli installed and an account configured. Check `gmcli accounts list`; if empty, follow the setup section of the gmcli skill.
- Confirm the account with the user before acting on any mailbox.

## Workflow

1. **Confirm scope.** Ask which account to triage (from `gmcli accounts list`) and how many messages to process (default 50).
2. **Pull the inbox.** `gmcli <email> search "in:inbox" --max N` — process oldest first. (`--max` defaults to 10, so always pass it.)
3. **Read → decide → act** on each thread, per the decision tree below.
4. **Report.** Summarise what was labelled, archived, and drafted, with Gmail URLs.

## Decision tree

For each thread:

1. Read it: `gmcli <email> thread <threadId>`. Note the **last** `Message-ID:` line — that id feeds `--reply-to` when drafting.
2. Classify it:

| Class | Action |
|-------|--------|
| Needs a reply | Draft a reply (`drafts create --reply-to`), then label + archive. |
| Action on the user, no reply | `to-do` + topic label, then archive. |
| Follow up later | `follow-up` + topic label, then archive. |
| Reference / keep | Topic label + archive. |
| Noise (newsletter, notification, receipt) | `newsletters` for recurring mail worth keeping; purchase confirmations → `receipts`; otherwise archive bare and suggest a Gmail filter. |

3. Label + archive in one step (this also marks it read):

```bash
gmcli <email> labels <threadId> --add <Label> --remove INBOX,UNREAD
```

- Multiple labels / removals are comma-separated: `--add work,to-do --remove INBOX,UNREAD`.
- Pure noise can be archived with no label; everything else should carry at least one.

If a classification is genuinely ambiguous, **skip it and list it for the user** rather than guess.

## Labelling

Two kinds of label. **Action labels** mark whether *you* still owe something; **topic labels** say what the mail is about.

### Action labels

| Label | Use |
|-------|-----|
| `to-do` | Requires action from you, no reply needed |
| `follow-up` | Waiting on someone else / revisit later |

### Topic labels

Hierarchical, `/`-nested. Reuse these — don't invent new ones (gmcli can't create labels, only apply existing ones).

- `work` — plus `work/ITS`, `work/JMP`, `work/Unicam`, `work/OverSide`
- `newsletters` — plus `newsletters/tech`, `newsletters/tech/flutter`, `newsletters/gamedev`, `newsletters/ttrpg`
- `receipts` — all money: purchase/payment confirmations, order + shipping notices, and bills/invoices. If a bill needs you to pay or act on it, also add `to-do`.

Apply an **action label when attention is owed** and a **topic label when it fits**. Pick the most specific child label (a Flutter newsletter → `newsletters/tech/flutter`; work for a client → `work/<project>`).

## Drafting replies

When a reply is needed, write a draft that threads correctly:

```bash
gmcli <email> drafts create \
  --to <recipient> \
  --subject "Re: <original subject>" \
  --body "<reply text>" \
  --reply-to <messageId>
```

- `--reply-to <messageId>` threads the draft under the original message (use the `Message-ID:` from `gmcli <email> thread <threadId>`).
- Add `--cc`, `--bcc`, `--attach` as needed.
- **Do not** run `drafts send`. Report the draft and let the user send it.

To locate drafts later: `gmcli <email> drafts list`.

## Reporting

End every session with a summary:

- **Labelled + archived:** `N` threads — list the notable ones.
- **Drafts written:** each with subject + `gmcli <email> url <threadId>` so the user can open and Send.
- **Skipped:** anything left for the user to decide, and why.
- **Filters suggested:** recurring senders worth filtering out of the inbox.

## Command cheat-sheet

```bash
gmcli accounts list
gmcli <email> search "in:inbox" --max 50
gmcli <email> thread <threadId>                 # read; note the Message-ID:
gmcli <email> labels list
gmcli <email> labels <threadId> --add L1,L2 --remove INBOX,UNREAD
gmcli <email> drafts create --to X --subject "Re: ..." --body "..." --reply-to <messageId>
gmcli <email> drafts list
gmcli <email> url <threadId>                    # Gmail web link
```

**Never:** `send`, `drafts send`, `--add TRASH` (unless explicitly asked for that thread).
