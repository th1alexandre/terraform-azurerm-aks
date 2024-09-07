variable "cert-manager" {
  description = "Cert Manager variables"
  type = object({
    chart_version = string
  })
}
