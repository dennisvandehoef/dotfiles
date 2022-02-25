XIOTIN_BRACKET_COLOR="%{$fg[white]%}"
XIOTIN_TIME_COLOR="%{$fg[yellow]%}"
XIOTIN_DIR_COLOR="%{$fg[cyan]%}"
XIOTIN_GIT_BRANCH_COLOR="%{$fg[green]%}"
XIOTIN_GIT_CLEAN_COLOR="%{$fg[green]%}"
XIOTIN_GIT_DIRTY_COLOR="%{$fg[red]%}"

# These Git variables are used by the oh-my-zsh git_prompt_info helper:
ZSH_THEME_GIT_PROMPT_PREFIX="$XIOTIN_BRACKET_COLOR:$XIOTIN_GIT_BRANCH_COLOR"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_CLEAN=" $XIOTIN_GIT_CLEAN_COLOR✓"
ZSH_THEME_GIT_PROMPT_DIRTY=" $XIOTIN_GIT_DIRTY_COLOR✗"

# Our elements:
XIOTIN_TIME_="$XIOTIN_TIME_COLOR%T %{$reset_color%}"
XIOTIN_DIR_="$XIOTIN_DIR_COLOR\$(__pwd)\$(git_prompt_info) "
XIOTIN_PROMPT="$XIOTIN_BRACKET_COLOR➭ "

source ~/code/private/dotfiles/prompt_helpers.sh
PROMPT="$XIOTIN_TIME_$XIOTIN_DIR_$XIOTIN_PROMPT%{$reset_color%}"
RPROMPT='$(__prompt_aws_profile)|$(__prompt_kube_context)'
