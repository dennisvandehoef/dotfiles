alias ..="cd .."

alias ls='ls -al'
alias dotfiles="cd ~/dotfiles"
alias code="/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code"

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
alias data="source ~/dotfiles/aws-switch-to.sh data"

update_ruby(){
  local version=$1

  echo $version >.ruby-version
  sed -i -E "s/FROM ruby:[a-z0-9.-]{2,}/FROM ruby:$version/" Dockerfile
  sed -i -E "s/ruby [a-z0-9.-]{2,}/ruby $version/" Gemfile.lock
  docker-compose build
}

t_plan(){
  local env=$1

  if [ -z "$env" ]; then
    env='staging'
  fi

  source ~/dotfiles/aws-switch-to.sh $env
  echo "AWS swiched to $(__colored_aws_env)"

  terraform init --backend-config=$env.backend --reconfigure
  if [ -f "$env.tfvars" ]; then
    terraform plan --var-file=$env.tfvars
  elif [ -f "common.tfvars" ]; then
    terraform plan --var-file=common.tfvars
  else
    terraform plan
  fi
}

t_apply(){
  local env=$1

  if [ -z "$env" ]; then
    env='staging'
  fi

  source ~/dotfiles/aws-switch-to.sh $env
  echo "AWS swiched to $(__colored_aws_env)"

  if [ -f "$env.tfvars" ]; then
    terraform apply --var-file=$env.tfvars
  elif [ -f "common.tfvars" ]; then
    terraform apply --var-file=common.tfvars
  else
    terraform apply
  fi
}
