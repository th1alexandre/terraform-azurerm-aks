variable "chart_version" {
  description = "The version of the ingress-nginx Helm chart to install"
  type        = string
}

variable "external_ip_name" {
  description = "The name of the external IP address"
  type        = string
}

variable "external_ip_address" {
  description = "The external IP address to assign to the ingress-nginx service"
  type        = string
}

variable "external_ip_resource_group" {
  description = "The resource group of the external IP address"
  type        = string
}
