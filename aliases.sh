alias .='cd . && ls -al'
alias ..="cd .."
alias ...="cd ../.."

alias ls='ls -al'

alias code="cd ~/code"
alias dotfiles="cd ~/dotfiles"

# GIT
alias g="git"
alias gpl="git pl"
alias gps="git push"
alias gst="git st"

# EKS
alias staging="source ~/dotfiles/aws-switch-to.sh staging"
alias production="source ~/dotfiles/aws-switch-to.sh production"
alias services="source ~/dotfiles/aws-switch-to.sh services"
alias kaeuferportal="source ~/dotfiles/aws-switch-to.sh kaeuferportal"

# Docker
dash()
{
  local service=$1

  if [ -z "$service" ]; then
    service='web'
  fi

  docker-compose run --no-deps --rm $service /bin/bash
}
