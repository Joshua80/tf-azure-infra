resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "static" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.main.name
  container_access_type = var.container_access_type
}

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "static_container_name" {
  value = azurerm_storage_container.static.name
}
