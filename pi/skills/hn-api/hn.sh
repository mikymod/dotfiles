#!/usr/bin/env bash
# Hacker News API helper CLI — thin wrapper around hn.py.
# Usage: hn.sh <cmd> [args...]
set -euo pipefail
exec python3 "$(dirname "$(readlink -f "$0")")/hn.py" "$@"
