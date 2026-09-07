locals {
  subnets = {
    container_apps = {
      address_prefix = cidrsubnet(var.vnet_cidr, 7, 0)
      delegation     = true
    }
    private_endpoints = {
      address_prefix = cidrsubnet(var.vnet_cidr, 8, 2)
      delegation     = false
    }
  }

  private_dns_zones = {
    key_vault          = "privatelink.vaultcore.azure.net"
    container_registry = "privatelink.azurecr.io"
  }
}

resource "azurerm_virtual_network" "this" {
  name                = "vnet-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]
  tags                = var.tags
}

resource "azurerm_network_security_group" "this" {
  for_each = local.subnets

  name                = "nsg-${var.name_prefix}-${replace(each.key, "_", "-")}"
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_network_security_rule" "allow_vnet_inbound" {
  for_each = local.subnets

  name                        = "AllowVnetInbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "VirtualNetwork"
  destination_address_prefix  = "VirtualNetwork"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this[each.key].name
}

resource "azurerm_network_security_rule" "deny_internet_inbound" {
  for_each = local.subnets

  name                        = "DenyInternetInbound"
  priority                    = 4096
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "Internet"
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.this[each.key].name
}

resource "azurerm_subnet" "this" {
  for_each = local.subnets

  name                 = "snet-${var.name_prefix}-${replace(each.key, "_", "-")}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [each.value.address_prefix]

  private_endpoint_network_policies = each.key == "private_endpoints" ? "Disabled" : "Enabled"

  dynamic "delegation" {
    for_each = each.value.delegation ? [1] : []
    content {
      name = "Microsoft.App.environments"
      service_delegation {
        name = "Microsoft.App/environments"
      }
    }
  }
}

resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = local.subnets

  subnet_id                 = azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}

resource "azurerm_private_dns_zone" "this" {
  for_each = local.private_dns_zones

  name                = each.value
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  for_each = local.private_dns_zones

  name                 = "link-${var.name_prefix}-${replace(each.key, "_", "-")}"
  private_dns_zone_id  = azurerm_private_dns_zone.this[each.key].id
  virtual_network_id   = azurerm_virtual_network.this.id
  registration_enabled = false
  tags                 = var.tags
}
