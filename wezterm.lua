local wezterm = require("wezterm")

local mux = wezterm.mux
local act = wezterm.action
local config = {}
local launch_menu = {}
local haswork, work = pcall(require, "work")

--- Setup PowerShell options
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    --- Grab the ver info for later use.
    -- local success, stdout, stderr = wezterm.run_child_process({ "cmd.exe", "ver" })
    -- local major, minor, build, rev = stdout:match("Version ([0-9]+)%.([0-9]+)%.([0-9]+)%.([0-9]+)")
    -- local is_windows_11 = tonumber(build) >= 22000

    --- Set Pwsh as the default on Windows
    config.default_prog = { "pwsh.exe", "-NoLogo" }
    table.insert(launch_menu, {
        label = "Pwsh",
        args = { "pwsh.exe", "-NoLogo" },
    })
    table.insert(launch_menu, {
        label = "PowerShell",
        args = { "powershell.exe", "-NoLogo" },
    })
    table.insert(launch_menu, {
        label = "Pwsh No Profile",
        args = { "pwsh.exe", "-NoLogo", "-NoProfile" },
    })
    table.insert(launch_menu, {
        label = "PowerShell No Profile",
        args = { "powershell.exe", "-NoLogo", "-NoProfile" },
    })
else
    --- Non-Windows Machine
    table.insert(launch_menu, {
        label = "Pwsh",
        args = { "/usr/local/bin/pwsh", "-NoLogo" },
    })
    table.insert(launch_menu, {
        label = "Pwsh No Profile",
        args = { "/usr/local/bin/pwsh", "-NoLogo", "-NoProfile" },
    })
end

