resource "azurerm_storage_account" "main" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}

resource "azurerm_storage_container" "static" {
  name                  = var.container_name
  storage_account_id    = azurerm_storage_account.main.id
  container_access_type = var.container_access_type
}

resource "azurerm_private_endpoint" "storage_pe" {
  name                = "pe-${var.storage_account_name}"
  resource_group_name = var.resource_group_name
  location            = var.location
  subnet_id = var.subnet_id

  private_service_connection {
    name                           = "pe-${var.storage_account_name}-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_storage_account.main.id
    subresource_names              = ["blob"]
  }
}