#!/bin/bash

# Description: Simple application launcher using wofi and fzf-style filtering

# Use wofi to select and run an application from the list of .desktop files
wofi --show drun --prompt "Launch: " --insensitive --width 400 --height 300 --hide-scroll --columns 1

