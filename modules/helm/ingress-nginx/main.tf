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

  set {
    name  = "controller.service.loadBalancerIP"
    value = var.external_ip_address
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-resource-group"
    value = var.external_ip_resource_group
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-pip-name"
    value = var.external_ip_name
  }

  depends_on = [module.ingress-nginx-namespace]
}
