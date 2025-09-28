#!/usr/bin/env bash

create_session() {
    
    local newSession selectedDir dirname

#Conditional patterns for executing fuzzy search by directory stdout would be the selected DIR
   case $1 in 
    fuzzyAll)
     selectedDir=$(find "$HOME" -maxdepth 4 -type d ! -path "*/.*" | fzf \
        --prompt "  Choose Session Directory: " \
        --info=hidden \
        --pointer= \
        --border=double \
        --margin=10% \
        --marker= \
        --border-label="[ Create Session All]" \
        )
     ;;
    fuzzyHidden)
       selectedDir=$(find "$HOME" -maxdepth 4 -type d -path "*/.*" ! -name "." ! -name ".." | fzf \
        --prompt "  Choose Session Directory: " \
        --info=hidden \
        --pointer= \
        --border=double \
        --margin=10% \
        --marker= \
        --border-label="[ Create Session Hidden]" \
        )
     ;;
    fuzzyCurrent)
       selectedDir=$(find "." -maxdepth 6 -type d  | fzf \
        --prompt "  Choose Session Directory: " \
        --info=hidden \
        --pointer= \
        --border=double \
        --margin=10% \
        --marker= \
        --border-label="[ Create Session CWD]" \
        )
     ;;
    *) 
        echo "Not a keybind for fuzzy searching"
  esac

    [ -z "$selectedDir" ] && return 1

    windowName=$(basename "$selectedDir")
    #sessionName=$(echo "$selectedDir" | cut -d'/' -f 4)
    sessionName=$(basename "$selectedDir")
    echo "Selected Directory: ${selectedDir}"
    echo "Session Name: $sessionName"
    echo "Window Name: ${windowName}"

        #tmux new-session -ds "$sessionName" -c "${selectedDir}" -n "${windowName}"
   

   if tmux has-session -t $sessionName 2>/dev/null; then
       
       if [[ -n $TMUX ]]; then 
           
           tmux switch-client -t "$sessionName"
       
       else 

       tmux attach -t "$sessionName"

       fi

   else 
        
       tmux new-session -ds "$sessionName" -c "${selectedDir}" -n "${windowName}"


   fi

}

attach_session() {

  if [[ -n $TMUX ]]; then
      local active_sesh

      active_sesh="$(tmux display-message -p '#S')" 
      tmux switch-client -t "$active_sesh"

  else

  if tmux has-session 2> /dev/null; then 

      tmux attach -t "$(tmux display-message -p '#S' || echo ${sessionName})"

  else
      tmux new-session -s "${sessionName}"
  fi

  fi  

}


