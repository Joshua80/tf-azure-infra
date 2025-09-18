variable "resource_group_name" {
  description = "Resource group name for storage account"
  type        = string
}

variable "location" {
  description = "Azure region for storage account"
  type        = string
}

variable "storage_account_name" {
  description = "Globally unique name for the storage account"
  type        = string
}

variable "account_tier" {
  description = "Storage account tier (Standard or Premium)"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type (LRS, GRS, etc.)"
  type        = string
  default     = "LRS"
}

variable "container_name" {
  description = "Name of the blob container"
  type        = string
  default     = "static-assets"
}

variable "container_access_type" {
  description = "Access type for the blob container (private, blob, container)"
  type        = string
  default     = "private"
}

variable "subnet_id" {
  description = "The ID of the subnet to which the private endpoint will be connected"
  type        = string
}
