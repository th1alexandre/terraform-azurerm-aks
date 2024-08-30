resource "azurerm_virtual_network" "this" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name

  address_space = [var.vnet_address_space]

  dns_servers = [
    "1.1.1.1", # Cloudflare's public DNS server
    "1.0.0.1",
    "8.8.8.8", # Google's public DNS server
    "8.8.4.4"
  ]

  tags = var.tags
}

resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet1_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [var.subnet1_address_prefix]
}

resource "azurerm_network_security_group" "subnet1_nsg" {
  name                = "${var.subnet1_name}_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.subnet1_nsg_security_rules != null ? var.subnet1_nsg_security_rules : []
    content {
      name                       = security_rule.value.name
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefixes    = security_rule.value.source_address_prefixes
      destination_address_prefix = security_rule.value.destination_address_prefixes
      access                     = security_rule.value.access
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction

      # description                                = "*"
      # source_port_ranges                         = ["*"]
      # destination_port_ranges                    = ["*"]
      # source_address_prefix                      = "*"
      # source_application_security_group_ids      = ["*"]
      # destination_address_prefixes               = ["*"]
      # destination_application_security_group_ids = ["*"]
    }
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "subnet1" {
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.subnet1_nsg.id
}

resource "azurerm_subnet" "subnet2" {
  name                 = var.subnet2_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name

  address_prefixes = [var.subnet2_address_prefix]
}

resource "azurerm_network_security_group" "subnet2_nsg" {
  name                = "${var.subnet2_name}_nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  dynamic "security_rule" {
    for_each = var.subnet2_nsg_security_rules != null ? var.subnet2_nsg_security_rules : []
    content {
      name                       = security_rule.value.name
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefixes    = security_rule.value.source_address_prefixes
      destination_address_prefix = security_rule.value.destination_address_prefixes
      access                     = security_rule.value.access
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction

      # description                                = "*"
      # source_port_ranges                         = ["*"]
      # destination_port_ranges                    = ["*"]
      # source_address_prefix                      = "*"
      # source_application_security_group_ids      = ["*"]
      # destination_address_prefixes               = ["*"]
      # destination_application_security_group_ids = ["*"]
    }
  }

  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "subnet2" {
  subnet_id                 = azurerm_subnet.subnet2.id
  network_security_group_id = azurerm_network_security_group.subnet2_nsg.id
}
