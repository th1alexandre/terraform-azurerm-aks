variable "resource_group_name" {
  description = "Resource group where the network security group is created"
  type        = string
}

variable "network_security_group_name" {
  description = "Network security group where the security rule will be applied"
  type        = string
}

variable "name" {
  description = "Name of the security rule"
  type        = string
}

variable "protocol" {
  description = "Network protocol used for communication"
  type        = string
}

variable "source_port_range" {
  description = "Source port range"
  type        = string
}

variable "destination_port_range" {
  description = "Destination port range"
  type        = string
}

variable "source_address_prefixes" {
  description = "Source address prefixes"
  type        = list(string)
}

variable "destination_address_prefix" {
  description = "Destination address prefix"
  type        = string
}

variable "access" {
  description = "Access, either Allow or Deny"
  type        = string
}

variable "priority" {
  description = "Priority of the security rule"
  type        = number
}

variable "direction" {
  description = "Direction of the security rule, either Inbound or Outbound"
  type        = string
}
