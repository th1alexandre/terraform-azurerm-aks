variable "cloudflare_cluster_issuer" {
  type = object({
    api_token   = string
    acme_email  = string
    acme_server = string
  })
  description = "Cloudflare Cluster Issuer Variables"
}
