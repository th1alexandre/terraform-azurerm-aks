module "cluster_issuer" {
  source = "./cluster_issuer/cloudflare"

  cloudflare_api_token = var.cloudflare_cluster_issuer.api_token
  acme_email           = var.cloudflare_cluster_issuer.acme_email
  acme_server          = var.cloudflare_cluster_issuer.acme_server
}
