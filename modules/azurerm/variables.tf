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
variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = string
}

variable "subnet1_name" {
  description = "The name of the first subnet"
  type        = string
}

variable "subnet1_address_prefix" {
  description = "The address prefix for the first subnet"
  type        = string
}

variable "subnet2_name" {
  description = "The name of the second subnet"
  type        = string
}

variable "subnet2_address_prefix" {
  description = "The address prefix for the second subnet"
  type        = string
}

## AKS Cluster
variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "aks_dns_prefix" {
  description = "The DNS prefix specified for the AKS cluster"
  type        = string
}

variable "aks_automatic_channel_upgrade" {
  description = "The upgrade channel selected for the AKS cluster"
  type        = string
}

variable "aks_image_cleaner_enabled" {
  description = "Enable the image cleaner for the AKS cluster"
  type        = bool
}

variable "aks_image_cleaner_interval_hours" {
  description = "The interval in hours to run the image cleaner"
  type        = number
}

variable "aks_kubernetes_version" {
  description = "The version to use when creating the AKS cluster"
  type        = string
}

variable "aks_node_resource_group" {
  description = "Name of the new resource group for the node resources"
  type        = string
}

variable "aks_private_cluster_enabled" {
  description = "Expose the API server only on internal IP addresses"
  type        = bool
}

variable "aks_sku_tier" {
  description = "The SKU tier for the AKS cluster"
  type        = string
}

# Network Profile
variable "aks_network_plugin" {
  description = "The network plugin to use for the AKS cluster"
  type        = string
}

variable "aks_ip_versions" {
  description = "IPv4 or dual stack IPv4/IPv6"
  type        = list(string)
}

variable "aks_service_cidrs" {
  description = "CIDR range for services, IPv4 or dual stack IPv4/IPv6"
  type        = list(string)
}

variable "aks_dns_service_ip" {
  description = "IPv4 address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns)"
  type        = string
}

# Linux Profile
variable "aks_admin_username" {
  description = "The username for the Linux Virtual Machines"
  type        = string
}

# API Server Access Profile
variable "aks_authorized_ip_ranges" {
  description = "IP ranges authorized to access the API server"
  type        = list(string)
}

# System Node Pool (Default)
variable "aks_system_node_pool_name" {
  description = "The name of the system node pool"
  type        = string
}

variable "aks_system_vm_size" {
  description = "The size of the Virtual Machines in the node pool"
  type        = string
}

variable "aks_system_node_count" {
  description = "The number of nodes in the node pool"
  type        = number
}

variable "aks_system_enable_host_encryption" {
  description = "Enable host encryption"
  type        = bool
}

variable "aks_system_only_critical_addons_enabled" {
  description = "Enable only critical addons"
  type        = bool
}

variable "aks_system_temporary_name_for_rotation" {
  description = "Temporary name for rotation"
  type        = string
}

variable "aks_system_node_labels" {
  description = "A mapping of labels to assign to the system node pool"
  type        = map(string)
}

# Satellite Node Pool
variable "aks_satellite_node_pool_name" {
  description = "The name of the satellite node pool"
  type        = string
}

variable "aks_satellite_vm_size" {
  description = "The size of the Virtual Machines in the node pool"
  type        = string
}

variable "aks_satellite_node_count" {
  description = "The number of nodes in the node pool"
  type        = number
}

variable "aks_satellite_enable_host_encryption" {
  description = "Enable host encryption"
  type        = bool
}

variable "aks_satellite_node_labels" {
  description = "A mapping of labels to assign to the satellite node pool"
  type        = map(string)
}

# Kubeconfig File
variable "aks_kubeconfig_target_file" {
  description = "The path to the kubeconfig file, including the file itself"
  type        = string
}
