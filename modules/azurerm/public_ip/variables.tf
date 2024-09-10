variable "public_ip_name" {
  description = "The name of the public IP address"
  type        = string
}

variable "region_location" {
  description = "The location/region where the public IP address will be created"
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group in which to create the public IP address"
  type        = string
}

variable "allocation_method" {
  description = "The allocation method for the public IP address"
  type        = string
}

variable "ip_version" {
  description = "The IP version for the public IP address"
  type        = string
}

variable "reverse_fqdn" {
  description = "The reverse FQDN for the public IP address"
  type        = string
}

variable "sku" {
  description = "The SKU for the public IP address"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
}
