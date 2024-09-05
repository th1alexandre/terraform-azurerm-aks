module "azurerm_resources" {
  source = "./modules/azurerm"

  ## Resource Group
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location


  ## Virtual Network
  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space

  subnet1_name           = var.subnet1_name
  subnet1_address_prefix = var.subnet1_address_prefix
  # subnet1_nsg_security_rules = [{ # Optional }]

  subnet2_name           = var.subnet2_name
  subnet2_address_prefix = var.subnet2_address_prefix
  # subnet2_nsg_security_rules = [{ # Optional }]


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


  ## KUBECONFIG file
  aks_kubeconfig_target_file = var.aks_kubeconfig_target_file


  ## TAGS
  tags = var.tags
}
