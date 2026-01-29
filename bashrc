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

# Set history file, size, and format
export HISTFILE=$HOME/.bash_history
export HISTSIZE=50000
export HISTFILESIZE=50000 
export HISTTIMEFORMAT="%F %T "

# fzf
if type fzf &> /dev/null && type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*" --glob "!vendor/*"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"

  eval "$(fzf --bash)"
fi

# fastfetch
if type fastfetch &> /dev/null;  then
    fastfetch
fi

# Source local config (not tracked in git)
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

