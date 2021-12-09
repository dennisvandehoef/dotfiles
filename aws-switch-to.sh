#!/usr/bin/env bash

function aws_switch_to () {
  envname=$1

  export AWS_PROFILE=$envname
  export AWS_ACCOUNT_NAME=$envname
  export AWS_DEFAULT_REGION=eu-central-1

  aws sts get-caller-identity

  echo "Please provide the target cluster name. (Use list to 'list'or 'l' avalible clusters, use 'none' or 'n' to skipp connecting to a cluster) "
  echo " - Use list to 'list'or 'l' avalible clusters"
  echo " - Use 'none', 'n' or press enter to skip connecting to a cluster "
  read cluster_name

  if [[ "$cluster_name" == "none" || "$cluster_name" == "n" ]]; then
    cluster_name=""
  fi

  if [[ "$cluster_name" == "list" || "$cluster_name" == "l" ]]; then
    cluster_name=""
    select cluster_name in $(aws eks list-clusters --query clusters --output text); do
      break
    done
  fi

  if [[ "$cluster_name" != "" ]]; then
    aws eks update-kubeconfig --name $cluster_name --region $AWS_DEFAULT_REGION
  fi
}
