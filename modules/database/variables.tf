variable "resource_group_name" {
  description = "Resource group name for database resources"
  type        = string
}

variable "location" {
  description = "Azure region for resources"
  type        = string
}

variable "sql_server_name" {
  description = "Name of the SQL server"
  type        = string
}

variable "sql_version" {
  description = "SQL server version"
  type        = string
  default     = "12.0"
}

variable "administrator_login" {
  description = "SQL admin username"
  type        = string
}

variable "administrator_login_password" {
  description = "SQL admin password"
  type        = string
  sensitive   = true
}

variable "minimum_tls_version" {
  description = "Minimum TLS version for SQL server"
  type        = string
  default     = "1.2"
}

variable "sql_database_name" {
  description = "Name of the SQL database"
  type        = string
}

variable "sku_name" {
  description = "SKU for SQL database"
  type        = string
  default     = "S0"
}
