#script runner folder for running commands without sourcing
export PATH="$HOME/bin:$PATH"


#TMUX Variable helper file
TMUX_HELPER_FILE="${HOME}/dotfiles/scripts/helper_functions/tmux_helper.sh"

#TMUX helper functions
    if [ -f "$TMUX_HELPER_FILE" ]; then
        source $TMUX_HELPER_FILE
    fi


#Pass fzf in the terminal
eval "$(fzf --bash)"

#Pass env to tmux Pywal
#eval "$(~/dotfiles/scripts/tmux-pywal.sh)"

#Pass starship in the terminal
eval "$(starship init bash)"


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='eza --color=auto  --icons=always'
alias grep='grep --color=auto'
alias v=nvim
alias t=tmux
alias cat=bat
PS1='[\u@\h \W]\$ '



# Keep a big history
HISTSIZE=50000             # commands kept in memory this session
HISTFILESIZE=100000        # max lines in ~/.bash_history

# Don’t store duplicates
HISTCONTROL=ignoredups:erasedups
# - ignoredups → don’t record the same command twice in a row
# - erasedups → keep only the most recent occurrence of a command

# Ignore trivial/noisy commands
HISTIGNORE="ls:bg:fg:history:clear:exit"

# Append to the history file instead of overwriting
shopt -s histappend

# Record each command as soon as it’s executed (not only when shell exits)
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# Timestamp every entry
HISTTIMEFORMAT="%F %T "



##########TMUX FUNCTIONS AND SCRIPTS######################

fuzzyAll() {
 create_session fuzzyAll
}

fuzzyCurrent() {
 create_session fuzzyCurrent 
}

fuzzyHidden() {
 create_session fuzzyHidden 
}

#TMUX create session keybind
bind -x '"\et": fuzzyAll'

#TMUX create session keybind
bind -x '"\el": fuzzyCurrent'

#TMUX create session keybind
bind -x '"\eh": fuzzyHidden'

#TMUX attach session keybind
bind -x '"\ea": attach_session'

