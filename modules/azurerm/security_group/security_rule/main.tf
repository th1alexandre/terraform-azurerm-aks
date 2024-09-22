resource "azurerm_network_security_rule" "this" {
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group_name

  name                       = name
  protocol                   = protocol
  source_port_range          = source_port_range
  destination_port_range     = destination_port_range
  source_address_prefixes    = source_address_prefixes
  destination_address_prefix = destination_address_prefixes
  access                     = access
  priority                   = priority
  direction                  = direction
}
