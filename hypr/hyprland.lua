-- ==============================================================================
-- HYPRLAND LUA CONFIGURATION
-- ==============================================================================
-- Lua port of the previous hyprland.conf + envs.conf (Hyprland 0.57+).
-- Wiki: https://wiki.hypr.land/configuring/
--
-- NOTE: Hyprland loads ~/.config/hypr/hyprland.lua instead of hyprland.conf
-- when this file exists. The check happens once at startup, so a restart
-- (not just a reload) is needed when switching between the two formats.
-- hypridle, hyprlock, hyprlauncher and hyprtoolkit still use hyprlang (.conf).

-- ==============================================================================
-- ENVIRONMENT VARIABLES (was envs.conf)
-- ==============================================================================

-- Cursor size
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Dark theme
hl.env("GTK_THEME", "Adwaita:dark")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("GTK2_RC_FILES", "/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc")

-- Force all apps to use Wayland
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Allow better support for screen sharing (Google Meet, Discord, etc)
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

-- ==============================================================================
-- MONITOR
-- ==============================================================================
-- Laptop panel anchors the layout. It needs an explicit position: Hyprland
-- places explicit monitors first, then lays out "auto*" ones around them.
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "0x0",
    scale    = "1",
})

-- Any other display sits physically above the laptop, horizontally centered.
-- Keep in sync with scripts/toggle-monitor-layout (apply_extend).
hl.monitor({
    output   = "",          -- fallback rule for any monitor without an explicit rule
    mode     = "preferred",
    position = "auto-center-up",
    scale    = "1",
})

-- ==============================================================================
-- AUTOSTART
-- ==============================================================================
hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/scripts/wallpaper restore") -- swaybg, last chosen image
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprlauncher -d") -- daemon: instant launcher, required by scripts/menu
    -- Menu actions (lock, screenshot, keybindings...) as searchable launcher entries
    hl.exec_cmd("~/.config/hypr/scripts/menu desktop-entries")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    -- Discord and streaming
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal")
    hl.exec_cmd("gnome-keyring-daemon --replace --start --components=pkcs11,secrets,ssh")
    hl.exec_cmd("/home/mikymod/work/mikymod/omarchy-local-ai/arch/bin/local-ai-qs")
end)

-- ==============================================================================
-- INPUT
-- ==============================================================================
hl.config({
    input = {
        kb_layout  = "us, it",
        kb_options = "grp:alt_shift_toggle",
        follow_mouse = 1,
        sensitivity = 0,
        numlock_by_default = true,

        touchpad = {
            natural_scroll     = true,
            tap_to_click       = true,
            disable_while_typing = true,
        },
    },

    xwayland = {
        force_zero_scaling = true,
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down", mods = "ALT", action = "close" })

-- ==============================================================================
-- LOOK & FEEL
-- ==============================================================================
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 10,
        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(e78a4eee)", "rgba(d8a657ee)" }, angle = 45 },
            inactive_border = "rgba(7c6f64aa)",
        },

        layout = "dwindle",
    },

    decoration = {
        rounding = 8,

        blur = {
            enabled = true,
            size    = 3,
            passes  = 2,
        },

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
        force_split    = 2,
    },

    misc = {
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        -- Safety net: wake displays on input even if hypridle's on-resume fails.
        key_press_enables_dpms   = true,
        mouse_move_enables_dpms  = true,
    },

    ecosystem = {
        no_donation_nag = true,
        no_update_news  = true,
    },
})

-- Curves (was: bezier = ...)
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},   {0.32, 1} } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05},{0.36, 1} } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},      {1, 1}    } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},  {0.75, 1} } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},   {0.1, 1}  } })

