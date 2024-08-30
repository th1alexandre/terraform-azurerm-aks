variable "vnet_name" {
  description = "The name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The location/region of the virtual network."
  type        = string
}

variable "subnet1_name" {
  description = "The name of the first subnet."
  type        = string
}

variable "subnet1_address_prefix" {
  description = "The address prefix for the first subnet."
  type        = string
}

variable "subnet2_name" {
  description = "The name of the second subnet."
  type        = string
}

variable "subnet2_address_prefix" {
  description = "The address prefix for the second subnet."
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the network resources."
  type        = map(string)
}
