variable "ip_address" {
  description = "The IP address to point the DNS record to"
  type        = string
}

variable "zone_id" {
  description = "The ID of the Cloudflare zone"
  type        = string
}

variable "name" {
  description = "The name of the DNS record"
  type        = string
}

variable "type" {
  description = "The type of DNS record"
  type        = string
}

variable "proxied" {
  description = "Whether the record should be proxied by Cloudflare"
  type        = bool
  default     = false
}

variable "dns_edit_token" {
  description = "The Cloudflare API token with edit access to DNS records"
  type        = string
}
