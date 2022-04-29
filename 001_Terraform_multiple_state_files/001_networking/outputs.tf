output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_hub_id" {
  value = azurerm_subnet.subnet.id
}

output "nsg_hub_id" {
  value = azurerm_network_security_group.nsg.id
}
