# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export EDITOR="hx"

eval "$(/home/danipoma/.local/bin/mise activate bash)"
. "$HOME/.cargo/env"

# Wasmer
export WASMER_DIR="/home/danipoma/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

export WASMTIME_HOME="$HOME/.wasmtime"

export PATH="$WASMTIME_HOME/bin:$PATH"

eval "$(fzf --bash)"
eval "$(zoxide init bash)"

# We also check for $KDE_FULL_SESSION since SSDM doesn't handle Zellij
# so we postpone autorunning zellij until we are in session fully.
# Gave me a scare that I was seeing black screen, but tty handled it like a champ
if [[ -z "$ZELLIJ" && $KDE_FULL_SESSION == "true" ]]; then
    ZELLIJ_AUTO_ATTACH="true"
    ZELLIJ_AUTO_EXIT="true"

    if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
        zellij attach -c
    else
        zellij
    fi

    if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
        exit
    fi
fi
