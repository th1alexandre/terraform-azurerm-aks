resource "local_sensitive_file" "aks_config" {
  content         = var.kube_config_raw
  filename        = var.filename
  file_permission = "0400"
}
