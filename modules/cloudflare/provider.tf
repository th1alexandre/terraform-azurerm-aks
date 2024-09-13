terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "4.41.0"
    }
  }
}

provider "cloudflare" {
  alias     = "read_zones"
  api_token = var.cloudflare_read_zones
}

provider "cloudflare" {
  alias     = "edit_dns"
  api_token = var.cloudflare_edit_dns
}
