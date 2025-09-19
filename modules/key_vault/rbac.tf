# Grant Key Vault Secrets access to Terraform principal
# This resource assigns the Key Vault Secrets User role to the current principal (used by Terraform)

resource "azurerm_role_assignment" "keyvault_secrets_user" {
  scope                = azurerm_key_vault.kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = data.azurerm_client_config.current.object_id
}
