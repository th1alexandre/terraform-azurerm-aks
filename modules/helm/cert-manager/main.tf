module "cert-manager-namespace" {
  source = "../../kubernetes/namespaces"

  namespaces = ["cert-manager"]
}

resource "helm_release" "this" {
  chart           = "cert-manager"
  name            = "cert-manager"
  namespace       = "cert-manager"
  repository      = "https://charts.jetstack.io"
  version         = var.chart_version
  atomic          = true
  cleanup_on_fail = true

  set {
    name  = "crds.enabled"
    value = true
  }

  set {
    name  = "crds.keep"
    value = false
  }

  depends_on = [module.cert-manager-namespace]
}
