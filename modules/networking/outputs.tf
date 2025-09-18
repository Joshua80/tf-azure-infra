output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "web_subnet_id" {
  value = azurerm_subnet.web.id
}

output "pe_subnet_id" {
  value = azurerm_subnet.pe.id
}
