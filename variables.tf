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
      network_plugin    = string
      ip_versions       = list(string)
      service_cidrs     = list(string)
      dns_service_ip    = string
      load_balancer_sku = string
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

## Public IPs
variable "aks_cluster_pip_module" {
  type = object({
    pip_name          = string
    allocation_method = string
    ip_version        = string
    reverse_fqdn      = string
    sku               = string
  })
}

variable "satellite_ingress_nginx_pip_module" {
  type = object({
    pip_name          = string
    allocation_method = string
    ip_version        = string
    reverse_fqdn      = string
    sku               = string
  })
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

# Kubernetes Resources
variable "cloudflare_cluster_issuer" {
  description = "Cloudflare Cluster Issuer variables"
  type = object({
    acme_email  = string
    acme_server = string
  })
}

# Cloudflare
variable "cloudflare_variables" {
  type = object({
    zone_name      = string
    record_name    = string
    record_type    = string
    record_proxied = bool
  })
  description = "A map of variables to pass to the cloudflare module"
}

variable "cloudflare_tokens" {
  type = object({
    edit_dns   = string
    read_zones = string
  })
  description = "A map of cloudflare api tokens with unique permissions"
}
