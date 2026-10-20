UNAME := $(shell uname)
DOTFILE_PATH := $(shell pwd)

$(HOME)/.%: %
	ln -sf $(DOTFILE_PATH)/$^ $@

bash: $(HOME)/.bashrc $(HOME)/.bash_profile $(HOME)/.functions

zsh: $(HOME)/.zshrc

git: $(HOME)/.gitconfig $(HOME)/.githelpers

wezterm: $(HOME)/.wezterm.lua

$(HOME)/.config/ghostty/config:
	mkdir -p $(HOME)/.config/ghostty
	ln -sf $(DOTFILE_PATH)/ghostty_config $(HOME)/.config/ghostty/config

ghostty: $(HOME)/.config/ghostty/config

$(HOME)/.config/nvim/init.lua:
	mkdir -p $(HOME)/.config/nvim
	ln -sf $(DOTFILE_PATH)/nvim/init.lua $(HOME)/.config/nvim/init.lua

$(HOME)/.config/nvim/lua:
	ln -sf $(DOTFILE_PATH)/nvim/lua $(HOME)/.config/nvim/lua

nvim: $(HOME)/.config/nvim/init.lua $(HOME)/.config/nvim/lua

$(HOME)/.config/zed/settings.json:
	mkdir -p $(HOME)/.config/zed
	ln -sf $(DOTFILE_PATH)/zed/settings.json $(HOME)/.config/zed/settings.json

$(HOME)/.config/zed/keymap.json:
	ln -sf $(DOTFILE_PATH)/zed/keymap.json $(HOME)/.config/zed/keymap.json

zed: $(HOME)/.config/zed/settings.json $(HOME)/.config/zed/keymap.json

$(HOME)/.config/hypr:
	mkdir -p $(HOME)/.config
	ln -sf $(DOTFILE_PATH)/hypr $(HOME)/.config/hypr

$(HOME)/.config/waybar:
	mkdir -p $(HOME)/.config
	ln -sf $(DOTFILE_PATH)/hypr/waybar $(HOME)/.config/waybar

hypr: $(HOME)/.config/hypr $(HOME)/.config/waybar

# Agent-agnostic skills: one source in $(SKILLS), symlinked into every coding agent.
# SKILL.md format is shared by pi, Codex, Claude Code, opencode and Antigravity.
SKILLS := $(DOTFILE_PATH)/skills

.PHONY: pi codex claude opencode antigravity agents

# pi is the primary coding agent (settings + themes live in pi/)
pi:
	mkdir -p $(HOME)/.pi/agent
	ln -sf $(DOTFILE_PATH)/pi/settings.json $(HOME)/.pi/agent/settings.json
	ln -sf $(SKILLS) $(HOME)/.pi/agent/skills
	ln -sf $(DOTFILE_PATH)/pi/themes $(HOME)/.pi/agent/themes

codex:
	mkdir -p $(HOME)/.codex
	ln -sf $(SKILLS) $(HOME)/.codex/skills

claude:
	mkdir -p $(HOME)/.claude
	ln -sf $(SKILLS) $(HOME)/.claude/skills

opencode:
	mkdir -p $(HOME)/.config/opencode
	ln -sf $(SKILLS) $(HOME)/.config/opencode/skills

# ~/.gemini/config/skills is the only global path all Antigravity flavours (AGY, CLI, IDE) read
antigravity:
	mkdir -p $(HOME)/.gemini/config
	ln -sf $(SKILLS) $(HOME)/.gemini/config/skills

agents: pi codex claude opencode antigravity

all: zsh bash git ghostty wezterm nvim zed hypr agents
