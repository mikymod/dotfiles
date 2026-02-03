# BASIC SETUP
typeset -U PATH
autoload colors; colors;

# Helper functions to avoid adding duplicate paths
add_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1:$PATH"
    fi
}

add_to_path_suffix() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$PATH:$1"
    fi
}

# HISTORY
HISTFILE=$HOME/.zsh_history
HISTSIZE=50000
HISTFILESIZE=50000
HISTTIMEFORMAT="%F %T "
SAVEHIST=50000

setopt INC_APPEND_HISTORY     # Immediately append to history file.
setopt EXTENDED_HISTORY       # Record timestamp in history.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Dont record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_IGNORE_SPACE      # Dont record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS      # Dont write duplicate entries in the history file.
setopt SHARE_HISTORY          # Share history between all sessions.
unsetopt HIST_VERIFY          # Execute commands using history (e.g.: using !$) immediately

beautiful() {
  while
  do
    i=$((i + 1)) && echo -en "\x1b[3$(($i % 7))mo" && sleep .2
  done
}

spinner() {
  while
  do
    for i in "-" "\\" "|" "/"
    do
      echo -n " $i \r\r"
      sleep .1
    done
  done
}

export XDG_CONFIG_HOME=$HOME/.config

# fzf
if type fzf &> /dev/null && type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

  eval "$(fzf --zsh)"
fi

# fastfetch
if type fastfetch &> /dev/null;  then
    fastfetch
fi

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /Users/mrossi/.config/.dart-cli-completion/zsh-config.zsh ]] && . /Users/mrossi/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

# Source local config (not tracked in git)
if [ -f ~/.zshrc.local ]; then
    source ~/.zshrc.local
fi
