output "aks_cluster_outbound_ip_address" {
  value = module.azurerm_resources.aks_cluster_pip_ip_address
}
