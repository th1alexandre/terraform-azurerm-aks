locals {
  zone_id = module.domain_zone.zone_id
}

module "domain_zone" {
  source = "./zone"

  zone_name = var.cloudflare_variables.zone_name

  providers = {
    cloudflare = cloudflare.read_zones
  }
}

module "loadbalancer_record" {
  source = "./record"

  zone_id    = local.zone_id
  name       = var.cloudflare_variables.record_name
  ip_address = var.cloudflare_variables.record_ip_address
  type       = var.cloudflare_variables.record_type
  proxied    = var.cloudflare_variables.record_proxied

  providers = {
    cloudflare = cloudflare.edit_dns
  }
}
