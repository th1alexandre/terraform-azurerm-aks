variable "cluster_issuer_name" {
  description = "The name of the ClusterIssuer"
  type        = string
  default     = "cloudflare-issuer"
}

variable "cloudflare_api_token" {
  description = "The Cloudflare API token"
  type        = string
}

variable "acme_email" {
  description = "The email address to use for ACME registration"
  type        = string
}

variable "acme_server" {
  description = "The ACME server URL"
  type        = string
}
