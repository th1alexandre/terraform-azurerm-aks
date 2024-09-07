module "cert-manager" {
  source = "./cert-manager"

  chart_version = var.cert-manager.chart_version
}