local keys = {
    { key = "F11",      mods = "NONE",           action = act.ToggleFullScreen },
    { key = "n",        mods = "CTRL",           action = act.SpawnWindow },

    -- tab
    { key = 't',        mods = 'CTRL',           action = act.SpawnTab 'DefaultDomain' },
    { key = "w",        mods = "SHIFT|CTRL",     action = act.CloseCurrentTab({ confirm = true }) },
    { key = "Tab",      mods = "CTRL",           action = act.ActivateTabRelative(1) },
    { key = "Tab",      mods = "SHIFT|CTRL",     action = act.ActivateTabRelative(-1) },
    { key = "PageUp",   mods = "SHIFT",          action = act.ScrollByPage(-1) },
    { key = "PageUp",   mods = "CTRL",           action = act.ActivateTabRelative(-1) },
    { key = "PageUp",   mods = "SHIFT|CTRL",     action = act.MoveTabRelative(-1) },
    { key = "PageDown", mods = "SHIFT",          action = act.ScrollByPage(1) },
    { key = "PageDown", mods = "CTRL",           action = act.ActivateTabRelative(1) },
    { key = "PageDown", mods = "SHIFT|CTRL",     action = act.MoveTabRelative(1) },
    { key = "1",        mods = "ALT",            action = act.ActivateTab(0) },
    { key = "2",        mods = "ALT",            action = act.ActivateTab(1) },
    { key = "3",        mods = "ALT",            action = act.ActivateTab(2) },
    { key = "4",        mods = "ALT",            action = act.ActivateTab(3) },
    { key = "5",        mods = "ALT",            action = act.ActivateTab(4) },
    -- { key = '%',        mods = "ALT|CTRL",       action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    -- { key = '%',        mods = "SHIFT|ALT|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    -- split
    { key = "%",        mods = "ALT|CTRL",       action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "%",        mods = "SHIFT|ALT|CTRL", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = '^',        mods = "ALT|CTRL",       action = act.SplitVertical({ domain = "CurrentPaneDomain" }) }, -- FIXME: doesn't work
    { key = '^',        mods = "SHIFT|ALT|CTRL", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) }, -- FIXME: doesn't work

    -- font size
    { key = "+",        mods = "SHIFT|CTRL",     action = act.IncreaseFontSize },
    { key = "=",        mods = "CTRL",           action = act.IncreaseFontSize },
    { key = "-",        mods = "CTRL",           action = act.DecreaseFontSize },
    { key = "0",        mods = "CTRL",           action = act.ResetFontSize },

    -- copy paste
    { key = "C",        mods = "CTRL",           action = act.CopyTo("Clipboard") },
    { key = "C",        mods = "SHIFT|CTRL",     action = act.CopyTo("Clipboard") },
    { key = "c",        mods = "SHIFT|CTRL",     action = act.CopyTo("Clipboard") },
    { key = "V",        mods = "CTRL",           action = act.PasteFrom("Clipboard") },
    -- { key = "V",        mods = "SHIFT|CTRL",     action = act.PasteFrom("Clipboard") },
    { key = "Insert",   mods = "SHIFT",          action = act.PasteFrom("PrimarySelection") },
    { key = "Insert",   mods = "CTRL",           action = act.CopyTo("PrimarySelection") },
    {
        key = "u",
        mods = "SHIFT|CTRL",
        action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
    },
    {
        key = "U",
        mods = "CTRL",
        action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
    },
    {
        key = "U",
        mods = "SHIFT|CTRL",
        action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
    },

    -- Search
    { key = "f",          mods = "CTRL",       action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "F",          mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },
    { key = "f",          mods = "SHIFT|CTRL", action = act.Search("CurrentSelectionOrEmptyString") },

    -- misc
    { key = "r",          mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
    { key = "L",          mods = "CTRL",       action = act.ShowDebugOverlay },
    { key = "L",          mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
    { key = "l",          mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
    { key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
    { key = "x",          mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
    { key = "z",          mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
    { key = "P",          mods = "CTRL",       action = act.ActivateCommandPalette },
    { key = "R",          mods = "CTRL",       action = act.ReloadConfiguration },
    { key = "R",          mods = "SHIFT|CTRL", action = act.ReloadConfiguration },
    { key = "t",          mods = "SHIFT|CTRL", action = act.ShowLauncher },
    { key = "T",          mods = "CTRL",       action = act.ShowLauncher },
    { key = "T",          mods = "SHIFT|CTRL", action = act.ShowLauncher },
    { key = "X",          mods = "CTRL",       action = act.ActivateCopyMode },
    { key = "X",          mods = "SHIFT|CTRL", action = act.ActivateCopyMode },
    { key = "Z",          mods = "CTRL",       action = act.TogglePaneZoomState },
    { key = "Z",          mods = "SHIFT|CTRL", action = act.TogglePaneZoomState },
    { key = "m",          mods = "SHIFT|CTRL", action = act.Hide },
    { key = "M",          mods = "CTRL",       action = act.Hide },
    { key = "M",          mods = "SHIFT|CTRL", action = act.Hide },
    { key = "k",          mods = "SHIFT|CTRL", action = act.ClearScrollback("ScrollbackOnly") },
}

-- Mousing bindings
local mouse_bindings = {
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "NONE",
        action = act.CompleteSelection("ClipboardAndPrimarySelection"),
    },

    -- and make CTRL-Click open hyperlinks
    {
        event = { Up = { streak = 1, button = "Left" } },
        mods = "CTRL",
        action = act.OpenLinkAtMouseCursor,
    },
    {
        event = { Down = { streak = 3, button = "Left" } },
        action = wezterm.action.SelectTextAtMouseCursor("SemanticZone"),
        mods = "NONE",
    },
}

local colors = {
    foreground = "#fbf1c7",
    background = "#1d2021",

    cursor_bg = "#928374",
    cursor_fg = "black",
    cursor_border = "#928374",

    selection_fg = "#928374",
    selection_bg = "#ebdbb2",

    scrollbar_thumb = "#222222",

    -- The color of the split lines between panes
    split = "#444444",

    ansi = {
        "#1d2021", -- black, color 0
        "#cc241d", -- red, color 1
        "#98971a", -- green, color 2
        "#d79921",
        "#458588",
        "#b16286",
        "#689d6a",
        "#a89984",
    },
    brights = {
        "#7c6f64", -- black, color 0
        "#fb4934", -- red, color 1
        "#b8bb26", -- green, color 2
        "#fabd2f",
        "#83a598",
        "#d3869b",
        "#8ec07c",
        "#fbf1c7",
    },
}

--- Default config settings
config.scrollback_lines = 7000
config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = "Gruvbox Dark"
config.font = wezterm.font("FiraCode Nerd Font")

config.font_size = 11
config.launch_menu = launch_menu
config.default_cursor_style = "BlinkingBar"
config.disable_default_key_bindings = true

config.keys = keys
config.mouse_bindings = mouse_bindings
config.colors = colors

return config
