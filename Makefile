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

# imv is the default image viewer. mimeapps.list is not tracked (it holds
# machine-specific entries), so the defaults are set with xdg-mime instead.
IMAGE_TYPES := image/png image/jpeg image/gif image/webp image/bmp image/tiff

$(HOME)/.config/imv/config:
	mkdir -p $(HOME)/.config/imv
	ln -sf $(DOTFILE_PATH)/imv_config $(HOME)/.config/imv/config

.PHONY: imv

imv: $(HOME)/.config/imv/config
	xdg-mime default imv.desktop $(IMAGE_TYPES)

# pi is the primary coding agent (settings + themes live in pi/).
# Skills are not part of this repo: they live in ~/work/mikymod/skills, grouped per
# organisation, and that repo's own Makefile links them into every agent.
.PHONY: pi

pi:
	mkdir -p $(HOME)/.pi/agent
	ln -sf $(DOTFILE_PATH)/pi/settings.json $(HOME)/.pi/agent/settings.json
	ln -sfn $(DOTFILE_PATH)/pi/themes $(HOME)/.pi/agent/themes

all: zsh bash git ghostty wezterm nvim zed hypr imv pi
