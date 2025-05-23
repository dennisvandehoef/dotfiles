# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390216875
ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="xiotin"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(aws docker docker-compose ssh-agent asdf)

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities dennish_kp dennish_kp.old ops

source $ZSH/oh-my-zsh.sh

# User configuration

export HISTSIZE=1000000
export HISTFILESIZE=1000000000
export HISTCONTROL=ignorespace:ignoredups

set show-all-if-ambiguous on
set completion-ignore-case on

if [ -f ~/.asdf/asdf.sh ] ; then
    . "$HOME/.asdf/asdf.sh"
  export PATH="$HOME/.asdf/shims:$PATH"
  . "$HOME/.asdf/completions/asdf.bash"
fi

source ~/code/private/dotfiles/aliases.sh

if command -v python 2>&1 >/dev/null
then
    PYTHON_BASE_PATH=$(python -m site --user-base)
    export PATH=$PATH:$PYTHON_BASE_PATH
    export PATH=$PATH:$PYTHON_BASE_PATH/bin
fi

export PATH=$PATH:$HOME/go/bin

if command -v yarn 2>&1 >/dev/null
then
    export PATH="$PATH:$(yarn global bin)"
fi

if command -v direnv 2>&1 >/dev/null
then
    eval "$(direnv hook zsh)"
fi

export GOPATH=$HOME/go
export GOPRIVATE=codevault.io
export GOPROXY=direct
export CGO_ENABLED=0
export ASDF_GOLANG_MOD_VERSION_ENABLED=true

export GPG_TTY=$(tty)


if [ -f ~/secrets.sh ] ; then
    echo -n "loading secrets "
    source ~/secrets.sh
    echo "done"
else
    echo "skiped loading secrets"
fi

#start in the most logical directory
if [[ ! $(pwd) =~ "/code/" ]] ; then
    if [[ $USER == "dennis.vandehoef" ]]; then # work
        cd ~/code/arh
    else
        cd ~/code/private
    fi
fi
