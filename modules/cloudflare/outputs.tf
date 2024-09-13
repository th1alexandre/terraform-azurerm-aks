output "cloudflare_edit_dns_token" {
  value     = module.cloudflare_edit_dns_token.token
  sensitive = true
}
