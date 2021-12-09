#!/usr/bin/env bash

function aws_switch_to () {
  envname=$1

  export AWS_PROFILE=$envname
  export AWS_ACCOUNT_NAME=$envname
  export AWS_DEFAULT_REGION=eu-central-1

  aws sts get-caller-identity

  echo "Please provide the wished cluster name or type one of the following options:"
  echo " - Use 'list' or 'l' to list available clusters and select one"
  echo " - Use 'none', 'n' or press enter to skip connecting to a cluster"
  read cluster_name

  if [[ "$cluster_name" == "none" || "$cluster_name" == "n" ]]; then
    cluster_name=""
  fi

  if [[ "$cluster_name" == "list" || "$cluster_name" == "l" ]]; then
    echo "Please select a cluster by number"
    echo "0) None (skip connecting to a cluster)"
    cluster_name=""
    select cluster_name in $(aws eks list-clusters --query clusters --output text); do
      break
    done
  fi

  if [[ "$cluster_name" != "" ]]; then
    aws eks update-kubeconfig --name $cluster_name --region $AWS_DEFAULT_REGION
  fi
}
