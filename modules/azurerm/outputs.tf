output "kubeconfig_path" {
  value = module.kubeconfig_file.file_path
}

output "satellite_pip_name" {
  value = module.satellite_ingress_nginx_public_ip.name
}

output "satellite_pip_ip_address" {
  value = module.satellite_ingress_nginx_public_ip.ip_address
}

output "satellite_pip_resource_group" {
  value = module.satellite_ingress_nginx_public_ip.resource_group_name
}