-- Animations (was: animation = ...)
hl.animation({ leaf = "global",           enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",           enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",          enabled = true,  speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",        enabled = true,  speed = 4.1,  bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",       enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",           enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",          enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",             enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",           enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",         enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",        enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",     enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut",    enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",       enabled = false })
hl.animation({ leaf = "specialWorkspace", enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "slidevert" })

-- ==============================================================================
-- KEYBINDINGS
-- ==============================================================================

-- Record every described bind's dispatcher in the global `menu_binds` table so
-- the keybindings menu (scripts/menu keybindings) can run it by description:
--   hyprctl dispatch 'menu_binds["Close active window"]'
-- Must come before the first hl.bind call.
menu_binds = {}
do
    local bind = hl.bind
    hl.bind = function(keys, dispatcher, opts)
        if opts and opts.description then
            menu_binds[opts.description] = dispatcher
        end
        return bind(keys, dispatcher, opts)
    end
end

local mod        = "SUPER"
local terminal   = "ghostty"
local browser    = "chromium"
local fileMgr    = "nautilus"
local launcher   = "hyprlauncher"
local menu       = "~/.config/hypr/scripts/menu"
local scripts    = "~/.config/hypr/scripts/"
local localAi    = "/home/mikymod/work/mikymod/omarchy-local-ai/arch/bin/local-ai-qs"

-- Core
hl.bind(mod .. " + Return",        hl.dsp.exec_cmd(terminal),            { description = "Open terminal" })
hl.bind(mod .. " + Q",             hl.dsp.window.close(),                { description = "Close active window" }) -- window.kill() = SIGKILL
hl.bind(mod .. " + M",             hl.dsp.exit(),                        { description = "Exit Hyprland" })
hl.bind(mod .. " + E",             hl.dsp.exec_cmd(fileMgr),             { description = "Open file manager" })
hl.bind(mod .. " + V",             hl.dsp.window.float({ action = "toggle" }), { description = "Toggle floating mode" })
hl.bind(mod .. " + Space",         hl.dsp.exec_cmd(launcher .. " -t"),   { description = "Toggle application launcher" })
hl.bind(mod .. " + P",             hl.dsp.window.pseudo(),               { description = "Toggle pseudo-tiling" })
hl.bind(mod .. " + J",             hl.dsp.layout("togglesplit"),         { description = "Toggle split orientation" })
hl.bind(mod .. " + F",             hl.dsp.window.fullscreen({ action = "toggle" }), { description = "Toggle fullscreen" })
hl.bind(mod .. " + B",             hl.dsp.exec_cmd(browser),             { description = "Open browser" })
hl.bind(mod .. " + CTRL + A",      hl.dsp.exec_cmd(localAi .. " toggle"),{ description = "Local AI" })

-- Move focus
hl.bind(mod .. " + left",          hl.dsp.focus({ direction = "left" }),  { description = "Focus window left" })
hl.bind(mod .. " + right",         hl.dsp.focus({ direction = "right" }), { description = "Focus window right" })
hl.bind(mod .. " + up",            hl.dsp.focus({ direction = "up" }),    { description = "Focus window up" })
hl.bind(mod .. " + down",          hl.dsp.focus({ direction = "down" }),  { description = "Focus window down" })
hl.bind(mod .. " + H",             hl.dsp.focus({ direction = "left" }),  { description = "Focus window left (vim)" })
hl.bind(mod .. " + L",             hl.dsp.focus({ direction = "right" }), { description = "Focus window right (vim)" })
hl.bind(mod .. " + K",             hl.dsp.focus({ direction = "up" }),    { description = "Focus window up (vim)" })
hl.bind(mod .. " + SHIFT + J",     hl.dsp.focus({ direction = "down" }),  { description = "Focus window down (vim)" })

-- Workspaces / move to workspace
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. " + " .. key,        hl.dsp.focus({ workspace = i }),
        { description = "Switch to workspace " .. i })
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }),
        { description = "Move window to workspace " .. i })
end

-- Move workspace to monitor
hl.bind(mod .. " + CTRL + 1", hl.dsp.exec_cmd("~/.config/hypr/scripts/move-workspace-to-monitor main"),
    { description = "Move workspace to main monitor" })
hl.bind(mod .. " + CTRL + 2", hl.dsp.exec_cmd("~/.config/hypr/scripts/move-workspace-to-monitor external"),
    { description = "Move workspace to external monitor" })

-- Scroll workspaces
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "Scroll to next workspace" })
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), { description = "Scroll to previous workspace" })

-- Move/resize windows with mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys (bindld = locked, bindeld = locked + repeating)
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true, description = "Increase volume" })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true, description = "Decrease volume" })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, description = "Toggle mute" })
hl.bind("XF86AudioPlay",         hl.dsp.exec_cmd("playerctl play-pause"),
    { locked = true, description = "Play/pause media" })
