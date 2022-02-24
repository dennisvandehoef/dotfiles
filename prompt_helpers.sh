#!/usr/bin/env bash

__prompt_kube_context(){
  if [ -z "$ZSH_KUBECTL_CONTEXT" ]; then
    exit 0
  fi

  if [[ $ZSH_KUBECTL_CONTEXT == *"arn:aws"* ]]; then
    cluster=$(__colored_string ${ZSH_KUBECTL_CONTEXT##*/})
    echo "<k:$cluster/$ZSH_KUBECTL_NAMESPACE>"
    exit 0
  fi

  echo $ZSH_KUBECTL_PROMPT
}

__prompt_aws_profile(){
  if [ -z "$AWS_ACCOUNT_NAME" ]; then
    exit 0
  fi

  echo "<a:$(__colored_string ${AWS_ACCOUNT_NAME})>"
}

__colored_string() {
  local input=$1
  local color="214" # orange

  if [[ $input =~ "staging" ]]; then
    color="087" # aqua
  fi

  if [[ $input =~ "production" ]]; then
    color="196" # red
  fi

  if [[ $input =~ "services" ]]; then
    color="075" # blue
  fi

  if [[ $input =~ "development" ]]; then
    color="076" # green
  fi

  echo "%{$FG[$color]%}$input%{$reset_color%}"
}
