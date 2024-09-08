module "cert-manager" {
  source = "./cert-manager"

  chart_version = var.cert-manager.chart_version
}

module "ingress-nginx" {
  source = "./ingress-nginx"

  chart_version = var.ingress-nginx.chart_version
}
