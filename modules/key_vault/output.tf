output "sql_username" {
  description = "The SQL username secret in Key Vault"
  value       = azurerm_key_vault_secret.sql_username.value

}

output "sql_password" {
  description = "The SQL password secret in Key Vault"
  value       = azurerm_key_vault_secret.sql_password.value

}
