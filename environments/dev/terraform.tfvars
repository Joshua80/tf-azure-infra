# Networking
resource_group_name = "rg-dev-webapp"
location = "East US"
vnet_name = "vnet-dev-webapp"
vnet_address_space = ["10.0.0.0/16"]
web_subnet_name = "web-subnet"
web_subnet_address_prefixes = ["10.0.1.0/24"]
pe_subnet_name = "pe-subnet"
pe_subnet_address_prefixes = ["10.0.2.0/24"]


##key vault
kv_name = "kv-dev-webapp"


# Compute
service_plan_name = "plan-dev-webapp"
os_type = "Windows"
app_service_sku = "B1"
webapp_name = "webapp-dev"
always_on = true
app_settings = {
	WEBSITE_RUN_FROM_PACKAGE = "1"
}

# Database
sql_server_name = "sql-dev-webapp"
sql_version = "12.0"
administrator_login = "sqladminuser"
administrator_login_password = "ChangeMe1234!"
minimum_tls_version = "1.2"
sql_database_name = "sqldb-dev-webapp"
sku_name = "S0"

# Storage
storage_account_name = "stdevwebapp123"
account_tier = "Standard"
account_replication_type = "LRS"
container_name = "static-assets"
container_access_type = "private"
