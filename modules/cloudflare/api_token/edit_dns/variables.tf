variable "token_name" {
  description = "The name of the Cloudflare API token"
  type        = string
}

variable "zone_id" {
  description = "The ID of the Cloudflare zone"
  type        = string
}

variable "token_white_list" {
  description = "A list of IP addresses that are allowed to use the token"
  type        = list(string)
}
