output "cloudflare_token" {
  value = module.cloudflare_api_token.token
  sensitive = true
}
