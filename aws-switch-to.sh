#!/usr/bin/env bash

envname=$1

export AWS_PROFILE=$envname
export AWS_ACCOUNT_NAME=$envname
export AWS_DEFAULT_REGION=eu-central-1

kube_avalible='yes'

case "$envname" in
  kaeuferportal) kube_avalible='no'  ;;
  services)      kube_avalible='no'  ;;
esac

if [ $kube_avalible = "yes" ]; then
  aws eks update-kubeconfig --name $envname --region eu-central-1 >>/dev/null
fi
