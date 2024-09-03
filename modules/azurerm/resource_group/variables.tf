variable "name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The region where the resource group will be created"
  type        = string
}

variable "tags" {
  description = "A map of tags to apply to the resource group"
  type        = map(string)
}
