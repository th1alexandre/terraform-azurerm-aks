module "backend" {
  source = "./modules/backend"

  resource_group_name  = var.tf_backend_module.resource_group
  location             = var.tf_backend_module.location
  storage_account_name = var.tf_backend_module.storage_account
  container_name       = var.tf_backend_module.container

  tags = {
    managed_by = "terraform"
  }
}

module "azurerm_resources" {
  source = "./modules/azurerm"

  ## Resource Group
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location


  ## Virtual Network
  virtual_network_module = var.virtual_network_module

  ## AKS Cluster
  kubernetes_cluster_module = var.kubernetes_cluster_module

  ## AKS Cluster Public IP
  aks_cluster_pip_module = var.aks_cluster_pip_module

  ## Satellite Public IP
  satellite_ingress_nginx_pip_module = var.satellite_ingress_nginx_pip_module


  ## KUBECONFIG file
  aks_kubeconfig_target_file = var.aks_kubeconfig_target_file


  ## TAGS
  tags = var.tags
}

locals {
  ingress-nginx-vars = merge(var.ingress-nginx, {
    external_ip_name           = module.azurerm_resources.satellite_pip_name
    external_ip_address        = module.azurerm_resources.satellite_pip_ip_address
    external_ip_resource_group = module.azurerm_resources.satellite_pip_resource_group
  })
}

module "helm_resources" {
  source = "./modules/helm"

  cert-manager  = var.cert-manager
  ingress-nginx = local.ingress-nginx-vars

  depends_on = [module.azurerm_resources]
}

locals {
  cluster_issuer_variables = merge(var.cloudflare_cluster_issuer, {
    api_token = module.cloudflare_resources.cloudflare_edit_dns_token
  })
}

module "kubernetes_resources" {
  source = "./modules/kubernetes"

  cloudflare_cluster_issuer = local.cluster_issuer_variables

  depends_on = [
    module.helm_resources,
    module.cloudflare_resources
  ]
}

locals {
  cloudflare_variables = merge(var.cloudflare_variables, {
    record_ip_address = module.azurerm_resources.satellite_pip_ip_address
    token_white_list = [
      module.azurerm_resources.satellite_pip_ip_address
    ]
  })
}

module "cloudflare_resources" {
  source = "./modules/cloudflare"

  cloudflare_variables = local.cloudflare_variables
}
