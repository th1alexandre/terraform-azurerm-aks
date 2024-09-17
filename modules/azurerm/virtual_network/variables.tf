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

variable "system_subnet_name" {
  description = "The name of the first subnet."
  type        = string
}

variable "system_subnet_address_prefix" {
  description = "The address prefix for the first subnet."
  type        = string
}

variable "system_subnet_nsg_security_rules" {
  description = "The security rules for the subnet 1."
  type = list(object({
    name                         = string
    protocol                     = string
    source_port_range            = string
    destination_port_range       = string
    source_address_prefixes      = list(string)
    destination_address_prefixes = string
    access                       = string
    priority                     = number
    direction                    = string
  }))
  default = null # Make this variable optional
}

variable "satellite_subnet_name" {
  description = "The name of the second subnet."
  type        = string
}

variable "satellite_subnet_address_prefix" {
  description = "The address prefix for the second subnet."
  type        = string
}

variable "satellite_subnet_nsg_security_rules" {
  description = "The security rules for the subnet 2."
  type = list(object({
    name                         = string
    protocol                     = string
    source_port_range            = string
    destination_port_range       = string
    source_address_prefixes      = list(string)
    destination_address_prefixes = string
    access                       = string
    priority                     = number
    direction                    = string
  }))
  default = null # Make this variable optional
}

variable "tags" {
  description = "A map of tags to assign to the network resources."
  type        = map(string)
}
