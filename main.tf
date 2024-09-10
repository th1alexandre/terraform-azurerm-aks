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
  aks_cluster_name                 = var.aks_cluster_name
  aks_dns_prefix                   = var.aks_dns_prefix
  aks_automatic_channel_upgrade    = var.aks_automatic_channel_upgrade
  aks_image_cleaner_enabled        = var.aks_image_cleaner_enabled
  aks_image_cleaner_interval_hours = var.aks_image_cleaner_interval_hours
  aks_kubernetes_version           = var.aks_kubernetes_version
  aks_node_resource_group          = var.aks_node_resource_group
  aks_private_cluster_enabled      = var.aks_private_cluster_enabled
  aks_sku_tier                     = var.aks_sku_tier

  # Network Profile
  aks_network_plugin = var.aks_network_plugin
  aks_ip_versions    = var.aks_ip_versions
  aks_service_cidrs  = var.aks_service_cidrs
  aks_dns_service_ip = var.aks_dns_service_ip

  # Linux Profile
  aks_admin_username = var.aks_admin_username

  # API Server Access Profile
  aks_authorized_ip_ranges = var.aks_authorized_ip_ranges

  # System Node Pool (Default)
  aks_system_node_pool_name               = var.aks_system_node_pool_name
  aks_system_vm_size                      = var.aks_system_vm_size
  aks_system_node_count                   = var.aks_system_node_count
  aks_system_node_labels                  = var.aks_system_node_labels
  aks_system_enable_host_encryption       = var.aks_system_enable_host_encryption
  aks_system_only_critical_addons_enabled = var.aks_system_only_critical_addons_enabled
  aks_system_temporary_name_for_rotation  = var.aks_system_temporary_name_for_rotation

  # Satellite Node Pool
  aks_satellite_node_pool_name         = var.aks_satellite_node_pool_name
  aks_satellite_vm_size                = var.aks_satellite_vm_size
  aks_satellite_node_count             = var.aks_satellite_node_count
  aks_satellite_node_labels            = var.aks_satellite_node_labels
  aks_satellite_enable_host_encryption = var.aks_satellite_enable_host_encryption

  # Satelite Public IP
  satellite_public_ip_name              = var.satellite_public_ip_name
  satellite_public_ip_allocation_method = var.satellite_public_ip_allocation_method
  satellite_public_ip_version           = var.satellite_public_ip_version
  satellite_public_ip_reverse_fqdn      = var.satellite_public_ip_reverse_fqdn
  satellite_public_ip_sku               = var.satellite_public_ip_sku


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
