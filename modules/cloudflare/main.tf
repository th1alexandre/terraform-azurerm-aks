locals {
  zone_id = module.domain_zone.zone_id
}

module "domain_zone" {
  source = "./zone_id"

  zone_name = var.cloudflare_variables.zone_name
}

module "cloudflare_api_token" {
  source = "./api_token"

  token_name = "cloudflare_token"
  zone_id    = local.zone_id
}

module "loadbalancer_record" {
  source = "./record"

  zone_id    = local.zone_id
  name       = var.cloudflare_variables.record_name
  ip_address = var.cloudflare_variables.record_ip_address
  type       = var.cloudflare_variables.record_type
  proxied    = var.cloudflare_variables.record_proxied
}
