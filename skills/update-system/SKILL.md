---
name: update-system
description: Update system software on this machine (tesseract). Use when the user asks to "update the system", check for updates, or patch/update anything — covers Arch packages (incl. AUR) and podman/quadlet containers such as halogen.
---

# Update System

Two parts: Arch packages and podman containers. Always report what changed; never reboot without asking.

## 1. Arch packages (incl. AUR)

```bash
yay -Qu            # list available updates
yay -Syu --needed  # apply (AUR builds may take a while; use a long timeout)
```

## 2. Podman / quadlet containers

Containers here run as **user quadlet units** in `~/.config/containers/systemd/*.container` (e.g. `halogen.container` → `halogen.service`). They are NOT started with bare `podman run` — do not `podman run` a new copy; edit the quadlet file instead.

For each quadlet unit:

1. Current image: `podman ps -a --format '{{.Names}} {{.Image}} {{.Status}}'`
2. Latest tag on GHCR (podman search truncates; query the registry API):
   ```bash
   TOKEN=$(curl -s "https://ghcr.io/token?scope=repository:<owner>/<repo>:pull" | sed -n 's/.*"token":"\([^"]*\)".*/\1/p')
   curl -s -H "Authorization: Bearer $TOKEN" "https://ghcr.io/v2/<owner>/<repo>/tags/list?n=1000" \
     | tr ',' '\n' | grep -o '"[0-9][0-9.]*"' | tr -d '"' | sort -V | tail -5
   ```
   (Docker Hub: use `https://hub.docker.com/v2/repositories/<owner>/<repo>/tags?page_size=100`.)
3. If newer: edit `Image=` in the `.container` file, then:
   ```bash
   systemctl --user daemon-reload && systemctl --user restart <name>.service
   ```
4. Verify: `podman ps --filter name=<name>` and `journalctl --user -u <name> -n 15 --no-pager` (halogen logs its version line: `serve_api: version X`).
5. Prune the old image once the new one is healthy:
   ```bash
   podman image rm <image>:<old-tag>
   ```

### Halogen specifics

- Unit: `~/.config/containers/systemd/halogen.container`, image `ghcr.io/peonist-ai/halogen-flash-server`, serves `127.0.0.1:8731`.
- Startup takes ~1 min (model load); don't judge health before the `serve_api: version` line appears.
