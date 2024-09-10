module "cert-manager" {
  source = "./cert-manager"

  chart_version = var.cert-manager.chart_version
}

module "ingress-nginx" {
  source = "./ingress-nginx"

  chart_version              = var.ingress-nginx.chart_version
  external_ip_name           = var.ingress-nginx.external_ip_name
  external_ip_address        = var.ingress-nginx.external_ip_address
  external_ip_resource_group = var.ingress-nginx.external_ip_resource_group
}
