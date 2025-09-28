#!/usr/bin/bash
Year=$(date +%Y)
Month=$(date +%B)
Day=$(date +%d)
Daily_Dir="${HOME}/notes/general/Daily/${Year}/${Month}"
Daily_Note="${HOME}/notes/general/Daily/${Year}/${Month}/${Day}_${Month}_${Year}_DailyNote.md"
Note_Title=$(basename "${Daily_Note}")

# 1. Ensure folder exists
mkdir -p "${Daily_Dir}" 

# 2. Only create file if it doesn't exist
if [[ ! -f "${Daily_Note}" ]]; then
touch "${Daily_Note}" && cat > "$Daily_Note" << EOF
# **DAILY NOTE**



## 🎯 **Today's Goals**
- 

## 📝 **Notes**


## ✅ **Tasks**
- [ ] 


## 🧠 **Ideas & Thoughts**


## 📚 **Learning**


## 🔗 **Links & References**


## 🎉 **Wins & Accomplishments**


## 🤔 **Reflections**


---
**Created: $(date +%d-%B-%Y)**
EOF
fi

# Name of the tmux session
SESSION="${Note_Title}"

open_in_tmux() {
    # Check if session exists
    if ! tmux has-session -t "$SESSION" 2>/dev/null; then
        # Create new session with session-local detach-on-destroy
        tmux new-session -d -s "$SESSION" -E nvim "${Daily_Note}"
        tmux set-option -t "Today_Note" detach-on-destroy on
    else
        # Attach if it already exists
        tmux attach -t "$SESSION"
    fi 
}

# Check if we're already in a terminal session
# Look for specific terminal indicators or check if stdin is a terminal
if [[ -n "$TMUX" || -n "$KITTY_WINDOW_ID" ||  -n "$KITTY_PID" ]]; then
    open_in_tmux 
else
    open_in_tmux 
fi
