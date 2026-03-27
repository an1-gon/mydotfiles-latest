#!/usr/bin/env bash

# 1. Get input
url=$(rofi -theme "$HOME/dotfiles/rofi/colors.rasi" -dmenu -p "WEB SEARCH")

# 2. Exit if empty (User pressed Escape)
if [[ -z "$url" ]]; then
    exit
fi

# 3. Construct the full string to test
full_url="https://www.$url"

# 4. Use Symbolic Notation (Regex) to validate

# We use [[ ]] for the =~ operator
if [[ "$full_url" =~ ^https?://www\.[a-zA-Z0-9.-]+\.[a-z]{1,3}$ ]]; then
    firefox "$full_url"
else
    echo "Invalid pattern: $full_url"
fi
