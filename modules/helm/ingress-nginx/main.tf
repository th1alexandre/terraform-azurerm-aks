module "ingress-nginx-namespace" {
  source = "../../kubernetes/namespaces"

  namespaces = ["ingress-nginx"]
}

resource "helm_release" "this" {
  chart           = "ingress-nginx"
  name            = "ingress-nginx"
  namespace       = "ingress-nginx"
  repository      = "https://kubernetes.github.io/ingress-nginx"
  version         = var.chart_version
  cleanup_on_fail = true

  depends_on = [module.ingress-nginx-namespace]
}
