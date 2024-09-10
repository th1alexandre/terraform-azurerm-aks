## TF Backend
variable "tf_backend_module" {
  type = object({
    resource_group  = string,
    location        = string,
    storage_account = string,
    container       = string,
    state_file_key  = string
  })
  description = "The required variables for the backend module"
}

## Resource Group
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

## All resources
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}

## Virtual Network
variable "virtual_network_module" {
  type = object({
    vnet_name              = string
    vnet_address_space     = string
    subnet1_name           = string
    subnet1_address_prefix = string
    subnet2_name           = string
    subnet2_address_prefix = string
  })
  description = "A map of variables to pass to the virtual network module"
}

## AKS Cluster
variable "kubernetes_cluster_module" {
  type = object({
    cluster_vars = object({
      cluster_name                 = string
      dns_prefix                   = string
      automatic_channel_upgrade    = string
      image_cleaner_enabled        = bool
      image_cleaner_interval_hours = number
      kubernetes_version           = string
      node_resource_group          = string
      private_cluster_enabled      = bool
      sku_tier                     = string
    })
    network_profile = object({
      network_plugin = string
      ip_versions    = list(string)
      service_cidrs  = list(string)
      dns_service_ip = string
    })
    linux_profile = object({
      admin_username = string
    })
    api_server_access_profile = object({
      authorized_ip_ranges = list(string)
    })
    np_system = object({
      node_pool_name               = string
      vm_size                      = string
      node_count                   = number
      enable_host_encryption       = bool
      only_critical_addons_enabled = bool
      temporary_name_for_rotation  = string
      node_labels                  = map(string)
    })
    np_satellite = object({
      node_pool_name         = string
      vm_size                = string
      node_count             = number
      enable_host_encryption = bool
      node_labels            = map(string)
    })
  })
  description = "A map of variables to pass to the kubernetes cluster module"
}

# Satellite Public IP
variable "satellite_public_ip_name" {
  description = "The name of the public IP address"
  type        = string
}

variable "satellite_public_ip_allocation_method" {
  description = "The allocation method for the public IP address"
  type        = string
}

variable "satellite_public_ip_version" {
  description = "The IP version for the public IP address"
  type        = string
}

variable "satellite_public_ip_reverse_fqdn" {
  description = "The reverse FQDN for the public IP address"
  type        = string
}

variable "satellite_public_ip_sku" {
  description = "The SKU for the public IP address"
  type        = string
}

# Kubeconfig File
variable "aks_kubeconfig_target_file" {
  description = "The path to the kubeconfig file, including the file itself"
  type        = string
}

## Helm
variable "cert-manager" {
  description = "Cert Manager variables"
  type = object({
    chart_version = string
  })
}

variable "ingress-nginx" {
  description = "Ingress Nginx variables"
  type = object({
    chart_version = string
  })
}
