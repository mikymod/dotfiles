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
	ln -sfn $(DOTFILE_PATH)/nvim/lua $(HOME)/.config/nvim/lua

nvim: $(HOME)/.config/nvim/init.lua $(HOME)/.config/nvim/lua

$(HOME)/.config/zed/settings.json:
	mkdir -p $(HOME)/.config/zed
	ln -sf $(DOTFILE_PATH)/zed/settings.json $(HOME)/.config/zed/settings.json

$(HOME)/.config/zed/keymap.json:
	ln -sf $(DOTFILE_PATH)/zed/keymap.json $(HOME)/.config/zed/keymap.json

zed: $(HOME)/.config/zed/settings.json $(HOME)/.config/zed/keymap.json

$(HOME)/.config/hypr:
	mkdir -p $(HOME)/.config
	ln -sfn $(DOTFILE_PATH)/hypr $(HOME)/.config/hypr

$(HOME)/.config/waybar:
	mkdir -p $(HOME)/.config
	ln -sfn $(DOTFILE_PATH)/hypr/waybar $(HOME)/.config/waybar

hypr: $(HOME)/.config/hypr $(HOME)/.config/waybar

# Skills live in ~/work/mikymod/skills (grouped per organisation). The few still
# here are linked one by one so both sources can share each agent's skills dir.
# Delete this block, skills/ and the .gitignore entry once the last skill moves.
SKILLS := $(DOTFILE_PATH)/skills
SKILL_NAMES := $(sort $(notdir $(patsubst %/,%,$(dir $(wildcard $(SKILLS)/*/SKILL.md)))))

# $(call link_skills,<agent skills dir>) - each agent dir is a real directory
# holding one symlink per skill, so several repos can feed the same agent.
link_skills = if [ -L $(1) ]; then echo "!! $(1) is a symlink; run 'make migrate' in ~/work/mikymod/skills first" >&2; exit 1; fi; mkdir -p $(1); for s in $(SKILL_NAMES); do ln -sfn $(SKILLS)/$$s $(1)/$$s; done

.PHONY: pi codex claude opencode antigravity agents

# pi is the primary coding agent (settings + themes live in pi/)
pi:
	mkdir -p $(HOME)/.pi/agent
	ln -sf $(DOTFILE_PATH)/pi/settings.json $(HOME)/.pi/agent/settings.json
	ln -sfn $(DOTFILE_PATH)/pi/themes $(HOME)/.pi/agent/themes
	@$(call link_skills,$(HOME)/.pi/agent/skills)

codex:
	mkdir -p $(HOME)/.codex
	@$(call link_skills,$(HOME)/.codex/skills)

claude:
	mkdir -p $(HOME)/.claude
	@$(call link_skills,$(HOME)/.claude/skills)

opencode:
	mkdir -p $(HOME)/.config/opencode
	@$(call link_skills,$(HOME)/.config/opencode/skills)

# ~/.gemini/config/skills is the only global path all Antigravity flavours (AGY, CLI, IDE) read
antigravity:
	mkdir -p $(HOME)/.gemini/config
	@$(call link_skills,$(HOME)/.gemini/config/skills)

agents: pi codex claude opencode antigravity

all: zsh bash git ghostty wezterm nvim zed hypr agents
