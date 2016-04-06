export HISTSIZE=1000000
export HISTFILESIZE=1000000000
export HISTCONTROL=ignoredups

export PS1='\[\e[2;49;37m\]\w\[\e[m\]$(__git_ps1  " [%s]"): '

source ~/dotfiles/aliases
source ~/dotfiles/git-prompt.sh
