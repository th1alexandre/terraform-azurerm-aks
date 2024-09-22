variable "name" {
  description = "Name of the network security group"
  type        = string
}

variable "location" {
  description = "Location of the network security group"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group where the network security group is created"
  type        = string
}

variable "tags" {
  description = "Tags for the network security group"
  type        = map(string)
}
