UNAME := $(shell uname)
DOTFILE_PATH := $(shell pwd)

$(HOME)/.%: %
	ln -sf $(DOTFILE_PATH)/$^ $@

bash: $(HOME)/.bashrc $(HOME)/.bash_profile

zsh: $(HOME)/.zshrc

git: $(HOME)/.gitconfig $(HOME)/.githelpers

$(HOME)/.config/ghostty/config:
	mkdir -p $(HOME)/.config/ghostty
	ln -sf $(DOTFILE_PATH)/ghostty_config $(HOME)/.config/ghostty/config

ghostty: $(HOME)/.config/ghostty/config

$(HOME)/.config/nvim/init.lua:
	mkdir -p $(HOME)/.config/nvim
	ln -sf $(DOTFILE_PATH)/nvim_config.lua $(HOME)/.config/nvim/init.lua

nvim: $(HOME)/.config/nvim/init.lua

all: zsh bash git ghostty nvim