hl.bind("XF86AudioNext",         hl.dsp.exec_cmd("playerctl next"),
    { locked = true, description = "Next track" })
hl.bind("XF86AudioPrev",         hl.dsp.exec_cmd("playerctl previous"),
    { locked = true, description = "Previous track" })

-- Brightness
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl set 5%+"),
    { locked = true, repeating = true, description = "Increase brightness" })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl set 5%-"),
    { locked = true, repeating = true, description = "Decrease brightness" })

-- Screenshots (saved to ~/Pictures/Screenshots and copied to the clipboard)
hl.bind("Print",          hl.dsp.exec_cmd(scripts .. "screenshot area"), { description = "Screenshot selected area" })
hl.bind("SHIFT + Print",  hl.dsp.exec_cmd(scripts .. "screenshot all"),  { description = "Screenshot entire screen" })

-- Screen recording (toggle: press again to stop and save)
hl.bind("CTRL + SHIFT + Print",      hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-record"),
    { description = "Toggle screen recording" })
hl.bind("CTRL + SHIFT + ALT + Print", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-record --region"),
    { description = "Toggle region recording (slurp)" })

-- Menus (scripts/menu, Omarchy-style pickers on hyprlauncher)
hl.bind(mod .. " + ALT + Space", hl.dsp.exec_cmd(menu),                  { description = "Open main menu" })
hl.bind(mod .. " + Escape",      hl.dsp.exec_cmd(menu .. " system"),     { description = "System menu (lock, suspend, power)" })
hl.bind(mod .. " + CTRL + C",    hl.dsp.exec_cmd(menu .. " capture"),    { description = "Capture menu (screenshots, recording)" })
hl.bind(mod .. " + CTRL + T",    hl.dsp.exec_cmd(menu .. " toggles"),    { description = "Toggles menu (idle lock, Waybar, displays)" })
hl.bind(mod .. " + CTRL + Space",hl.dsp.exec_cmd(menu .. " wallpaper"),  { description = "Wallpaper menu (next, random, pick)" })
hl.bind(mod .. " + slash",       hl.dsp.exec_cmd(menu .. " keybindings"),{ description = "Keybindings (Enter runs the bind)" })
hl.bind(mod .. " + SHIFT + V",   hl.dsp.exec_cmd(menu .. " clipboard"),  { description = "Open clipboard history" })
hl.bind(mod .. " + period",      hl.dsp.exec_cmd(menu .. " emoji"),      { description = "Emoji picker (copies to clipboard)" })
hl.bind(mod .. " + SHIFT + period", hl.dsp.exec_cmd(menu .. " symbols"), { description = "Symbol picker: arrows, math, accents... (copies)" })
hl.bind(mod .. " + equal",       hl.dsp.exec_cmd(launcher .. " -f math"),    { description = "Calculator (Enter copies the result)" })

-- Battery status
hl.bind(mod .. " + SHIFT + B",
    hl.dsp.exec_cmd('notify-send "󰁹 Battery" "$(cat /sys/class/power_supply/BAT*/capacity)% - $(cat /sys/class/power_supply/BAT*/status)"'),
    { description = "Show battery status" })

-- Lock screen
hl.bind(mod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"), { description = "Lock screen" })

-- Monitor layout
hl.bind(mod .. " + O", hl.dsp.exec_cmd("~/.config/hypr/scripts/toggle-monitor-layout"),
    { description = "Toggle mirror/extend" })

-- ==============================================================================
-- RULES
-- ==============================================================================

-- Launcher: frosted glass (blur behind the translucent hyprlauncher surface).
-- ignore_alpha skips blur on pixels with alpha <= value, so it must stay below
-- the hyprtoolkit background alpha (0xB3 ~ 0.70). dim_around darkens the rest
-- of the screen while the launcher / menus are open.
hl.layer_rule({
    match        = { namespace = "hyprlauncher" },
    blur         = true,
    ignore_alpha = 0.5,
    dim_around   = true,
    animation    = "popin 90%",
})

-- Image viewer: centred floating window instead of a tile (as in Omarchy).
hl.window_rule({
    name   = "float-imv",
    match  = { class = "^imv$" },
    float  = true,
    center = true,
    size   = { 875, 600 },
})
