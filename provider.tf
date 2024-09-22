terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.116.0"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "1.15.0"
    }

    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.41.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.15.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.32.0"
    }

    local = {
      source  = "hashicorp/local"
      version = "2.5.1"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azapi" {}

provider "cloudflare" {}

provider "helm" {
  kubernetes {
    config_path = module.azurerm_resources.kubeconfig_path
  }
}

provider "kubernetes" {
  config_path = module.azurerm_resources.kubeconfig_path
}

provider "local" {}
