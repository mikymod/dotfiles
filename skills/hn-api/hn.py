#!/usr/bin/env python3
"""Hacker News API helper — Firebase + Algolia CLI."""
import json
import sys
import time
import datetime
import urllib.parse
import urllib.request

FIREBASE = "https://hacker-news.firebaseio.com/v0"
ALGOLIA = "https://hn.algolia.com/api/v1"

def get(url):
    with urllib.request.urlopen(url) as r:
        return json.load(r)

def feed(kind, n):
    ids = get(f"{FIREBASE}/{kind}stories.json")[:n]
    print(f"# {len(ids)} ids listed; showing {len(ids)}")
    for i in ids:
        try:
            d = get(f"{FIREBASE}/item/{i}.json")
            t = d.get("title") or (d.get("text") or "")[:80]
            print(f"- [{d.get('score','?')}pts/{d.get('descendants','?')}c] {d.get('by')} | {t}")
        except Exception as e:
            print(f"- {i}: err {e}")

def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else ""
    arg = sys.argv[2] if len(sys.argv) > 2 else None

    if cmd in ("top", "new", "best", "ask", "show", "job"):
        n = int(arg) if arg and arg.isdigit() else 10
        feed(cmd, n)
    elif cmd == "daily":
        # Top stories posted within the last N hours, using HN's own ranking
        # (flagged/dead stories drop out of topstories); exclude dead/deleted as a safety net.
        hours = int(arg) if arg and arg.isdigit() else 24
        limit = int(sys.argv[3]) if len(sys.argv) > 3 and sys.argv[3].isdigit() else 10
        cutoff = time.time() - hours * 3600
        ids = get(f"{FIREBASE}/topstories.json")
        picks = []
        for i in ids:
            d = get(f"{FIREBASE}/item/{i}.json")
            if d.get("dead") or d.get("deleted"):
                continue
            if d.get("time", 0) < cutoff:
                continue
            picks.append(d)
        picks.sort(key=lambda d: d.get("score", 0), reverse=True)
        picks = picks[:limit]
        print(f"# top {len(picks)} stories in last {hours}h (flagged/dead excluded)")
        for d in picks:
            print(f"- [{d.get('score')}pts/{d.get('descendants')}c] {d.get('by')} | {d.get('title')}")
    elif cmd == "max":
        print(get(f"{FIREBASE}/maxitem.json"))
    elif cmd == "item":
        print(json.dumps(get(f"{FIREBASE}/item/{arg}.json"), indent=2))
    elif cmd == "user":
        d = get(f"{FIREBASE}/user/{arg}.json")
        print(f"{d.get('id')}: karma={d.get('karma')} created={d.get('created')}")
        print(f"submitted: {len(d.get('submitted', []))} items")
        if d.get("about"):
            print("about:", d["about"][:200])
    elif cmd == "search":
        # parse --tags=.. --min-points=.. --since=.. --limit=.. ; positional = query
        tags = minpts = since = ""
        limit = 10
        query = ""
        for a in sys.argv[2:]:
            if a.startswith("--tags="): tags = a[7:]
            elif a.startswith("--min-points="): minpts = a[13:]
            elif a.startswith("--since="): since = a[8:]
            elif a.startswith("--limit="): limit = int(a[8:])
            else: query += " " + a
        query = query.strip()
        filters = []
        if minpts: filters.append(f"points>{minpts}")
        if since:
            if since.endswith("h"):
                delta = datetime.timedelta(hours=int(since[:-1]))
            else:
                delta = datetime.timedelta(days=int(since[:-1]))
            ts = int(time.time() - delta.total_seconds())
            filters.append(f"created_at_i>{ts}")
        url = ALGOLIA + ("/search_by_date" if since else "/search")
        params = f"hitsPerPage={limit}"
        if tags: params += f"&tags={tags}"
        if filters: params += "&numericFilters=" + ";".join(filters)
        if query: params += "&query=" + urllib.parse.quote(query)
        d = get(url + "?" + params)
        print(f"nbHits: {d.get('nbHits')}")
        for h in d.get("hits", []):
            title = h.get("title") or h.get("story_title") or (h.get("comment_text") or "")[:80]
            print(f"- [{h.get('points')}pts/{h.get('num_comments')}c] {h.get('author')} | {title} ({h.get('created_at')})")
    elif cmd == "comments":
        d = get(f"{ALGOLIA}/items/{arg}")
        def walk(n, depth=0):
            t = (n.get("text") or "")[:120].replace("\n", " ")
            print("  "*depth + f"- {n.get('author')}: {t}")
            for c in n.get("children", []):
                walk(c, depth+1)
        print(f"{d.get('title')} by {d.get('author')} [{d.get('points')}pts]")
        walk(d)
    else:
        print("usage: hn.sh <top|new|best|ask|show|job|item <id>|user <name>|max|search <q>|comments <id>>")
        sys.exit(1)

if __name__ == "__main__":
    main()
