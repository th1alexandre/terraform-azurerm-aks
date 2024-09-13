variable "cloudflare_variables" {
  type = object({
    zone_name         = string
    record_name       = string
    record_ip_address = string
    record_type       = string
    record_proxied    = bool
  })
  description = "A map of variables to pass to the cloudflare module"
}
