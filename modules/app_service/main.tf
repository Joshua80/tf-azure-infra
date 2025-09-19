
resource "azurerm_windows_web_app" "web" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.app_service_plan_id
  site_config  {
    always_on = var.always_on
  }
  app_settings              = var.app_settings
  virtual_network_subnet_id = var.app_service_subnet_id
}
