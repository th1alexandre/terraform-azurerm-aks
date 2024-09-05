#!/bin/bash

set -e

init_local_backend() {
  # Comment the backend configuration block
  sed -i "22,29s/^/# /" backend.tf

  # Migrate to local backend
  terraform init -force-copy

  # Change the prevent_destroy value to false, allowing the backend resources to be destroyed
  sed -i "s/\btrue\b/false/g" modules/backend/main.tf

  # Destroy the remote backend resources
  terraform destroy -target=module.backend -auto-approve
}

init_remote_backend() {
  # Create the required backend resources
  terraform apply -target=module.backend -auto-approve

  # Change the prevent_destroy value to true, preventing the backend resources from being destroyed
  sed -i "s/\bfalse\b/true/g" modules/backend/main.tf

  # Uncomment the azurerm backend configuration
  sed -i "22,29s/^# //" backend.tf

  # Migrate the local backend to the remote backend
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
