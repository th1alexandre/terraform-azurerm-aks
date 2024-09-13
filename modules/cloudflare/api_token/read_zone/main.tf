data "cloudflare_api_token_permission_groups" "this" {}

resource "cloudflare_api_token" "this" {
  name = var.token_name

  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.this.zone["Zone Read"],
    ]
    resources = {
      "com.cloudflare.api.account.zone.${var.zone_id}" = "*"
    }
  }

  condition {
    request_ip {
      in = var.token_white_list
    }
  }
}