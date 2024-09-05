#!/bin/bash

set -e

init_local_backend() {
  sed -i "1,8s/^/# /" backend.tf
  terraform init -force-copy
  sed -i "s/\btrue\b/false/g" modules/backend/main.tf
  terraform destroy -target=module.backend -auto-approve
}

init_remote_backend() {
  terraform apply -target=module.backend -auto-approve
  sed -i "s/\bfalse\b/true/g" modules/backend/main.tf
  sed -i "1,8s/^# //" backend.tf
  terraform init -force-copy
}

if [ "$1" = "-backend=local" ]; then
  init_local_backend
  exit 0
elif [ "$1" = "-backend=azurerm" ]; then
  init_remote_backend
  exit 0
else
  echo "Usage: sh backend-init.sh -backend=local|azurerm"
  exit 1
fi
