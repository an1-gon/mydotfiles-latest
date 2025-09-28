#!/usr/bin/env bash

# Colors (ANSI codes for fzf menu)
YELLOW="\033[33m"
CYAN="\033[36m"
RESET="\033[0m"

# Function: format tmux list with icons
get_list() {
    tmux list-windows -a -F '#S:#I:#W' | while IFS=: read -r session index name; do
        # Mark current window with a star
        if [ "$session:$index" = "$(tmux display-message -p '#S:#I')" ]; then
            icon="⭐"
        else
            icon="🖥"
        fi
        printf "%b %s:%s:%s%b\n" "$CYAN$icon$RESET" "$session" "$index" "$name" "$RESET"
    done
}

# Function: live preview of panes in selected window
preview_panes() {
    target=$(echo "$1" | sed 's/^[^ ]* //')  # Strip icon
    tmux list-panes -t "$target" -F '#{pane_index}: #{pane_title} [#{pane_current_command}]'
}

# Main fzf menu
selected=$(get_list | \
    fzf --height=100% --reverse \
        --ansi \
        --header=$'⏎ Switch • CTRL-X Kill Window • CTRL-N New Window' \
        --preview 'preview_panes {}' \
        --bind 'ctrl-x:execute(tmux kill-window -t $(echo {} | sed "s/^[^ ]* //"))+reload(get_list)' \
        --bind 'ctrl-n:execute(tmux new-window -t $(echo {} | sed "s/^[^ ]* //"))+reload(get_list)'
)

# If nothing selected, exit
[ -z "$selected" ] && exit 0

# Extract real target
target=$(echo "$selected" | sed 's/^[^ ]* //')

# Switch to chosen window
tmux switch-client -t "$target"

