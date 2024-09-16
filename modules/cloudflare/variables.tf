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

variable "cloudflare_read_zones" {
  description = "The Cloudflare API token to use for reading zones"
  type        = string
}

variable "cloudflare_edit_dns" {
  description = "The Cloudflare API token to use for editing DNS records"
  type        = string
}
