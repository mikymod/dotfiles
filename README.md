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

| Context / Mode | Keys | Description | Command |
| :--- | :--- | :--- | :--- |
| **Global** | `<Space>` | Leader key | `vim.g.mapleader` |
| **Normal** | `<Esc>` | Clear search highlight | `<cmd>nohlsearch<CR>` |
| **Normal** | `<C-h>` | Move focus to the left window | `<C-w><C-h>` |
| **Normal** | `<C-l>` | Move focus to the right window | `<C-w><C-l>` |
| **Normal** | `<C-j>` | Move focus to the lower window | `<C-w><C-j>` |
| **Normal** | `<C-k>` | Move focus to the upper window | `<C-w><C-k>` |
| **Normal** | `<S-l>` | Next buffer | `:bnext<CR>` |
| **Normal** | `<S-h>` | Previous buffer | `:bprevious<CR>` |
| **Terminal** | `<Esc><Esc>` | Exit terminal mode | `<C-\><C-n>` |
| **Normal, Visual** | `<C-d>` | Find Under / Find Subword Under (Multi-Cursor) | `VM_maps["Find Under"]` |
| **Normal, Visual** | `<leader> /` | Toggle comment | `require("Comment.api").toggle.linewise()` |
| **Normal** | `<leader> f` | [F]ormat buffer | `require("conform").format()` |
| **Normal** | `<leader> q` | Open diagnostic [Q]uickfix list | `vim.diagnostic.setloclist` |
| **Normal** | `<leader> e` | Toggle file explorer | `:NvimTreeToggle<CR>` |
| **Normal** | `<leader> bd` | Close buffer | `:bdelete<CR>` |
| **Normal** | `<leader> wv` | Vertical split | `:vsplit<CR>` |
| **Normal** | `<leader> wh` | Horizontal split | `:split<CR>` |
| **Normal** | `<leader> wc` | Close window | `<C-w>c` |
| **Telescope (Normal)**| `<leader> sh` | [S]earch [H]elp | `telescope.builtin.help_tags` |
| **Telescope (Normal)**| `<leader> sk` | [S]earch [K]eymaps | `telescope.builtin.keymaps` |
| **Telescope (Normal)**| `<leader> sf` | [S]earch [F]iles | `telescope.builtin.find_files` |
| **Telescope (Normal)**| `<leader> ss` | [S]earch [S]elect Telescope | `telescope.builtin.builtin` |
| **Telescope (Normal)**| `<leader> sw` | [S]earch current [W]ord | `telescope.builtin.grep_string` |
| **Telescope (Normal)**| `<leader> sg` | [S]earch by [G]rep | `telescope.builtin.live_grep` |
| **Telescope (Normal)**| `<leader> sd` | [S]earch [D]iagnostics | `telescope.builtin.diagnostics` |
| **Telescope (Normal)**| `<leader> sr` | [S]earch [R]esume | `telescope.builtin.resume` |
| **Telescope (Normal)**| `<leader> s.` | [S]earch Recent Files | `telescope.builtin.oldfiles` |
| **Telescope (Normal)**| `<leader> <leader>`| Find existing buffers | `telescope.builtin.buffers` |
| **Telescope (Normal)**| `<leader> /` | Fuzzily search in current buffer | `telescope.builtin.current_buffer_fuzzy_find`|
| **Telescope (Normal)**| `<leader> s/` | [S]earch [/] in Open Files | `telescope.builtin.live_grep` |
| **Telescope (Normal)**| `<leader> sn` | [S]earch [N]eovim files | `telescope.builtin.find_files` |
| **LSP (Normal)** | `cd` | [C]hange [D]efinition (Rename) | `vim.lsp.buf.rename` |
| **LSP (Normal, Visual)**| `ga` | [G]oto Code [A]ction | `vim.lsp.buf.code_action` |
| **LSP (Normal)** | `gr` | [G]oto [R]eferences | `telescope.builtin.lsp_references` |
| **LSP (Normal)** | `gi` | [G]oto [I]mplementation | `telescope.builtin.lsp_implementations` |
| **LSP (Normal)** | `gd` | [G]oto [D]efinition | `telescope.builtin.lsp_definitions` |
| **LSP (Normal)** | `gD` | [G]oto [D]eclaration | `vim.lsp.buf.declaration` |
| **LSP (Normal)** | `gs` | [G]oto Document [S]ymbols | `telescope.builtin.lsp_document_symbols` |
| **LSP (Normal)** | `gS` | [G]oto Workspace [S]ymbols | `telescope.builtin.lsp_dynamic_workspace_symbols`|
| **LSP (Normal)** | `gy` | [G]oto T[y]pe Definition | `telescope.builtin.lsp_type_definitions` |
| **LSP (Normal)** | `<leader> th` | [T]oggle Inlay [H]ints | `vim.lsp.inlay_hint.enable()` |
| **DAP (Normal)** | `<leader> db` | [D]ebug [B]reakpoint | `dap.toggle_breakpoint()` |
| **DAP (Normal)** | `<leader> dc` | [D]ebug [C]ontinue | `dap.continue()` |
| **DAP (Normal)** | `<leader> dC` | [D]ebug Run to [C]ursor | `dap.run_to_cursor()` |
| **DAP (Normal)** | `<leader> dT` | [D]ebug [T]erminate | `dap.terminate()` |
| **DAP (Normal)** | `<leader> du` | [D]ebug [U]I | `dapui.toggle()` |
| **Mini Around/Inside** | `va)` | [V]isually select [A]round [)]paren |  |
| **Mini Around/Inside** | `yinq` | [Y]ank [I]nside [N]ext [Q]uote |  |
| **Mini Around/Inside** | `ci'` | [C]hange [I]nside [']quote |  |
| **Mini Surroundings** | `saiw)` | [S]urround [A]dd [I]nner [W]ord [)]Paren |  |
| **Mini Surroundings** | `sd'` | [S]urround [D]elete [']quotes |  |
| **Mini Surroundings** | `sr)'` | [S]urround [R]eplace [)] ['] |  |

## Mux Bindings

No tmux installed :) We rely on terminal (look at wezterm.lua)

Leader -> ctrl + a
hsplit -> leader + %
vsplit -> leader + "
move -> leader + [h,j,k,l]
