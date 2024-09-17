output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "system_subnet_id" {
  value = azurerm_subnet.system_subnet.id
}

output "satellite_subnet_id" {
  value = azurerm_subnet.satellite_subnet.id
}
