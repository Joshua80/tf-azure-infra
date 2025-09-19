variable "resource_group_name" {}
variable "location" {}
variable "vnet_name" {}
variable "vnet_address_space" {}
variable "web_subnet_name" {}
variable "web_subnet_address_prefixes" {}
variable "pe_subnet_name" {}
variable "pe_subnet_address_prefixes" {}
variable "service_plan_name" {}
variable "app_service_sku" {}
variable "os_type" {}
variable "sql_server_name" {}
variable "sql_version" {}
variable "minimum_tls_version" {}
variable "sql_database_name" {}
variable "sku_name" {}
variable "storage_account_name" {}
variable "account_tier" {}
variable "account_replication_type" {}
variable "container_name" {}
variable "container_access_type" {}
variable "kv_name" {}


variable "webapps" {
  description = "Map of web app names to create"
  type = map(object({
    name         = string
    always_on    = bool
    app_settings = map(string)
  }))
  default = {}
}
