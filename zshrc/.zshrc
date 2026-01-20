#script runner folder for running commands without sourcing
export PATH="$HOME/bin:$PATH"

##### --- Plugin Manager: Zinit --- #####
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# Example useful plugins (uncomment if you want them):
 zinit light zsh-users/zsh-syntax-highlighting
 zinit light zsh-users/zsh-autosuggestions
 zinit light zsh-users/zsh-completions

#Completion styling
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
 
# Load Completions
 autoload -U compinit && compinit

##### --- Only run in interactive shells --- #####
[[ $- != *i* ]] && return


##### --- Aliases --- #####
alias ls='eza --color=auto --icons=always'
alias grep='grep --color=auto'
alias v=nvim
alias t=tmux
alias cat=bat
alias ob='obsidian --enable-features=UseOzonePlatform --ozone-platform=wayland --disable-gpu-sandbox --force-device-scale-factor=1'
alias .='pwd'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias cd..='cd ..'

# Tip: use \ls or \cat to bypass these aliases


##### --- Prompt (Starship) & Keymap --- #####
#set -o vi                     # enable vi mode in ZLE

eval "$(starship init zsh)"   # init Starship AFTER vi mode
#
#Source fzf
source <(fzf --zsh)


##### --- History Settings --- #####
HISTFILE=~/.zsh_history
HISTSIZE=100000               # commands kept in memory this session
HISTFILESIZE=100000           # max lines stored in file

# History behavior
setopt INC_APPEND_HISTORY     # write commands immediately
setopt SHARE_HISTORY          # share history across sessions
setopt HIST_IGNORE_ALL_DUPS   # remove older duplicate commands anywhere
setopt HIST_EXPIRE_DUPS_FIRST # expire oldest duplicates first
setopt APPEND_HISTORY         # append to history file, don’t overwrite
setopt EXTENDED_HISTORY       # save timestamp + duration
setopt HIST_REDUCE_BLANKS     # strip superfluous spaces

# Security
setopt HIST_IGNORE_SPACE      # don’t record commands starting with a space
setopt HIST_NO_STORE          # don’t record the `history` command itself
# Example: run " mysql -p" (note leading space) → won’t be saved

#TMUX Variable helper file
TMUX_HELPER_FILE="${HOME}/dotfiles/scripts/helper_functions/tmux_helper.sh"

#TMUX helper functions
    if [ -f "$TMUX_HELPER_FILE" ]; then
        source $TMUX_HELPER_FILE
    fi

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

attach_sess() {
    attach_session
}


zle -N fuzzyAll
zle -N fuzzyCurrent
zle -N fuzzyHidden

#TMUX create session keybind
bindkey '^[t' fuzzyAll

#TMUX create session keybind
bindkey '^[l' fuzzyCurrent

#TMUX create session keybind
bindkey '^[h' fuzzyHidden

#TMUX attach session keybind
bindkey -s '^[a' 'attach_sess\n'
