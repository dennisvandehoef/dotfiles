#!/usr/bin/env bash

envname=$1

export AWS_PROFILE=$envname
aws eks update-kubeconfig --name $envname --region eu-central-1

# OUTPUT
echo ' -------------------------------------'
echo '      Switched AWS to: ' $envname
echo ' -------------------------------------'
