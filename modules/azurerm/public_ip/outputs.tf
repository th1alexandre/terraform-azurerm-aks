output "id" {
  description = "The ID of the Public IP"
  value       = azurerm_public_ip.this.id
}

output "name" {
  description = "The name of the Public IP"
  value       = azurerm_public_ip.this.name
}

output "ip_address" {
  description = "The IP address of the Public IP"
  value       = azurerm_public_ip.this.ip_address
}

output "resource_group_name" {
  description = "The name of the resource group in which the Public IP is created"
  value       = azurerm_public_ip.this.resource_group_name
}
