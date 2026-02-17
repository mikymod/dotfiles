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

# Prefer gpg-agent or GNOME Keyring SSH agent when available.
if [ -n "$XDG_RUNTIME_DIR" ]; then
    if [ ! -S "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh" ] && type gpgconf &> /dev/null; then
        gpgconf --launch gpg-agent >/dev/null 2>&1
    fi

    if [ -S "$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh" ]; then
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/S.gpg-agent.ssh"
        SSH_AGENT_USE_KEYRING=1
    elif [ -S "$XDG_RUNTIME_DIR/keyring/ssh" ]; then
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/keyring/ssh"
        SSH_AGENT_USE_KEYRING=1
    fi
fi

# SSH agent bootstrap: start agent, add keys once per session.
# Optional toggles: SSH_AGENT_DEBUG=1 (verbose), SSH_AGENT_QUIET=1 (suppress output).
ssh_agent_add_all() {
    ssh_agent_run() {
        if [ -n "$SSH_AGENT_DEBUG" ] && [ -z "$SSH_AGENT_QUIET" ]; then
            "$@"
        else
            "$@" >/dev/null 2>&1
        fi
    }

    ssh_agent_add_key() {
        if [ -t 0 ]; then
            ssh_agent_run ssh-add "$1" </dev/tty
        else
            ssh_agent_debug "no tty for passphrase prompt; attempting $1 without prompt"
            SSH_ASKPASS_REQUIRE=never ssh_agent_run ssh-add "$1" </dev/null
        fi
    }

    ssh_agent_debug() {
        if [ -n "$SSH_AGENT_DEBUG" ] && [ -z "$SSH_AGENT_QUIET" ]; then
            printf '%s\n' "$*"
        fi
    }

    # If GNOME Keyring manages the agent, skip this helper unless forced.
    if [ -n "$SSH_AGENT_USE_KEYRING" ] && [ -z "$SSH_AGENT_FORCE" ]; then
        ssh_agent_debug "gnome-keyring ssh agent detected; skipping ssh-agent bootstrap"
        return
    fi

    # If the agent already has identities, skip re-adding keys.
    if [ -n "$SSH_AGENT_KEYS_ADDED" ] && [ -z "$SSH_AGENT_FORCE" ]; then
        ssh_agent_debug "ssh-agent keys already processed; set SSH_AGENT_FORCE=1 to rerun"
        return
    fi

    ssh_add_status=2
    if [ -n "$SSH_AUTH_SOCK" ] && type ssh-add &> /dev/null; then
        ssh-add -l >/dev/null 2>&1
        ssh_add_status=$?
        if [ $ssh_add_status -eq 0 ]; then
            ssh_agent_debug "ssh-agent already has identities; adding any missing keys"
        fi

        # Status 2 means the agent is unreachable; discard stale socket.
        if [ $ssh_add_status -eq 2 ]; then
            unset SSH_AUTH_SOCK
        fi
    fi

    if [ -z "$SSH_AUTH_SOCK" ]; then
        ssh_agent_debug "starting ssh-agent"
        eval "$(ssh-agent -s)" >/dev/null 2>&1
    fi

    if [ -n "$SSH_AUTH_SOCK" ] && type ssh-keygen &> /dev/null; then
        ssh_agent_debug "adding ssh keys from $HOME/.ssh"
        find "$HOME/.ssh" -type f \
            ! -name '*.pub' \
            ! -name 'known_hosts*' \
            ! -name 'config' \
            ! -name '*.old' \
            -print0 2>/dev/null | while IFS= read -r -d '' key; do
                if ssh-keygen -l -f "$key" >/dev/null 2>&1; then
                    ssh_agent_debug "adding key $key"
                    ssh_agent_add_key "$key"
                fi
            done
    fi

    SSH_AGENT_KEYS_ADDED=1
}

ssh_agent_add_all

# Source local config (not tracked in git)
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi

# Source local config (not tracked in git)
if [ -f ~/.functions ]; then
    source ~/.functions
fi
