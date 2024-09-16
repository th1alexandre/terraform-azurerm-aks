resource "kubernetes_secret" "cloudflare_api_token_secret" {
  metadata {
    name      = "cloudflare-api-token-secret"
    namespace = "cert-manager"
  }

  data = {
    api-token = var.cloudflare_api_token
  }

  type = "Opaque"
}

resource "kubernetes_manifest" "letsencrypt_issuer_cloudflare" {
  manifest = {
    "apiVersion" = "cert-manager.io/v1"
    "kind"       = "ClusterIssuer"
    "metadata" = {
      "name" = var.cluster_issuer_name
    }
    "spec" = {
      "acme" = {
        "email"  = var.acme_email
        "server" = var.acme_server
        "privateKeySecretRef" = {
          "name" = "cloudflare-issuer-key"
        }
        "solvers" = [{
          "dns01" = {
            "cloudflare" = {
              "apiTokenSecretRef" = {
                "name" = "cloudflare-api-token-secret"
                "key"  = "api-token"
              }
            }
          }
        }]
      }
    }
  }

  depends_on = [kubernetes_secret.cloudflare_api_token_secret]
}
