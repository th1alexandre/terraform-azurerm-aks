terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"        # var.tf_backend_module.resource_group
    storage_account_name = "t1atfazaksbackend" # var.tf_backend_module.storage_account
    container_name       = "terraform-state"   # var.tf_backend_module.container
    key                  = "terraform.tfstate" # var.tf_backend_module.state_file_key
  }
}
