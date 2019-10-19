set -o vi
source '/home/jakub/.bash-powerline.sh'
PATH=$PATH:/home/jakub/.gem/ruby/2.6.0/bin:/home/jakub/.local/bin
XDG_DATA_HOME=$HOME/.config
export XDG_DATA_HOME
export TERMINAL=st
export BROWSER=firefox
export GOPATH="/home/user/Developer/go"

#Aliases
alias sl='ls'
alias la='ls -la'
alias l='ls'
alias cl='clear; ls'
alias cll='clear; ls -a'
alias gdv='cd ~/Developer/'
alias gdc='cd ~/Documents/'
alias gd='cd ~/Downloads/'
alias gh='cd ~/'
alias gc='cd ~/.config'
alias start='bash ~/Developer/scripts/startx.sh'
alias v='nvim'
alias vim='nvim'
alias sv='sudo nvim'
alias p='pacman'
alias sp='sudo pacman'
alias pdf='zathura'
alias gw='gcalcli calw'
alias gm='gcalcli calm'
alias fv='nvim $(fzf)'
alias fcv='cd ~/.config; nvim $(fzf)'
alias ff='feh $(fzf)'
alias fz='zathura $(fzf)'
alias r='ranger'
