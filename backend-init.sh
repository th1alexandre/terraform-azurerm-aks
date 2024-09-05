#!/bin/bash

set -e

init_local_backend() {}

init_remote_backend() {}

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
