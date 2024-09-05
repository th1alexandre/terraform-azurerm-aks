#!/bin/bash

set -e

confirm() {
  local prompt_message=$1
  local cancelled_message=$2
  read -p "$prompt_message Type 'yes' to proceed: " choice
  if [ "$choice" != "yes" ]; then
    echo "$cancelled_message"
    exit 0
  fi
}

init_local_backend() {
  # Comment the backend configuration block
  sed -i "22,29s/^/# /" backend.tf

  # Migrate to local backend
  terraform init -force-copy

  # Confirm the destroy operation
  CONFIRM_TF_DESTROY="Continuing will destroy the remote backend resources. PROCEED WITH CAUTION!! Do you want to continue?"
  DESTROY_CANCELLED="Remote backend resources were not destroyed. Exiting..."
  confirm "$CONFIRM_TF_DESTROY" "$DESTROY_CANCELLED"

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
  # Confirm the operation
  LOCAL_INIT_CONFIRMATION="Proceeding will migrate the tfstate to local and destroy the remote backend resources. Do you want to continue?"
  LOCAL_INIT_CANCELLED="Local backend was not initialized. Exiting..."
  confirm "$LOCAL_INIT_CONFIRMATION" "$LOCAL_INIT_CANCELLED"

  # Initialize the local backend
  init_local_backend
  exit 0
elif [ "$1" = "-backend=azurerm" ]; then
  # Confirm the operation
  REMOTE_INIT_CONFIRMATION="Proceeding will create the remote backend resources and migrate the tfstate to remote. Do you want to continue?"
  REMOTE_INIT_CANCELLED="Remote backend was not initialized. Exiting..."
  confirm "$REMOTE_INIT_CONFIRMATION" "$REMOTE_INIT_CANCELLED"

  # Initialize the remote backend
  init_remote_backend
  exit 0
else
  echo "Usage: sh backend-init.sh -backend=local|azurerm"
  exit 1
fi
