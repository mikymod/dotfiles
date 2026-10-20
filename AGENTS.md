# AGENTS.md

## Overview
Personal dotfiles repository for Linux (Arch) and Windows. Contains configuration files for shells, editors, terminals, and window managers.

## Commands
- `make all` - Install all dotfiles via symlinks
- `make <target>` - Install specific config (bash, zsh, git, nvim, ghostty, wezterm, zed, hypr, pi)
- `make pi` - Install pi coding agent config (global AGENTS.md, settings.json, skills)
- `./install.ps1` - Install on Windows (PowerShell)

## Structure
- `nvim/` - Neovim config (Lua-based with lazy.nvim plugin manager)
- `hypr/` - Hyprland WM config + Waybar
- `zed/` - Zed editor settings and keymap
- `skills/` - Agent-agnostic skills (SKILL.md format), symlinked into pi, Codex, Claude Code, opencode and Antigravity via `make agents`
- `pi/` - Pi coding agent configuration (settings.json, themes); pi is the primary agent
- `bashrc`, `zshrc` - Shell configs
- `gitconfig`, `githelpers` - Git configuration
- `ghostty_config`, `wezterm.lua` - Terminal emulator configs

## Conventions
- Configs are symlinked to `~/.config/` or `~/` via Makefile
- Neovim uses Lua exclusively (no VimScript)
- Follow existing formatting in each config file type (JSON, Lua, conf)
- Keep configs modular and well-commented for reference
