export HISTSIZE=1000000
export HISTFILESIZE=1000000000
export HISTCONTROL=ignoredups

export PS1='\[\e[2;49;37m\]\w\[\e[m\]$(__git_ps1  " [%s]"): '

USER_BASE_PATH=$(python -m site --user-base)
export PATH=$PATH:$USER_BASE_PATH
export PATH=$PATH:$USER_BASE_PATH/bin

export GPG_TTY=$(tty)

source ~/dotfiles/aliases
source ~/dotfiles/git-prompt.sh
