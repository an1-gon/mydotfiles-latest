#!/usr/bin/env bash

# Source Pywal colors
if [ -f "$HOME/.cache/wal/colors.sh" ]; then
    source "$HOME/.cache/wal/colors.sh"

    # Export all 16 colors to tmux environment
    for i in {0..15}; do
        tmux set-environment -g COLOR$i "${!color$i}"
    done

    # Export foreground and background
    tmux set-environment -g FOREGROUND "$foreground"
    tmux set-environment -g BACKGROUND "$background"
fi

