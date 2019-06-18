[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*


# starting x
   if [ -z "$DISPLAY" ] && [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ]; then
       clear
       # some ascii art
       cat /home/jakub/.bash_start_art.txt
       read -n 1 -p "" answer
       echo
           if [[ $answer =~ ^[Yy]$ ]]
           then
               # start x but without output
               [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- -keeptty > ~/.xorg.log 2>&1
               clear
           else
               clear
           fi
   fi

   . ~/.bashrc
