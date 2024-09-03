locals {
  region_location = module.resource_group.location
  resource_group  = module.resource_group.name
}

module "resource_group" {
  source = "./modules/azurerm_resource_group"

  name     = var.resource_group_name
  location = var.resource_group_location

  tags = var.tags
}

module "virtual_network" {
  source = "./modules/azurerm_virtual_network"

  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  resource_group_name = local.resource_group
  location            = local.region_location

  subnet1_name           = var.subnet1_name
  subnet1_address_prefix = var.subnet1_address_prefix
  # subnet1_nsg_security_rules = [{ # Optional }]

  subnet2_name           = var.subnet2_name
  subnet2_address_prefix = var.subnet2_address_prefix
  # subnet2_nsg_security_rules = [{ # Optional }]

  tags = var.tags
}
