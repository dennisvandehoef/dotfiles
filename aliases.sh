alias ..="cd .."

alias ls='ls -alhG'
alias dotfiles="cd ~/code/private/dotfiles"

# GIT
alias g="git"
alias gpl="git pl"
alias gps="git push"
alias gst="git st"

# Docker
alias docker-compose="docker compose"
alias dclean="docker container prune -f && docker image prune -af --filter until=168h && docker volume prune -af"

# AWS & EKS
source ~/code/private/dotfiles/aws-switch-to.sh
alias staging="aws_switch_to staging"
alias production="aws_switch_to production"
alias services="aws_switch_to services"
alias kaeuferportal="aws_switch_to kp"
alias development="aws_switch_to dev"
alias data="aws_switch_to data"

update_ruby(){
  local version=$1

  echo $version >.ruby-version
  sed -i -E "s/FROM ruby:[a-z0-9.-]{2,}/FROM ruby:$version/" Dockerfile
  sed -i -E "s/ruby [a-z0-9.-]{2,}/ruby $version/" Gemfile.lock
  docker-compose build
}

function cursor {
  open -a "/Applications/Cursor.app" "$@"
}
