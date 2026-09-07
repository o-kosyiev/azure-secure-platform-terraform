output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "container_apps_subnet_id" {
  value = azurerm_subnet.this["container_apps"].id
}

output "private_endpoint_subnet_id" {
  value = azurerm_subnet.this["private_endpoints"].id
}

output "private_dns_zone_ids" {
  value = { for key, zone in azurerm_private_dns_zone.this : key => zone.id }
}
