UNAME := $(shell uname)
DOTFILE_PATH := $(shell pwd)

$(HOME)/.%: %
	ln -sf $(DOTFILE_PATH)/$^ $@

bash: $(HOME)/.bashrc $(HOME)/.bash_profile

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

all: zsh bash git ghostty wezterm nvim zed hypr
