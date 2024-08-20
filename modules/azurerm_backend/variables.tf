variable "resource_group_name" {
  description = "The name of the resource group in which the backend resources will be located."
  type        = string
}

variable "location" {
  description = "The Azure region in which the backend infrastructure will be created."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account to create."
  type        = string
}

variable "container_name" {
  description = "The name of the storage container to create."
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the backend resource group."
  type        = map(string)
}
