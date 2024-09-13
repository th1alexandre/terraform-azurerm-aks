data "cloudflare_zone" "this" {
  name = var.zone_name
}

resource "cloudflare_record" "this" {
  zone_id = data.cloudflare_zone.this.id
  name    = var.name
  content = var.ip_address
  type    = var.type
  proxied = var.proxied
}
