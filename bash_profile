# Login shells get the common config from bashrc, which also sources the
# machine-local ~/.bashrc.local.
if [ -f "$HOME/.bashrc" ]; then
    source "$HOME/.bashrc"
fi

# Autostart Hyprland from the console login. Guarded on start-hyprland so
# machines that do not ship it simply skip the block.
if [ -z "$WAYLAND_DISPLAY" ] && [ "$(tty 2>/dev/null)" = "/dev/tty1" ] \
    && command -v start-hyprland >/dev/null 2>&1; then
    start-hyprland
fi
