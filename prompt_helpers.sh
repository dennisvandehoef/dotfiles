#!/usr/bin/env bash

__prompt_kube_context(){
  context=$(kubectl config current-context 2> /dev/null) || exit 0

  if [[ $context == *"arn:aws"* ]]; then
    echo $(__colored_string ${context##*/})
    exit 0
  fi

  echo $context
}

__prompt_aws_profile(){
  if [ -z "$AWS_ACCOUNT_NAME" ]; then
    exit 0
  fi


  echo "$(__colored_string ${AWS_ACCOUNT_NAME})"
}

__colored_string() {
  local input=$1
  local color="214" # orange

  count=$(echo $input | xxd -p | sed -E "s/[a-z]//g")
  while [ 231 -le $count ]
  do
    count=$(echo $((count / 15)))
  done

  # # colors unreadable on black bg: 52 16 17 18 0
  # if [$count = "0"] || [$count = "16"] || [$count = "17"] || [$count = "18"] || [$count = "52"]; then
  #   count=$(echo $((count + 10)))
  # fi
  color="000$count"
  color=$(echo ${color: -3})

  echo "%{$FG[$color]%}$input%{$reset_color%}"
}

__pwd(){
  code_home="$HOME/code/"
  path=${PWD/"$code_home"/}
  echo ${path/private/prv}
}
