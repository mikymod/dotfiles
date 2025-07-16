# Helper function to avoid adding duplicate paths
add_to_path() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH"
    fi
}

add_to_path_suffix() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

# Set history file, size, and format
export HISTFILE=$HOME/.bash_history
export HISTSIZE=50000
export HISTFILESIZE=50000 
export HISTTIMEFORMAT="%F %T " 
