locals {
  zone_id = module.domain_zone.zone_id
}

module "domain_zone" {
  source = "./zone"

  zone_name       = var.cloudflare_variables.zone_name
  zone_read_token = module.cloudflare_read_zone_token.token
}

module "cloudflare_edit_dns_token" {
  source = "./api_token/edit_dns"

  token_name       = "edit_dns_token"
  zone_id          = local.zone_id
  token_white_list = var.cloudflare_variables.token_white_list
}

module "cloudflare_read_zone_token" {
  source = "./api_token/read_zone"

  token_name       = "read_zone_token"
  zone_id          = local.zone_id
  token_white_list = var.cloudflare_variables.token_white_list
}

module "loadbalancer_record" {
  source = "./record"

  zone_id        = local.zone_id
  name           = var.cloudflare_variables.record_name
  ip_address     = var.cloudflare_variables.record_ip_address
  type           = var.cloudflare_variables.record_type
  proxied        = var.cloudflare_variables.record_proxied
  dns_edit_token = module.cloudflare_edit_dns_token.token
}
