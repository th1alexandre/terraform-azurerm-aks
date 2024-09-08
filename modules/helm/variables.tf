variable "cert-manager" {
  description = "Cert Manager variables"
  type = object({
    chart_version = string
  })
}

variable "ingress-nginx" {
  description = "Ingress Nginx variables"
  type = object({
    chart_version = string
  })
}
