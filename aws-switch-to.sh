#!/usr/bin/env bash

envname=$1

export AWS_PROFILE=$envname
export AWS_ACCOUNT_NAME=$envname
export AWS_DEFAULT_REGION=eu-central-1

aws eks update-kubeconfig --name $envname --region $AWS_DEFAULT_REGION >>/dev/null
