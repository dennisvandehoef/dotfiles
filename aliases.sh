alias ..="cd .."

alias ls='ls -alhG'
alias dotfiles="cd ~/code/private/dotfiles"
alias arh="cd ~/code/arh"
alias private="cd ~/code/private"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

# GIT
alias g="git"
alias gpl="git pl"
alias gps="git push"
alias gst="git st"

# EKS
alias staging="source ~/code/private/dotfiles/aws-switch-to.sh staging"
alias production="source ~/code/private/dotfiles/aws-switch-to.sh production"
alias services="source ~/code/private/dotfiles/aws-switch-to.sh services"
alias kaeuferportal="source ~/code/private/dotfiles/aws-switch-to.sh kaeuferportal"
alias development="source ~/code/private/dotfiles/aws-switch-to.sh development"
alias data="source ~/code/private/dotfiles/aws-switch-to.sh data"

update_ruby(){
  local version=$1

  echo $version >.ruby-version
  sed -i -E "s/FROM ruby:[a-z0-9.-]{2,}/FROM ruby:$version/" Dockerfile
  sed -i -E "s/ruby [a-z0-9.-]{2,}/ruby $version/" Gemfile.lock
  docker-compose build
}
