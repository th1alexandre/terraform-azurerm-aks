locals {
  region_location = module.resource_group.location
  resource_group  = module.resource_group.name
}

module "resource_group" {
  source = "./modules/azurerm/resource_group"

  name     = var.resource_group_name
  location = var.resource_group_location

  tags = var.tags
}

module "virtual_network" {
  source = "./modules/azurerm/virtual_network"

  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  resource_group_name = local.resource_group
  location            = local.region_location

  subnet1_name           = var.subnet1_name
  subnet1_address_prefix = var.subnet1_address_prefix
  # subnet1_nsg_security_rules = [{ # Optional }]

  subnet2_name           = var.subnet2_name
  subnet2_address_prefix = var.subnet2_address_prefix
  # subnet2_nsg_security_rules = [{ # Optional }]

  tags = var.tags
}

module "kubeconfig_file" {
  source = "./modules/local/sensitive_file/kubeconfig"

  kube_config_raw = module.kubernetes_cluster.kube_config_raw
  filename        = var.aks_kubeconfig_target_file
}

module "kubernetes_cluster" {
  source = "./modules/azurerm/aks"

  cluster_name                 = var.aks_cluster_name
  location                     = local.region_location
  resource_group_name          = local.resource_group
  dns_prefix                   = var.aks_dns_prefix
  automatic_channel_upgrade    = var.aks_automatic_channel_upgrade
  image_cleaner_enabled        = var.aks_image_cleaner_enabled
  image_cleaner_interval_hours = var.aks_image_cleaner_interval_hours
  kubernetes_version           = var.aks_kubernetes_version
  node_resource_group          = var.aks_node_resource_group
  private_cluster_enabled      = var.aks_private_cluster_enabled
  sku_tier                     = var.aks_sku_tier

  # Network Profile
  network_plugin = var.aks_network_plugin
  ip_versions    = var.aks_ip_versions
  service_cidrs  = var.aks_service_cidrs
  dns_service_ip = var.aks_dns_service_ip

  # Linux Profile
  admin_username = var.aks_admin_username
  ssh_public_key = file(".ssh/id_rsa.pub")

  # API Server Access Profile
  authorized_ip_ranges = var.aks_authorized_ip_ranges

  ## System Node Pool (Default)
  system_node_pool_name               = var.aks_system_node_pool_name
  system_vm_size                      = var.aks_system_vm_size
  system_node_count                   = var.aks_system_node_count
  system_vnet_subnet_id               = module.virtual_network.subnet1_id
  system_node_labels                  = var.aks_system_node_labels
  system_enable_host_encryption       = var.aks_system_enable_host_encryption
  system_only_critical_addons_enabled = var.aks_system_only_critical_addons_enabled
  system_temporary_name_for_rotation  = var.aks_system_temporary_name_for_rotation

  tags = var.tags
}
