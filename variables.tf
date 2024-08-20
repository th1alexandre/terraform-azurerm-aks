# Resource Group
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
}

# All resources
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
}
