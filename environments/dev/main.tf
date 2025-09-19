
module "networking" {
  source                      = "../../modules/networking"
  resource_group_name         = var.resource_group_name
  location                    = var.location
  vnet_name                   = var.vnet_name
  vnet_address_space          = var.vnet_address_space
  web_subnet_name             = var.web_subnet_name
  web_subnet_address_prefixes = var.web_subnet_address_prefixes
  pe_subnet_name              = var.pe_subnet_name
  pe_subnet_address_prefixes  = var.pe_subnet_address_prefixes
}

module "key_vault" {
  depends_on          = [module.networking]
  source              = "../../modules/key_vault"
  resource_group_name = var.resource_group_name
  location            = var.location
  key_vault_name      = var.kv_name
}

module "database" {
  depends_on                   = [module.key_vault]
  source                       = "../../modules/database"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  sql_server_name              = var.sql_server_name
  sql_version                  = var.sql_version
  administrator_login          = module.key_vault.sql_username
  administrator_login_password = module.key_vault.sql_password
  minimum_tls_version          = var.minimum_tls_version
  sql_database_name            = var.sql_database_name
  sku_name                     = var.sku_name
  subnet_id                    = module.networking.pe_subnet_id
}

module "storage" {
  depends_on               = [module.key_vault]
  source                   = "../../modules/storage"
  resource_group_name      = var.resource_group_name
  location                 = var.location
  storage_account_name     = var.storage_account_name
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  container_name           = var.container_name
  container_access_type    = var.container_access_type
  subnet_id                = module.networking.pe_subnet_id
}

module "app_service_plan" {
  depends_on          = [module.storage]
  source              = "../../modules/app_service_plan"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_name   = var.service_plan_name
  os_type             = var.os_type
  app_service_sku     = var.app_service_sku
}

module "app_service" {
  depends_on = [ module.app_service_plan ]
  for_each              = var.webapps
  source                = "../../modules/app_service"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_service_plan_id   = module.app_service_plan.app_service_plan_id
  webapp_name           = each.value.name
  always_on             = each.value.always_on
  app_settings          = each.value.app_settings
  app_service_subnet_id = module.networking.web_subnet_id
}
