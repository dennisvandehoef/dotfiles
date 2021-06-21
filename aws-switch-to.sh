#!/usr/bin/env bash

envname=$1
cluster_name=$1

case "$envname" in
  services) cluster_name='mosquito' ;;
esac

export AWS_PROFILE=$envname
export AWS_ACCOUNT_NAME=$envname
export AWS_DEFAULT_REGION=eu-central-1

aws eks update-kubeconfig --name $cluster_name --region $AWS_DEFAULT_REGION >>/dev/null
