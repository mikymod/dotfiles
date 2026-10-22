---
name: check-health
description: Read-only system health check for tesseract (disks, RAM, load, GPU, systemd units, halogen, OOM, updates, clock). Use when the user asks "check health", "is everything OK", a health/status report, or wants to troubleshoot slowness or a suspected failure.
---

# Check Health

Run all checks **read-only**, then print a ✅/⚠️/❌ table with a one-line note per row. Do not fix anything automatically — suggest fixes below the table and ask before acting. Thresholds below mark ⚠️/❌.

Run the independent commands in parallel (one bash call with `;` or a codemode `Promise.all`) to keep it fast.

## Checks

| # | Check | Command | ⚠️ / ❌ |
|---|-------|---------|--------|
| 1 | Disk space | `df -h --output=pcent,target -x tmpfs -x devtmpfs -x overlay` | ⚠️ ≥85%, ❌ ≥95% |
| 2 | Journal size | `journalctl --disk-usage` | ⚠️ >2G |
| 3 | Podman bloat | `podman system df` | ⚠️ much dangling (dangling images/build cache >5G) |
| 4 | RAM & swap | `free -h`; `lsblk -dno NAME,SIZE,MOUNTPOINT /dev/zram* 2>/dev/null` | ⚠️ available <1G or swap >50% used |
| 5 | Load | `uptime`; compare 5-min load to `nproc` | ⚠️ 5-min load > nproc |
| 6 | GPU (ROCm) | `rocm-smi --showmeminfo vram --showtemp --showpower` | ⚠️ temp >85°C; VRAM near-full while halogen idle |
| 7 | Failed units | `systemctl --failed --no-legend; systemctl --user --failed --no-legend`; `systemctl is-system-running` | ❌ any failed unit (name it; `systemd-networkd-wait-online` is a known-benign one here — mark ⚠️) |
| 8 | Halogen | `curl -s -m 3 -o /dev/null -w '%{http_code}' 127.0.0.1:8731/v1/models`; recent errors: `journalctl --user -u halogen -p err --since "24h ago" --no-pager \| tail -5` | ❌ not 200 (or no reply); ⚠️ errors in journal |
| 9 | OOM kills | `journalctl -k -S "24 hours ago" --no-pager \| grep -i -E 'out of memory|oom-kill' \| tail -5` | ❌ any hit |
| 10 | Disk health (SMART) | `printf '%s\n' "$SUDO_PW" \| sudo -S -v; sudo -n smartctl -a /dev/nvme0 \| grep -E 'Overall|Percentage Used|Available Spare|Temperature:|Media and Data|Error Log'` | ❌ not "PASSED"; ⚠️ Percentage Used >80, Available Spare <10%, temp >70°C, media errors >0 |
| 11 | Pending updates | `yay -Qu` (empty = current) | ⚠️ any pending — point to the update-system skill |
| 12 | Clock | `timedatectl` → "System clock synchronized" | ❌ not synchronized |

## Notes

- `smartctl` needs root; use the sudo timestamp trick (`sudo -S -v` with the password on stdin, then `sudo -n ...`). If no password is available, mark the row "skipped (needs sudo)" — never guess.
- Halogen quadlet unit: `halogen.service` (user). Startup takes ~1 min; a fresh restart may 404/timeout until `serve_api: version` appears in its journal.
- GPU here is gfx1151 with a BIOS UMA carve-out (~512M default VRAM reported + large BAR); "VRAM near-full" is normal *while halogen is loaded* — only flag it if the service is down.

## Output format

```
| Check        | Status | Detail              |
|--------------|--------|---------------------|
| Disk /       | ✅     | 59% used            |
...
```
Then: "Suggested actions" (only for ⚠️/❌ rows) and ask before running any fix.
