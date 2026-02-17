# Dotfiles

## Requirements

- git
- make

## Install on Linux

To setup all files, run this:

```
make all
```

## Install on Windows

```
./install.ps1
```

## Local Configuration

For machine-specific or private configuration (e.g., work-related PATH exports), create `~/.bashrc.local`. This file is sourced by `bashrc` if it exists but is not tracked in git.

## NeoVim Bindings

> Leader key: `<Space>`

### Vim Motions (Built-in)

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `h` `j` `k` `l` | Move left/down/up/right |
| Normal | `w` `W` | Move to next word/WORD |
| Normal | `b` `B` | Move to previous word/WORD |
| Normal | `e` `E` | Move to end of word/WORD |
| Normal | `0` `^` `$` | Move to start/first char/end of line |
| Normal | `gg` `G` | Go to first/last line |
| Normal | `{` `}` | Move by paragraph |
| Normal | `%` | Jump to matching bracket |
| Normal | `f{char}` `F{char}` | Find char forward/backward |
| Normal | `t{char}` `T{char}` | Till char forward/backward |
| Normal | `;` `,` | Repeat f/t motion forward/backward |
| Normal | `*` `#` | Search word under cursor forward/backward |
| Normal | `n` `N` | Next/previous search result |
| Normal | `Ctrl-d` `Ctrl-u` | Scroll half page down/up |
| Normal | `Ctrl-f` `Ctrl-b` | Scroll full page down/up |
| Normal | `zz` `zt` `zb` | Center/top/bottom cursor line |

### Vim Operators (Built-in)

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `d{motion}` | Delete |
| Normal | `c{motion}` | Change (delete + insert) |
| Normal | `y{motion}` | Yank (copy) |
| Normal | `>` `<` | Indent/unindent |
| Normal | `dd` `cc` `yy` | Delete/change/yank line |
| Normal | `D` `C` | Delete/change to end of line |
| Normal | `x` `X` | Delete char under/before cursor |
| Normal | `p` `P` | Paste after/before cursor |
| Normal | `u` `Ctrl-r` | Undo/redo |
| Normal | `.` | Repeat last change |
| Normal | `r{char}` | Replace single char |
| Normal | `~` | Toggle case |
| Normal | `J` | Join lines |
| Insert | `i` `I` | Insert at cursor/start of line |
| Insert | `a` `A` | Append after cursor/end of line |
| Insert | `o` `O` | Open line below/above |
| Visual | `v` `V` `Ctrl-v` | Visual/line/block mode |

### Text Objects (Built-in + mini.ai)

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Operator | `iw` `aw` | Inner/around word |
| Operator | `iW` `aW` | Inner/around WORD |
| Operator | `is` `as` | Inner/around sentence |
| Operator | `ip` `ap` | Inner/around paragraph |
| Operator | `i"` `a"` | Inner/around double quotes |
| Operator | `i'` `a'` | Inner/around single quotes |
| Operator | `i)` `a)` | Inner/around parentheses |
| Operator | `i]` `a]` | Inner/around brackets |
| Operator | `i}` `a}` | Inner/around braces |
| Operator | `it` `at` | Inner/around HTML tag |
| Operator | `if` `af` | Inner/around function (treesitter) |
| Operator | `ic` `ac` | Inner/around class (treesitter) |
| Operator | `ia` `aa` | Inner/around argument (treesitter) |

### Custom Keybindings

#### General

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal/Insert | `Ctrl-s` | Save file |
| Visual | `Ctrl-c` | Copy to system clipboard |
| Visual | `Ctrl-x` | Cut to system clipboard |
| Normal/Insert | `Ctrl-v` | Paste from system clipboard |
| Normal | `Ctrl-z` | Undo |
| Normal | `Ctrl-y` | Redo |
| Normal/Visual | `Alt-j` | Move line(s) down |
| Normal/Visual | `Alt-k` | Move line(s) up |
| Normal/Visual | `Ctrl-d` | Multi-cursor select next |

