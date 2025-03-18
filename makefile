UNAME := $(shell uname)
DOTFILE_PATH := $(shell pwd)

$(HOME)/.%: %
	ln -sf $(DOTFILE_PATH)/$^ $@

zsh: $(HOME)/.zshrc

git: $(HOME)/.gitconfig $(HOME)/.githelpers

$(HOME)/.config/ghostty/config:
	mkdir -p $(HOME)/.config/ghostty
	ln -sf $(DOTFILE_PATH)/ghostty_config $(HOME)/.config/ghostty/config

ghostty: $(HOME)/.config/ghostty/config

$(HOME)/.config/zed/settings.json:
	mkdir -p $(HOME)/.config/zed
	ln -sf $(DOTFILE_PATH)/zed_settings.json $(HOME)/.config/zed/settings.json

zed: $(HOME)/.config/zed/settings.json
