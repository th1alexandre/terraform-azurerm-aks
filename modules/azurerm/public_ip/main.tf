resource "azurerm_public_ip" "this" {
  name                = var.public_ip_name
  location            = var.region_location
  resource_group_name = var.resource_group
  allocation_method   = var.allocation_method
  ip_version          = var.ip_version
  sku                 = var.sku

  lifecycle {
    create_before_destroy = true
  }

  tags = var.tags
}
