variable "resource_group_name" {
  description = "Resource group name for key vault"
  type        = string

}

variable "location" {
  description = "Azure region for key vault"
  type        = string

}

variable "key_vault_name" {
  description = "Name of the key vault"
  type        = string

}
