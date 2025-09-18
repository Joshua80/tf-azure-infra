# Networking
resource_group_name = "rg-prod-webapp"
location = "East US"
vnet_name = "vnet-prod-webapp"
vnet_address_space = ["10.1.0.0/16"]
web_subnet_name = "web-subnet"
web_subnet_address_prefixes = ["10.1.1.0/24"]
pe_subnet_name = "pe-subnet"
pe_subnet_address_prefixes = ["10.1.2.0/24"]


##key vault
kv_name = "kv-prod-webapp"


# Compute
service_plan_name = "plan-prod-webapp"
os_type = "Linux"
app_service_sku = "B1"
webapp_name = "webapp-prod"
always_on = true
app_settings = {
	WEBSITE_RUN_FROM_PACKAGE = "1"
}

# Database
sql_server_name = "sql-prod-webapp"
sql_version = "12.0"
administrator_login = "sqladminuser"
administrator_login_password = "ChangeMeProd!234"
minimum_tls_version = "1.2"
sql_database_name = "sqlpe-prod-webapp"
sku_name = "S0"

# Storage
storage_account_name = "stprodwebapp123"
account_tier = "Standard"
account_replication_type = "LRS"
container_name = "static-assets"
container_access_type = "private"
