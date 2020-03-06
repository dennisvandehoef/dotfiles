#!/usr/bin/env bash

envname=$1

export AWS_PROFILE=$envname
export AWS_ACCOUNT_NAME=$envname

aws eks update-kubeconfig --name $envname --region eu-central-1 >> /dev/null

echo ' -------------------------------------'
echo ' -------------------------------------'
echo '      Switched AWS to: ' $envname
echo ' -------------------------------------'
echo ' -------------------------------------'

kubectl get all -n ca
