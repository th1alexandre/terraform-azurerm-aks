locals {
  region_location = module.resource_group.location
  resource_group  = module.resource_group.name
}

module "resource_group" {
  source = "./resource_group"

  name     = var.resource_group_name
  location = var.resource_group_location

  tags = var.tags
}

module "virtual_network" {
  source = "./virtual_network"

  vnet_name           = var.virtual_network_module.vnet_name
  vnet_address_space  = var.virtual_network_module.vnet_address_space
  resource_group_name = local.resource_group
  location            = local.region_location

  subnet1_name           = var.virtual_network_module.subnet1_name
  subnet1_address_prefix = var.virtual_network_module.subnet1_address_prefix
  # subnet1_nsg_security_rules = [{ # Optional }]

  subnet2_name           = var.virtual_network_module.subnet2_name
  subnet2_address_prefix = var.virtual_network_module.subnet2_address_prefix
  # subnet2_nsg_security_rules = [{ # Optional }]

  tags = var.tags
}

module "kubernetes_cluster" {
  source = "./aks"

  location            = local.region_location
  resource_group_name = local.resource_group

  # Cluster Variables
  cluster_name                 = var.kubernetes_cluster_module.cluster_vars.cluster_name
  dns_prefix                   = var.kubernetes_cluster_module.cluster_vars.dns_prefix
  automatic_channel_upgrade    = var.kubernetes_cluster_module.cluster_vars.automatic_channel_upgrade
  image_cleaner_enabled        = var.kubernetes_cluster_module.cluster_vars.image_cleaner_enabled
  image_cleaner_interval_hours = var.kubernetes_cluster_module.cluster_vars.image_cleaner_interval_hours
  kubernetes_version           = var.kubernetes_cluster_module.cluster_vars.kubernetes_version
  node_resource_group          = var.kubernetes_cluster_module.cluster_vars.node_resource_group
  private_cluster_enabled      = var.kubernetes_cluster_module.cluster_vars.private_cluster_enabled
  sku_tier                     = var.kubernetes_cluster_module.cluster_vars.sku_tier

  # Network Profile
  network_plugin = var.kubernetes_cluster_module.network_profile.network_plugin
  ip_versions    = var.kubernetes_cluster_module.network_profile.ip_versions
  service_cidrs  = var.kubernetes_cluster_module.network_profile.service_cidrs
  dns_service_ip = var.kubernetes_cluster_module.network_profile.dns_service_ip

  # Linux Profile
  admin_username = var.kubernetes_cluster_module.linux_profile.admin_username
  ssh_public_key = file("../../.ssh/id_rsa.pub")

  # API Server Access Profile
  authorized_ip_ranges = var.kubernetes_cluster_module.api_server_access_profile.authorized_ip_ranges

  ## System Node Pool (Default)
  system_node_pool_name               = var.kubernetes_cluster_module.np_system.node_pool_name
  system_vm_size                      = var.kubernetes_cluster_module.np_system.vm_size
  system_node_count                   = var.kubernetes_cluster_module.np_system.node_count
  system_vnet_subnet_id               = module.virtual_network.subnet1_id
  system_enable_host_encryption       = var.kubernetes_cluster_module.np_system.enable_host_encryption
  system_only_critical_addons_enabled = var.kubernetes_cluster_module.np_system.only_critical_addons_enabled
  system_temporary_name_for_rotation  = var.kubernetes_cluster_module.np_system.temporary_name_for_rotation
  system_node_labels                  = var.kubernetes_cluster_module.np_system.node_labels

  ## Satellite Node Pool
  satellite_node_pool_name         = var.kubernetes_cluster_module.np_satellite.node_pool_name
  satellite_vm_size                = var.kubernetes_cluster_module.np_satellite.vm_size
  satellite_node_count             = var.kubernetes_cluster_module.np_satellite.node_count
  satellite_vnet_subnet_id         = module.virtual_network.subnet2_id
  satellite_enable_host_encryption = var.kubernetes_cluster_module.np_satellite.enable_host_encryption
  satellite_node_labels            = var.kubernetes_cluster_module.np_satellite.node_labels

  tags = var.tags
}

module "kubeconfig_file" {
  source = "../local/sensitive_file/kubeconfig"

  kube_config_raw = module.kubernetes_cluster.kube_config_raw
  filename        = var.aks_kubeconfig_target_file
}

module "satellite_ingress_nginx_public_ip" {
  source = "./public_ip"

  region_location = local.region_location
  resource_group  = module.kubernetes_cluster.node_resource_group

  public_ip_name    = var.satellite_ingress_nginx_pip_module.pip_name
  allocation_method = var.satellite_ingress_nginx_pip_module.allocation_method
  ip_version        = var.satellite_ingress_nginx_pip_module.ip_version
  reverse_fqdn      = var.satellite_ingress_nginx_pip_module.reverse_fqdn
  sku               = var.satellite_ingress_nginx_pip_module.sku

  tags = var.tags
}
