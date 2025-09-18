data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id
}

resource "azurerm_key_vault_secret" "sql_username" {
  name         = "sqlAdminUsername"
  value        = "sqladminuser"
  key_vault_id = azurerm_key_vault.kv.id
  
}

resource "random_password" "name" {
  length  = 16
  special = true
}

resource "azurerm_key_vault_secret" "sql_password" {
  name         = "sqlAdminPassword"
  value        = random_password.name.result
  key_vault_id = azurerm_key_vault.kv.id
  
}

