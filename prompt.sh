__prompt_aws ()
{
  if [ -z "$AWS_ACCOUNT_NAME" ]; then
    exit 0
  fi

  printf -- "$(__prompt_non_higlight '|')$(__colored_aws_env)"
}

__colored_aws_env(){
  local account=$AWS_ACCOUNT_NAME
  local color='0;35m'

  case "$account" in
    production)    color='0;31m' ;;
    staging)       color='0;32m' ;;
    kaeuferportal) color='0;33m' ;;
    services)      color='0;36m' ;;
  esac

  printf -- "\e[$color$account\e[m"
}

__prompt_git ()
{
  local git_str=$(__git_ps1  "%s")

  if [ -z "$git_str" ]; then
    exit 0
  fi

  printf -- "$(__prompt_non_higlight '|')$git_str"
}

__prompt_non_higlight ()
{
  printf -- "\e[2;49;37m$1\e[m"
}
