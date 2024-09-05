terraform {
  backend "azurerm" {
    resource_group_name  = "tfstate-rg"        # tf_backend_resource_group
    storage_account_name = "t1atfazaksbackend" # tf_backend_storage_account
    container_name       = "terraform-state"   # tf_backend_container
    key                  = "terraform.tfstate" # tf_backend_state_file_key
  }
}
