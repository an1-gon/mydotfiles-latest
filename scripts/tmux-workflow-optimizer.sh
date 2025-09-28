#!/usr/bin/env bash
set -euo pipefail

choice=$(find . -type d | fzf)

# Exit if nothing selected
if [[ -z "$choice" ]]; then
  echo "No directory selected, exiting."
  exit 1
fi

# Remove leading './' if present
choice=${choice#./}

selectedDir="$HOME/$choice"

folderName=$(basename $selectedDir)

echo "starting a tmux session to: $selectedDir"
tmux new-session -s $folderName -c "$selectedDir"

