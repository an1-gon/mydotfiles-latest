#!/usr/bin/env bash

# === Config ===
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tmux-sessionizer"
CONFIG_FILE="$CONFIG_DIR/tmux-sessionizer.conf"
PANE_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/tmux-sessionizer"
PANE_CACHE_FILE="$PANE_CACHE_DIR/panes.cache"

# Load config if exists
[[ -f "$CONFIG_FILE" ]] && source "$CONFIG_FILE"

# Check dependencies
command -v tmux >/dev/null || { echo "Please install tmux"; exit 1; }
command -v fzf >/dev/null || { echo "Please install fzf"; exit 1; }

# === Helper: switch to or attach session ===
switch_to() {
    if [[ -z $TMUX ]]; then
        tmux attach-session -t "$1"
    else
        tmux switch-client -t "$1"
    fi
}

# === Helper: check if session exists ===
has_session() {
    tmux list-sessions 2>/dev/null | grep -q "^$1:"
}

# === Find project directories to choose from ===
find_dirs() {
    # Example: Search your home directory for folders, ignoring .git
    find ~ -mindepth 1 -maxdepth 2 -type d -path '*/.git' -prune -o -print
}

# === Main ===
selected="$1"

if [[ -z $selected ]]; then
    selected=$(find_dirs | fzf)
fi

# Exit if nothing selected
[[ -z $selected ]] && exit 0

# Use folder name as session name (replace dots with underscores)
session_name=$(basename "$selected" | tr '.' '_')

# Start tmux if not running
if ! pgrep tmux >/dev/null; then
    tmux new-session -ds "$session_name" -c "$selected"
    echo "Started new tmux session: $session_name"
else
    # Create session if it doesn't exist
    if ! has_session "$session_name"; then
        tmux new-session -ds "$session_name" -c "$selected"
        echo "Created new tmux session: $session_name"
    fi
    # Switch to the session
    switch_to "$session_name"
fi

