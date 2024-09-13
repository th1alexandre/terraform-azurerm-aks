variable "cloudflare_variables" {
  type = object({
    zone_name         = string
    record_name       = string
    record_ip_address = string
    record_type       = string
    record_proxied    = bool
    token_white_list  = list(string)
  })
  description = "A map of variables to pass to the cloudflare module"
}
