#!/usr/bin/env bash

NOTESDIR="$HOME/notes"

cd ${NOTESDIR} || exit 1

git add . > /dev/null 2>&1

git commit -m "update of my notes on $(date +%d-%B-%Y)" > /dev/null 2>&1

git push -u origin master >  /dev/null 2>&1

echo "Notes successfully updated"

