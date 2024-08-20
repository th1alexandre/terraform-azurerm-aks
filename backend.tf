locals {
  tf_backend_resource_group  = "tfstate-rg"
  tf_backend_location        = "East US"
  tf_backend_storage_account = "t1atfazaksbackend" # th1alexandre terraform azurerm aks backend
  tf_backend_container       = "terraform-state"
  tf_backend_state_file_key  = "terraform.tfstate"
}

module "backend" {
  source = "./modules/azurerm_backend"

  resource_group_name  = local.tf_backend_resource_group
  location             = local.tf_backend_location
  storage_account_name = local.tf_backend_storage_account
  container_name       = local.tf_backend_container

  tags = {
    managed_by = "terraform"
  }
}
