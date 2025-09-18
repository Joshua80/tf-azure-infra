
module "networking" {
  source = "../../modules/networking"
  resource_group_name           = var.resource_group_name
  location                     = var.location
  vnet_name                    = var.vnet_name
  vnet_address_space           = var.vnet_address_space
  web_subnet_name              = var.web_subnet_name
  web_subnet_address_prefixes  = var.web_subnet_address_prefixes
  pe_subnet_name               = var.pe_subnet_name
  pe_subnet_address_prefixes   = var.pe_subnet_address_prefixes

}

module "key_vault" {
  depends_on          = [module.networking]
  source              = "../../modules/key_vault"
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_name      = var.kv_name
}

module "compute" {
  source = "../../modules/compute"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_name   = var.service_plan_name
  app_service_sku     = var.app_service_sku
  os_type             = var.os_type
  webapp_name         = var.webapp_name
  always_on           = var.always_on
  app_settings        = var.app_settings
  app_service_subnet_id = module.networking.web_subnet_id
}

module "database" {
  source = "../../modules/database"
  resource_group_name           = var.resource_group_name
  location                     = var.location
  sql_server_name              = var.sql_server_name
  sql_version                  = var.sql_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
  minimum_tls_version          = var.minimum_tls_version
  sql_database_name            = var.sql_database_name
  sku_name                     = var.sku_name
  subnet_id                    = module.networking.pe_subnet_id
}

module "storage" {
  source                  = "../../modules/storage"
  resource_group_name     = var.resource_group_name
  location                = var.location
  storage_account_name    = var.storage_account_name
  account_tier            = var.account_tier
  account_replication_type= var.account_replication_type
  container_name          = var.container_name
  container_access_type   = var.container_access_type
  subnet_id               = module.networking.pe_subnet_id
}
