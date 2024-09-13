resource "cloudflare_record" "this" {
  zone_id = var.zone_id
  name    = var.name
  content = var.ip_address
  type    = var.type
  proxied = var.proxied
}
