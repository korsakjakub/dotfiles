set -o vi
source $HOME/.bash-powerline.sh

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
alias fz='zathura $(find | grep .pdf$ | fzf)'
alias r='ranger'
alias gg='cd ~/Developer/go/src/github.com/korsakjakub'
alias o='xdg-open'
alias 4sem='cd ~/Documents/4sem'

export GOPATH=/home/jakub/Developer/go
