UNAME := $(shell uname)
DOTFILE_PATH := $(shell pwd)

$(HOME)/.%: %
	ln -sf $(DOTFILE_PATH)/$^ $@

zsh: $(HOME)/.zshrc

git: $(HOME)/.gitconfig $(HOME)/.githelpers

$(HOME)/bin/tmux-sessionizer:
	mkdir -p $(HOME)/bin
	ln -sf $(DOTFILE_PATH)/bin/tmux-sessionizer $(HOME)/bin/tmux-sessionizer
	chmod +x $(HOME)/bin/tmux-sessionizer

tmux: $(HOME)/.tmux.conf $(HOME)/bin/tmux-sessionizer

$(HOME)/.config/ghostty/config:
	mkdir -p $(HOME)/.config/ghostty
	ln -sf $(DOTFILE_PATH)/ghostty_config $(HOME)/.config/ghostty/config

ghostty: $(HOME)/.config/ghostty/config

$(HOME)/.config/nvim/init.lua:
	mkdir -p $(HOME)/.config/nvim
	ln -sf $(DOTFILE_PATH)/nvim_config.lua $(HOME)/.config/nvim/init.lua

nvim: $(HOME)/.config/nvim/init.lua

$(HOME)/.config/zed/settings.json:
	mkdir -p $(HOME)/.config/zed
	ln -sf $(DOTFILE_PATH)/zed_settings.json $(HOME)/.config/zed/settings.json

zed: $(HOME)/.config/zed/settings.json

all: zsh git tmux ghostty nvim zed
