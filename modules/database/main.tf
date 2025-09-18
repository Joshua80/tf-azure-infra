
resource "azurerm_mssql_server" "main" {
  name                         = var.sql_server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  minimum_tls_version          = var.minimum_tls_version
}

resource "azurerm_mssql_database" "main" {
  name                = var.sql_database_name
  server_id           = azurerm_mssql_server.main.id
  sku_name            = var.sku_name
}
