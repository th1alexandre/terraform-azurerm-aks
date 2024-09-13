terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.41.0"
    }
  }
}

provider "cloudflare" {
  api_token = var.dns_edit_token
}