#### Window/Split Management

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `Ctrl-h` | Focus left pane |
| Normal | `Ctrl-j` | Focus down pane |
| Normal | `Ctrl-k` | Focus up pane |
| Normal | `Ctrl-l` | Focus right pane |
| Normal | `<leader>\|` | Vertical split |
| Normal | `<leader>_` | Horizontal split |
| Normal | `Ctrl-w sv` | New file vertical split |
| Normal | `Ctrl-w sh` | New file horizontal split |
| Normal | `Ctrl-w z` | Zoom current pane |
| Normal | `Ctrl-w q` | Close window |

#### Buffers

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `Shift-h` | Previous buffer |
| Normal | `Shift-l` | Next buffer |
| Normal | `<leader>bd` | Delete buffer |
| Normal | `<leader>,` | List buffers (Telescope) |

#### File Explorer

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `Ctrl-e` | Toggle file explorer |
| Normal | `-` | Reveal current file in tree |

#### Terminal

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `` Ctrl-` `` | Toggle terminal |

#### Telescope (Finder)

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `<leader>ff` | Find files |
| Normal | `<leader>/` | Live grep |
| Normal | `<leader>fo` | Recent files |
| Normal | `,fo` | Recent files (Zed style) |
| Normal | `<leader>:` | Command history |

#### LSP

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `gd` | Go to definition |
| Normal | `gD` | Go to declaration |
| Normal | `gI` | Go to implementation |
| Normal | `gy` | Go to type definition |
| Normal | `gR` | Find all references |
| Normal | `gr` | Rename symbol |
| Normal | `ga` | Code actions |
| Normal | `K` | Hover documentation |
| Normal | `g]` | Next diagnostic |
| Normal | `g[` | Previous diagnostic |
| Normal | `]d` | Next diagnostic |
| Normal | `[d` | Previous diagnostic |
| Normal | `<leader>cd` | Show line diagnostics |

#### Git (gitsigns)

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `]c` | Next git hunk |
| Normal | `[c` | Previous git hunk |
| Normal | `,gb` | Git blame line |
| Normal | `<leader>gb` | Git blame line |
| Normal | `<leader>hs` | Stage hunk |
| Normal | `<leader>hr` | Reset hunk |
| Normal | `<leader>hp` | Preview hunk |

#### Treesitter

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal/Visual | `[x` | Expand syntax selection |
| Visual | `]x` | Shrink syntax selection |

#### Surround (nvim-surround)

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `ys{motion}{char}` | Add surround (e.g., `ysiw"`) |
| Normal | `cs{old}{new}` | Change surround (e.g., `cs"'`) |
| Normal | `ds{char}` | Delete surround (e.g., `ds"`) |

#### Comment (Comment.nvim)

| Mode | Keys | Description |
| :--- | :--- | :--- |
| Normal | `gcc` | Toggle line comment |
| Normal | `gbc` | Toggle block comment |
| Visual | `gc` | Toggle comment selection |

## Mux Bindings

No tmux installed :) We rely on terminal (look at wezterm.lua)

Leader -> ctrl + a
hsplit -> leader + %
vsplit -> leader + "
move -> leader + [h,j,k,l]

## Hyprland OpenVPN Toggle

This repo includes a Waybar VPN toggle for Hyprland.

Requirements:
- openvpn
- waybar

Setup:
1. Place `.ovpn` files in `~/.config/openvpn/`.
2. Right-click the VPN icon in Waybar to select a profile and store credentials.
3. Left-click the VPN icon to connect or disconnect.

If you want to create it manually, `vpn.conf` should look like:
```
VPN_NAME="my-vpn-profile"
VPN_CONFIG_PATH="/home/you/.config/openvpn/my-vpn-profile.ovpn"
```

Credentials are optional. If your `.ovpn` handles auth itself, omit these keys. If you need them, add:
```
VPN_USER="your_username"
VPN_PASSWORD="your_password"
```

Scripts are located in `~/.config/hypr/scripts/`:
- `vpn-status`
- `vpn-toggle`
- `vpn-select`
