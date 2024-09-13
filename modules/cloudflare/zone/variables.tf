variable "zone_name" {
  description = "The name of the Cloudflare zone"
  type        = string
}

variable "zone_read_token" {
  description = "The Cloudflare API token with read access to the zone"
  type        = string
}
