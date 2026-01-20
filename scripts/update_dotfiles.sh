#!/usr/bin/env bash 

DOT_FOLDER="$HOME/dotfiles"

cd $DOT_FOLDER || exit 1

git add . #> /dev/null 2&>1

git commit -m "dot files updated on $(date +%d-%B-%Y)" #> /dev/null 2&>1

git push -u origin main > /dev/null 2&>1

echo "Dot files updated to github"
