export HISTSIZE=1000000
export HISTFILESIZE=1000000000
export HISTCONTROL=ignorespace:ignoredups

source ~/dotfiles/aliases.sh
source ~/dotfiles/git-prompt.sh
source ~/dotfiles/git-completion.sh
source ~/dotfiles/prompt.sh

export PS1='$(__prompt_non_higlight "\w")$(__prompt_git)$(__prompt_aws)$(__prompt_non_higlight ">") '

USER_BASE_PATH=$(python -m site --user-base)
export PATH=$PATH:$USER_BASE_PATH
export PATH=$PATH:$USER_BASE_PATH/bin

export GPG_TTY=$(tty)


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
